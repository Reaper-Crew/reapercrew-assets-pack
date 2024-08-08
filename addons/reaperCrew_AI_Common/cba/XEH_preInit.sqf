// AI Global Settings
["reaperCrew_reinforcements_side", "LIST",     ["Opposition Faction", "What side is the opposition faction?"], ["Reaper Crew - AI Common", "1. Global AI Settings"], [[east,west,resistance], ["EAST","WEST", "INDEPENDENT"], 1]] call cba_settings_fnc_init;

// AI Infantry Settings
["reaperCrew_reinforcements_regularTroops", "EDITBOX", ["Regular Troops", "A comma seperated list of classnames to be used for the regular troops"], ["Reaper Crew - AI Common", "2. Infantry Settings"], "O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_eliteTroops", "EDITBOX", ["Elite Troops", "A comma seperated list of classnames to be used for the elite troops"], ["Reaper Crew - AI Common", "2. Infantry Settings"], "O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_specialForces", "EDITBOX", ["Special Forces", "A comma seperated list of classnames to be used for the special forces troops"], ["Reaper Crew - AI Common", "2. Infantry Settings"], "O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F"] call cba_settings_fnc_init;

// AI Difficulty Settings
["reaperCrew_reinforcements_regularTroopsDifficulty", "SLIDER",   ["Regular Troops Skill",   "What skill % should the regular troops be?"], ["Reaper Crew - AI Common", "2. Infantry Settings"], [20, 100, 50, 0]] call cba_settings_fnc_init;
["reaperCrew_reinforcements_eliteTroopsDifficulty", "SLIDER",   ["Elite Troops Skill",   "What skill % should the regular troops be?"], ["Reaper Crew - AI Common", "2. Infantry Settings"], [20, 100, 80, 0]] call cba_settings_fnc_init;
["reaperCrew_reinforcements_specialForcesDifficulty", "SLIDER",   ["Special Forces Skill",   "What skill % should the regular troops be?"], ["Reaper Crew - AI Common", "2. Infantry Settings"], [20, 100, 100, 0]] call cba_settings_fnc_init;

// Transport Fire Support
["reaperCrew_reinforcements_transportGround", "EDITBOX", ["Transport Vehicles", "A comma seperated list of classnames to be used for transport vehicles"], ["Reaper Crew - AI Common", "3. Transport Settings"], "O_G_Offroad_01_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_transportHelicopter", "EDITBOX", ["Transport Helicopters", "A comma seperated list of classnames to be used for transport helicopters"], ["Reaper Crew - AI Common", "3. Transport Settings"], "O_Heli_Light_02_unarmed_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_transportBoat", "EDITBOX", ["Transport Boats", "A comma seperated list of classnames to be used for transport boats"], ["Reaper Crew - AI Common", "3. Transport Settings"], "I_C_Boat_Transport_02_F"] call cba_settings_fnc_init;

// Ground Fire Support
["reaperCrew_reinforcements_fireSupportHeavyArmour", "EDITBOX", ["Heavy Armour", "A comma seperated list of classnames to be used for enemy heavy armour threats"], ["Reaper Crew - AI Common", "4. Fire Support (Ground)"], "O_MBT_02_cannon_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_fireSupportLightArmour", "EDITBOX", ["Light Armour", "A comma seperated list of classnames to be used for enemy light armour threats"], ["Reaper Crew - AI Common", "4. Fire Support (Ground)"], "O_APC_Tracked_02_cannon_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_fireSupportTechnicals", "EDITBOX", ["Technicals", "A comma seperated list of classnames to be used for enemy technical threats"], ["Reaper Crew - AI Common", "4. Fire Support (Ground)"], "O_G_Offroad_01_armed_F"] call cba_settings_fnc_init;

