# Project rules

- `original.html` is a frozen reference copy of the game, kept for comparison via the
  "ORIGINAL VERSION" link in `index.html`. When making changes to the game, edit
  `index.html` — never `original.html` — unless the user explicitly says to update
  `original.html` (or to resync it with `index.html`).
- If `original.html` is ever edited (because the user explicitly asked for that), apply
  the same edit to `index.html` too, unless the user explicitly says not to. The two
  files should otherwise stay identical except for the "ORIGINAL VERSION" link itself
  (present only in `index.html`, absent from `original.html`).
