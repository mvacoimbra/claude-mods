#!/bin/sh
# Puts the claude-mods pack back exactly as it was before the unified redesign.
#
# Every repo was tagged `pre-redesign` before any change. Going back means pointing every
# marketplace entry at that tag, reinstalling every mod from it, and restoring the plugin
# stores saved at that moment.
#
#   sh marketplace/scripts/rollback-redesign.sh   (from the claude-mods folder)
#
# Nothing is deleted: main keeps the redesign, and pointing the entries back at main undoes this.
set -e
root=$(cd "$(dirname "$0")/../.." && pwd)
backup="$root/.pre-redesign-backup"
mods="mods filetree skins cache-tax savvy-progress replay-theater blast-radius"

echo "1/4 Marketplace: every mod from its pre-redesign tag"
cd "$root/marketplace"
git switch -q main
git checkout pre-redesign -- .claude-plugin/marketplace.json
python3 - <<'PY'
import json
p = '.claude-plugin/marketplace.json'
d = json.load(open(p))
for plugin in d['plugins']:
    plugin['source']['ref'] = 'pre-redesign'
json.dump(d, open(p, 'w'), indent=2)
open(p, 'a').write('\n')
PY
git add .claude-plugin/marketplace.json
if ! git diff --cached --quiet; then
  git commit -qm "revert: install every mod from its pre-redesign tag"
  git push -q origin main
fi

echo "2/4 Refresh the marketplace"
claude plugin marketplace update claude-mods

echo "3/4 Reinstall every mod from the tag"
for mod in $mods; do
  claude plugin uninstall "$mod@claude-mods" >/dev/null 2>&1 || true
  claude plugin install "$mod@claude-mods"
done

# reflect-mod joined after the redesign; before it, the Python claude-reflect plugin ran.
claude plugin uninstall reflect-mod@claude-mods >/dev/null 2>&1 || true
claude plugin install claude-reflect@claude-reflect-marketplace >/dev/null 2>&1 || true

echo "4/4 Restore the stores saved before the redesign"
cp "$backup"/store/*.json "$HOME/.claude/plugins/store/"

echo "Done. Restart Claude Code."