// Aircraft Fire Support
["reaperCrew_reinforcements_fireSupportLightRotary", "EDITBOX", ["Light Rotary", "A comma seperated list of classnames to be used for enemy light rotary"], ["Reaper Crew - AI Common", "5. Fire Support (Air)"], "O_Heli_Light_02_dynamicLoadout_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_fireSupportHeavyRotary", "EDITBOX", ["Heavy Rotary", "A comma seperated list of classnames to be used for enemy heavy rotary"], ["Reaper Crew - AI Common", "5. Fire Support (Air)"], "O_Heli_Attack_02_F"] call cba_settings_fnc_init;

["reaperCrew_reinforcements_fireSupportFixedWingFighters", "EDITBOX", ["Fixed Wing (Fighters)", "A comma seperated list of classnames to be used for enemy fixed wing"], ["Reaper Crew - AI Common", "5. Fire Support (Air)"], "O_Plane_CAS_02_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_fireSupportFixedWingBombers", "EDITBOX", ["Fixed Wing (Bombers)", "A comma seperated list of classnames to be used for enemy fixed wing"], ["Reaper Crew - AI Common", "5. Fire Support (Air)"], "O_Plane_CAS_02_F"] call cba_settings_fnc_init;

// Advanced AI
// Airborne Infantry
["reaperCrew_reinforcements_airborneInfantry", "EDITBOX", ["Airborne Infantry", "A comma seperated list of classnames to be used for the Airborne Infantry"], ["Reaper Crew - AI Detailed Orbat", "1. Infantry Settings"], "O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_airborneInfantryDifficulty", "SLIDER",   ["Airborne Infantry Skill",   "What skill % should the airborneInfantry be?"], ["Reaper Crew - AI Detailed Orbat", "1. Infantry Settings"], [20, 100, 50, 0]] call cba_settings_fnc_init;

// Naval Infantry
["reaperCrew_reinforcements_navalInfantry", "EDITBOX", ["Naval Infantry", "A comma seperated list of classnames to be used for the Naval Infantry"], ["Reaper Crew - AI Detailed Orbat", "1. Infantry Settings"], "O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_navalInfantryDifficulty", "SLIDER",   ["Naval Infantry Skill",   "What skill % should the navalInfantry be?"], ["Reaper Crew - AI Detailed Orbat", "1. Infantry Settings"], [20, 100, 50, 0]] call cba_settings_fnc_init;

// Mechanised Infantry
// ["reaperCrew_reinforcements_mechanisedInfantry", "EDITBOX", ["Mechanised Infantry", "A comma seperated list of classnames to be used for the Mechanised Infantry"], ["Reaper Crew - AI Detailed Orbat", "1. Infantry Settings"], "O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F"] call cba_settings_fnc_init;
// ["reaperCrew_reinforcements_mechanisedInfantryDifficulty", "SLIDER",   ["Mechanised Infantry Skill",   "What skill % should the mechanisedInfantry be?"], ["Reaper Crew - AI Detailed Orbat", "1. Infantry Settings"], [20, 100, 50, 0]] call cba_settings_fnc_init;

// Territorial Defence
["reaperCrew_reinforcements_territorialDefence", "EDITBOX", ["Territorial Defence", "A comma seperated list of classnames to be used for the Territorial Defence"], ["Reaper Crew - AI Detailed Orbat", "1. Infantry Settings"], "O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_territorialDefenceDifficulty", "SLIDER",   ["Territorial Defence Skill",   "What skill % should the territorialDefence be?"], ["Reaper Crew - AI Detailed Orbat", "1. Infantry Settings"], [20, 100, 50, 0]] call cba_settings_fnc_init;

// Irregular Infantry
["reaperCrew_reinforcements_irregularInfantry", "EDITBOX", ["Irregular Infantry", "A comma seperated list of classnames to be used for the Irregular Infantry"], ["Reaper Crew - AI Detailed Orbat", "1. Infantry Settings"], "O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F,O_Soldier_F,O_Soldier_AR_F"] call cba_settings_fnc_init;
["reaperCrew_reinforcements_irregularInfantryDifficulty", "SLIDER",   ["Irregular Infantry Skill",   "What skill % should the irregularInfantry be?"], ["Reaper Crew - AI Detailed Orbat", "1. Infantry Settings"], [20, 100, 50, 0]] call cba_settings_fnc_init;