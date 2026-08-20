# Simple Language — porting conformance

The brief for anyone porting Simple Language to another platform (Codex, Grok, Antigravity, or one that doesn't exist yet). This is not the skill. The reference text is [`skills/simple-language/SKILL.md`](skills/simple-language/SKILL.md).

**A port is a translation, not a rewrite.** Translate the mechanics — hook plumbing, manifest format. Keep the meaning. If a rule below is missing from your port, the port is wrong, however good it reads.

## Rules that must survive the port

Any wording. All present.

1. **Check who the reader actually is, before writing.** The skill fires when the reader is non-technical, or when technical work is being reported to someone who did not do it. It does **not** fire for a technical reader who asked for detail, or a trivial one-line exchange.
2. **Altitude first.** Open with the goal in business terms, where things stand right now, and why this piece matters to that goal — *before* any detail. Then descend gradually: goal, then this piece's job, then what was found. Never open on the detail and hope the reader reconstructs the altitude.
3. **One idea per sentence.** Short sentences.
4. **Jargon is deleted or defined in a line — never used bare.**
5. **Say the number and the unit.** "494 rows under a sign saying 1,747" beats "a count mismatch".
6. **Findings and actions are separate.** What you found is not what they must do. Put the ask near the top, not in paragraph four, and make it answerable in one word where possible.
7. **Re-anchor in long sessions.** A proper noun that stood alone an hour ago means nothing now. Restate the altitude when the subject changes; a run of status-shaped messages gets the altitude once at the start of the run, and again the moment something needs a decision.
8. **Metaphors map the mechanism, not the mood.** One per idea. Drawn from ordinary life. If it has to be explained, it failed — cut it. A metaphor that implies a wrong prediction is worse than none.

## Free to change — and expected to

- **Wording, voice, and every example.** The worked example exists to demonstrate the method, not to be preserved.
- **The jargon list.** It should carry the words that platform's users actually meet.
- **Hook and manifest mechanics** — whatever that platform's format is.
- **The trigger phrasing**, so long as the fire/skip boundary in rule 1 lands in the same place.

## Never change these

- **Simplifying is choosing what to leave out, never changing what is true.** If the simple version would mislead, add a sentence. Accuracy is not the thing being traded away.
- **Plain language must never soften the unwelcome part.** Simple is not gentle. A risk, a cost, or a mistake you made gets *clearer* in short words, not softer. "This will break again next month" is both simple and direct.
- **Never hedge until nothing is claimed.** State it, then state your confidence separately.
- **Declare only when genuinely run.** The `SKILLS` row names this skill when it actually shaped the response. Approximating the style from memory and then claiming the row is exactly the failure the row exists to expose.
- **The run box shape:** one fenced code block, one row per skill that genuinely ran, left rail only, **no right-hand border**, last thing in the response — unless a later always-last postmark skill is installed, which defines itself as coming after.

## Wiring checklist for a new platform

- [ ] Plugin manifest in that platform's own folder and format — never share a folder with another platform's manifest.
- [ ] Hook path uses **that platform's own root variable**. `${CLAUDE_PLUGIN_ROOT}` is Claude Code's. If you do not know the platform's variable, find out or use an absolute path — do not borrow another platform's.
- [ ] The hook emits valid single-line JSON, verified by running it.
- [ ] `.ps1` and `.sh` both present where the platform runs on both Windows and Unix, and both emit identical text.
- [ ] No discoverable skill or hook left at the repo root, where two platforms could both load it.
- [ ] Version set in that platform's manifest — and **bumped on every change**, or installers will not pick the change up.

## Checking a port

Structural checks are automatable: files exist, manifests parse, the hook emits valid JSON, no cross-platform leakage.

The rules above are **not** automatable, and should not be turned into exact-phrase greps. They say "any wording" on purpose; a grep for a phrase forces one wording and defeats the point of a port. A person or a reviewing agent reads the port against this list. That reading is the check.

The sharpest test for this particular skill: hand the port's output to someone who was not in the room, wait an hour, and ask them to explain it back. If they can't, the port describes rather than explains — which is the exact failure the skill exists to prevent.
