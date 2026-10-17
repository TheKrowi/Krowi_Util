# CLAUDE.md

Krowi's Util (`Krowi_Util`) is the library every other Krowi library and addon builds on, in Lua 5.1 + WoW XML: LibMan (`KROWI_LIBMAN`, the manager the Krowi libraries register through), the utility library `Krowi_Util_2` with its submodules, and options and minimap icon code that addons load into their own namespace. It ships standalone on CurseForge and Wago and embedded as `Libs/Krowi_Util` in the addons. The workspace-wide rules load from `../../CLAUDE.md` and `Krowi_ClaudeKit/WowAddons.md`; this file adds only what is specific to this repo.

There is no build, lint or test step: the game, through a consumer addon, is the test harness. The `krowi` plugin (enabled in `.claude/settings.json`) syntax-checks every edited `.lua` with Lua 5.1 and guards the known tooling traps. The repo is public, but `.claude/settings.json` points at the private kit by absolute path, so the plugin loads only on Krowi's machine; that is intended.

## Clients and loading

- One TOC, `Krowi_Util.toc`: `## Interface: 120105, 120100, 50504, 38002, 20506, 11509`, that is Retail 12.1.5 and 12.1.0, Mists Classic 5.5.4, Titan Reforged 3.80.2, TBC Anniversary 2.5.6 and Classic Era 1.15.9. No WoW Forever (16001), which Krowi_WorldMapButtons lists. No saved variables.
- Load order is `Krowi_Util.xml`: the `Krowi_Tooltip` frame, `Libs\Files.xml` (LibStub, CallbackHandler-1.0, LibDataBroker-1.1, AceLocale-3.0), `LibMan.lua`, `Krowi_Util.lua`, `Constants.lua`, `Colors.lua`, `Strings.lua`, `Metadata.lua` (the file is `MetaData.lua`), `Credits.lua`, `LocalizationHelper.lua`, then `Localization\Files.xml` (enUS, deDE, frFR, itIT, ruRU, zhCN, `Shared.lua`). At load time Metadata and LocalizationHelper read `Constants`, Colors calls `DeepCopyTable`, and `Shared.lua` calls the `SetColorOrange` that Colors adds.
- The submodules and locale files attach to `KROWI_LIBMAN:GetCurrentLibrary()`, which `Krowi_Util.lua` sets to `Krowi_Util_2` even when its copy does not upgrade (`LibMan.lua:23-26`). Nothing that sets another current library may run inside that sequence.
- `Icon.lua` and `Options\*.lua` are not in the XML. They start with `local addonName, addon = ...` and are loaded into a consumer's namespace by the consumer's own TOC or `Files.xml` (see Consumers).

## Versioning

Every embedded copy runs the whole XML, and LibStub keeps the highest minor per name. Each file has its own rule:

| File | Registered as | When the file changes |
|---|---|---|
| `Krowi_Util.lua` | `Krowi_Util_2`, minor 4 (`Krowi_Util.lua:8`) | bump that minor |
| `Constants.lua`, `Colors.lua`, `Strings.lua`, `MetaData.lua`, `Credits.lua` | `Krowi_Util_2_<Name>`, minor 0 (`NewSubmodule` on line 8) | bump that file's minor |
| `LocalizationHelper.lua` | `Krowi_Util_2_LocalizationHelper`, minor 1 (line 8) | bump that file's minor |
| `LibMan.lua` | global `KROWI_LIBMAN`, LibStub `Krowi_LibMan` minor 0 | cannot be upgraded, see below |
| `Localization\*.lua`, `Krowi_Util.xml` | nothing | run for every copy; see Known debt |
| `Icon.lua`, `Options\*.lua` | nothing | reach players only when a consumer bumps its submodule and releases |
| `Libs\*` | their upstream LibStub minors | replace with the upstream file, never edit |

- The minors are independent: a `Krowi_Util_2` bump re-runs only `Krowi_Util.lua`, a submodule bump only that file. Bump every one whose file changed, in the same release.
- An upgrade reuses the same table: the newer copy redefines its functions and fields on it and everything else stays. There are no `oldminor` handlers yet.
- History: `Krowi_Util_2` was 0 at 2.0 and went to 1, 2 and 3 in 2.1 to 2.3 and to 4 in 2.7; LocalizationHelper went from 0 to 1 in 2.2; the other submodules are 0 and unchanged since 2.0. The changelog names the bump ("Library version 3 → 4").
- `LibMan.lua` starts with `if KROWI_LIBMAN then return end` (line 8), so the first copy that loads keeps LibMan for the whole session and no later copy's LibMan runs. Do not add LibMan behaviour that a consumer relies on; put it in `Krowi_Util.lua` or a submodule.
- Never remove or rename a public name: a consumer reading it gets nil without an error. 6ee1198 (2025-11-22) dropped `IsWrathClassic` and `IsCataClassic`, and 2.7 restored them. Krowi_AchievementFilter's `util-flags` lint reads the `lib.IsX =` and `function lib.IsX(` lines here, so keep flags in that form.
- Before a release, check every file in `git diff --stat <last tag>` against this table.

