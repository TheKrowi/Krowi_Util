--[[
    Copyright (c) 2023 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local lib = KROWI_LIBMAN:GetCurrentLibrary(true)
if not lib then	return end

local L = lib.Localization.NewLocale('frFR')
if not L then return end

-- [[ Everything after this line is automatically generated from CurseForge and is not meant for manual edit - SOURCETOKEN - AUTOGENTOKEN ]] --

-- [[ Exported at 2026-01-10 11-32-45 ]] --
L["Checked"] = "Coché"
L["Default value"] = "Valeur par défaut"
L["Loaded"] = "Chargé"
L["Loaded Desc"] = "Indique si l'addon associé au plugin est chargé ou non."
L["Profiles"] = "Profils"
L["Requires a reload"] = "Nécessite un /reload"
L["Unchecked"] = "Non coché"