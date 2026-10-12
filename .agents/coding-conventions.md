# Coding Conventions

## General

The principles below are for all languages. They use camelCase for demonstration purposes; adapt casing to the language's style.

### Formats

- Keep file content reads top-down: high-level intent first, details descending (newspaper metaphor).
- Keep related things close: declarations near first use, callers near callees.
- Always brace control-flow bodies (if/else, for, while, do, switch, when) even for a single statement; never rely on brace-less bodies.
<!-- Project-specific / Formats -->

### Names

- Use one word per concept across the codebase; never one word for two concepts.
- Use intention-revealing names: the name says why it exists and what it does, with no mental mapping from a terse abbreviation to a concept.
- Include units in names where values carry them (e.g. `timeoutMs`, `maxBytes`).
- Function names: start with a verb, and disclose side effects (`save`, `delete`, `publish`, or `mutate`).
- Acronyms: stay consistently cased (e.g. `ID`, `URL`, `HTTP`, not `Id`, `Url`, `Http`).
- Booleans: name as predicates (`isReady`, `hasItems`, `canRetry`).
- Avoid generic names: (`data`, `manager`, `helper`, `util`, `info`, `result`) when a domain name exists.
- Avoid noise: names that differ only by noise words or loose abbreviations.
<!-- Project-specific / Names -->

### Comments

- Document every exported identifier (constants, vars, types, methods, functions) with a doc comment.
- Write comments explaining *why*, not *what*; the code already shows what it does.
- Cut articles, filler, and hedging; keep IDs, numbers, links, and warnings whole.
- Keep comments short and concise: they should be one to three lines; longer explanations belong in a doc file the comment points to, or an extracted function.
- Keep comments up to date with the code: a stale comment is worse than no comment.
- Keep comments about: non-obvious constraints, legal requirements, algorithmic tradeoffs, external system quirks, warnings of consequences, and TODOs with context and ownership.
- Delete comment noise: redundant restatements, change journals, attributions, banner or position markers, closing-brace labels, and commented-out code.
- Never delete or reword comments a tool reads (shebangs, encoding lines, license and SPDX headers, build and compiler directives, suppressions, doctests, generated-file headers). An unexplained suppression is a finding, not a comment to delete.
<!-- Project-specific / Comments -->

### Errors

- Handle errors explicitly where a meaningful decision can be made.
- Wrap errors with original cause and context when propagating.
- Error strings should be lowercase and not end with punctuation (they're often composed into larger messages).
- Make retry, fallback, timeout, and cancellation behavior explicit.
- Never log secrets, tokens, and sensitive data in error messages and logs.
- Never swallow errors or catch broadly without handling, wrapping, or propagating with context.
<!-- Project-specific / Errors -->

## Shell

### Formats

- Run `shfmt -d .` to check formatting; it must report no files; run `shfmt -w .` locally before committing.
<!-- Project-specific / Shell-Formats -->

### Names

- Name functions and locals `snake_case`; reserve `UPPER_SNAKE_CASE` for exported or readonly globals (`CONFIG_PATH`) so scope is visible at a glance.
- Prefix a sourced library's private functions with the library's name (`_mylib_parse_args`); shell has no real module privacy.
- Name a function for the action it performs (`deploy_release`, never `do_stuff` or `run2`); never a bare `data`/`tmp` for a variable holding one thing.
- Never encode a type into a name (`str_path`, `int_count`); never leave a rename half-done with `_v2`, `_old`, or `_final`.
- Keep a name that short only for a loop index (`for i in`) or a shell idiom (`$#`, `$?`); name anything read later on.
<!-- Project-specific / Shell-Names -->

### Functions And Types

- Wrap logic in functions and call them from one `main "$@"` at the bottom; nothing but definitions runs at the top level.
- Declare every function-local with `local` (`local -r` when it never changes); an undeclared variable leaks into the caller's scope.
- Mark a value that must not change `readonly` right after it is set.
- Keep a function to one job; parsing arguments, doing the work, and printing a report is three functions.
- Pass data through arguments and exit status, not through a global a sibling function set earlier.
<!-- Project-specific / Shell-Functions-And-Types -->

### Errors

- Start every Bash script with `set -euo pipefail` unless a command's failure needs inspecting; document why when turning a flag off for one line.
- Write user-facing errors to stderr (`echo "error: ..." >&2`) and exit with a distinct, documented code per failure class; never let a script fail silently with exit 0.
- Check every command whose failure matters, including `cd` and `mkdir`; `set -e` does not catch a failure inside `if`, `&&`/`||`, or a non-last pipeline stage without `pipefail`.
- Use `trap 'cleanup' EXIT` (and `INT`/`TERM` when the script holds a lock or a temp file) so cleanup runs on every exit path.
- Never swallow a failure with `2>/dev/null` alone; redirect, then act on the exit status, or let the error surface.
<!-- Project-specific / Shell-Errors -->

### Modules And Visibility

- Keep reusable functions in `lib/*.sh`, loaded with `source`.
- Guard a sourced library against double-sourcing (`[[ -n "${MYLIB_SOURCED:-}" ]] && return`).
- Never `export` a variable a sourced library does not document as its interface; keep the rest local to the sourcing script.
<!-- Project-specific / Shell-Modules-And-Visibility -->

### Tests

- Test with bats-core or ShellSpec; guard `main "$@"` behind `[[ "${BASH_SOURCE[0]}" == "${0}" ]]` so a test can load its functions without running it.
- Assert on exit status and stdout/stderr, not on incidental formatting; use real temp directories, cleaned up in teardown.
- Add a test for every argument-parsing edge case and every past incident: a missing argument, an unwritable path, a missing dependency on `PATH`.
<!-- Project-specific / Shell-Tests -->

### Tooling

- Run ShellCheck in CI on every script (`git ls-files '*.sh' | xargs shellcheck`) as a build failure, not a suggestion; disable one code only with a comment saying why (`# shellcheck disable=SC2064 # trap must expand now`).
- Run `shfmt -d` in CI so formatting never bikesheds a review.
- Pin the dialect per file when the project mixes Bash and POSIX sh (`# shellcheck shell=sh`).
<!-- Project-specific / Shell-Tooling -->

### Smells

- An unquoted expansion (`$1`, `$var`, `$@` instead of `"$@"`) that breaks on a space, a glob character, or an empty value.
- Parsing `ls`, or any column-formatted command output, instead of `find`, a glob, or a tool with stable output.
- `eval`, or a command built as a string and piped to `sh -c`, where a plain array or a function call would do.
- Backticks instead of `$(...)` for command substitution.
- An unchecked `cd` — a failed one leaves later commands running against the wrong files.
- A script hundreds of lines long with no functions and no `main`, that nobody wants to touch.
<!-- Project-specific / Shell-Smells -->

## Project-specific

<!-- Project-specific -->
