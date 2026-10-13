# claude-mods

My Claude Code mods, as one marketplace. Each entry points at a fork that keeps its link to the original, so upstream changes can still be merged.

| Mod | Fork | Upstream |
| --- | --- | --- |
| filetree | [mvacoimbra/claude-code-filetree](https://github.com/mvacoimbra/claude-code-filetree) | [data-goblin/claude-code-filetree](https://github.com/data-goblin/claude-code-filetree) |
| skins | [mvacoimbra/claude-skins](https://github.com/mvacoimbra/claude-skins) | [hellosverre/claude-skins](https://github.com/hellosverre/claude-skins) |

## Install

```bash
claude plugin marketplace add mvacoimbra/claude-mods
claude plugin install filetree@claude-mods
claude plugin install skins@claude-mods
```

## Update

After pushing to a fork:

```bash
claude plugin marketplace update claude-mods
claude plugin update <mod>@claude-mods
```

Then restart Claude Code.

## Add a mod

1. `gh repo fork <owner>/<repo> --clone` next to this folder.
2. Add an entry to `.claude-plugin/marketplace.json` with `"source": { "source": "github", "repo": "mvacoimbra/<repo>" }`.
3. Add a row to the table above.
