/*
* Author: Xeenenta
* This event function is remotely executed on a client to add all of the vehicles artillery data to their map
*
* Arguments:
* 0: Radar Unit <OBJECT>
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_counterBattery_fnc_eventGetIn
*
* Public: No
*/

params ["_radarUnit"];

// Show radar zone
_radarZone = _radarUnit getVariable ["_radarZone", ""];
_radarZone setMarkerAlphaLocal 1;

while { vehicle player == _radarUnit } do {
	_radarKnowledge = _radarUnit getVariable ["_radarKnowledge", []];
	if (reaperCrew_fireSupport_debugKnowledgeMarkers) then {
		diag_log format ["[COUNTER BATTERY]: The knowledge is %1", _radarKnowledge];
	};
	
	{
		_markerName = _x select 1;
		if (reaperCrew_fireSupport_debugKnowledgeMarkers) then {
			diag_log format ["[COUNTER BATTERY]: Radar %1 has a marker with alpha %2 for player %3", _radarUnit, (markerAlpha _markerName), player];
		};
		// If it's not already shown, show it, otherwise skip
		if !(markerAlpha _markerName == 1) then {
			_markerName setMarkerAlphaLocal 1;
		};
	} forEach _radarKnowledge;
	sleep 1;
};