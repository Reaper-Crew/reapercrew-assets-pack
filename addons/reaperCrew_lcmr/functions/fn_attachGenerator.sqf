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
 * [_radarObject] call reaperCrew_fireSupport_fnc_attachGenerator
 *
 * Public: No
 */

params ["_radarObject"];

// Find the generator object
_generatorObject = nearestObject [getPos _radarObject, "reaperCrew_TPQ_49_PowerUnit"];
_radarObject setVariable ["attachedGenerator", _generatorObject, true];

diag_log "Generator attached";

// Spawn long running task to check for disconnect
[_radarObject, _generatorObject] spawn {
	params ["_radarObject", "_generatorObject"];
	waitUntil { sleep 15; (!alive _generatorObject) or ((_generatorObject distance _radarObject) > 10) };
	_radarObject setVariable ["attachedGenerator", nil, true];
	diag_log "Generator detacted";
}; 