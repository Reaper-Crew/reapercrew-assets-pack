/*
* Author: Xeenenta
* This is the function executed locally for the client in order to save their loadout
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_player_management_fnc_savePlayerLoadoutLocal
*
* Public: No
*/

_loadout = [player] call acre_api_fnc_filterUnitLoadout;
[] call reapercrew_player_management_fnc_setUnitInsigniaLocal;
player setVariable["Saved_Loadout",getUnitLoadout player];