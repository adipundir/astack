---
name: git-safe-sync
description: Use this every time before running git pull, git push, git rebase onto a shared branch, or anything that exchanges commits with origin. It bakes in the "don't overwrite anyone else's code" rules.
---

# git-safe-sync

The non-negotiables:

1. **Never `git push --force` / `--force-with-lease`** unless the user has explicitly asked for that specific push. Never to `main` even with permission; push the rewrite to a branch and let the user decide.
2. **Never resolve a merge/rebase conflict by silently picking one side.** Blatantly deleting someone else's work is the worst failure mode. Read both sides and preserve both intents where reasonable. Reuse a conflict-resolution strategy already approved in this session; ask only about a new tradeoff that approval does not cover.
3. **Never skip the pre-push fetch.** A push that races a teammate's commit can clobber their work (GitHub protects `main` but you can still rewrite feature branches).

## Before `git push`

A pull or conflict resolution does not authorize publishing code. Follow the user's current push-approval requirements; prepare the concrete commits before asking.

Run this sequence in order:

```
1. git status --short          # working tree clean? anything unstaged you meant to add?
2. git fetch origin <branch>   # see what's on remote
3. git rev-list --left-right --count HEAD...origin/<branch>
```

Interpret the counts:

- `X 0` — local is ahead only. Safe to push.
- `0 X` — local is behind only. Don't push; `git pull --rebase` first, then re-evaluate.
- `X Y` (both non-zero) — diverged. `git pull --rebase` (or merge per repo policy), resolve any conflicts per the rules below, then push.

Only after the above, run `git push` (plain — no `--force`).

## Before `git pull`

```
1. git status --short                        # anything uncommitted that could be lost?
2. if dirty: preserve-and-restore (see below). do NOT use `git stash` if the repo
   forbids it — check AGENTS.md / AGENTS.md for rules like "Do not use git stash
   unless explicitly requested".
3. git fetch origin <branch>
4. git rev-list --left-right --count HEAD...origin/<branch>   # classify divergence
5. git pull --rebase           # rebase keeps history linear; use merge if repo policy says so
6. if you preserved files in step 2: restore them (see below)
```

If the pull reports conflicts, stop and use the conflict rules below.

### Dirty-tree preserve-and-restore (no-stash flow)

Default to this when the repo forbids `git stash` or when you want a visible audit trail.

```
1. Make a backup branch pointing at HEAD — cheap insurance:
     git branch backup-pre-sync-<yyyymmdd>
2. Preserve tracked changes outside the working tree. Keep each relative path
   (for example `src/a/config.ts` and `src/b/config.ts`) rather than flattening
   basenames, which can overwrite one backup with another. Record staged state,
   deletions, renames and binary changes with both patches as well:
     git diff --binary > /tmp/sync-preserve-<unique-id>-worktree.patch
     git diff --cached --binary > /tmp/sync-preserve-<unique-id>-index.patch
   Copy existing modified file bytes into matching relative backup paths before
   restoring them. Keep untracked files in place; preserve any that would collide
   with incoming tracked files before proceeding.
3. Discard the tracked modifications so the working tree is clean:
     git restore --staged --worktree <modified-file> ...
   (Untracked files survive — no action needed for them.)
4. Proceed with `git fetch` + `git pull --rebase`.
5. After the rebase, diff the remote version of each preserved file against your .mine copy:
     diff -u <relative-path> /tmp/sync-preserve-<unique-id>/<relative-path>.mine
   - No remote change to that file → copy .mine back over it.
   - Remote also changed it → classify the conflict like a merge conflict
     (see rules below), present to user, apply the resolution.
   - File was deleted on remote → apply an explicitly approved deletion strategy, or ask whether to restore it
     (deletion vs modification is a judgment call — never silent).
   Restore the intended staged/unstaged distinction using the saved index patch,
   reviewing overlaps instead of blindly applying it over remote changes.
6. Rerun `npm install` / `db:generate` / etc. for any machine-generated files
   (`package-lock.json`, Drizzle migrations, generated types) to sync them to
   the new state instead of copying your old version.
```

### Diverged after a force-push (both counts non-zero, `forced update` in fetch output)

