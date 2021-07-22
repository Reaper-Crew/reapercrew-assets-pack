/*
 * Author: Xeenenta
 * This function alerts a counter battery station about the turret
 *
 * Arguments:
 * 1: CB Unit <OBJECT>
 * 2: Enemy Turret <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit] call reaperCrew_fireSupport_fnc_alertUnit
 *
 * Public: No
 */

params ["_radarUnit", "_enemyTurret", "_triggerType"];

// Variables
_newValue = [];
_markerName = "";
_controllerObject = objnull;

_attachedController = isNil { _radarUnit getVariable "attachedController" };
if (_attachedController) exitWith {
	if (reaperCrew_fireSupport_debugEventHandlers == true) then {
	diag_log format ["SCENARIO: attachedController is nil for object %1", _radarUnit];
	};
};
_controllerObject = _radarUnit getVariable "attachedController";

if (_triggerType == "fresh") then {

	// Get the current alerted list and append it
	_alertedUnits = _radarUnit getVariable ["alertedUnits", []];
	_newValue = _alertedUnits + [_enemyTurret];
	_radarUnit setVariable ["alertedUnits", _newValue];

	// Debug information
	if (reaperCrew_fireSupport_debugEventHandlers == true) then {
		diag_log format ["SCENARIO: Radar unit %1 was alerted to %2", _radarUnit, _enemyTurret];
		diag_log format ["SCENARIO: Object variable is now: %1", _alertedUnits];
		diag_log format ["SCENARIO: Object variable should be: %1", _newValue];
	};

	// Play environmental alerting
	playSound3D ["reaperCrew_lcmr\sounds\alert.ogg", _controllerObject, false, getPosASL _controllerObject, 3, 1, 250];

	// Spawn a long running task to remove that unit after 5 mins
	[_radarUnit,_enemyTurret] spawn {
		params ["_radarUnit", "_enemyTurret"];
		sleep 300;
		_alertedUnits = _radarUnit getVariable ["alertedUnits", []];
		_newValue = _alertedUnits - [_enemyTurret];
		_radarUnit setVariable ["alertedUnits", _newValue];
	
		if (reaperCrew_fireSupport_debugEventHandlers == true) then {
			diag_log format ["SCENARIO: Alert block on %1 removed from %2", _enemyTurret, _radarUnit];
		};
	};
};

// Create the marker and assign to the turret
_markerName = format ["ArtilleryPosition%1", _enemyTurret];
_markerText = format ["%1", [daytime, "HH:MM"] call BIS_fnc_timeToString];
_markerPosition = [(getPos _enemyTurret) select 0, (getPos _enemyTurret) select 1, 0];

_enemyTurret setVariable ["detectedMarker", _markerName];

// Get all players with a 20m radius of the control unit
{
	// If update, change the existing marker
	if (_triggerType == "update") then {
		[_markerName, _markerText, _markerPosition, _enemyTurret] remoteExecCall ["reaperCrew_fireSupport_fnc_updateMapMarker", _x];
	} else {
		// [_markerName] call reaperCrew_fireSupport_fnc_removeMapMarker;
		[_markerName, _markerText, _markerPosition] remoteExecCall ["reaperCrew_fireSupport_fnc_addMapMarker", _x];
	};

	// Spawn long running task to remove marker
	[_markerName, _x] spawn {
		params ["_markerName", "_playerUnit"];
		sleep 1800;
		[_markerName] remoteExecCall ["deleteMarkerLocal", _playerUnit];
	};
} forEach (allPlayers select { _x distance2D _controllerObject < 50 });