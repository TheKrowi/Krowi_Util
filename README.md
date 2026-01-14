![Midnight](https://img.shields.io/badge/Midnight-12.0.0-a335ee?style=for-the-badge) ![Retail](https://img.shields.io/badge/Retail-11.2.7-008833?style=for-the-badge) ![Mists](https://img.shields.io/badge/Mists-5.5.3-28ae7e?style=for-the-badge) ![TBC](https://img.shields.io/badge/TBC-2.5.5-62c907?style=for-the-badge) ![Classic](https://img.shields.io/badge/Classic-1.15.8-c39361?style=for-the-badge)<br>
[![CurseForge](https://img.shields.io/badge/curseforge-download-F16436?style=for-the-badge&logo=curseforge&logoColor=white)](https://www.curseforge.com/wow/addons/krowi-util) [![Wago](https://img.shields.io/badge/Wago-Download-c1272d?style=for-the-badge)](https://addons.wago.io/addons/krowi-util)<br>
[![Discord](https://img.shields.io/badge/discord-join-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/mdBFQJYeQZ) [![PayPal](https://img.shields.io/badge/paypal-donate-002991.svg?style=for-the-badge&logo=paypal&logoColor=white)](https://www.paypal.com/donate/?hosted_button_id=9QEDV37APQ6YJ)

A comprehensive modular utility library for World of Warcraft addon development, built on the KROWI_LIBMAN architecture. Provides reusable modules for string manipulation, table operations, color management, metadata handling, localization, and more.

## Features

### LibMan Architecture
- **Modular Design**: Clean submodule system for better code organization
- **Dependency Management**: Automatic version tracking and compatibility checks
- **Shared Library Support**: Seamless integration with other Krowi libraries

### Core Utilities Module
- **Version Detection**: Automatic detection of WoW version (Mainline, Midnight, Classic variants)
- **Table Operations**: Merge, copy, search, and manipulate tables
- **Nested Key Operations**: Safe access to deeply nested table values
- **Delayed Execution**: Timer-based function delays
- **Type Checking**: Complete set of type validation functions

### String Utilities Module
- **Variable Replacement**: Template-based string formatting with `{varName}` syntax
- **UI Helpers**: Reload requirement and default value text generation
- **String Extensions**: Methods added directly to the string type with `K_` prefix

### Color Management Module
- **Color Utilities**: Apply and remove color codes from text
- **RGB/Hex Conversion**: Convert between RGB percentages and hex values
- **Predefined Colors**: Quest difficulty colors (Green, Grey, Red, Orange, Yellow)
- **Item Quality Colors**: Poor, Common, Uncommon, Rare, Epic
- **Dynamic String Methods**: Auto-generated `SetColor*` methods for convenient styling

### Metadata Management Module
- **Addon Information Extraction**: Parse TOC file metadata with caching
- **Link Generation**: Automatic CurseForge and Wago link formatting
- **Build Version Tracking**: Combined build and version information

### Localization Helper Module
- **Simplified Setup**: Easy initialization with `InitLocalization`
- **Automatic Detection**: Smart locale detection and fallback handling
- **AceLocale Integration**: Built on top of AceLocale-3.0 with improved API
- **Multi-Language Support**: English, German, French, Chinese (Simplified)

### Credits System Module
- **Contributor Recognition**: Formatted lists for special thanks, donations, and localizations
- **Class Coloring**: Automatic character class color formatting

### Additional Features
- **Minimap Icon Support** (`Icon.lua`): LibDBIcon integration with tooltip and click handling
- **Options Framework** (`Options/`): Profile management and AceConfig integration
- **Complete Localization**: Comprehensive translations for all supported languages

## Usage Examples

### Basic Setup (2.0)
```lua
-- Access via LibMan
local util = KROWI_LIBMAN:GetLibrary('Krowi_Util_2')

-- Or access submodules directly
local strings = KROWI_LIBMAN:GetLibrary('Krowi_Util_2'):GetSubmodule('Strings')

-- Or via parent
local util = KROWI_LIBMAN:GetLibrary('Krowi_Util_2')
local strings = util.Strings
```

### Legacy LibStub Support (1.x)
```lua
-- Still supported for backward compatibility
local util = LibStub("Krowi_Util_2")
```

### String Variable Replacement
```lua
-- Using module method
local text = util.Strings.ReplaceVars("Hello {name}, you have {count} items", {
    name = "Player",
    count = 5
})
-- Result: "Hello Player, you have 5 items"

-- Using string extension
local text = ("Hello {name}"):K_ReplaceVars({name = "World"})
-- Result: "Hello World"
```

### Localization Setup (New in 2.0)
```lua
-- Initialize localization for your addon
util.LocalizationHelper.InitLocalization(MyAddon, "MyAddonName")

-- Create default locale (enUS)
local L = MyAddon.Localization.NewDefaultLocale()
L["Hello"] = "Hello"
L["Goodbye"] = "Goodbye"

-- Create other locales
local L = MyAddon.Localization.NewLocale('deDE')
if L then
    L["Hello"] = "Hallo"
    L["Goodbye"] = "Auf Wiedersehen"
end

-- Use localized strings
local greeting = MyAddon.Localization.GetLocale()["Hello"]
```

### Color Management
```lua
local colors = util.Colors
local coloredText = colors.SetTextColor("Warning!", colors.Red)

-- Or use string method:
local epicText = ("Legendary Item"):SetColorEpic()
local greenText = ("Completed"):SetColorGreen()
```

### Table Operations
```lua
-- Safe nested access
local data = {player = {stats = {health = 100}}}
local health = util.SafeGet(data, {"player", "stats", "health"}) -- Returns 100
local missing = util.SafeGet(data, {"player", "items", "sword"}) -- Returns nil safely

-- Deep copy
local original = {a = 1, b = {c = 2}}
local copy = {}
util.DeepCopyTable(original, copy)

-- Delayed function execution
util.DelayFunction("myDelay", 2, function(msg) print(msg) end, "Hello after 2 seconds")
```

### Version Detection
```lua
if util.IsMainline then
    -- Retail-specific code (The War Within, Midnight)
elseif util.IsMistsClassic then
    -- Mists Classic-specific code
end
```

### Metadata Extraction (Enhanced in 2.0)
```lua
local metadata = util.Metadata.GetAddOnMetadata("YourAddon")
print(metadata.Title, metadata.Version, metadata.Author)
print(metadata.CurseForge, metadata.Wago) -- Auto-formatted links
print(metadata.BuildVersion) -- Combined build and version
```

## API Reference

### Core Utility Functions

| Function | Parameters | Returns | Description |
|----------|------------|---------|-------------|
| `ConcatTables` | `t1, t2` | table | Merges two tables (appends t2 to t1) |
| `DeepCopyTable` | `src, dest` | - | Deep copies all elements from src to dest |
| `ReadNestedKeys` | `tbl, keys` | any | Reads value from nested table using key array |
| `WriteNestedKeys` | `tbl, keys, value` | - | Writes value to nested table using key array |
| `SafeGet` | `source, path` | any | Safe nested access, returns nil if path invalid |
| `Enum` | `table` | table | Converts array to enum (modifies original) |
| `Enum2` | `table` | table | Converts array to enum (returns new table) |
| `StringSplitTable` | `delimiter, str` | table | Splits string into table by delimiter |
| `DelayFunction` | `name, delay, func, ...` | - | Executes function after delay with args |
| `TableRemoveByValue` | `table, value` | boolean | Removes element by value, returns success |
| `TableFindKeyByValue` | `table, value` | any | Returns key for given value |
| `InjectMetatable` | `tbl, meta` | table | Injects metatable into table |

### Type Checking Functions

| Function | Parameter | Returns | Description |
|----------|-----------|---------|-------------|
| `IsNil` | `value` | boolean | Checks if value is nil |
| `IsNumber` | `value` | boolean | Checks if value is number |
| `IsString` | `value` | boolean | Checks if value is string |
| `IsBoolean` | `value` | boolean | Checks if value is boolean |
| `IsTable` | `value` | boolean | Checks if value is table |
| `IsFunction` | `value` | boolean | Checks if value is function |
| `IsThread` | `value` | boolean | Checks if value is thread |
| `IsUserData` | `value` | boolean | Checks if value is userdata |

### String Utility Functions (Enhanced in 2.0)

| Function | Parameters | Returns | Description |
|----------|------------|---------|-------------|
| `Strings.ReplaceVars` | `str, vars` | string | Replaces `{key}` placeholders with values from vars table |
| `string.K_ReplaceVars` | `str, vars` | string | String extension version of ReplaceVars |
| `Strings.AddReloadRequired` | `str` | string | Appends reload requirement message |
| `string.K_AddReloadRequired` | `str` | string | String extension version of AddReloadRequired |
| `Strings.AddDefaultValueText` | `str, startTbl, valuePath, values` | string | Appends default value information |
| `string.K_AddDefaultValueText` | `str, startTbl, valuePath, values` | string | String extension version of AddDefaultValueText |

### Localization Helper Functions (New in 2.0)

| Function | Parameters | Returns | Description |
|----------|------------|---------|-------------|
| `LocalizationHelper.InitLocalization` | `app, appName` | - | Initializes localization system for an addon |
| `app.Localization.NewDefaultLocale` | `addMore` | table | Creates/retrieves enUS locale table |
| `app.Localization.NewLocale` | `locale, addMore` | table | Creates/retrieves specific locale table |
| `app.Localization.GetLocale` | - | table | Gets the active locale table |

### Color Functions

| Function | Parameters | Returns | Description |
|----------|------------|---------|-------------|
| `Colors.SetTextColor` | `text, color` | string | Wraps text in color code |
| `Colors.RemoveColor` | `text` | string | Strips all color codes from text |
| `Colors.RGBPrct2HEX` | `r, g, b, a` | string | Converts RGB percentages (0-1) to hex string |

### Available Color Constants

**Quest Difficulty Colors:**
- `AddonBlue`, `Green`, `LightGreen`, `Grey`, `LightGrey`, `Red`, `LightRed`, `Orange`, `LightOrange`, `Yellow`, `White`

**Item Quality Colors:**
- `Poor`, `Common`, `Uncommon`, `Rare`, `Epic`

Each color is available as both RGB table (`*RGB`) and formatted string.

### String Color Methods
All colors automatically extend the string type:
```lua
("text"):SetColorRed()
("text"):SetColorEpic()
("text"):SetColorGreen()
-- etc. for all color constants
```

### Metadata Functions (Enhanced in 2.0)

| Function | Parameters | Returns | Description |
|----------|------------|---------|-------------|
| `Metadata.GetAddOnMetadata` | `addonName` | table | Returns comprehensive cached addon metadata |

**Returned Metadata Fields:**
- `AddonName`, `Title`, `Prefix`, `Acronym`
- `Build`, `Version`, `BuildVersion` (combined build + version)
- `Author`, `Icon`
- `CurseForge` (auto-formatted link), `Wago` (auto-formatted link)

### Credits Functions

| Function | Parameters | Returns | Description |
|----------|------------|---------|-------------|
| `Credits.GetSpecialThanksAsTable` | - | table | Returns formatted array of special thanks |
| `Credits.GetDonationsAsTable` | - | table | Returns formatted array of donors |
| `Credits.GetLocalizationsAsTable` | - | table | Returns formatted array of translators |

### Version Detection Properties

| Property | Type | Description |
|----------|------|-------------|
| `IsMistsClassic` | boolean | True if running Mists of Pandaria Classic |
| `IsTBCClassic` | boolean | True if running The Burning Crusade Classic |
| `IsClassicWithAchievements` | boolean | True if Classic version with achievements |
| `IsTheWarWithin` | boolean | True if running The War Within expansion |
| `IsMidnight` | boolean | True if running Midnight expansion |
| `IsMainline` | boolean | True if running retail (uses WOW_PROJECT_MAINLINE) |

## Use Cases
- **Modular Addon Development**: Build addons using clean, reusable modules
- **Dynamic Text Generation**: Create tooltips, messages, and UI elements with template strings
- **Safe Data Access**: Navigate nested tables without nil reference errors
- **Consistent Styling**: Apply WoW-standard quest and item quality colors
- **Multi-Version Support**: Implement version-specific features across all WoW versions
- **Localization**: Easy setup and management of multi-language support
- **Metadata Management**: Centralized addon information with automatic link generation
- **Profile Configuration**: Built-in profile management and options framework

## Requirements
- KROWI_LIBMAN (included)
- LibStub (included)
- AceLocale-3.0 (included)
- CallbackHandler-1.0 (included)
- AceConfig-3.0 (for options)
- AceConfigDialog-3.0 (for options UI)
- AceDB-3.0 (for options database)
- AceDBOptions-3.0 (for profile options)
- LibDBIcon-1.0 (for minimap icon)
- LibDataBroker-1.1 (included, for minimap icon)