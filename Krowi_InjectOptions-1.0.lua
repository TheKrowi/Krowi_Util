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
lib.InjectOptions = {};
local injectOptions = lib.InjectOptions;

injectOptions.__index = injectOptions;
function injectOptions:New()
    local instance = setmetatable({}, injectOptions);

    instance.AdjustedWidth = function(number)
        return (number or 1) * (instance.WidthMultiplier or 170); -- Default Ace3
    end

    instance.autoOrder = 1;
    instance.AutoOrderPlusPlus = function(amount)
        local current = instance.autoOrder;
        instance.autoOrder = instance.autoOrder + (1 or amount);
        return current;
    end

    instance.PlusPlusAutoOrder = function(amount)
        instance.autoOrder = instance.autoOrder + (1 or amount);
        return instance.autoOrder;
    end

    return instance;
end

function injectOptions:SetOptionsTable(optionsTable)
    self.OptionsTable = optionsTable;
end

function injectOptions:SetDefaultOptions(defaultOptions)
    self.DefaultOptions = defaultOptions;
end

function injectOptions:SetWidthMultiplier(widthMultiplier)
    self.WidthMultiplier = widthMultiplier;
end

function injectOptions:SetLocalization(localization)
    self.L = localization;
end

function injectOptions:AddTable(destTablePath, key, table)
    local destTable;
    if type(destTablePath) == "table" then
        destTable = destTablePath;
    elseif type(destTablePath) == "string" then
        destTable = self.OptionsTable.args;
        local pathParts = strsplittable(".", destTablePath);
        for _, part in next, pathParts do
            destTable = destTable[part];
        end
    end
    destTable[key] = table;
    return destTable[key];
end

function injectOptions:TableExists(destTablePath)
    local destTable = self.OptionsTable.args;
    local pathParts = strsplittable(".", destTablePath);
    for _, part in next, pathParts do
        destTable = destTable[part];
    end
    return destTable and true or false;
end

function injectOptions:AddDefaults(destTablePath, key, table)
    local destTable = self.DefaultOptions;
    local pathParts = strsplittable(".", destTablePath);
    for _, part in next, pathParts do
        destTable = destTable[part];
    end
    destTable[key] = table;
end

function injectOptions:DefaultsExists(destTablePath)
    local destTable = self.DefaultOptions;
    local pathParts = strsplittable(".", destTablePath);
    for _, part in next, pathParts do
        destTable = destTable[part];
    end
    return destTable and true or false;
end

function injectOptions:AddPluginTable(pluginName, pluginDisplayName, desc, loadedFunc)
    local OrderPP = self.AutoOrderPlusPlus;
    return self:AddTable("Plugins.args", pluginName, {
        type = "group",
        name = pluginDisplayName,
        args = {
            Loaded = {
                order = OrderPP(), type = "toggle", width = "full",
                name = self.L["Loaded"],
                desc = self.L["Loaded Desc"],
                descStyle = "inline",
                get = loadedFunc,
                disabled = true
            },
            Line = {
                order = OrderPP(), type = "header", width = "full",
                name = ""
            },
            Description = {
                order = OrderPP(), type = "description", width = "full",
                name = desc,
                fontSize = "medium"
            }
        }
    }).args;
end


-- function lib.AddReloadRequired(str)
--     return str .. "\n\n" .. addon.L["Requires a reload"];
-- end
-- string["AddReloadRequired_KMFE"] = function(self)
--     return self .. "\n\n" .. addon.L["Requires a reload"];
-- end