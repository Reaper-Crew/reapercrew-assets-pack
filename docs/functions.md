# Functions

## reapercrew_player_management_fnc_setUnitInsigniaLocal

Applies the correct callsign insignia to a player based on their group name and role description.

| Callsign | Supported Role names |
|----------|---------------------|
| Zero | Platoon Commander, Platoon Sergeant, Logistics Commander, Platoon JTAC, Platoon Medic |
| Reaper-1-1,2,3 | Section Commander, Section 2IC, Medic, Autorifleman, Assist Autorifleman, Sharpshooter, Rifleman, AT Specialist, AA Specialist, Engineer |
| Thunder | Section Commander, Section 2IC, Sniper, Heavy Gunner |
| Hammer | Battery Commander, Battery Medic, Battery Gunner |
| Fury-1,2 | Vehicle Commander, Vehicle Crew |
| Sentinel-1,2 | Vehicle Commander, Vehicle Crew |
| Shadow | Section Commander, Section 2IC, Medic, Autorifleman, Assist Autorifleman, Rifleman, Sniper, Spotter, JTAC |
| Viper-1,2 | Pilot |
| Ugly-1,2 | Pilot |
| Phantom-1,2 | Pilot |
| Foxhound-1,2 | Logistics Officer |

## reapercrew_common_fnc_groupCleanupWatcher

Runs automatically on every machine (postInit). Deletes empty local groups every 15 minutes, guarding against the engine's silent per-side group limit. No setup required.
