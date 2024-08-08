// Logistics Settings
// Rifle Magazine
["reaperCrew_rifleMagazines", "EDITBOX", ["Rifle Magazines", "A comma seperated list of all rifle magazines that should be available from the logistics crate"], ["Reaper Crew - Logistics", "Small Arms"], "ACE_30Rnd_556x45_Stanag_Tracer_Dim"] call cba_settings_fnc_init;

// Grenadier Ammo
["reaperCrew_grenadierAmmo", "EDITBOX", ["Grenadier Ammo", "A comma seperated list of all Grenadier Ammo that should be available from the logistics crate"], ["Reaper Crew - Logistics", "Small Arms"], "1Rnd_HE_Grenade_shell"] call cba_settings_fnc_init;

// Sidearm Magazines
["reaperCrew_sidearmMagazines", "EDITBOX", ["Sidearm Magazines", "A comma seperated list of all Sidearm Magazines that should be available from the logistics crate"], ["Reaper Crew - Logistics", "Small Arms"], "9Rnd_45ACP_Mag"] call cba_settings_fnc_init;

// Lethal grenades
["reaperCrew_lethalGrenades", "EDITBOX", ["Lethal Grenades", "A comma seperated list of all Lethal Grenades that should be available from the logistics crate"], ["Reaper Crew - Logistics", "Small Arms"], "HandGrenade"] call cba_settings_fnc_init;

// Non-lethal grenades
["reaperCrew_nonLethalGrenades", "EDITBOX", ["Non-Lethal Grenades", "A comma seperated list of all Non-Lethal Grenades that should be available from the logistics crate"], ["Reaper Crew - Logistics", "Small Arms"], "ACE_CTS9"] call cba_settings_fnc_init;

// Smoke Grenades
["reaperCrew_smokeGrenades", "EDITBOX", ["Smoke Grenades", "A comma seperated list of all Smoke Grenades that should be available from the logistics crate"], ["Reaper Crew - Logistics", "Small Arms"], "SmokeShellPurple,SmokeShell"] call cba_settings_fnc_init;

// Machinegun Magazines
["reaperCrew_machinegunMagazines", "EDITBOX", ["Machinegun Magazines", "A comma seperated list of all Machinegun Magazines that should be available from the logistics crate"], ["Reaper Crew - Logistics", "Small Arms"], "200Rnd_556x45_Box_Tracer_F"] call cba_settings_fnc_init;

// Marksman Magazines
["reaperCrew_MarksmanMagazines", "EDITBOX", ["Marksman Magazines", "A comma seperated list of all Marksman Magazines that should be available from the logistics crate"], ["Reaper Crew - Logistics", "Small Arms"], "10Rnd_338_Mag"] call cba_settings_fnc_init;

// Launcher Ammo
["reaperCrew_LauncherAmmo", "EDITBOX", ["Launcher Ammo", "A comma seperated list of all Launcher Ammo that should be available from the logistics crate"], ["Reaper Crew - Logistics", "Small Arms"], "Titan_AT"] call cba_settings_fnc_init;

// One time launchers
["reaperCrew_SingleUseLaunchers", "EDITBOX", ["Single-use Launchers", "A comma seperated list of all Single-use Launchers that should be available from the logistics crate"], ["Reaper Crew - Logistics", "Small Arms"], "launch_NLAW_F"] call cba_settings_fnc_init;

// Explosives
["reaperCrew_explosives", "EDITBOX", ["Explosives", "A comma seperated list of all Explovies that should be available from the logistics crate"], ["Reaper Crew - Logistics", "Small Arms"], "DemoCharge_Remote_Mag"] call cba_settings_fnc_init;

// Mortar
["reaperCrew_IDFCrate", "CHECKBOX", ["Add IDF Crate", "Should an IDF ammo crate be added to the list of available crates?"], ["Reaper Crew - Logistics", "Indirect Fires"]] call cba_settings_fnc_init;
["reaperCrew_IDFExplosiveRounds", "EDITBOX", ["IDF Explosive Rounds", "A comma seperated list of all offensive IDF rounds"], ["Reaper Crew - Logistics", "Indirect Fires"], "ACE_1Rnd_82mm_Mo_HE,ACE_1Rnd_82mm_Mo_HE_Guided,ACE_1Rnd_82mm_Mo_HE_LaserGuided"] call cba_settings_fnc_init;
["reaperCrew_IDFUtility", "EDITBOX", ["IDF Utility Rounds", "A comma seperated list of all utility IDF rounds"], ["Reaper Crew - Logistics", "Indirect Fires"], "ACE_1Rnd_82mm_Mo_Smoke,ACE_1Rnd_82mm_Mo_Illum"] call cba_settings_fnc_init;
["reaperCrew_IDFItems", "EDITBOX", ["IDF Items", "A comma seperated list of items to be added to the IDF crate"], ["Reaper Crew - Logistics", "Indirect Fires"], "ACE_UAVBattery,ACE_MapTools,ACE_RangeTable_82mm,ACE_artilleryTable"] call cba_settings_fnc_init;

// Vehicle Fuel
["reaperCrew_VehicleFuelCheckbox", "CHECKBOX", ["Add Vehicle Fuel barrels", "Should a vehicle fuel crate be added to the list of available crates?"], ["Reaper Crew - Logistics", "Vehicle Armaments"]] call cba_settings_fnc_init;

// Vehicle Ammo
["reaperCrew_VehicleAmmoCheckbox", "CHECKBOX", ["Add Vehicle Ammo crates", "Should a vehicle ammo crate be added to the list of available crates?"], ["Reaper Crew - Logistics", "Vehicle Armaments"]] call cba_settings_fnc_init;

// Misc
["reaperCrew_transportCheckbox", "CHECKBOX", ["Add empty crates", "Should players have the option to spawn empty wooden boxes for transport?"], ["Reaper Crew - Logistics", "Misc"]] call cba_settings_fnc_init;