/*
 * Author: Xeenenta
 * Create a standard medical crate
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call reapercrew_fnc_logisticsCreateMedicalCrate
 *
 * Public: No
 */

params ["_resupplyObject"];

// Crate Variables
_supplyCrate = "ReaperCrew_PlasticCase_Medical" createVehicle position player;
[_resupplyObject, _supplyCrate, [([-5,5] call BIS_fnc_randomInt), -3, 0], 0] call BIS_fnc_relPosObject;