## Consumers

- `Libs/Krowi_Util` submodule, pinned version on 2026-10-17: Krowi_AchievementFilter 2.7, Krowi_ExtendedVendorUI 2.6, Krowi_Vendorer 2.2, Krowi_Brokers_Currency, Krowi_Brokers_System and Krowi_Brokers_Time 2.1. Each loads `Krowi_Util.xml` from `Libs/Files.xml` and calls `KROWI_LIBMAN:NewAddon` in `Libs/Libs.lua`.
- Not on 2.x: Krowi_AchievementFilter_TooltipData (submodule at a 2024 commit, `Krowi_Util-1.0`), Krowi_Brokers_Template (vendored 1.0.13), Krowi_Reminders (untracked copy, repo idle since 2023).
- Consumer-namespace files: `Icon.lua` from the TOCs of Krowi_AchievementFilter, Krowi_Vendorer and Krowi_ExtendedVendorUI; `Options/Options.lua` and `Options/InjectOptions.lua` from the same three; `Options/Profiles.lua` from Krowi_Vendorer only.
- Libraries that need it loaded first without embedding it: Krowi_Menu, Krowi_PopupDialog, Krowi_Currency, Krowi_Brokers, Krowi_ProgressBar and Krowi_Tutorials register through `KROWI_LIBMAN`. Krowi_WorldMapButtons and Krowi_Globals do not use it.
- A change here means releasing Krowi_Util, then bumping `Libs/Krowi_Util` in each consumer and releasing that. Grep the consumers before changing a public name or its behaviour.

## Architecture

- `LibMan.lua`: `NewLibrary(name, minor, {SetCurrent, SetUtil, InitLocalization})` wraps `LibStub:NewLibrary` and sets `lib.Name` and `lib.Version`. `NewSubmodule(name, minor[, parent])` registers `<parent.Name>_<name>` and sets `parent[name]`; the parent defaults to the current library. `NewAddon(addonName, addon, {SetCurrent, SetUtil, SetMenuBuilder, SetBroker, SetMetaData, InitLocalization, SilentLocalization})` runs once per addon name and sets `addon.Util`, `addon.MenuBuilder` (Krowi_Menu_2), `addon.Broker` (Krowi_Brokers_2), `addon.Metadata` and `addon.Localization`. Also `GetLibrary`, `GetCurrentLibrary`, `SetUtil` and `GetUtil`.
- `Krowi_Util.lua` (`addon.Util`): client flags from the major of `GetBuildInfo()` (`IsClassicEra`, `IsBCCClassic`, `IsWrathClassic`, `IsCataClassic`, `IsMistsClassic`, `IsTheWarWithin`, `IsMidnight`), `IsClassicWithAchievements` (Wrath, Cata or Mists) and `IsMainline` (`WOW_PROJECT_ID == WOW_PROJECT_MAINLINE`); table helpers, `DelayFunction` (one named `C_Timer` at a time) and the `Is<Type>` checks.
- `Constants`: the Discord, CurseForge and Wago links and the AceLocale name. `Credits`: the special thanks, donations and translators lists the addons show. `Metadata.GetAddOnMetadata(name)`: cached TOC fields, including `X-Prefix`, `X-Acronym`, `IconTexture` and the `X-Slug` links.
- `Colors`: `<Name>RGB` tables (with `.Hex`), `<Name>` format strings, `SetTextColor`, `RemoveColor`, `RGBPrct2HEX`, `UnpackRGB`, and a `string.SetColor<Name>` method per colour. `Strings`: `ReplaceVars` (`{key}` placeholders), `AddReloadRequired` and `AddDefaultValueText`, also as `string.K_ReplaceVars`, `K_AddReloadRequired` and `K_AddDefaultValueText`.
- `LocalizationHelper.InitLocalization(app, appName, silent)` gives `app.Localization` (`NewDefaultLocale`, `NewLocale`, `GetLocale`) on AceLocale; Krowi_Util calls it on itself (`LocalizationHelper.lua:52`), and `Localization/Shared.lua` sets `Krowi_Util_2.L`.
- Consumer-namespace files: `Options/Options.lua` (`addon.Options`: AceDB `<X-Prefix>_Options`, `Load` runs every table in `OptionsTables`, `Open`, and `string.<X-Acronym>_InjectAddonName` and `_AddDefaultValueText`), `Options/InjectOptions.lua` (`addon.InjectOptions`: dotted-path access into the options table and defaults, plugin pages), `Options/Profiles.lua` (the AceDBOptions page) and `Icon.lua` (`addon.Icon`: LibDataBroker launcher, LibDBIcon button, addon compartment). They expect `NewAddon` with `SetUtil` and `SetMetaData`, the TOC fields above plus `AddonCompartmentFunc*` naming `<X-Prefix>_OnAddonCompartmentClick`, `Enter` and `Leave`, `addon.Options.Defaults.profile.ShowMinimapIcon` and `.Minimap`, `addon.Icon.SetMoreTooltipContent`, and AceDB, AceDBOptions, AceConfig, AceConfigDialog and LibDBIcon from the consumer; Krowi_Util bundles none of those.

