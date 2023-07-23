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
lib.MetaData = {};
local metaData = lib.MetaData;

function metaData.GetMetaData(addonName)
    return {
        Title = GetAddOnMetadata(addonName, "Title");
        Build = GetBuildInfo();
        Version = GetAddOnMetadata(addonName, "Version");
        BuildVersion = metaData.Build .. "." .. metaData.Version;
        Author = GetAddOnMetadata(addonName, "Author");
        DiscordInviteLink = GetAddOnMetadata(addonName, "X-Discord-Invite-Link");
        DiscordServerName = GetAddOnMetadata(addonName, "X-Discord-Server-Name");
        CurseForge = GetAddOnMetadata(addonName, "X-CurseForge");
        Wago = GetAddOnMetadata(addonName, "X-Wago");
        WoWInterface = GetAddOnMetadata(addonName, "X-WoWInterface");
    };
end