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
 * [_centerObject] call reaperCrew_fireSupport_fnc_checkAttachControlUnit
 *
 * Public: No
 */

params ["_centerObject"];

_objectArray = nearestObjects [_centerObject, ["reaperCrew_TPQ_49_ControlUnit"], 10];

_attachedController = isNil { _centerObject getVariable "attachedController" };

if ((count _objectArray > 0) and (_attachedController == true)) then {
	true;
} else {
	false;
};