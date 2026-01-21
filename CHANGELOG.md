# Changelog

- The changelog format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
- The project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
- The date format is `YYYY-MM-DD`.

## [Unreleased]

### Breaking
- Removed `custom-enum-numbering` helper
- Removed `subtask-label` helper

### Added
- Added `subtask` system
- Added an argument `todo` in `#task` to mark task with TODO
- Added `definition` environment and `example` environment
- Added task text handling

## [0.4.0] - 2025-11-22

### Breaking
- Renamed `setup` -> `assignment`
- Renamed `setup`/`assignment` options:
  - `header-date` -> `date`
  - `header-date-format` -> `date-format`
- Renamed `task` options:
  - `task-string` -> `task-prefix`
  - `points-string` -> `points-prefix`
  - `counter-reset` -> `counter`
- Removed `task` options:
  - `subtask-numbering-pattern`
- Changed behavior of `task` options:
  - `subtask-pattern`

### Changed (minor breaking)
- Changed default setting: no custom `par.first-line-indent`
- Changed task number update behavior
- Changed default column spacing in header
- Changed template

### Fixed
- Fixed `date-format` bug in header
- Fixed empty score box, hide it when no tasks

### Added
- Added a lot of new customization options
- Added `custom-enum-numbering` helper
- Added referencing support for tasks (+ subtasks) and theorems
- Added `todo` feature
- Added `theorem`, `lemma`, `corollary` and `proof`
- Added appendix
- Added user manual

## [0.3.3] - 2025-09-22
No information available.

## [0.2.0] - 2025-09-15
No information available.

## [0.1.0] - 2025-09-11
No information available.
