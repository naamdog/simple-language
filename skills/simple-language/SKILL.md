---
name: simple-language
description: Use when explaining technical work, findings, or decisions to a non-technical reader — and ALWAYS when the user says "simple language", "plain English", "break it down", "explain it simply", "use metaphors", "ELI5", "I don't understand", "you're hard to understand", or asks you to repeat something more simply. Also use proactively when reporting engineering, financial, legal or tax work to someone who did not do that work: code reviews, PR summaries, dependency failures, tax research, architecture decisions, status updates. Do NOT use when the reader is clearly technical and asked for detail.
---

# Simple Language

## Overview

Explaining technical work to a non-technical reader is a translation job, not a summarising job. Most explanations fail because they are shorter but still written in the original language.

The reader is not less intelligent than you. They are less *loaded* than you. They do not have the twenty pieces of context that make your sentence obvious. Write for someone smart who just walked in.

**The test:** could they repeat your explanation to someone else, correctly, an hour later? If not, you described it. You did not explain it.

## The 40,000-ft view — the rule everything else depends on

Before any detail, spend two or three sentences on where this sits in the bigger picture. The reader has been away from it. You have not. That gap is the single biggest reason explanations fail. This comes before all the other rules, and it is the one most likely to get skipped — see "Where this fails in practice" below.

Fill this in, literally, before writing anything else:

- **Ultimate goal (business terms, not technical):** what are we actually trying to get to? Not "review the ledger stack" — "so the three of you can legally take money out of the company."
- **Where we are on that road:** "It's built. Nobody has checked it. Checking it is today."
- **Why this piece matters to that goal:** what happens to the goal if this specific piece is wrong.

Then descend into the detail. Never open on the detail and hope the reader reconstructs the altitude — they will not, and everything after it lands as noise.

**The altitude test:** if the reader asked "yes, but why are we doing this at all?" and your explanation cannot answer it, you started too low.

