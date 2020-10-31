/*
 * Author: Xeenenta
 * Sets the ACRE settings
 *
 * Arguments:
 * 0: Logic <LOGIC>
 * 1: 
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call reapercrew_func_setACRESettings
 *
 * Public: No
 */

diag_log "Reaper Crew: Setting ACRE Settings";

["ACRE_PRC152", "default", "reapercrew_preset_1"] call acre_api_fnc_copyPreset;
["ACRE_PRC117F", "default", "reapercrew_preset_1"] call acre_api_fnc_copyPreset;

["ACRE_PRC152", "default", 1, "description", "Platoon Net"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 2, "description", "Air Control Net"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 3, "description", "Zero JTAC"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 4, "description", "1-1 JTAC"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 5, "description", "1-2 JTAC"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 6, "description", "1-3 JTAC"] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC117F", "default", 1, "name", "Platoon Net"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 2, "name", "Air Control Net"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 3, "name", "Zero JTAC"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 4, "name", "1-1 JTAC"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 5, "name", "1-2 JTAC"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 6, "name", "1-3 JTAC"] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC152", "reapercrew_preset_1"] call acre_api_fnc_setPreset;