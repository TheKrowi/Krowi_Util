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

lib.Options = {};
local options = lib.Options;

function options.Open(title)
    if lib.IsWrathClassic then
        InterfaceAddOnsList_Update(); -- This way the correct category will be shown when calling InterfaceOptionsFrame_OpenToCategory
        InterfaceOptionsFrame_OpenToCategory(title);
        for _, button in next, InterfaceOptionsFrameAddOns.buttons do
            if button.element and button.element.name == title and button.element.collapsed then
                OptionsListButtonToggle_OnClick(button.toggle);
                break;
            end
        end
        return;
    end

    Settings.GetCategory(title).expanded = true;
    Settings.OpenToCategory(title, true);
end

options.__index = options;
function options:New(savedVariable, name, injectOptions)
    local instance = setmetatable({}, options);

    instance.SavedVariable = savedVariable;
    instance.Name = name;
    instance.OptionsTables = {};
    instance.WidthMultiplier = lib.IsWrathClassic and 1 or 200 / 170; -- 170 comes from AceConfigDialog-3.0.lua, 200 fits better on the screen in DF
    instance.OptionsTable = {
        name = name,
        type = "group",
        childGroups = "tab",
        args = {}
    };

    injectOptions:SetWidthMultiplier(instance.WidthMultiplier);

    return instance;
end

function options:Load(addon)
    addon.Options = LibStub("AceDB-3.0"):New(self.SavedVariable, self.Defaults, true);
    addon.Options.WidthMultiplier = self.WidthMultiplier;
    addon.Options.Open = function()
        options.Open(self.Name);
    end
    addon.Options.db = addon.Options.profile;

    for _, optionsTable in next, self.OptionsTables do
        optionsTable.RegisterOptionsTable();
    end

    for _, optionsTable in next, self.OptionsTables do
        optionsTable.PostLoad();
    end
end