Descend gradually. 40,000 feet (the goal) → 10,000 feet (this piece's job) → ground level (what you found). Do not jump from the goal straight to a line number.

### What altitude actually looks like

The rule is easy to nod along to and hard to do. Here is the same finding, twice.

**Ground level — technically accurate, and useless to the reader:**

> The seed file had the supplier rate at 240. The live table is read separately at runtime, so the running app was unaffected. I've corrected it to 210 and opened a pull request.

Every word is true. The reader has no idea whether to care.

**With altitude — same facts, same length:**

> You pay each supplier a set rate per order. Getting that number wrong means paying the wrong amount, so it's worth knowing when it drifts.
>
> One had drifted: a leftover file still said £240 after you agreed £210. **The good news is it was a stale copy, not the number the system actually bills from — so nobody was ever charged wrongly.** I've corrected it anyway, because the next person to read that file would have believed it.

The second version answers "why should I care" before saying what happened. Note the order: goal, then reassurance, then the detail. A reader who stops after two sentences still leaves with the right impression.

**The tell:** if your first sentence contains a filename, a function name, or a number, you started at ground level. Move it to sentence three.

### Where this fails in practice

The rule is easiest to follow on a single big report and easiest to drop during a long, fast, mechanical session — reviewing several PRs back to back, checking a board repeatedly, cross-referencing card numbers and commit SHAs. Each individual message feels like "just an update," not "an explanation," so the instinct to add altitude doesn't fire — even though the reader's context gap is exactly the same as it would be in a single big report. **Mechanical does not mean the reader needs less altitude. It usually means they need it restated more often, because the thread is getting longer, not shorter.**

If a stretch of messages is going to be status-check-shaped (PR states, board sweeps, "still waiting"), do the altitude sentence once at the start of the stretch, not on every single message — but do re-anchor the moment something in that stretch actually needs a decision or explanation, per "Keeping altitude in a long session" below.

## The rules

**1. Lead with what it means for them, not what happened.**
Not "the lockfile pinned a different patch version" but "two lists got out of step, and here's what that cost you."

**2. One idea per sentence. Short sentences.**
If a sentence has a comma-then-which in it, it is two sentences wearing a coat.

**3. Delete the jargon or spend a line defining it.** Never use it bare.
Words that need this: repo, lockfile, dependency, type-check, PR, merge, branch, CI, deploy, endpoint, schema, API, migration, PAYE, apportionment, treaty article, accrual.

**4. Say the number and the unit.** "494 rows under a sign saying 1,747" beats "a count mismatch."

**5. Name what they must DO, separately from what you found.**
Findings and actions are different things. Do not braid them.

**6. Give one-word answers where you can.**
"Say merge it or wait." A reader who can reply in one word will reply. A reader who must compose a paragraph will postpone.

**7. Never soften a real problem into vagueness.**
Simple does not mean gentle. "This will break again next month" is simple AND direct. Say the hard thing in short words.

**8. The plain version should be SHORTER. Usually much shorter.**
This is the rule most often broken, because every other rule in this file adds words — altitude adds a paragraph, metaphors add a sentence, glossing jargon adds a clause. Left unchecked, "plain English" becomes a longer document that is merely easier to read, which is not the goal. The goal is that they finish it.

Working targets, not laws:
- **A status update: under 200 words.** If it needs more, it is two updates.
- **A finding or a decision: one screen.** They should not scroll to reach the ask.
- **Never more than three headings** unless the reader explicitly asked for a full report.

Simplifying means *choosing what to leave out*. If your plain version is longer than the technical one, you translated but never chose. Go back and cut — the detail you are protecting is almost always for your benefit, not theirs.

**The cut test:** delete your longest paragraph. If the reader can still act correctly, leave it deleted.

## Metaphors

A metaphor is the highest-value tool here and the easiest to do badly.

**A good metaphor maps the mechanism, not the mood.** It should let the reader predict what happens next without knowing the technology.

- Two dependency lists out of sync → *"two shopping lists for one recipe, and the robot only updates one of them."* Now they can predict it recurs.
- A badge count disagreeing with the table → *"a shop sign advertising a sale the till doesn't know about."* Now they know why staff stop trusting both numbers.
- An approved change waiting to merge → *"a parcel packed, addressed and stamped, sitting by the door."* Now they know the only missing step is theirs.
- A stale approval after the code changed → *"a signature on a contract, then someone swapped three pages."* Now they know why the tick is worthless.

**Rules for metaphors:**
- One per idea. Stacked metaphors cancel out.
- Draw from ordinary life: post, shops, tools, cooking, keys, filing cabinets, decorating.
- If you must explain the metaphor, it failed. Cut it.
- Never use a metaphor that implies a wrong prediction. Accuracy beats vividness.
- No metaphor is better than a forced one. Some things are just "the test failed."

## Structure

Default shape for any report to a non-technical reader:

0. **Where this sits** — two or three sentences of altitude, per rule 0. The goal, where we are on the way to it, and why this piece matters to it. Skip only if you gave the same altitude earlier in the same conversation and nothing has moved.
1. **The headline** — one or two sentences. What happened and whether it is good or bad.
2. **What I did / what I found** — grouped by *their* concern, not by your chronology.
3. **What needs you** — a short numbered list, each with a one-word answer where possible.
4. **What is still open** — named plainly, with who is holding it.

Put the thing they must act on where they will see it, not at the end after the reasoning.

## Keeping altitude in a long session

In a long working session you will drift back down into jargon without noticing, because each message builds on the last one and *you* never lost the thread. The reader did.

- **Re-anchor whenever the subject changes**, or every few exchanges in a long stretch. One sentence is enough: "Reminder of where we are — this is the safety catch that has to go in before the nine changes behind it."
- **Never let a proper noun stand alone the second time.** "Card #294" means nothing an hour later. Say "card #294, the bookkeeping build."
- **If you catch yourself writing a sentence only someone who read the last ten messages could parse, stop and put the altitude back.**

## Anti-patterns

| Don't | Do |
|---|---|
| "The dependency graph had a version skew" | "Two lists of ingredients disagreed" |
| "It's non-trivial" | Say how long it takes, or what it costs |
| "There were some issues" | Say what broke, and what it means |
| "Per the guidance in EIM40004…" | "HMRC's own manual says…" then the plain point |
| Explaining every step you took | Explaining what it changed |
| Burying the ask in paragraph four | Ask in its own line, near the top |
| Hedging so hard nothing is claimed | State it, then state your confidence separately |

## Mixed audiences

The rules above assume one reader. Often there is more than one — an email to a founder and their engineer, a PR description read by a reviewer today and a non-technical colleague next quarter, a report the recipient will forward.

**Write for the least-loaded reader, then add the detail underneath — never the reverse.** A technical reader skims a plain opening in three seconds and loses nothing. A non-technical reader hits a technical opening and stops entirely. The costs are wildly unequal, so the tie always breaks the same way.

The shape that serves both:

1. **Plain summary first** — the altitude, the finding, the ask. Everyone reads this.
2. **Detail below, clearly labelled** — "the specifics" or "what I changed". The technical reader drops into this; the other reader stops at the line above and has still got what they need.
3. **Never split it into two documents.** Two versions drift, and the wrong person gets the wrong one.

**When you can't tell who is reading:** assume non-technical. Being over-explained is a mild irritation; being lost is a dead end.

**One exception.** If the artifact is *only* ever read by specialists — a code comment, a runbook step, a commit message — write it for them properly. Plain language is a service to the reader, not a costume; simplifying past the point of precision is its own failure.

## Two things simple language must never cost

**Accuracy.** Simplifying is choosing what to leave out, never changing what is true. If the simple version would mislead, add a sentence — do not shrug.

**The unwelcome part.** The reason to simplify is so the reader can act. That includes acting on bad news. Never let plain language soften a risk, a cost, or a mistake you made. Short words make hard news clearer, not softer.

## Declare That You Used It

Whenever you genuinely apply this skill, end your response with one compact line:

```
Skills used: simple-language
```

If other declaring skills fired in the same turn, combine them on that **one** comma-separated line: `Skills used: simple-language, world-class`.

This belongs to the skill, not to any one host, so it holds the same in Claude Code, Codex, Grok, or a manual invocation. Three conditions, all required:

- **Only when genuinely used.** Never as decoration. If you correctly skipped the skill — a technical reader who asked for detail, a one-line answer — there is no tag, and that silence is information too.
- **Never instead of the work.** The tag is a receipt, not a substitute for actually writing plainly.
- **One line, at the very end.** A footer, not a heading.

## Worked example

**Before:**
> The CI failure on #239 stems from a `@types/react` version skew between the root workspace lockfile and the CRM lockfile, causing nominal type divergence in `ComponentProps<'select'>` resolution against the JSX intrinsic, surfacing as TS2322 on the ref property in Field.tsx.

**After:**
> The project keeps two shopping lists of its ingredients — one for the main site, one for the CRM. The robot that updates them only knows about the first. So one got upgraded and the other didn't, and a shared part ended up measured against two rulers that were a millimetre apart.
>
> Nothing was wrong with the part itself. **The fix was to bring the second list up to match.** Not one line of the component changed.
>
> If we'd "fixed" the part instead, it would have gone green today and broken again on the next update.

Same facts. The second one is repeatable by the reader.
