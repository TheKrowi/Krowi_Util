--[[
    Copyright (c) 2023 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local function NewLibrary(self, libName, libVersion, setCurrent)
    assert(type(libName) == 'string', 'Bad argument #2 to \'InitLibrary\' (string expected)')
    libVersion = assert(tonumber(string.match(libVersion, '%d+')), 'Bad argument #3 to \'InitLibrary\' (version must either be a number or contain a number)')

    local lib = LibStub:NewLibrary(libName, libVersion)
    if not lib then return end -- Already loaded and no upgrade needed

    lib.Name = libName
    lib.Version = libVersion

    if setCurrent ~= false then
        self = self or lib
        self.CurrentLibrary = lib
    end

    return lib
end

local lib = NewLibrary(nil, 'Krowi_LibMan', 1)
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

    local submodule = self:NewLibrary(parentLibrary.Name .. '_' .. subName, subVersion, false)
    if not submodule then return end -- Already loaded and no upgrade needed

    parentLibrary[subName] = submodule

    return submodule, parentLibrary
end

