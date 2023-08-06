-- local _, addon = ...;
-- local options = addon.Options;
-- options.Profiles = {};
-- local profiles = options.Profiles;
-- tinsert(options.OptionsTables, profiles);

-- local OrderPP = addon.InjectOptions.AutoOrderPlusPlus;
-- local AdjustedWidth = addon.InjectOptions.AdjustedWidth;

-- function profiles.RegisterOptionsTable()
--     LibStub("AceConfig-3.0"):RegisterOptionsTable("Profiles", options.OptionsTable.args.Profiles);
--     LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Profiles", "Profiles", addon.Metadata.Title);
-- end

-- function profiles.PostLoad()

-- end

-- local _, addon = ...;
-- tinsert(addon.Options.OptionsTables, { IsProfiles = true });

local _, addon = ...;
addon.Options:InsertProfilesOptions();