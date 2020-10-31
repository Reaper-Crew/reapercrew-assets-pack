// HQ Settings
["reaperCrew_forcesSide", "LIST",     ["Opposition Faction", "What side is the opposition faction?"], ["Reaper Crew", "HQ Settings"], [[east,west,resistance], ["EAST","WEST", "INDEPENDENT"], 1]] call cba_settings_fnc_init;

// Garrison Settings
["reaperCrew_garrisonUnits", "EDITBOX", ["Garrison Units", "A comma seperated list of classnames to be used to garrison buildings"], ["Reaper Crew", "Garrison Settings"], "O_Soldier_F,O_Soldier_AR_F"] call cba_settings_fnc_init;