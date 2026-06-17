#!/usr/bin/env bash
# Install the git hooks that auto-sync the maka-design skill on every commit / merge.
# Run once after cloning this repo:  bash scripts/install-hooks.sh
set -euo pipefail

root="$(git rev-parse --show-toplevel)"
hooks="$root/.git/hooks"
mkdir -p "$hooks"

for h in post-commit post-merge; do
  cat > "$hooks/$h" <<'STUB'
#!/bin/sh
# auto-installed by scripts/install-hooks.sh -- syncs the standalone Claude skill
exec "$(git rev-parse --show-toplevel)/scripts/sync-skill.sh"
STUB
  chmod +x "$hooks/$h"
  echo "installed $hooks/$h"
done
