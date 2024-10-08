/*
 * Author: Xeenenta
 * Sets the ACRE settings
 *
 * Arguments:
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call reapercrew_common_fnc_setACRESettings
 *
 * Public: No
 */

diag_log "[Reaper Crew]: Configuring ACRE channel names";

["ACRE_PRC148", "default", 1, "description", "Command Net"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", "default", 2, "description", "Logistics Net"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", "default", 3, "description", "Fire Control Net"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC148", "default", 4, "description", "Operations Room"] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC152", "default", 1, "description", "Command Net"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 2, "description", "Logistics Net"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 3, "description", "Fire Control Net"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 4, "description", "Operations Room"] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC117F", "default", 1, "name", "Command Net"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 2, "name", "Logistics Net"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 3, "name", "Fire Control Net"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 4, "name", "Operations Room"] call acre_api_fnc_setPresetChannelField;