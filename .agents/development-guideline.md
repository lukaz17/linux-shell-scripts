# Development Guideline

## Exploring

Reuse before writing new code; go through these in order and stop at the first that applies:

- Does it already exist in this codebase? Reuse the helper, util, or pattern that's already here; don't rewrite it.
- Does a closely matching implementation that needs adaptation exist in this codebase? Report it and propose extending it before writing anything new.
- Does the standard library already do this? Use it.
- Does a native platform feature cover it? Use it.
- Does an already-installed dependency solve it? Use it.
- Would a well-maintained new dependency solve it? Propose it with its name, version, and license before adding it; its license must be compatible with the project's.
<!-- Project-specific / Exploring -->

## Writing

When writing code, follow these rules:

- Write the minimum that satisfies the task; never cut safety: validation, error handling, security, accessibility; see [Security](#security).
- Make targeted edits, never whole-file regeneration; every changed line must trace to the request.
- Keep one job per unit at every scale (function, type, module); if describing its job needs "and", split it. Parsing, domain rules, persistence, external calls, presentation, and wiring stay in separate homes.
- Find every usage of a symbol, config key, route, or file you change, by text search as well as code references, including tests and docs; make sure a signature or behavior change doesn't introduce a new bug or leave a bug half-fixed.
- Report unrelated findings instead of fixing them.
- Remove what your change orphaned (unused code, imports, tests, files).
- Update the docs that describe changed behavior (README, API docs, examples) in the same change.
- Treat public APIs, config keys, CLI flags, and persisted data formats as contracts; ask before breaking one, and call out the break.
- Never silence a linter, type checker, compiler warning, or test to get a clean run; fix the cause, or add a narrowly scoped suppression with a *why* comment.
- Never hand-edit generated files or lockfiles; change their source or use the tool that owns them, then regenerate.
<!-- Project-specific / Writing -->
- Create the top-level script with the executable bit set (git mode 100755); only `shared/` libraries may be non-executable.

## Security

When writing code or verifying changes, follow these rules:

- Keep authorization checks beside the operation they protect, or centralized in one enforced policy layer.
- Perform input validation at trust boundaries. Boundaries are external APIs, databases, file systems, clocks, queues, UI events, network calls, subprocesses, generated code.
- Grant least privilege: the narrowest permissions, token scopes, file modes, and network exposure that work.
- Use the standard library or a well-maintained, established library for auth and crypto.
- Prefer the standard library or a well-maintained, established library for parsing and serialization.
- Prefer allowlists over denylists when validating input, permissions, and file types.
- Never build queries, shell commands, markup, or code by concatenating untrusted input; use parameterized queries, argument lists, and context-aware escaping.
- Never log secrets, tokens, and sensitive data in error messages and logs.
- Never hardcode secrets or commit them to the repository; read them from the environment or a secret store.
<!-- Project-specific / Security -->

## Fixing

When fixing issues, follow these rules:

- Fix the root cause, not just the symptom.
- Write a test that reproduces the bug first, watch it fail, then make it pass.
- Search for the same defect elsewhere and report other occurrences; fix them only when the task covers them.
<!-- Project-specific / Fixing -->
- For fixing: reproduce by running the failing script, capture and quote its output, fix, then re-run the same invocation and quote the passing result. There is no test or testing framework.
- For refactoring, run the touched script(s) before and after; behavior must not change.

## Refactoring

When restructuring code without changing its behavior, follow these rules:

- Run the relevant tests before and after; behavior must not change.
- For deduplication, only merge true duplication (copies that must always change together, owned by the same actor); merging accidental lookalikes is harder to undo than leaving them apart.
- Run audit or cleanup work spanning more than one batch as a workstream: once the user consents to it, create `workstream.md` from [memory-template.md](memory-template.md), record the baseline before the first change, keep one intent per batch, verify after each batch, and keep `workstream.md` current.
<!-- Project-specific / Refactoring -->

## Testing

With a test harness, follow these rules when writing and running tests:

- Write one concept per test; split a test whose name needs "and"; prefer behavior-focused names.
- Write at least three deterministic expectations for each changed behavior, spread across tests as needed, and make sure at least one fails against the unchanged code.
- Cover boundaries and failure paths (empty, null, limits, invalid input, errors), not just the happy path.
- Keep arrange, act, and assert visibly distinct through code structure, not comments.
- Keep results deterministic: no sleeps or timing guesses; unit tests make no real network, filesystem, or clock call, and integration tests use only isolated, disposable resources (temp directories, local containers).
- Keep tests independent: each test sets up its own state and passes alone or in any order; never rely on another test's leftovers or on shared mutable state.
- Keep unit tests fast enough to run after every change; slow work belongs in integration tests.
- Assert on outcomes, not implementation.
- Treat a flaky test as a bug to fix; never rerun it until it passes.
- Treat a test that already failed before your change as a known failure only once the user confirms it.
- Never weaken, skip, or delete failing tests: restore the test, fix the code, or report the conflict and stop.
<!-- Project-specific / Testing -->

## Common Mistakes

Check your diff against these failure patterns; each must be fixed before completion:

- Hallucinated API: a function, method, option, or config key not in this codebase or the installed version => verify at the installed version, replace or remove.
- Unverified dependency: a new package or import without checking its registry name, version, license, or whether an installed dependency does the job => confirm the exact name/version (an invented name may be attacker-registered) and that its license is compatible with the project's; prefer what is installed.
- Context loss: a stale or partial read that contradicts existing code, restores deleted code, or drops error handling in a rewrite => re-read target files, callers, tests.
- Scope creep: changed lines that trace to no request such as drive-by renames, reformatting, dependency bumps => revert them and report instead.
- Duplicated implementation: a helper or sibling variant paralleling one that exists => search before writing, extend the original, merge only true duplication, never code owned by different actors.
- Wrong-file gravity: logic added to whatever file was open, a god file growing, a new file at the repository root or current directory => place by role per [context.md's Layout](../.attunic/context.md#layout), falling back to [project-structure.md](project-structure.md).
- Phantom success: "should work now" with nothing run; a stub, pass, placeholder, or demo value presented as done => run the check and quote the result, name what did not run, and state plainly what remains.
- Test weakening: an assertion loosened; a test skipped, deleted, or rewritten to match the bug, a snapshot re-accepted unread => restore the test and fix the code, or report the conflict and stop.
- Silent architecture drift: a new import cycle; or, when [context.md's Layer Dependencies](../.attunic/context.md#layer-dependencies) declares architecture layers, an import against the declared direction, a skipped architecture layer, or an ORM, framework, or HTTP type in a business rule, unless listed in its [Deliberate Exceptions](../.attunic/context.md#deliberate-exceptions) => break the cycle, check every changed file's imports against the table, keep framework types at the boundary.
- Missing validation: an input from a trust boundary accepted unchecked, including empty, null, or boundary values => validate at the boundary where the data enters.
- Missing error handling: a failing path swallowed or ignored, such as an unchecked error or an empty catch => handle it, wrap it, or propagate it explicitly.
- Silenced diagnostic: a lint, type-check, or compiler suppression or a disabled rule added to get a clean run => fix the cause, or scope the suppression narrowly with a *why* comment.
- Edited generated file: a hand edit to generated output or a lockfile => revert it, change the source, and regenerate.
- Stale docs: docs, examples, or comments still describing the old behavior => update them in the same change.
- Padded prose: filler or meaningless words in comments or docs, or a sentence restating the one before it => cut them.
- Unannounced breaking change: a public API, config key, CLI flag, or persisted data format changed without the user's agreement => restore compatibility or ask, then call out the break.
<!-- Project-specific / Common Mistakes -->

## Shell

### Shell-Exploring

<!-- Project-specific / Shell-Exploring -->

### Shell-Writing

<!-- Project-specific / Shell-Writing -->

### Shell-Security

<!-- Project-specific / Shell-Security -->

### Shell-Fixing

<!-- Project-specific / Shell-Fixing -->

### Shell-Refactoring

<!-- Project-specific / Shell-Refactoring -->

### Shell-Testing

- Guard `main "$@"` behind `[[ "${BASH_SOURCE[0]}" == "${0}" ]]` so a test can load its functions without running it.
- Assert on exit status and stdout/stderr, not on incidental formatting; use real temp directories, cleaned up in teardown.
- Add a test for every argument-parsing edge case and every past incident: a missing argument, an unwritable path, a missing dependency on `PATH`.
<!-- Project-specific / Shell-Testing -->

### Shell-Common Mistakes

- Unquoted expansion: `$1`, `$var`, or `$@` left unquoted, breaking on a space, a glob character, or an empty value => quote it (`"$var"`, `"$@"`).
- Parsed `ls`: parsing `ls`, or any column-formatted command output => use `find`, a glob, or a tool with stable output.
- String-built command: `eval`, or a command built as a string and piped to `sh -c` => use a plain array or a function call.
- Backtick substitution: backticks for command substitution => use `$(...)`.
- Unchecked `cd`: a `cd` whose failure goes unnoticed, so later commands run against the wrong files => check it (`cd "$dir" || exit 1`).
- Monolithic script: hundreds of lines with no functions and no `main` => split the logic into functions called from one `main "$@"`.
<!-- Project-specific / Shell-Common Mistakes -->
- Positional arguments usage in body: a positional parameter (`$1`, `${2}`) referenced anywhere inside a function body, instead of being bound to an `_`-prefixed name at the top.
- Missing script usage and strict guard: a top-level script whose top lacks the banner comment or a `set` guard.
- Unexecutable script: a script nowhere `$PATH`-invokable: a top-level script missing the executable bit.

## Checklist

Before considering any coding task complete, verify the following to ensure nothing is missed during implementation:

- [ ] The task's requirements are fulfilled; acceptance criteria (if any) are verified against real behavior, not assumed from passing tests.
- [ ] The project builds successfully, if it has a build step (see [context.md's Supporting Tools](../.attunic/context.md#supporting-tools)).
- [ ] Code files are formatted and pass static analysis (see [context.md's Supporting Tools](../.attunic/context.md#supporting-tools)).
- [ ] Changed code files follow project convention (see [coding-conventions.md](coding-conventions.md)).
- [ ] The complete final diff has been read line by line; every change is intentional and understood.
- [ ] Changes are reviewed for security requirements (see [Security](#security)).
- [ ] Changes are reviewed for common mistakes (see [Common Mistakes](#common-mistakes)).
- [ ] Every usage of changed symbols, config keys, routes, and files is checked; no signature or behavior change left half-applied (see [Writing](#writing)).
- [ ] New/changed behavior has test coverage.
- [ ] Relevant tests are passing, except known failures the user confirmed (see [Testing](#testing)).
- [ ] No unused code, debug prints, or commented-out blocks left behind.
- [ ] New or moved top-level files and folders are reflected in [context.md's Layout](../.attunic/context.md#layout) (prompt the user per its rule).
- [ ] Project knowledge the user gave during the task that a later agent couldn't derive and would otherwise have to guess or ask about, exceptions included, is named in the report, for the user to record in the project memory (see [attunic-protocol.md's Write Rules](attunic-protocol.md#write-rules)).
- [ ] [context.md](../.attunic/context.md) entries and [memory.md](../.attunic/memory.md) facts the task made stale, or found contradicted by the project, are named in the report, for the user to update or remove (see [attunic-protocol.md's Write Rules](attunic-protocol.md#write-rules)).
- [ ] Open questions are recorded in [question.md](../.attunic/question.md) per [attunic-protocol.md's Write Rules](attunic-protocol.md#write-rules), each once the user explicitly confirms it (unconfirmed ones are named in the report).
- [ ] Every applicable item above was verified by actually running the check; anything not run is explicitly reported, not claimed.
<!-- Project-specific / Checklist -->

## Project-specific

<!-- Project-specific / Project-specific -->
