### Fixed (2.7)
- `IsWrathClassic` and `IsCataClassic` are back, and `IsClassicWithAchievements` includes them again, as before the Midnight update of November 2025. Since then, addons on the Wrath (38002) client read nil for both and took their non-Classic branches
- Library version 3 → 4, so this copy replaces an older embedded one
- Options open through the settings panel on every client that has one, Wrath Classic included; the old Interface Options path only runs where the client has no settings panel

### Changed (2.7)
- Updated supported interfaces: `120007 → 120105, 120100` (Midnight 12.1.0 and 12.1.5), added `38002` (Wrath Classic), `20505 → 20506` (Burning Crusade Anniversary), `11508 → 11509` (Classic Era)