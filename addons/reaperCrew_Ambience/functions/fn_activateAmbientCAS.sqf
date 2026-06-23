/*
 * Author: Xeenenta
 * Activation loop for the Ambient CAS module. While the trigger is active, executes
 * CAS strikes at random positions within the trigger area. Supports player proximity
 * gating and player-avoidance for strike positions.
 *
 * Arguments:
 * 0: Trigger Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [thisTrigger] spawn reapercrew_ambience_fnc_activateAmbientCAS
 *
 * Public: No
 */

if (!isServer) exitWith {};

params [["_triggerObject", objNull, [objNull]]];

if (isNull _triggerObject) exitWith {
	["ERROR: No trigger object provided to activateAmbientCAS"] call reapercrew_common_fnc_remoteLog;
};

// Read configuration from trigger variables
private _aircraftClass = _triggerObject getVariable ["aircraftClass", "B_Plane_CAS_01_F"];
private _strikeType = _triggerObject getVariable ["strikeType", 1];
private _strikeDir = _triggerObject getVariable ["strikeDir", 0];
private _proximityEnabled = _triggerObject getVariable ["proximityEnabled", true];
private _proximityRange = _triggerObject getVariable ["proximityRange", 2000];
private _avoidPlayers = _triggerObject getVariable ["avoidPlayers", false];
private _avoidRadius = _triggerObject getVariable ["avoidRadius", 500];
private _delayMin = _triggerObject getVariable ["delayMin", 30];
private _delayMax = _triggerObject getVariable ["delayMax", 180];

private _triggerPos = getPos _triggerObject;

[(format ["Ambient CAS active - aircraft: %1, proximity: %2 (%3m), avoidPlayers: %4 (%5m), delay: %6-%7s", _aircraftClass, _proximityEnabled, _proximityRange, _avoidPlayers, _avoidRadius, _delayMin, _delayMax])] call reapercrew_common_fnc_remoteLog;

while {triggerActivated _triggerObject} do {

	// Per-strike proximity check - skip if no players are within range
	if (_proximityEnabled && {allPlayers findIf {_x distance2D _triggerPos < _proximityRange} == -1}) then {
		["No players within proximity range, skipping strike"] call reapercrew_common_fnc_remoteLog;
		sleep ([_delayMin, _delayMax] call BIS_fnc_randomInt);
		continue;
	};

	// Generate strike position
	private _strikePos = [_triggerObject] call BIS_fnc_randomPosTrigger;

	// Avoid-players check - try to find a position away from all players
	if (_avoidPlayers) then {
		private _attempts = 0;
		while {_attempts < 5} do {
			if (allPlayers findIf {_x distance2D _strikePos < _avoidRadius} == -1) exitWith {};
			_strikePos = [_triggerObject] call BIS_fnc_randomPosTrigger;
			_attempts = _attempts + 1;
		};
		if (_attempts >= 5) then {
			["Could not find position away from players after 5 attempts, using fallback"] call reapercrew_common_fnc_remoteLog;
		};
	};

	[(format ["Executing air strike at %1", mapGridPosition _strikePos])] call reapercrew_common_fnc_remoteLog;

	// Create an invisible laser target as the CAS aim point, execute the strike,
	// then schedule cleanup via CBA rather than spawning a thread just to sleep and delete.
	private _dummy = "LaserTargetCBase" createVehicle _strikePos;
	_dummy enableSimulation false;
	_dummy hideObject true;
	_dummy setVariable ["vehicle", _aircraftClass];
	_dummy setVariable ["type", _strikeType];
	_dummy setDir _strikeDir;

	[_dummy, nil, true] call BIS_fnc_moduleCAS;

	[{deleteVehicle _this}, _dummy, 10] call CBA_fnc_waitAndExecute;

	sleep ([_delayMin, _delayMax] call BIS_fnc_randomInt);
};

["Ambient CAS deactivated - trigger no longer active"] call reapercrew_common_fnc_remoteLog;
