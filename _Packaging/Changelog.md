# Changelog
All notable changes to this project will be documented in this file.

## 2.4 - 2026-06-10
### Fixed
- `GameTooltip:Hide()` in `Icon:OnAddonCompartmentLeave` is now called via `securecall` to prevent UI taint (dev note: calling `GameTooltip:Hide()` directly from addon code marks the `GameTooltip` object as tainted; this cascades through `GameTooltip_ClearWidgetSet` → `UpdateWidgetLayout` → `DefaultWidgetLayout` → `LayoutFrame.lua`, producing repeated `attempt to compare a secret number value (execution tainted by ...)` errors that auto-fire every ~20–30 seconds, commonly triggered by hovering map POIs or entering/leaving combat; wrapping in `securecall` keeps the call in a protected context so Blizzard's layout code never sees the taint)

## 2.3 - 2026-06-03
### Added
- `lib.IsClassicEra` for WoW Classic Era (version 1.x)
- `lib.IsBCCClassic` for Burning Crusade Classic (version 2.x)

### Changed
- Updated supported interfaces: removed 110207 (The War Within), kept 120005 (Midnight), 50503, 20505, 11508

## 2.2 - 2026-01-18
### Changed
- KROWI_LIBMAN:NewAddon can now receive SilentLocalization option

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