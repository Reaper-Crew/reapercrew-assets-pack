// Debug Settings
["reaperCrew_HCDiscoveryCheckbox", "CHECKBOX", ["Debug HC Discovery", "Log HC discovery to console?"], ["Reaper Crew - Reinforcements", "Debug Settings"]] call cba_settings_fnc_init;
["reaperCrew_InfantrySpawnCheckbox", "CHECKBOX", ["Debug Infantry Spawn Discovery", "Log Infantry Spawn discovery to console?"], ["Reaper Crew - Reinforcements", "Debug Settings"]] call cba_settings_fnc_init;
["reaperCrew_VehicleSpawnCheckbox", "CHECKBOX", ["Debug Vehicle Spawn Discovery", "Log Vehicle Spawn discovery to console?"], ["Reaper Crew - Reinforcements", "Debug Settings"]] call cba_settings_fnc_init;
["reaperCrew_AircraftSpawnCheckbox", "CHECKBOX", ["Debug Aircraft Spawn Discovery", "Log Aircraft Spawn discovery to console?"], ["Reaper Crew - Reinforcements", "Debug Settings"]] call cba_settings_fnc_init;
["reaperCrew_ReinforcementsCheckbox", "CHECKBOX", ["Debug Reinforcements System", "Log reinforcements output to console?"], ["Reaper Crew - Reinforcements", "Debug Settings"]] call cba_settings_fnc_init;

// Discovery Settings


// AI Settings
["reaperCrew_reinforcements_side", "LIST",     ["Opposition Faction", "What side is the opposition faction?"], ["Reaper Crew - Reinforcements", "AI Settings"], [[east,west,resistance], ["EAST","WEST", "INDEPENDENT"], 1]] call cba_settings_fnc_init;
["reaperCrew_reinforcements_units", "EDITBOX", ["Reinforcement Units", "A comma seperated list of classnames to be used for the reinforcement group"], ["Reaper Crew - Reinforcements", "AI Settings"], "O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_transportGround", "EDITBOX", ["Transport Vehicles", "A comma seperated list of classnames to be used for transport vehicles"], ["Reaper Crew - Reinforcements", "AI Settings"], "B_Truck_01_transport_F,B_Truck_01_covered_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_transportHelicopter", "EDITBOX", ["Transport Helicopters", "A comma seperated list of classnames to be used for transport helicopters"], ["Reaper Crew - Reinforcements", "AI Settings"], "B_Heli_Transport_01_F"] call cba_settings_fnc_init;
