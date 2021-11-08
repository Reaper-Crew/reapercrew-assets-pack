/*
 * Author: Xeenenta
 * Disarms players
 *
 * Arguments:
 * 0: Logic <LOGIC>
 * 1: 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call reaperCrew_fnc_moduleDisarmPlayers
 *
 * Public: No
 */

params ["_logic"];

diag_log "DISARM MODULE: Function Started";

// Variables
_allPlayers = call BIS_fnc_listPlayers;
_moduleLocation = (getPos _logic);

{
	diag_log format ["Disarming player %1", name(_x)];
	remoteExecCall ["reapercrew_player_management_fnc_disarmModuleKitChange", _x, false];	

} forEach _allPlayers;

deleteVehicle _logic;

diag_log "DISARM MODULE: Function Complete";