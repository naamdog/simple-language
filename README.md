# Simple Language

A plugin for Claude Code and Grok Build that keeps status reports, findings, and technical explanations readable by whoever they're actually written for - automatically, without having to ask for "plain English" every time.

## What it does

Ships a skill (`simple-language`) plus a `UserPromptSubmit` hook that checks, on every turn, who the response is actually for:

- If the reader is non-technical, or the response is a status/technical report going to a non-technical owner (PR reviews, findings, financial or tax work, anything drafted for them to send), the hook tells the model to actually invoke the `simple-language` skill rather than approximating its style from memory.
- The skill leads with the 40,000-ft view - the goal, where things stand, and why the piece in front of the reader matters to that goal - before descending into detail.
- It skips itself for a clearly technical reader who asked for detail, or a genuinely trivial one-line exchange.
- When the skill genuinely fires, the response ends with a one-line declaration - `Skills used: simple-language` - so you can see, turn by turn, whether it actually ran. If other qualifying skills fire the same turn, they land on that same line, comma-separated.

## Why it exists

The skill itself works well once it's invoked - the problem is remembering to invoke it. Left to habit, technical explanations drift back into technical language the moment a response feels like "just a quick update," even when the reader wasn't in the room for any of the underlying work. The hook removes the remembering: it runs automatically on every prompt and puts the check in front of Claude before it starts writing, not after the fact.

## Install for Grok Build

```powershell
grok plugin marketplace add naamdog/simple-language
grok plugin install simple-language --trust
```

Or install it with the other naamdog Grok plugins from one marketplace:

```powershell
grok plugin marketplace add naamdog/grok-plugins
grok plugin install simple-language --trust
```

Start a new Grok session so the skill and hook load. Manage it with `grok plugin list`, `grok plugin disable simple-language`, or `grok plugin uninstall simple-language`.

## Install for Claude Code

In any Claude Code session:

```
/plugin marketplace add naamdog/simple-language
/plugin install simple-language@simple-language
```

Start a new session (or restart Claude Code) so the skill and hook load. Manage it any time with `/plugin list`, `/plugin disable simple-language`, or `/plugin uninstall simple-language@simple-language`.

## macOS / Linux note

The hook ships two versions of the reminder script. Both emit the exact same single-line JSON:

- `hooks/simple-language-reminder.ps1` - Windows (PowerShell). This is the one wired up in `hooks/hooks.json` by default.
- `hooks/simple-language-reminder.sh` - macOS/Linux (POSIX `sh`).

If you're on macOS or Linux, switch `hooks/hooks.json` over to the `.sh` script:

1. Make it executable once (it's already tracked with the executable bit set, but if that's ever lost): `chmod +x hooks/simple-language-reminder.sh`
2. Edit `hooks/hooks.json` and replace the PowerShell `command` value with:
   ```
   "\"${CLAUDE_PLUGIN_ROOT}/hooks/simple-language-reminder.sh\""
   ```

`hooks.json` can't hold comments, which is why this note lives here instead.

## License

MIT - see [LICENSE](LICENSE).
