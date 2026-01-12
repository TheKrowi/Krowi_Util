--[[
    Copyright (c) 2023 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local lib = KROWI_LIBMAN:GetCurrentLibrary(true)
if not lib then	return end

local L = lib.Localization.NewLocale('deDE')
if not L then return end

-- [[ Everything after this line is automatically generated from CurseForge and is not meant for manual edit - SOURCETOKEN - AUTOGENTOKEN ]] --

-- [[ Exported at 2026-01-10 11-32-45 ]] --
L["Checked"] = "Aktivert"
L["Default value"] = "Vorgabewert (Standard)"
L["Loaded"] = "Geladen"
L["Loaded Desc"] = "Zeigt an, ob das mit dem Plugin verbundene Addon geladen ist oder nicht."
L["Profiles"] = "Profile"
L["Requires a reload"] = "Funktioniert erst nach einem /reload."
L["Unchecked"] = "Nicht aktiviert"