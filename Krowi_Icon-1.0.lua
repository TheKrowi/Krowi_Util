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

local ldbIcon = LibStub("LibDBIcon-1.0"); -- Global icon object


lib.Icon = {};
local icon = lib.Icon;

icon.__index = icon;
function icon:New(metaData, setMoreTooltipContent, onLeftClick, onRightClick)
    local instance = setmetatable({}, icon);

    instance.Metadata = metaData;
    instance.LdbName = metaData.AddonName .. "LDB";
    instance.SetMoreTooltipContent = setMoreTooltipContent;
    instance.OnLeftClick = onLeftClick;
    instance.OnRightClick = onRightClick;

    return instance;
end

function icon:SetTooltipContent(tooltip)
    tooltip:ClearLines();
    tooltip:AddDoubleLine(self.Metadata.Title, self.Metadata.BuildVersion);
    GameTooltip_AddBlankLineToTooltip(tooltip);
    self.SetMoreTooltipContent(tooltip);
end

function icon:OnClick(button)
    if button == "LeftButton" and self.OnLeftClick then
        self.OnLeftClick();
    elseif button == "RightButton" and self.OnRightClick then
        self.OnRightClick();
    end
end

function icon:CreateIcon()
    self.LdbObject = LibStub("LibDataBroker-1.1"):NewDataObject(self.LdbName, {
        type = "launcher",
        label = self.Metadata.Title,
        icon = self.Metadata.Icon,
        OnClick = function(_, button) self:OnClick(button); end,
        OnTooltipShow = function(tooltip) self:SetTooltipContent(tooltip); end
    });
end

function icon:Load(addon)
    self:CreateIcon();

    local db = addon.Options.db.profile;
    db.Minimap.hide = not db.ShowMinimapIcon;
    ldbIcon:Register(self.LdbName, self.LdbObject, db.Minimap);
end

function icon:Show()
    ldbIcon:Show(self.LdbName);
end

function icon:Hide()
    ldbIcon:Hide(self.LdbName);
end

function icon:OnAddonCompartmentEnter(_, menuButtonFrame)
    GameTooltip:SetOwner(menuButtonFrame, "ANCHOR_NONE");
    GameTooltip:SetPoint("TOPRIGHT", menuButtonFrame, "BOTTOMRIGHT", 0, 0);
    self:SetTooltipContent(GameTooltip);
    GameTooltip:Show();
end

function icon:OnAddonCompartmentLeave()
    GameTooltip:Hide();
end

function icon:OnAddonCompartmentClick(_, button)
    self:OnClick(button)
end