## Taint-sensitive areas

- `Icon.lua`: the LibDBIcon tooltip callback fills the tooltip LibDBIcon passes, `GameTooltip` (lines 24-29). The addon compartment uses the own `Krowi_Tooltip` since 2.5, after addon code on `GameTooltip` caused the 12.x "secret number value" layout errors (changelog 2.4 and 2.5). It also defines the global compartment functions (lines 71-82).
- `Options/Options.lua` `Open` (lines 82-97): `Settings.OpenToCategory`; the legacy branch drives Blizzard's Interface Options frame from addon code. `Options/Profiles.lua`: `AddToBlizOptions`.
- Global writes: `KROWI_LIBMAN`, `Krowi_Tooltip` (`Krowi_Util.xml:7`) and new keys on Lua's shared `string` table (`Colors.lua:75`, `Strings.lua:30,39,62`, `Options/Options.lua:99,103`). Only add names there, never one Blizzard or Lua already defines.
- `Icon.lua:25` calls `tooltip:ClearLines()` on the tooltip LibDBIcon passes (normally `GameTooltip`), which runs Blizzard's tooltip-cleared handler from addon code; the baseline review (2026-10-17) rates it plausible but unconfirmed for the #811 widget-set error family. The call is redundant after the display's `SetOwner`.
- Run the `krowi:taint-reviewer` agent after changing any of them.

## Localization

- `Localization/enUS.lua`, `deDE`, `frFR`, `itIT`, `ruRU`, `zhCN` and `Shared.lua`. Each locale file has its code above the `AUTOGENTOKEN` marker (line 14) and the CurseForge export below it (exported 2026-06-28). New strings go in `enUS.lua` below the marker; ask Krowi whether to add them on the CurseForge localization page too (URL in `Shared.lua:6`).
- In the non-enUS files `= true` appears only for keys that are their own English text (Credits, CurseForge, Discord, Plugins, Version, Wago), where AceLocale's fallback to the key is right. Never use it for a sentence key such as `CurseForge Desc`.
- `Shared.lua` aliases Blizzard global strings (`GENERAL`, `GAME_VERSION_LABEL`, ...), colours `Requires a reload` orange and finally sets `lib.L` to the AceLocale table.
- A string added here may not reach players: see Known debt.

## Code style

Measured on 2026-10-17; match it:

- 4-space indentation (a few tab-indented lines remain, `Krowi_Util.lua:42-49`, `LibMan.lua:62-63`); XML uses tabs.
- No semicolons. Single quotes in code (one double-quoted string at `Options/Options.lua:95`); the CurseForge export uses double quotes.
- First lines: the block comment `--[[ Copyright (c) 2023 Krowi / Licensed under the terms of the LICENSE file in this repository. ]]` (`Icon.lua` and `Options/*.lua` still carry the older full licence text), a blank line, `---@diagnostic disable: undefined-global`, a blank line, then `local sub, parent = KROWI_LIBMAN:NewSubmodule(...)` and `if not sub ... then return end`, or `local _, addon = ...` in the consumer-namespace files. The XML and TOC files carry the same header as comments.
- Functions on module tables are PascalCase with a dot (`sub.ReplaceVars`), locals camelCase.
- CRLF on disk (LF in git, `core.autocrlf=true`), no BOM, no final newline (only the bundled `Libs/AceLocale-3.0.lua` has one). There is no `.vscode/settings.json`.

## Testing in game

