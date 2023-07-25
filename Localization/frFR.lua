--[[
	Krowi's Util License
		Copyright ©2023 The contents of this library, excluding third-party resources, are
		copyrighted to their authors with all rights reserved.

		This library is free to use and the authors hereby grants you the following rights:

		1. 	You may make modifications to this library for private use only, you
			may not publicize any portion of this library. The only exception being you may
			upload to the github website.

		2. 	Do not modify the name of this library, including the library folders.

		3. 	This copyright notice shall be included in all copies or substantial
			portions of the Software.

		All rights not explicitly addressed in this license are reserved by
		the copyright holders.
]]

local lib = LibStub("Krowi_Util-1.0");
-- lib.Localization.frFR = {};
-- local localization = lib.Localization.frFR;

if lib.IsLoaded_frFR then
	return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("Krowi_Util-1.0", "frFR");
if not L then return end

-- function localization.Load(L)
	L["Loaded"] = "Chargé";
	L["Loaded Desc"] = "Indique si l'addon associé au plugin est chargé ou non.";
	L["Requires a reload"] = "Nécessite un /reload";
-- end

lib.IsLoaded_frFR = true;