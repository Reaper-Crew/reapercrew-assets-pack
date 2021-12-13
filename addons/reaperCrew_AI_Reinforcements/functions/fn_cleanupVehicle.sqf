/*
 * Author: Xeenenta
 * Spawns infantry units and sets them to rush
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle] call reapercrew_reinforcements_fnc_cleanupVehicle
 *
 * Public: No
 */

params ["_vehicle"];

[_vehicle] spawn {
	params ["_vehicle"];
	// After 10 mins, delete the vehicle
	sleep 600;
	if (alive _vehicle) then {
		deleteVehicle _vehicle;
	};
};