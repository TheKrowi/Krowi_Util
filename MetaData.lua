--[[
    Copyright (c) 2023 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local sub = KROWI_LIBMAN:NewSubmodule('Metadata', 0)
if not sub then	return end

local buildVersionFormat = '%s.%s'

function sub.GetAddOnMetadata(addonName)
    local getAddOnMetadata = C_AddOns.GetAddOnMetadata
    local title = getAddOnMetadata(addonName, 'Title')
    local prefix = getAddOnMetadata(addonName, 'X-Prefix')
    local acronym = getAddOnMetadata(addonName, 'X-Acronym')
    local build = GetBuildInfo()
    local version = getAddOnMetadata(addonName, 'Version')
    local author = getAddOnMetadata(addonName, 'Author')
    local icon = getAddOnMetadata(addonName, 'IconTexture')
    local discordInviteLink = getAddOnMetadata(addonName, 'X-Discord-Invite-Link')
    local discordServerName = getAddOnMetadata(addonName, 'X-Discord-Server-Name')
    local curseForge = getAddOnMetadata(addonName, 'X-CurseForge')
    local wago = getAddOnMetadata(addonName, 'X-Wago')
    local woWInterface = getAddOnMetadata(addonName, 'X-WoWInterface')

    return {
        AddonName = addonName,
        Title = title,
        Prefix = prefix,
        Acronym = acronym,
        Build = build,
        Version = version,
        BuildVersion = string.format(buildVersionFormat, build, version),
        Author = author,
        Icon = icon,
        DiscordInviteLink = discordInviteLink,
        DiscordServerName = discordServerName,
        CurseForge = curseForge,
        Wago = wago,
        WoWInterface = woWInterface
    }
end