When the remote says `(forced update)`, history was rewritten upstream. Your
local commits may already be represented on remote under different SHAs
(common after squash/rebase-main cleanup). Do NOT assume they must be
preserved as-is, and do NOT `git reset --hard` without confirming.

```
1. git cherry -v origin/<branch> HEAD      # classify each local commit:
                                            # '-' = equivalent exists on remote (safe to drop)
                                            # '+' = no equivalent on remote (may be real unique work)
2. For each '+' commit, inspect its patch and any candidate remote equivalent:
     git show <local-sha>
     git show <candidate-remote-sha>
   A matching title is only a search hint, not evidence of equivalent work.
   Confirm the actual changes before treating a local commit as redundant.
3. If ALL local commits are equivalent → safe to rebase (will auto-drop them).
   Just run `git pull --rebase` — no reset needed.
4. If some local commits are truly unique → rebase replays them. If that creates
   conflicts, use the Conflict rules section.
5. Only propose `git reset --hard origin/<branch>` if the user explicitly asks
   to discard local and you have a backup branch in place. Never as the default.
```

**Never** `git reset --hard` in response to "I just want the latest code."
That phrasing authorizes a pull, not a discard.

## Conflict rules

When git writes `<<<<<<<` / `=======` / `>>>>>>>` markers into a file, do **not** just pick a side. Work through every conflict:

1. **Read both halves fully.** Understand what each side is trying to do semantically, not just textually.
2. **Classify the conflict:**
   - *Independent additions* (e.g. both sides added different imports / different new fields / different new functions) → keep **both**.
   - *Same-line tweaks* (e.g. both sides renamed the same variable differently) → use an approved strategy, or ask and leave the choice unresolved until answered.
   - *Semantic overlap* (both sides changed the same behavior for different reasons) → identify a merge that honors both intents; apply an approved strategy or obtain approval before writing the resolution.
   - *Deletion vs. modification* → ask unless existing approval explicitly settles the deletion. Preserve the work while waiting; a pull alone does not authorize discarding it.
   - *Machine-generated files* (e.g. `package-lock.json`, Drizzle migrations, generated types) → take the newer of the two and then re-run the generator (`npm install`, `npm run db:generate`, etc.). Verify the regenerated output is consistent with both sides of source changes.
3. **Use existing authorization first.** If the user has already approved a
   concrete resolution strategy, apply it to conflicts covered by that strategy
   and report what was preserved. Do not ask again for each file. Mechanical
   combinations of independent changes can proceed during an authorized sync.
   For an uncovered semantic tradeoff, present the conflict before writing it:

   > Conflict in `<file>` around `<symbol>`:
   > - Your change: <one-sentence summary>
   > - Remote change: <one-sentence summary>
   > - Proposed resolution: <the merge>
   >
   > OK to apply?

   Pause only for a decision the current authorization does not settle. A
   request to pull does not authorize discarding unique local work or choosing
   between incompatible product behaviors without an approved strategy.
4. **Remove every conflict marker** from the file before staging. A dangling marker means the resolution is incomplete.
5. After staging resolved files, re-run whatever type-check / lint / test / build is standard for the project. If those fail, the resolution is broken — fix it, don't ship a red build.

## When a resolution looks wrong, back out

- `git merge --abort` / `git rebase --abort` restores the pre-attempt state. Use it whenever the merge turned into something you can't confidently explain.
- Offer the abort path to the user instead of forcing through a conflict you don't understand.

## When the user asks for a force-push

1. Confirm: "This will rewrite remote history on `<branch>`. Anyone who has pulled it will need to reset. Proceed?"
2. Only proceed on an unambiguous yes.
3. Prefer `--force-with-lease` over `--force`; it refuses if the remote advanced since your last fetch.
4. Do not force-push `main`, `master`, `prod`, or another protected branch.
   Prepare the rewrite on a separate branch for review instead. Approval for an
   ordinary push never authorizes a history rewrite.

## Summary

Before every sync action: **fetch, compare, then act.** For conflicts: **read both sides, classify, apply an approved strategy or ask about uncovered tradeoffs.** Never delete someone else's code blindly — duplicated lines are always easier to untangle than lost ones.
