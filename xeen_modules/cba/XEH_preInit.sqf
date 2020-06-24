// HQ Settings
["xeen_forcesSide", "LIST",     ["Opposition Faction", "What side is the opposition faction?"], ["XBE Settings", "HQ Settings"], [[east,west,resistance], ["EAST","WEST", "INDEPENDENT"], 1]] call cba_settings_fnc_init;

// Garrison Settings
["xeen_garrisonUnits", "EDITBOX", ["Garrison Units", "A comma seperated list of classnames to be used to garrison buildings"], ["XBE Settings", "Garrison Settings"], "O_Soldier_F,O_Soldier_AR_F"] call cba_settings_fnc_init;

// Forward Observer Settings
["xeen_observerPlane", "EDITBOX", ["Forward Observer Plane", "A comma seperated list of classnames to be used for airstrikes"], ["XBE Settings", "Observer Settings"], "O_Plane_CAS_02_dynamicLoadout_F,O_Plane_CAS_02_dynamicLoadout_F"] call cba_settings_fnc_init;