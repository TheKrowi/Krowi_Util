--[[
    Copyright (c) 2023 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local function NewLibrary(self, libName, libVersion, setCurrent, setUtil, initLocalization)
    assert(type(libName) == 'string', 'Bad argument #2 to \'InitLibrary\' (string expected)')
    libVersion = assert(tonumber(string.match(libVersion, '%d+')), 'Bad argument #3 to \'InitLibrary\' (version must either be a number or contain a number)')

    local lib = LibStub:NewLibrary(libName, libVersion)
    if not lib then return end -- Already loaded and no upgrade needed

    lib.Name = libName
    lib.Version = libVersion

    self = self or lib
    if setCurrent ~= false then
        self.CurrentLibrary = lib
    end

    if setUtil ~= false then
        lib.Util = self:GetUtil()
    end

    if initLocalization ~= false then
        self:GetUtil().LocalizationHelper.InitLocalization(lib)
    end
    return lib
end

local lib = NewLibrary(nil, 'Krowi_LibMan', 0, false, false, false)
if not lib then return end

KROWI_LIBMAN = lib
lib.NewLibrary = NewLibrary

function lib:GetLibrary(libName, silent)
    assert(type(libName) == 'string', 'Bad argument #2 to \'GetLibrary\' (string expected)')
    return LibStub(libName, silent)
end

function lib:GetCurrentLibrary(silent)
    if not self.CurrentLibrary and not silent then
        error('No current library is set.', 2)
    end
    return self.CurrentLibrary
end

function lib:NewSubmodule(subName, subVersion, parentLibrary)
	assert(type(subName) == 'string', 'Bad argument #2 to \'InitSubmodule\' (string expected)')
	subVersion = assert(tonumber(string.match(subVersion, '%d+')), 'Bad argument #3 to \'InitSubmodule\' (version must either be a number or contain a number)')

    if type(parentLibrary) == 'string' then
        parentLibrary = LibStub(parentLibrary)
    elseif not parentLibrary then
        parentLibrary = self.CurrentLibrary
    end

    local submodule = self:NewLibrary(parentLibrary.Name .. '_' .. subName, subVersion, false, false, false)
    if not submodule then return end -- Already loaded and no upgrade needed

    parentLibrary[subName] = submodule

    return submodule, parentLibrary
end

function lib:SetUtil(utilLibrary)
    self.Util = utilLibrary
end

function lib:GetUtil(silent)
    if not self.Util and not silent then
        error('No current library is set.', 2)
    end
    return self.Util
end

function lib:NewAddon(addonName, addon, setCurrent, setUtil, setMetaData, initLocalization)
    self.Addons = self.Addons or {}
    if self.Addons[addonName] then return end

    self.Addons[addonName] = self.Addons[addonName] or addon

    if setCurrent ~= false then
        self.CurrentAddon = addon
    end

    if setUtil ~= false then
        addon.Util = self:GetUtil()
    end

    if setMetaData ~= false then
        addon.Metadata = self:GetUtil().Metadata.GetAddOnMetadata(addonName)
    end

    if initLocalization ~= false then
        addon.Util.LocalizationHelper.InitLocalization(addon)
    end
end