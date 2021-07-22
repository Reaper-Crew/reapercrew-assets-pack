/*
 * Author: Xeenenta
 * This function adds local map markers for discovered artillery positions
 *
 * Arguments:
 * 1: Marker Name <STRING>
 * 2: Marker Text <STRING>
 * 3: Marker Position <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Marker1", "Test Marker", [0,0,0]] call reaperCrew_fireSupport_fnc_addMapMarker
 *
 * Public: No
 */

params ["_markerName", "_markerText", "_markerPosition"];

_mapMarker = createMarkerLocal [_markerName, _markerPosition];
_mapMarker setMarkerColorLocal "ColorRed";
_mapMarker setMarkerTextLocal _markerText;
_mapMarker setMarkerTypeLocal "mil_warning";
_mapMarker setMarkerSizeLocal [0.75, 0.75];

if (reaperCrew_fireSupport_debugMarkerSystem == true) then {
	diag_log format ["SCENARIO: Added local marker: %1", _mapMarker];
};