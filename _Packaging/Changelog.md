# Changelog
All notable changes to this project will be documented in this file.

## 2.1 - 2026-01-15
### Changed
- Updated the Settings opening process to work with 12.0

## 2.0 - 2026-01-14
### Added
- **New LibMan Architecture**: Complete refactor to use KROWI_LIBMAN library management system
- **LocalizationHelper Module**: New module providing improved localization handling with `InitLocalization`, `NewDefaultLocale`, `NewLocale`, and `GetLocale` functions

### Changed
- **Breaking**: Migrated from standalone library to LibMan-based submodule architecture
- **Code Style**: Standardized code style across all files:
  - Removed semicolons
  - Changed string literals from double quotes to single quotes
  - Improved code consistency and readability
- **License Headers**: Updated all file headers to reference LICENSE file instead of inline license text

## 1.0.14 - 2026-01-10
### Added
- Support for WoW 12.0.0 (Midnight)

### Changed
- Improved localization handling

### TBC Classic
- Support added

## 1.0.13 - 2025-12-29
### Changed
- Updated `lib.IsMainline` to use `WOW_PROJECT_ID == WOW_PROJECT_MAINLINE` instead of version-specific checks

## 1.0.12 - 2025-12-07
### Changed
- Codebase for upload