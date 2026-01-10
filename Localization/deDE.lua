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

---@diagnostic disable: undefined-global

local lib = LibStub("Krowi_Util-1.0", true);
if not lib then	return end

local L = lib.Localization.GetLocale('deDE')
if not L then return end
lib.L = L

-- [[ https://legacy.curseforge.com/wow/addons/krowi-util/localization ]] --
-- [[ Everything after this line is automatically generated from CurseForge and is not meant for manual edit - SOURCETOKEN - AUTOGENTOKEN ]] --

-- [[ Exported at 2026-01-10 11-32-45 ]] --
L["Checked"] = "Aktivert"
L["Default value"] = "Vorgabewert (Standard)"
L["Loaded"] = "Geladen"
L["Loaded Desc"] = "Zeigt an, ob das mit dem Plugin verbundene Addon geladen ist oder nicht."
L["Profiles"] = "Profile"
L["Requires a reload"] = "Funktioniert erst nach einem /reload."
L["Unchecked"] = "Nicht aktiviert"