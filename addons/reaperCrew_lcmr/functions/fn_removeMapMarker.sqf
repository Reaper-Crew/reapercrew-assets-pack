/*
 * Author: Xeenenta
 * This function removes a local marker
 *
 * Arguments:
 * 1: Marker Name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Marker1"] call reaperCrew_fireSupport_fnc_removeMapMarker
 *
 * Public: No
 */

params ["_markerName"];

deleteMarkerLocal _markerName;

// // Evaluate all map markers
// _allMarkers = allMapMarkers;

// if (reaperCrew_fireSupport_debugMarkerSystem == true) then {
// 	diag_log format ["SCENARIO: Passed Marker Pos was : %1", _markerPosition];
// };

// // Remove all markers that share a position
// {
// 	if (reaperCrew_fireSupport_debugMarkerSystem == true) then {
// 		diag_log format ["SCENARIO: Current Marker pos is : %1", (getPos _x)];
// 	};
// 	if ((getPos _x) isEqualTo _markerPosition) then {
// 		deleteMarkerLocal _x;
// 		if (reaperCrew_fireSupport_debugMarkerSystem == true) then {
// 			diag_log format ["SCENARIO: Removed local marker: %1", _x];
// 		};
// 	};
// } forEach _allMarkers;

