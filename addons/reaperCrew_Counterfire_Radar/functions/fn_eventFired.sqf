/*
* Author: Xeenenta
* This event function runs when the Fired eventhandler is triggered for an artillery unit
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_counterBattery_fnc_eventFired
*
* Public: No
*/

params ["_artilleryUnit"];

// Only execute on the server
if (!isServer) exitWith {diag_log "[COUNTER BATTERY]: Server checked failed - not running event handler"};

// Loop through the radar systems
{

	// Check that unit is alive
	if (!alive _x) exitWith {diag_log "[COUNTER BATTERY]: Unit not alive, skipping EH trigger"};

	// Check that unit is active
	if (!isEngineOn _x) exitWith {diag_log "[COUNTER BATTERY]: Unit is not active, skipping EH trigger"};

	// Check that unit is within radar range
	_radarZone = _x getVariable ["_radarZone", ""];
	_isInArea = _artilleryUnit inArea _radarZone;
	if (!_isInArea) exitWith {diag_log "[COUNTER BATTERY]: Unit not in radar zone skipping EH trigger"};

	// Determine if the radar unit is already aware
	_radarKnowledge = _x getVariable ["_radarKnowledge", []];
	_isFound = false;
	_foundRecord = [];
	{
		_arrayObject = _x select 0;
		// diag_log format ["Matching %1 with %2", _arrayObject, _artilleryUnit];
		if (_arrayObject == _artilleryUnit) exitWith {_foundRecord = _x; _isFound = true; diag_log "[COUNTER BATTERY]: Found match"};
	} forEach _radarKnowledge;

	if (_isFound) then {
		// If already aware, update the icon
		if ( reaperCrew_fireSupport_debugRadarKnowledge ) then {
			diag_log format ["[COUNTER BATTERY]: Radar %1 is aware of %2, refreshing icon", _x, _artilleryUnit];
		};
		_mapMarker = _foundRecord select 1;

		// Call update event
		["playerCBMarkerUpdate", [_mapMarker, _artilleryUnit, _x]] call CBA_fnc_globalEvent;

	} else {
		// If not aware, add a new icon
		if ( reaperCrew_fireSupport_debugRadarKnowledge ) then {
			diag_log format ["[COUNTER BATTERY]: Radar %1 is not aware of %2, creating icon", _x, _artilleryUnit];
		};

		// Create marker in global space
		_randomName = [1000,9999] call BIS_fnc_randomInt;
		_markerName = format ["ArtilleryUnit%1", _randomName]; 
		_mapMarker = createMarker [_markerName, getPos _artilleryUnit];
		_mapMarker setMarkerAlpha 0;
		_mapMarker setMarkerType "mil_warning";
		_mapMarker setMarkerSize [0.75, 0.75];
		_mapMarker setMarkerColor "ColorRed";

		// Call add event
		["playerCBMarkerAdd", [_mapMarker, _artilleryUnit, _x]] call CBA_fnc_globalEvent;

		// Add to aware list
		_knowledgeArray = [_artilleryUnit, _mapMarker, true];
		_radarKnowledge pushBack _knowledgeArray;
		_x setVariable ["_radarKnowledge", _radarKnowledge, true];

		// Spawn long run task to remove alert lock
		[_artilleryUnit, _x] spawn {
			params ["_artilleryUnit", "_radarUnit"];
			sleep 300;
			_radarKnowledge = _radarUnit getVariable ["_radarKnowledge", []];
			if ( reaperCrew_fireSupport_debugRadarKnowledge ) then {
				diag_log format ["[COUNTER BATTERY]: Radar %1 knowledge before: %2", _radarUnit, _radarKnowledge];
			};	
			{
				_arrayObject = _x select 0;
				// If match, delete element and append
				if (_arrayObject == _artilleryUnit) exitWith { _x set [2, false]; diag_log format ["[COUNTER BATTERY]: Removing alert lock on radar %1 for asset %2", _radarUnit, _artilleryUnit]; };
			} forEach _radarKnowledge;
			if ( reaperCrew_fireSupport_debugRadarKnowledge ) then {
				diag_log format ["[COUNTER BATTERY]: Radar %1 knowledge after: %2", _radarUnit, _radarKnowledge];
			};
			_radarUnit setVariable ["_radarKnowledge", _radarKnowledge, true];
		};
	};
} forEach playerCounterBatterySystems;