- Changes are tested through a consumer, picked by what changed: the client flags and most helpers through Krowi_AchievementFilter (Retail, Mists, Titan) and Krowi_ExtendedVendorUI (Retail, Mists, Anniversary, Era); `Icon.lua` and `Options/` through those two plus Krowi_Vendorer (Retail, the only one that loads `Profiles.lua`); `SetBroker`, `SetMenuBuilder` and Colors through the Krowi_Brokers addons.
- The kit's `Deploy.ps1` run from this repo installs a standalone `AddOns\Krowi_Util`. It replaces an embedded copy only where its minors are higher, and LibMan and the locale strings come from whichever copy loads first, so it does not show what players get. Deploy over the consumer's copy instead, with `-Destination "<client>\Interface\AddOns\<Consumer>\Libs\Krowi_Util"` (preview with `-WhatIf` first); it lasts until that consumer is deployed again. A standalone `AddOns\Krowi_Util` left behind keeps loading; remove it after the check.
- `Read-GameErrors.ps1` from this repo shows the errors whose message or stack names `Krowi_Util`, including the AceLocale "Missing entry" errors for `Krowi_Util_2`.

## Git and release

- `main` is the only branch and the release branch: every `Release x.y` commit and tag (`2.0` to `2.7`, no `v`) is on it. Branch work from `main` and open PRs against it. The local `origin/rework-options` ref is stale; that branch is gone from GitHub.
- Release only with the plugin's `krowi:release`, from `Krowi_Libraries\Krowi_Util` (it is in the addon manager's `LIBRARY_NAMES`). Every GitHub release so far is a full release: `--stability stable`.
- `_Packaging/Changelog.md` is read by addon authors: entries name the API and the interface numbers, and say when a minor changed ("Library version 3 → 4"). `README.md` (badges plus `_Packaging/Description.md`) and `_Packaging/ReleaseNotes.md` are generated.
- `Constants.lua` is a contract with the addon manager. It reads `DiscordInviteLink`, `CurseForgeLinkBase` and `WagoIoLinkBase` from this checkout with a `Name = 'value'` regex (`Krowi_AddonManager_Python/resources.py:77-149`) for the Discord badge and the CurseForge and Wago links in every addon's README (`text_porter.py:22-23,56`). Keep the names and the one-line quoted form; otherwise it falls back to hardcoded URLs without a warning.

## Known debt (verified 2026-10-17)

- LibMan cannot be upgraded (`LibMan.lua:8`; minor 0 at line 43). 2.2's `SilentLocalization` (`LibMan.lua:119`) is ignored whenever a 2.0 or 2.1 copy loads first, as the three Krowi_Brokers addons pin 2.1; Krowi_AchievementFilter and Krowi_ExtendedVendorUI ask for it.
- Locale strings of a newer copy never register. `InitLocalization` returns when `app.Localization` exists (`LocalizationHelper.lua:37`), which survives on the `Krowi_Util_2` table across upgrades; `localeIsLoaded` lives in the first copy's closure, so every later `NewDefaultLocale()` and `NewLocale()` returns nil (lines 15 and 24) and the locale file stops (`enUS.lua:11-12`). Only the first-loaded copy's strings exist; a key added later shows as the raw key with an AceLocale "Missing entry" error. A LocalizationHelper bump does not help. Krowi_PopupDialog, Krowi_Currency and Krowi_Brokers have the same problem through `InitLocalization = true` and the same locale-file pattern. `Shared.lua` has no such guard, so its aliases do arrive.
- `Localization/Shared.lua:11` reads `if not lib and not lib.L`, which errors instead of returning when there is no current library (`or` was meant); unreachable today. `Shared.lua:27` wraps `Requires a reload` in orange once per loaded copy, except the first copy on an enUS client, where AceLocale's default-locale proxy refuses the overwrite.
- `Options/Options.lua:83-93`: the legacy branch is dead. All five supported clients define `Settings.OpenToCategory` (`Blizzard_Settings_Shared/Blizzard_Settings.lua:143` in every wow-ui-source clone) and none defines `InterfaceOptionsFrame_OpenToCategory` or `InterfaceAddOnsList_Update`, so it would error if reached.
- `Options/InjectOptions.lua:28` and `:33` add `(1 or amount)`, which is always 1: `amount` is ignored.
- `Krowi_Util.xml:17` loads `Metadata.lua`; the file is `MetaData.lua` and loads only because the file system ignores case.
- `Krowi_Util.xml:7` creates a new `Krowi_Tooltip` for every embedded copy; the global points at the last one.
- `_Packaging/Description.md` (and the README made from it) documents a `GetSubmodule` that does not exist (line 57) and `IsTBCClassic` where the code has `IsBCCClassic` (line 252), leaves out `IsClassicEra`, `IsWrathClassic` and `IsCataClassic`, and lists four languages where six ship.