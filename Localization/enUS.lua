--[[
    Copyright (c) 2023 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local lib = KROWI_LIBMAN:GetCurrentLibrary(true)
if not lib then	return end

local L = lib.Localization.NewDefaultLocale()
if not L then return end
lib.L = L

-- [[ https://legacy.curseforge.com/wow/addons/krowi-util/localization ]] --
-- [[ Everything after this line is automatically generated from CurseForge and is not meant for manual edit - SOURCETOKEN - AUTOGENTOKEN ]] --

-- [[ Exported at 2026-01-10 11-32-44 ]] --
L["Checked"] = true
L["Default value"] = true
L["Loaded"] = true
L["Loaded Desc"] = "Indicates if the addon related to the plugin is loaded or not."
L["Profiles"] = true
L["Requires a reload"] = "Requires a reload to take full effect."
L["Unchecked"] = true
L["Wago Desc"] = "Open a popup dialog with a link to the {addonName} {wago} page."
L["Credits"] = true
L["Special thanks"] = true
L["Donations"] = true
L["Localizations"] = true
L["Author"] = true
L["Build"] = true
L["CurseForge"] = true
L["CurseForge Desc"] = "Open a popup dialog with a link to the {addonName} {curseForge} page."
L["Discord"] = true
L["Discord Desc"] = "Open a popup dialog with a link to the {serverName} Discord server. Here you can post comments, reports, remarks, ideas or anything else related."
L["Wago"] = true
L["Left click"] = true
L["Right click"] = true
L["Plugins"] = true
L["Show minimap icon"] = true
L["Show minimap icon Desc"] = "Show / hide the minimap icon."
L["Deselect All"] = true
L["Select All"] = true
L["Left-Click"] = true
L["Right-Click"] = true
L["Hide"] = true