A comprehensive utility library for World of Warcraft addon development, providing reusable functions for string manipulation, table operations, color management, metadata handling, and more.

## Features

### Core Utilities (`Krowi_Util-1.0.lua`)
- **Version Detection**: Automatic detection of WoW version (Mainline, Classic variants)
- **Table Operations**:
  - `ConcatTables(t1, t2)` - Merge two tables
  - `DeepCopyTable(src, dest)` - Deep copy table contents
  - `TableRemoveByValue(table, value)` - Remove element by value
  - `TableFindKeyByValue(table, value)` - Find key by value
  - `Enum(table)` / `Enum2(table)` - Create enumerations
- **Nested Key Operations**:
  - `ReadNestedKeys(tbl, keys)` - Read deeply nested table values
  - `WriteNestedKeys(tbl, keys, value)` - Write to deeply nested tables
  - `SafeGet(source, path)` - Safe nested access with nil checking
- **Utility Functions**:
  - `DelayFunction(name, delay, func, ...)` - Delayed function execution
  - `StringSplitTable(delimiter, str)` - Split string into table
  - `InjectMetatable(tbl, meta)` - Metatable injection
- **Type Checking**: `IsNil`, `IsNumber`, `IsString`, `IsBoolean`, `IsTable`, `IsFunction`, `IsThread`, `IsUserData`

### String Utilities (`Krowi_Strings-1.0.lua`)
- `ReplaceVars(str, vars)` - Template variable replacement (supports `{varName}` syntax)
- `AddReloadRequired(str)` - Append reload requirement message
- `AddDefaultValueText(str, startTbl, valuePath, values)` - Add default value information

### Color Management (`Krowi_Colors-1.0.lua`)
- **Color Utilities**:
  - `SetTextColor(text, color)` - Apply color to text
  - `RemoveColor(text)` - Strip color codes
  - `RGBPrct2HEX(r, g, b, a)` - Convert RGB percentages to hex
- **Predefined Colors**: AddonBlue, Green, LightGreen, Grey, LightGrey, Red, LightRed, Orange, LightOrange, Yellow, White
- **Item Quality Colors**: Poor, Common, Uncommon, Rare, Epic
- **Dynamic String Methods**: Auto-generated `SetColor*` methods for all color types

### Metadata Management (`Krowi_MetaData-1.0.lua`)
- `GetAddOnMetadata(addonName)` - Extract comprehensive addon metadata including:
  - Title, Version, Author, Icon
  - Custom fields (Prefix, Acronym, Discord, CurseForge, Wago, WoWInterface)

### Credits System (`Krowi_Credits-1.0.lua`)
- `GetSpecialThanksAsTable()` - Formatted list of contributors
- `GetDonationsAsTable()` - Formatted list of donors
- `GetLocalizationsAsTable()` - Formatted list of translators

### Additional Features
- **Minimap Icon Support** (`Icon.lua`) - LibDBIcon integration with tooltip and click handling
- **Options Framework** (`Options/`) - Profile management and AceConfig integration
- **Localization Support** - English, German, French, Chinese (Simplified)

## Usage Examples

### String Variable Replacement
```lua
local util = LibStub("Krowi_Util-1.0")
local text = util.Strings.ReplaceVars("Hello {name}, you have {count} items", {
    name = "Player",
    count = 5
})
-- Result: "Hello Player, you have 5 items"
```

### Color Management
```lua
local colors = LibStub("Krowi_Util-1.0").Colors
local coloredText = colors.SetTextColor("Warning!", colors.Red)
-- Or use string method:
local epicText = "Legendary Item".SetColorEpic(self)
```

### Table Operations
```lua
local util = LibStub("Krowi_Util-1.0")
local data = {player = {stats = {health = 100}}}
local health = util.SafeGet(data, {"player", "stats", "health"}) -- Returns 100
local missing = util.SafeGet(data, {"player", "items", "sword"}) -- Returns nil safely
```

### Version Detection
```lua
local util = LibStub("Krowi_Util-1.0")
if util.IsMainline then
    -- Mainline-specific code
elseif util.IsMistsClassic then
    -- Mists Classic-specific code
end
```

## Requirements
- LibStub
- AceLocale-3.0
- AceConfig-3.0 (for options)
- AceConfigDialog-3.0 (for options UI)
- LibDBIcon-1.0 (for minimap icon)
- LibDataBroker-1.1 (for minimap icon)