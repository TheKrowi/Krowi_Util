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

options.__index = options;
function options:New(addon)
    local metadata = addon.Metadata;
    local instance = setmetatable({}, options);

    instance.Metadata = addon.Metadata;
    instance.SavedVariable = metadata.Prefix .. "_Options";
    instance.Name = metadata.Title;
    instance.OptionsTables = {};
    instance.WidthMultiplier = lib.IsWrathClassic and 1 or 200 / 170; -- 170 comes from AceConfigDialog-3.0.lua, 200 fits better on the screen in DF
    instance.OptionsTable = {
        name = metadata.Title,
        type = "group",
        childGroups = "tab",
        args = {}
    };

    addon.InjectOptions:SetWidthMultiplier(instance.WidthMultiplier);

    return instance;
end

function options:Load(addon)
    self.db = LibStub("AceDB-3.0"):New(self.SavedVariable, self.Defaults, true);
    self.OptionsTable.args.Profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db);

    for _, optionsTable in next, self.OptionsTables do
        if optionsTable.IsProfiles then
            LibStub("AceConfig-3.0"):RegisterOptionsTable("Profiles", self.OptionsTable.args.Profiles);
            LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Profiles", "Profiles", self.Metadata.Title);
        else
            optionsTable.RegisterOptionsTable();
        end
    end

    for _, optionsTable in next, self.OptionsTables do
        if not optionsTable.IsProfiles then
            optionsTable.PostLoad();
        end
    end
end

function options:InsertProfilesOptions()
    local profiles = {};
    tinsert(self.OptionsTables, profiles);
    profiles.RegisterOptionsTable = function()
        LibStub("AceConfig-3.0"):RegisterOptionsTable("Profiles", self.OptionsTable.args.Profiles);
        LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Profiles", "Profiles", self.Metadata.Title);
    end
    profiles.PostLoad = function()
        
    end
end

function options:Open()
    if lib.IsWrathClassic then
        InterfaceAddOnsList_Update(); -- This way the correct category will be shown when calling InterfaceOptionsFrame_OpenToCategory
        InterfaceOptionsFrame_OpenToCategory(self.Name);
        for _, button in next, InterfaceOptionsFrameAddOns.buttons do
            if button.element and button.element.name == self.Name and button.element.collapsed then
                OptionsListButtonToggle_OnClick(button.toggle);
                break;
            end
        end
        return;
    end

    Settings.GetCategory(self.Name).expanded = true;
    Settings.OpenToCategory(self.Name, true);
end