/*
 * Author: Xeenenta
 * This function adds local map markers for discovered artillery positions
 *
 * Arguments:
 * 1: Marker Name <STRING>
 * 2: Marker Text <STRING>
 * 3: Marker Position <ARRAY>
 * 4: Enemy Turret <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Marker1", "Test Marker", [0,0,0], _enemyTurret] call reaperCrew_fireSupport_fnc_updateMapMarker
 *
 * Public: No
 */

params ["_markerName", "_markerText", "_markerPosition", "_enemyTurret"];

// // Get the details of the current marker
// // Check the marker name is in the namespace
// _checkMarkerVariable = isNil { _enemyTurret getVariable "detectedMarker" };
// if (_checkMarkerVariable) then {
// 	if (reaperCrew_fireSupport_debugMarkerSystem == true) then {
// 		diag_log format ["SCENARIO: Marker update failed, no existing local marker for %1", _enemyTurret];
// 	};
// };

// // Grab the data
// _oldMarker = _enemyTurret getVariable "detectedMarker";

// if (reaperCrew_fireSupport_debugMarkerSystem == true) then {
// 	diag_log format ["SCENARIO: Found existing marker for %1 named %2", _enemyTurret, _oldMarker];
// };

// Delete the current marker
[_markerName] call reaperCrew_fireSupport_fnc_removeMapMarker;

// Add the new marker
[_markerName, _markerText, _markerPosition] call reaperCrew_fireSupport_fnc_addMapMarker;