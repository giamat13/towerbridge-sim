# Project rules

- The game lives in `index.html` on `main`. The original version lives on the separate
  `original` branch, also as `index.html`. `main`'s `original.html` is generated from that
  branch by `deploy-original.sh`, which the `Deploy original` GitHub Actions workflow runs
  automatically on every push to `original` that changes `index.html`; never edit
  `original.html` on `main` by hand. The workflow file must exist on both branches (the
  push trigger reads it from `original`, the manual trigger from `main`).
- By default, make changes in `index.html` on `main` only — not on the `original` branch —
  unless the user explicitly says to change the original too.
- When the user asks to change the original: make the change on the `original` branch,
  commit and push it; the workflow publishes it to `main` (then `git pull` on `main`).
  `./deploy-original.sh` on `main` still works as a manual fallback.
  Apply the same change to `index.html` on `main` as well, unless the user explicitly says not to.
- The two versions should stay identical apart from intentional differences, such as the
  "ORIGINAL VERSION" link that only `main`'s `index.html` has.
