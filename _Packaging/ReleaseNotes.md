### Added (2.8)
- `IsForever`, true on WoW Forever (16001). `IsClassicEra` stays true there as well, as before, since Forever's build is 1.x
- `IsModern`, true where the game runs Retail's interface: Retail and WoW Forever

### Changed (2.8)
- Library version 4 → 5, so this copy replaces an older embedded one
- Updated supported interfaces: `120105, 120100 → 120105` (Midnight 12.1.5; 12.1.0 is no longer live), added `16001` (WoW Forever)
- `Options/Options.lua` gives the options pages Retail's width wherever `IsModern` is true, so also on WoW Forever