/*
 * Author: Xeenenta
 * Checks for a nearby generator
 *
 * Arguments:
 * 0: OBJECT <OBJECT>
 * 1: 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_centerObject] call reaperCrew_fireSupport_fnc_checkAttachGenerator
 *
 * Public: No
 */

params ["_centerObject"];

_objectArray = nearestObjects [_centerObject, ["reaperCrew_TPQ_49_PowerUnit"], 10];

_attachedGenerator = isNil { _centerObject getVariable "attachedGenerator" };

if ((count _objectArray > 0) and (_attachedGenerator == true)) then {
	true;
} else {
	false;
};