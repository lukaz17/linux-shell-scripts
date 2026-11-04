# Project Structure

Here are standard project structures of languages and frameworks, kept for reference.

The file holding the layout attuned to this project is [context.md](../.attunic/context.md).

The files holding the rules for working with this project are [coding-conventions.md](coding-conventions.md) and [development-guideline.md](development-guideline.md).

## General structure

### Layout

Entries a project commonly has at its root, whatever its languages; each layout below lists only what its language or framework adds:

```
├── .agents/            # shared AI agent instructions (coding conventions, PR/task checklists, project structure)
├── .attunic/           # project memory (context, confirmed facts, questions, work in progress)
├── .github/            # GitHub-specific config (workflows, issue/PR templates)
├── .vscode/            # VS Code editor/workspace settings
├── .copier-answers.yml # Copier answers replayed by `copier update`; never edited by hand
├── .editorconfig       # editor formatting rules
├── .gitignore          # git ignore patterns
├── AGENTS.md           # instructions for AI coding agents
├── CLAUDE.md           # points to AGENTS.md
├── CONTRIBUTING.md     # contribution guidelines
├── COPYING             # license text for GPL, LGPL, and AGPL
├── COPYING.LESSER      # LGPL additions, beside COPYING
├── LICENSE             # license text for other licenses (e.g. MIT, Apache-2.0)
├── README.md           # project overview
<!-- Project-specific / Layout -->
```

## Shell

### Shell-Guideline

- Keep one script per operational task; when unrelated subcommands accumulate, split the script or add a real subcommand dispatcher.
- Put shared functions in `lib/`, entry points in `bin/` or the project root, whichever the project already uses; never duplicate a helper across scripts.
- Keep generated or vendored scripts out of the directories you hand-edit.
<!-- Project-specific / Shell-Guideline -->

### Shell-Layout

```
├── bin/            # executable entry-point scripts
├── docs/           # design and user documents
├── lib/            # shared sourced libraries (lib/*.sh)
├── scripts/        # build/install/analysis helper scripts
├── test/           # test suites, fixtures, and test data
├── Makefile        # build/test/lint task automation (optional)
<!-- Project-specific / Shell-Layout -->
```

### Shell-Layer Dependencies

Notes for declaring architecture layers in the `Layer Dependencies` section of `.attunic/context.md`; adjust them to the project before declaring.

- Treat each script as a Humble Object: argument parsing, environment setup, and orchestration only; once it needs a real data structure, a retry policy, or a shared business rule, move that logic to the system's main language, called from the script, or to tested `lib/` functions in a shell-only project.
- Past a couple hundred lines, or the first time an associative array models more than a lookup table, move that logic out; a shell script is glue, not an application.
- Keep no dependency-injection wiring: shell has none of the tooling to enforce the Dependency Rule, so keep the script small enough that the question does not arise.
- Check by hand: a script containing business rules instead of delegating them to the main language (or to `lib/` in a shell-only project) is a violation.
<!-- Project-specific / Shell-Layer Dependencies -->

## Project-specific

<!-- Project-specific / Project-specific -->
