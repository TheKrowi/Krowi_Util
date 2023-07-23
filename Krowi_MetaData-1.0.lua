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
lib.Metadata = {};
local metadata = lib.Metadata;

function metadata.GetMetaData(addonName)
    local title = GetAddOnMetadata(addonName, "Title");
    local build = GetBuildInfo();
    local version = GetAddOnMetadata(addonName, "Version");
    local author = GetAddOnMetadata(addonName, "Author");
    local discordInviteLink = GetAddOnMetadata(addonName, "X-Discord-Invite-Link");
    local discordServerName = GetAddOnMetadata(addonName, "X-Discord-Server-Name");
    local curseForge = GetAddOnMetadata(addonName, "X-CurseForge");
    local wago = GetAddOnMetadata(addonName, "X-Wago");
    local woWInterface = GetAddOnMetadata(addonName, "X-WoWInterface");

    return {
        Title = title,
        Build = build,
        Version = version,
        BuildVersion = build .. "." .. version,
        Author = author,
        DiscordInviteLink = discordInviteLink,
        DiscordServerName = discordServerName,
        CurseForge = curseForge,
        Wago = wago,
        WoWInterface = woWInterface
    };
end