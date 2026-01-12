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