// HQ Settings
["reaperCrew_forcesSide", "LIST",     ["Opposition Faction", "What side is the opposition faction?"], ["Reaper Crew", "HQ Settings"], [[east,west,resistance], ["EAST","WEST", "INDEPENDENT"], 1]] call cba_settings_fnc_init;

// Garrison Settings
["reaperCrew_garrisonUnits", "EDITBOX", ["Garrison Units", "A comma seperated list of classnames to be used to garrison buildings"], ["Reaper Crew", "Garrison Settings"], "O_Soldier_F,O_Soldier_AR_F"] call cba_settings_fnc_init;

// Logistics Settings
// Rifle Magazine
["reaperCrew_rifleMagazines", "EDITBOX", ["Rifle Magazines", "A comma seperated list of all rifle magazines that should be available from the logistics crate"], ["Reaper Crew", "Logistics Settings"], "ACE_30Rnd_556x45_Stanag_Tracer_Dim"] call cba_settings_fnc_init;

// Grenadier Ammo
["reaperCrew_grenadierAmmo", "EDITBOX", ["Grenadier Ammo", "A comma seperated list of all Grenadier Ammo that should be available from the logistics crate"], ["Reaper Crew", "Logistics Settings"], "1Rnd_HE_Grenade_shell"] call cba_settings_fnc_init;

// Sidearm Magazines
["reaperCrew_sidearmMagazines", "EDITBOX", ["Sidearm Magazines", "A comma seperated list of all Sidearm Magazines that should be available from the logistics crate"], ["Reaper Crew", "Logistics Settings"], "9Rnd_45ACP_Mag"] call cba_settings_fnc_init;

// Lethal grenades
["reaperCrew_lethalGrenades", "EDITBOX", ["Lethal Grenades", "A comma seperated list of all Lethal Grenades that should be available from the logistics crate"], ["Reaper Crew", "Logistics Settings"], "HandGrenade"] call cba_settings_fnc_init;

// Non-lethal grenades
["reaperCrew_nonLethalGrenades", "EDITBOX", ["Non-Lethal Grenades", "A comma seperated list of all Non-Lethal Grenades that should be available from the logistics crate"], ["Reaper Crew", "Logistics Settings"], "ACE_CTS9"] call cba_settings_fnc_init;

// Smoke Grenades
["reaperCrew_smokeGrenades", "EDITBOX", ["Smoke Grenades", "A comma seperated list of all Smoke Grenades that should be available from the logistics crate"], ["Reaper Crew", "Logistics Settings"], "SmokeShellPurple,SmokeShell"] call cba_settings_fnc_init;

// Machinegun Magazines
["reaperCrew_machinegunMagazines", "EDITBOX", ["Machinegun Magazines", "A comma seperated list of all Machinegun Magazines that should be available from the logistics crate"], ["Reaper Crew", "Logistics Settings"], "200Rnd_556x45_Box_Tracer_F"] call cba_settings_fnc_init;

// Marksman Magazines
["reaperCrew_MarksmanMagazines", "EDITBOX", ["Marksman Magazines", "A comma seperated list of all Marksman Magazines that should be available from the logistics crate"], ["Reaper Crew", "Logistics Settings"], "10Rnd_338_Mag"] call cba_settings_fnc_init;

// Launcher Ammo
["reaperCrew_LauncherAmmo", "EDITBOX", ["Launcher Ammo", "A comma seperated list of all Launcher Ammo that should be available from the logistics crate"], ["Reaper Crew", "Logistics Settings"], "Titan_AT"] call cba_settings_fnc_init;

// One time launchers
["reaperCrew_SingleUseLaunchers", "EDITBOX", ["Single-use Launchers", "A comma seperated list of all Single-use Launchers that should be available from the logistics crate"], ["Reaper Crew", "Logistics Settings"], "launch_NLAW_F"] call cba_settings_fnc_init;

// Explosives
["reaperCrew_explosives", "EDITBOX", ["Explosives", "A comma seperated list of all Explovies that should be available from the logistics crate"], ["Reaper Crew", "Logistics Settings"], "DemoCharge_Remote_Mag"] call cba_settings_fnc_init;