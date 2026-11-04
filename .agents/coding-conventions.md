# Coding Conventions

## General

The principles below are for all languages. They use camelCase for demonstration purposes; adapt casing to the language's style.

When a language's established idiom contradicts a principle below, follow the idiom even when its section doesn't name it (e.g. PowerShell's `-Force` switch parameter).

### Formats

- Let the project's formatter own the format: run the formatter declared in [context.md's Supporting Tools](../.attunic/context.md#supporting-tools), if any; its check mode must report no file to change.
- Follow `.editorconfig` for indentation, line endings, charset, and final newline; it wins over editor and community defaults (e.g. tab indentation where a language has no official rule).
- Use ASCII punctuation and straight quotes by default in code, comments, and docs; use non-ASCII characters only where the content requires them (names, quoted text, symbols with no ASCII form, box-drawing in layout trees).
- Order file content top-down: high-level intent first, details descending; in a code file: file-level constants and variables, then exported identifiers, then private helpers.
- Keep related things close: local declarations near first use, callers near callees.
- Never pad comments or docs outside quoted text with filler (e.g. `simply`, `really`, `in order to`), meaningless words, or a sentence restating the one before it.
<!-- Project-specific / Formats -->
- Start top-level scripts with a standard banner comment block: program name, purpose, prerequisites if any, `Usage:`, `Example:`, then the MIT license block; see any existing script, consistency matters more than wording.

### Names

- Use one word per concept across the codebase; never one word for two concepts.
- Use intention-revealing names: the name says why it exists and what it does, with no mental mapping from a terse abbreviation to a concept.
- Include units in names where the type does not carry them (e.g. `timeoutMs`, `maxBytes`); a value typed as a duration or size needs none.
- Start the name of a function that performs an action with a verb that discloses its side effects (`save`, `delete`, `publish`, `mutate`); name a side-effect-free accessor for what it returns (`owner`, `totalPrice`).
- Case acronyms consistently, following the language's convention; never mix forms in one codebase (`userId` beside `userID`).
- Name booleans as predicates (`isReady`, `hasItems`, `canRetry`), never as negations (`isNotReady`).
- Never write a vague name (`data`, `info`, `obj`, `temp`, `result`) when a domain name exists; a loop index, a lambda or callback parameter, a caught error, or an established short form may stay short; nothing else may.
- Never write a bare-verb function with no object (`handle`, `process`); a method's receiver counts as its object (`file.close()`).
- Never number or version a name instead of replacing the original (`user2`, `dataV2`, `_new`, `_final`, `_copy`).
- Never suffix a type with a noise word (`Manager`, `Helper`, `Util`) or name it after a verb (`ProcessOrder`).
- Avoid magic numbers or strings; use a named constant for the meaning, or attach an inline *why* comment.
<!-- Project-specific / Names -->

### Packages

- Use the narrowest visibility; export only what another module must use.
- Name a module for the domain concept it owns; never add to a catch-all `utils`, `helpers`, or `common`.
<!-- Project-specific / Packages -->

### Types

- Avoid unnecessary abstraction: introduce an interface, trait, protocol, or abstract base only once two implementations exist; a test double counts as one.
<!-- Project-specific / Types -->

### Functions

- Keep functions small, at one level of abstraction; extract a named function instead of nesting another branch or commenting a block.
- Keep positional parameters to three or fewer; past that, group related values into one parameter object.
- Prefer early exits for invalid or terminal cases over nested conditionals.
- Never switch behavior on a boolean parameter; write two functions or take a small enum.
- Never mutate an input the caller does not expect to change; return a new value instead.
<!-- Project-specific / Functions -->

### Comments

- Document every exported identifier with a doc comment stating its contract: what it is or does, and what a caller must know.
- Write inline comments explaining *why*, not *what*.
- Cut hedging from comments, and articles from inline comments; keep IDs, numbers, links, and warnings whole.
- Keep inline comments short: one to three lines; longer explanations belong in a doc file the comment points to, or an extracted function.
- Keep comments up to date with the code: a stale comment is worse than no comment.
- Keep comments about: non-obvious constraints, legal requirements, algorithmic tradeoffs, external system quirks, warnings of consequences, and TODOs with context and ownership.
- Never write comment noise: redundant restatements, change journals, attributions, banner or position markers, closing-brace labels, and commented-out code.
- Never delete or reword comments a tool reads (shebangs, encoding lines, license and SPDX headers, build and compiler directives, suppressions, doctests, generated-file headers).
<!-- Project-specific / Comments -->

### Errors

- Handle each error once, where a meaningful decision can be made; elsewhere propagate it, and never log and rethrow it at every frame.
- Wrap errors with original cause and context when propagating.
- Model an expected outcome (not found, declined, empty) as a value, an optional, or a result type, never a sentinel value (`-1`, `""`); reserve the language's error mechanism for genuine failures.
- Reserve crashes (panic, abort, process exit) for programmer errors the caller cannot act on; never crash library code on an expected failure.
- Write user-facing error messages as actionable sentences; never expose internals (stack traces, queries, file paths) in them.
- Never swallow errors or catch broadly without handling, wrapping, or propagating with context.
<!-- Project-specific / Errors -->

### Concurrency

- Give every concurrent task an owner that can wait for it or cancel it; never start one that nothing can stop.
- Keep shared mutable state to a minimum; hold a lock as briefly as possible, and never across a suspension point.
- Treat every suspension point as a place where shared state can change; re-check invariants after it.
- Never block an event loop or async runtime with blocking I/O or long computation; hand it to an async API, a worker, or a blocking-task pool.
<!-- Project-specific / Concurrency -->

## Shell

The rules below assume Bash. In a POSIX `sh` script (`#!/bin/sh`), use `[ ]` instead of `[[ ]]`, and drop each Bash-only construct the target shell lacks (e.g. arrays, `local -r`, `BASH_SOURCE`).

### Shell-Formats

<!-- Project-specific / Shell-Formats -->
- Let EditorConfig format layout per `.editorconfig`: tabs for indent, LF, UTF-8, final newline.

### Shell-Names

- Name functions and locals `snake_case`; reserve `UPPER_SNAKE_CASE` for exported or readonly globals (`CONFIG_PATH`) so scope is visible at a glance.
- Prefix a sourced library's private functions with the library's name (`_mylib_parse_args`); shell has no real module privacy.
<!-- Project-specific / Shell-Names -->

### Shell-Packages

- Keep reusable functions in `lib/*.sh`, loaded with `source`.
- Guard a sourced library against double-sourcing (`[[ -n "${MYLIB_SOURCED:-}" ]] && return; readonly MYLIB_SOURCED=1`).
- Never `export` a variable a sourced library does not document as its interface; keep the rest local to the sourcing script.
<!-- Project-specific / Shell-Packages -->

### Shell-Types

<!-- Project-specific / Shell-Types -->

### Shell-Functions

- Wrap logic in functions and call them from one `main "$@"` at the bottom; nothing but definitions runs at the top level.
- Declare every function-local with `local` (`local -r` when it never changes); an undeclared variable leaks into the caller's scope.
- Mark a value that must not change `readonly` right after it is set.
- Keep a function to one job; parsing arguments, doing the work, and printing a report is three functions.
- Pass data through arguments and exit status, not through a global a sibling function set earlier.
<!-- Project-specific / Shell-Functions -->
- Open every function body by binding its positional parameters: one argument per line, `_name="${1}"`, `_name="${2}"`,... before any other statement; use only those `_` names afterward — never reference `$1`, `${2}`,... directly inside a function.
- Keep an installer script a linear top-level flow calling shared-library functions; wrap an application's logic in functions only where the script itself owns it.
- Prefix a function-local variable with `_` (`_path`) so it visibly belongs to the function; pass state up via documented uppercase globals (`INSTALL_VERSION`, `INSTALL_TARGET`) — POSIX sh has no `local`.

### Shell-Comments

<!-- Project-specific / Shell-Comments -->

### Shell-Errors

- Start every Bash script with `set -euo pipefail` unless a command's failure needs inspecting; document why when turning a flag off for one line.
- Write user-facing errors to stderr (`echo "error: ..." >&2`) and exit with a distinct, documented code per failure class; never let a script fail silently with exit 0.
- Check every command whose failure matters, including `cd` and `mkdir`; `set -e` does not catch a failure inside `if`, `&&`/`||`, or a non-last pipeline stage without `pipefail`.
- Use `trap 'cleanup' EXIT` (and `INT`/`TERM` when the script holds a lock or a temp file) so cleanup runs on every exit path.
- Never swallow a failure with `2>/dev/null` alone; redirect, then act on the exit status, or let the error surface.
<!-- Project-specific / Shell-Errors -->
- Use an `echo "> Label:   value"` status line as the CLI progress channel; a failure message goes to stderr as `Error: ...` or `<function>: Invalid arguments`.
- Set `set -e` at the start of the script; POSIX sh has no `pipefail`, so make a pipeline's error path explicit instead.

### Shell-Concurrency

<!-- Project-specific / Shell-Concurrency -->

## Project-specific

<!-- Project-specific / Project-specific -->
