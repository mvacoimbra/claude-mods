# claude-mods

My Claude Code mods, as one marketplace. `/mods` is the only command: it opens one pane with a
tab per installed mod ([claude-mods-hub](https://github.com/mvacoimbra/claude-mods-hub)). Each
other entry points at a fork that keeps its link to the original, so upstream changes can still
be merged.

| Mod | Tab in `/mods` | Fork | Upstream |
| --- | --- | --- | --- |
| mods | the pane itself | [mvacoimbra/claude-mods-hub](https://github.com/mvacoimbra/claude-mods-hub) | |
| cache-tax | Keep warm | [mvacoimbra/cache-tax](https://github.com/mvacoimbra/cache-tax) | [karanb192/cache-tax](https://github.com/karanb192/cache-tax) |
| skins | Skins | [mvacoimbra/claude-skins](https://github.com/mvacoimbra/claude-skins) | [hellosverre/claude-skins](https://github.com/hellosverre/claude-skins) |
| filetree | Files | [mvacoimbra/claude-code-filetree](https://github.com/mvacoimbra/claude-code-filetree) | [data-goblin/claude-code-filetree](https://github.com/data-goblin/claude-code-filetree) |
| savvy-progress | Agents | [mvacoimbra/claude-kit](https://github.com/mvacoimbra/claude-kit) (`plugins/savvy-progress`) | [johnnyvizz/claude-kit](https://github.com/johnnyvizz/claude-kit) |
| replay-theater | Replay | [mvacoimbra/claude-code-playground](https://github.com/mvacoimbra/claude-code-playground) (`claude-code/mods/replay-theater`) | [anthropics/claude-code-playground](https://github.com/anthropics/claude-code-playground) |
| blast-radius | none: it asks before a risky shell command | [mvacoimbra/claude-code-playground](https://github.com/mvacoimbra/claude-code-playground) (`claude-code/mods/blast-radius`) | [anthropics/claude-code-playground](https://github.com/anthropics/claude-code-playground) |

## The redesign

Every mod is drawn from one shared kit (`claude-mods-hub/kit`), in Claude Code's own idiom and
the skin chosen in skins, and every setting is the user's, the same in every session. It is
on every repo's `main`.

Before it, every repo was tagged `pre-redesign`. To go back exactly to that point (every mod
reinstalled from the tag, the plugin stores restored from the backup taken then), from the
`claude-mods` folder:

```bash
sh marketplace/scripts/rollback-redesign.sh
```

## Install

```bash
claude plugin marketplace add mvacoimbra/claude-mods
claude plugin install mods@claude-mods
claude plugin install cache-tax@claude-mods
claude plugin install skins@claude-mods
claude plugin install filetree@claude-mods
claude plugin install savvy-progress@claude-mods
claude plugin install replay-theater@claude-mods
claude plugin install blast-radius@claude-mods
```

## Update

Bump `version` in the fork's `.claude-plugin/plugin.json` (an update only installs a new version number, not a new commit), push, then:

```bash
claude plugin marketplace update claude-mods
claude plugin update <mod>@claude-mods
```

Then restart Claude Code.

## Add a mod

1. `gh repo fork <owner>/<repo> --clone` next to this folder.
2. Give it a noun with `panel` and `act` as [the hub's protocol](https://github.com/mvacoimbra/claude-mods-hub/blob/main/PROTOCOL.md) says, drop its slash commands, and add its noun to the hub's `MODS` table.
3. Add an entry to `.claude-plugin/marketplace.json`: `"source": { "source": "github", "repo": "mvacoimbra/<repo>" }`, or for a mod in a subfolder `{ "source": "git-subdir", "url": "https://github.com/mvacoimbra/<repo>.git", "path": "<folder>", "ref": "main" }`.
4. Add a row to the table above.
