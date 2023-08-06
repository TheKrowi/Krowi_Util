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

local _, addon = ...;
addon.Options = {};
local options = addon.Options;
local metadata = addon.Metadata;

options.OptionsTables = {};
options.WidthMultiplier = addon.Util.IsWrathClassic and 1 or 200 / 170; -- 170 comes from AceConfigDialog-3.0.lua, 200 fits better on the screen in DF

options.OptionsTable = {
    name = metadata.Title,
    type = "group",
    childGroups = "tab",
    args = {}
};

function options:Load()
    self.db = LibStub("AceDB-3.0"):New(metadata.Prefix .. "_Options", self.Defaults, true);
    self.OptionsTable.args.Profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db);

    for _, optionsTable in next, self.OptionsTables do
        optionsTable.RegisterOptionsTable();
    end

    for _, optionsTable in next, self.OptionsTables do
        optionsTable.PostLoad();
    end
end

function options:Open()
    local name = metadata.Title;

    if addon.Util.IsWrathClassic then
        InterfaceAddOnsList_Update(); -- This way the correct category will be shown when calling InterfaceOptionsFrame_OpenToCategory
        InterfaceOptionsFrame_OpenToCategory(name);
        for _, button in next, InterfaceOptionsFrameAddOns.buttons do
            if button.element and button.element.name == name and button.element.collapsed then
                OptionsListButtonToggle_OnClick(button.toggle);
                break;
            end
        end
        return;
    end

    Settings.GetCategory(name).expanded = true;
    Settings.OpenToCategory(name, true);
end