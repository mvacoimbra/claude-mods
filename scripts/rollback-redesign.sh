#!/bin/sh
# Puts the claude-mods pack back exactly as it was before the unified redesign.
#
# Every repo was tagged `pre-redesign` before any change, and the redesign lives only on
# `redesign` branches: the mods' `main` branches were never touched. Going back means pointing
# the marketplace at `main` again (its pre-redesign file), reinstalling every mod from there,
# and restoring the plugin stores saved at that moment.
#
#   sh marketplace/scripts/rollback-redesign.sh   (from the claude-mods folder)
#
# The redesign branches stay on GitHub; nothing is deleted.
set -e
root=$(cd "$(dirname "$0")/../.." && pwd)
backup="$root/.pre-redesign-backup"
mods="mods filetree skins cache-tax savvy-progress replay-theater blast-radius"

echo "1/4 Marketplace back to its pre-redesign file"
cd "$root/marketplace"
git switch -q main
git checkout pre-redesign -- .claude-plugin/marketplace.json
if ! git diff --cached --quiet; then
  git commit -qm "revert: point the mods back at main"
  git push -q origin main
fi

echo "2/4 Refresh the marketplace"
claude plugin marketplace update claude-mods

echo "3/4 Reinstall every mod from main"
for mod in $mods; do
  claude plugin uninstall "$mod@claude-mods" >/dev/null 2>&1 || true
  claude plugin install "$mod@claude-mods"
done

echo "4/4 Restore the stores saved before the redesign"
cp "$backup"/store/*.json "$HOME/.claude/plugins/store/"

echo "Done. Restart Claude Code."
