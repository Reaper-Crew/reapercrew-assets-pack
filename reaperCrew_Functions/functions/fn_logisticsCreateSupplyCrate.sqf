/*
 * Author: Xeenenta
 * Create a standard ammo crate
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call reapercrew_fnc_logisticsCreateSupplyCrate
 *
 * Public: No
 */

params ["_resupplyObject"];

// Crate Variables
_supplyCrate = "B_CargoNet_01_ammo_F" createVehicle position player;
[_supplyCrate, 8] call ace_cargo_fnc_setSize;
[_supplyCrate] call reapercrew_fnc_logisticsPopulateSupplyCrate;
[_resupplyObject, _supplyCrate, [([-10,10] call BIS_fnc_randomInt), -3, 0], 0] call BIS_fnc_relPosObject;