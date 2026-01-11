--[[
    Copyright (c) 2023 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local sub = KROWI_LIBMAN:NewSubmodule('Metadata', 0)
if not sub then	return end

local buildVersionFormat = '%s.%s'
local metadataCache = {}

function sub.GetAddOnMetadata(addonName)
    if metadataCache[addonName] then
        return metadataCache[addonName]
    end

    local getAddOnMetadata = C_AddOns.GetAddOnMetadata
    local build = GetBuildInfo()
    local version = getAddOnMetadata(addonName, 'Version')

    metadataCache[addonName] = {
        AddonName = addonName,
        Title = getAddOnMetadata(addonName, 'Title'),
        Prefix = getAddOnMetadata(addonName, 'X-Prefix'),
        Acronym = getAddOnMetadata(addonName, 'X-Acronym'),
        Build = build,
        Version = version,
        BuildVersion = string.format(buildVersionFormat, build, version),
        Author = getAddOnMetadata(addonName, 'Author'),
        Icon = getAddOnMetadata(addonName, 'IconTexture'),
        DiscordInviteLink = getAddOnMetadata(addonName, 'X-Discord-Invite-Link'),
        DiscordServerName = getAddOnMetadata(addonName, 'X-Discord-Server-Name'),
        CurseForge = getAddOnMetadata(addonName, 'X-CurseForge'),
        Wago = getAddOnMetadata(addonName, 'X-Wago'),
        WoWInterface = getAddOnMetadata(addonName, 'X-WoWInterface')
    }

    return metadataCache[addonName]
end