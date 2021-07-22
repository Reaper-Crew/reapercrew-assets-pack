/*
 * Author: Xeenenta
 * Attaches a generator to the LCMR object
 *
 * Arguments:
 * 0: OBJECT <OBJECT>
 * 1: 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_radarObject] call reaperCrew_fireSupport_fnc_attachControlUnit
 *
 * Public: No
 */

params ["_radarObject"];

// Find the generator object
_controllerObject = nearestObject [getPos _radarObject, "reaperCrew_TPQ_49_ControlUnit"];
_radarObject setVariable ["attachedController", _controllerObject];

diag_log "Controller attached";

// Spawn long running task to check for disconnect
[_radarObject, _controllerObject] spawn {
	params ["_radarObject", "_controllerObject"];
	waitUntil { sleep 15; (!alive _controllerObject) or ((_controllerObject distance _radarObject) > 10) };
	_radarObject setVariable ["attachedController", nil];
	diag_log "Controller detacted";
}; 