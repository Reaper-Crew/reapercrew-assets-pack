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
 * [_logic] call reaperCrew_Func_moduleDisarmPlayers
 *
 * Public: No
 */

params ["_logic"];

diag_log "DISARM MODULE: Function Started";

// Variables
_allPlayers = call BIS_fnc_listPlayers;
_moduleLocation = (getPos _logic);

{
	diag_log format ["Disarming player %1", _x];

	removeAllWeapons _x;
	removeAllItems _x;
	removeAllAssignedItems _x;
	removeUniform _x;
	removeVest _x;
	removeBackpack _x;
	removeHeadgear _x;
	removeGoggles _x;

	_x forceAddUniform "U_BG_Guerilla2_1";
	_x linkItem "ItemMap";
	_x linkItem "ItemCompass";
	_x linkItem "ItemWatch";
	_x linkItem "ItemGPS";	

} forEach _allPlayers;

deleteVehicle _logic;

diag_log "DISARM MODULE: Function Complete";