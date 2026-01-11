--[[
    Copyright (c) 2023 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local sub, parent = KROWI_LIBMAN:NewSubmodule('LocalizationHelper', 0)
if not sub or not parent then return end

local aceLocaleName = parent.Constants.AceLocaleName
local defaultLocale = 'enUS'

local function NewDefaultLocale(appName, localeIsLoaded, addMore)
    if localeIsLoaded[defaultLocale] and not addMore then return end
    localeIsLoaded[defaultLocale] = true
    return LibStub(aceLocaleName):NewLocale(appName, defaultLocale, true)
end

local function NewLocale(appName, localeIsLoaded, locale, addMore)
    if localeIsLoaded[locale] and not addMore then return end
    localeIsLoaded[locale] = true
    return LibStub(aceLocaleName):NewLocale(appName, locale)
end

local function GetLocale(appName)
    return LibStub(aceLocaleName):GetLocale(appName)
end

function sub.InitLocalization(app, appName)
    if app.Localization then return end
    appName = appName or app.Name or app
    local localeIsLoaded = {}
    app.Localization = {
        NewDefaultLocale = function(addMore)
            return NewDefaultLocale(appName, localeIsLoaded, addMore)
        end,
        NewLocale = function(locale, addMore)
            return NewLocale(appName, localeIsLoaded, locale, addMore)
        end,
        GetLocale = function()
            return GetLocale(appName)
        end
    }
end