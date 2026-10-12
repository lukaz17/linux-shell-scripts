# Project Context

Part of the project memory layer: human-readable memory of what this project is and what has been confirmed.

The reading and writing rules for this file and the rest of `.attunic/` are defined in [attunic-protocol.md](../.agents/attunic-protocol.md).

## Abstract

A newcomer should be able to tell what the software does without knowing what it is built with. One paragraph that describes the domain, not the technology, in simple terms:
<!-- Project-specific / Abstract -->

## Technical Specifications

A brief overview of the ingredients used for developing this project. These are things developers should know when developing the project.

Typical ingredients include, but are not limited to: primary language, frameworks, architecture styles, environment prerequisites, libraries, test runners, tools, databases...

<!-- Project-specific / Technical Specifications -->

## Layout

Layout of this project; [project-structure.md](../.agents/project-structure.md) holds the language's standard map, kept for reference.

List of important folders, files and their roles in the project:

- They visualize the actual file system where source files live.
- If a top-level file/folder is missing from the list, prompt the user to update it.
<!-- Project-specific / Layout -->

## Layer Dependencies

List of layers and their relationships:

- Declare the innermost layer first.
- A layer may depend on itself and on any layer declared before it, and on nothing declared after it.
- If a layer appears in the table below, the dependency graph must be enforced.

| Layer | Path | Depends on | Must never contain |
|-------|------|------------|--------------------|
<!-- Project-specific / Layer Dependencies -->

### Deliberate Exceptions

List of documented exceptions that cannot follow the architecture rules above:

- Any place the rules above are knowingly broken, with the reason and the condition for fixing it.
- An undocumented exception is a defect; a documented one is a decision.

| What | Why | Revisit-if |
|------|-----|------------|
<!-- Project-specific / Deliberate Exceptions -->

## Supporting Tools

All the supporting tools declared here are opinionated for the sake of consistent results across development environments.

List each required tool/library under its own heading, followed by the commands for each use case.
Common use cases include: Build, Test, Lint, Format, Install, ...

<!-- Project-specific / Supporting Tools -->

## Confirmed Facts

Facts about the project which have been confirmed; they outrank anything derived or guessed.

| Fact | Reason |
|------|--------|
<!-- Project-specific / Confirmed Facts -->

## Project-specific

<!-- Project-specific -->
