#!/usr/bin/env bash
# Publish the game from the `original` branch to main as original.html.
#
# Usage (from main):  ./deploy-original.sh [--no-push] [branch]
#   --no-push   commit locally but don't push to origin
#   branch      where the original game lives (default: original)
set -euo pipefail

push=1
branch=original
for arg in "$@"; do
  case "$arg" in
    --no-push) push=0 ;;
    -h|--help) sed -n '2,7p' "$0"; exit 0 ;;
    *) branch=$arg ;;
  esac
done

cd "$(git rev-parse --show-toplevel)"

current=$(git rev-parse --abbrev-ref HEAD)
if [ "$current" != "main" ]; then
  echo "error: run this from main (currently on '$current')" >&2
  exit 1
fi
if ! git diff --quiet -- original.html || ! git diff --cached --quiet -- original.html; then
  echo "error: original.html has uncommitted changes; commit or discard them first" >&2
  exit 1
fi

# Prefer the pushed branch so a deploy matches what's on GitHub.
if git remote get-url origin >/dev/null 2>&1 && git fetch --quiet origin "$branch" 2>/dev/null; then
  ref="origin/$branch"
elif git rev-parse --verify --quiet "$branch" >/dev/null; then
  ref=$branch
else
  echo "error: branch '$branch' not found locally or on origin" >&2
  exit 1
fi

git show "$ref:index.html" > original.html
git add original.html

if git diff --cached --quiet -- original.html; then
  echo "original.html already matches $ref ($(git rev-parse --short "$ref")); nothing to deploy."
  exit 0
fi

git commit --quiet -m "Deploy original.html from $branch ($(git rev-parse --short "$ref"))" -- original.html
echo "Committed original.html from $ref ($(git rev-parse --short "$ref"))."

if [ "$push" = 1 ]; then
  git push --quiet origin main
  echo "Pushed to origin/main."
fi
