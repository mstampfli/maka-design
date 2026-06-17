#!/usr/bin/env bash
# Mirror the maka-design repo into the standalone Claude skill, then push both repos.
#
# Source of truth: this repo (~/maka-design). It feeds three places:
#   1. the standalone Claude skill at ~/.claude/skills/maka-design  (real files, no symlink)
#   2. the maka-design GitHub repo (origin)  -> also rebuilds GitHub Pages
#   3. the claude-skills GitHub repo (the skill's home)
#
# Invoked automatically by .git/hooks/post-commit and post-merge; also safe to run by hand.
# Never aborts the triggering git operation: all failures are logged, exit stays 0.
set -uo pipefail

REPO="${MAKA_DESIGN_REPO:-$HOME/maka-design}"
SKILL="${MAKA_DESIGN_SKILL:-$HOME/.claude/skills/maka-design}"
SKILLS_REPO="${CLAUDE_SKILLS_REPO:-$HOME/.claude/skills}"

log() { printf 'sync-skill: %s\n' "$*"; }

cd "$REPO" 2>/dev/null || { log "repo not found: $REPO"; exit 0; }
rev="$(git rev-parse --short HEAD 2>/dev/null || echo unknown)"

# The skill path must be a real directory, never a symlink: writing through a symlink
# would scribble back into this repo. Convert a legacy symlink to a real dir.
if [ -L "$SKILL" ]; then
  log "converting legacy symlink at $SKILL to a real directory"
  rm -f "$SKILL"
fi
mkdir -p "$SKILL"

# Export exactly the tracked tree at HEAD (no .git, no untracked junk), then drop the
# dev-only dirs so the skill stays pure design assets.
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
git archive --format=tar HEAD | tar -x -C "$tmp"
rm -rf "$tmp/scripts" "$tmp/.githooks"

# Mirror into the skill, deleting files that no longer exist upstream.
rsync -a --delete "$tmp"/ "$SKILL"/
log "mirrored $rev -> $SKILL"

# Push maka-design itself (best-effort: never fail the triggering commit).
if git push -q origin HEAD 2>/dev/null; then
  log "pushed maka-design ($rev)"
else
  log "WARN: maka-design push skipped/failed (commit is safe locally)"
fi

# Commit + push the claude-skills repo, scoped to the maka-design path only so we never
# sweep up unrelated staged changes in that repo.
cd "$SKILLS_REPO" 2>/dev/null || { log "skills repo not found: $SKILLS_REPO"; exit 0; }
git add -A -- maka-design
if git diff --cached --quiet -- maka-design; then
  log "skill unchanged; nothing to commit in claude-skills"
else
  git -c user.name='maka-design sync' -c user.email='sync@mstampfli.com' \
      commit -q -m "maka-design: sync skill from repo $rev" -- maka-design
  if git push -q 2>/dev/null; then
    log "pushed claude-skills"
  else
    log "WARN: claude-skills push skipped/failed (commit is safe locally)"
  fi
fi
