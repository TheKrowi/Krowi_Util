--[[
    Copyright (c) 2023 Krowi

    All Rights Reserved unless otherwise explicitly stated.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
]]

local lib = LibStub("Krowi_Util-1.0");

if not lib then
	return;
end

lib.InjectOptions = {};
local injectOptions = lib.InjectOptions;

injectOptions.__index = injectOptions;
function injectOptions:New()
    local instance = setmetatable({}, injectOptions);

    instance.AdjustedWidth = function(number)
        return (number or 1) * (instance.WidthMultiplier or 170); -- Default Ace3
    end

    instance.AutoOrder = 1;
    instance.AutoOrderPlusPlus = function(amount)
        local current = instance.AutoOrder;
        instance.AutoOrder = instance.AutoOrder + (1 or amount);
        return current;
    end

    instance.PlusPlusAutoOrder = function(amount)
        instance.AutoOrder = instance.AutoOrder + (1 or amount);
        return instance.AutoOrder;
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
                name = lib.L["Loaded"],
                desc = lib.L["Loaded Desc"],
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