/*
* Author: Xeenenta
* This event function is remotely executed on a client to hide all of the markers
*
* Arguments:
* 0: Radar Unit <OBJECT>
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_counterBattery_fnc_eventGetOut
*
* Public: No
*/

params ["_radarUnit"];

_radarZone = _radarUnit getVariable ["_radarZone", ""];
_radarZone setMarkerAlphaLocal 0;

_radarKnowledge = _radarUnit getVariable ["_radarKnowledge", []];

{
	_markerName = _x select 1;
	_markerName setMarkerAlphaLocal 0;
} forEach _radarKnowledge;