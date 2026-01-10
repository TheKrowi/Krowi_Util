--[[
    Copyright (c) 2023 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local sub, parent = KROWI_LIBMAN:NewSubmodule('LocalizationHelper', 0)
if not sub or not parent then return end

local aceLocaleName = parent.Constants.AceLocaleName
local localeIsLoaded, defaultLocale = {}, 'enUS'

function sub.NewDefaultLocale()
    if localeIsLoaded[defaultLocale] then return end

    localeIsLoaded[defaultLocale] = true
    return LibStub(aceLocaleName):NewLocale(parent.Name, defaultLocale, true)
end

function sub.NewLocale(locale)
    if localeIsLoaded[locale] then return end

    localeIsLoaded[locale] = true
    return LibStub(aceLocaleName):NewLocale(parent.Name, locale)
end

function sub.GetLocale()
    return LibStub(aceLocaleName):GetLocale(parent.Name)
end

function sub.NewLocalization()
    return {
        NewDefaultLocale = sub.NewDefaultLocale,
        NewLocale = sub.NewLocale,
        GetLocale = sub.GetLocale
    }
end