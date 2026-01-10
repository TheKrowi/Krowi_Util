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

local lib = LibStub("Krowi_Util-2.0", true);
if not lib then	return end

local L = lib.Localization.NewLocale('frFR')
if not L then return end
lib.L = L

-- [[ https://legacy.curseforge.com/wow/addons/krowi-util/localization ]] --
-- [[ Everything after this line is automatically generated from CurseForge and is not meant for manual edit - SOURCETOKEN - AUTOGENTOKEN ]] --

-- [[ Exported at 2026-01-10 11-32-45 ]] --
L["Checked"] = "Coché"
L["Default value"] = "Valeur par défaut"
L["Loaded"] = "Chargé"
L["Loaded Desc"] = "Indique si l'addon associé au plugin est chargé ou non."
L["Profiles"] = "Profils"
L["Requires a reload"] = "Nécessite un /reload"
L["Unchecked"] = "Non coché"