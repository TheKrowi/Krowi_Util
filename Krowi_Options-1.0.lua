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