#!/bin/sh
# Emits the simple-language UserPromptSubmit reminder as compact JSON.
# macOS/Linux counterpart to simple-language-reminder.ps1 - see README.md
# for how to point hooks/hooks.json at this script instead.

msg="Simple Language (per the simple-language skill): before you write this response, check who it is actually for. If the reader is non-technical, or this is a status or technical report going to a non-technical owner - a PR review, findings, financial or tax work, anything drafted for them to send - actually INVOKE the simple-language skill rather than approximating its style from memory. Lead with 40,000-ft altitude: the goal, where things stand right now, and why this piece matters to that goal - before any detail. SKIP all of this for a clearly technical reader who asked for detail, or a genuinely trivial one-line exchange. If, and only if, you genuinely invoked and applied the skill this turn, end your response with one compact line in exactly this form: Skills used: simple-language - and if other qualifying skills also fired this turn, combine them on that SAME line, comma-separated, e.g. Skills used: simple-language, world-class. State this only when the skill was genuinely used, never as decoration, and never claim use if it was skipped."

printf '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"%s"}}\n' "$msg"
