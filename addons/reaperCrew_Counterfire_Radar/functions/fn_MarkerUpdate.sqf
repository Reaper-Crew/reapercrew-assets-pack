/*
* Author: Xeenenta
* This function is called when there is a requirement to update a marker locally for a player
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_counterBattery_fnc_MarkerUpdate
*
* Public: No
*/
params ["_paramArray"];

_markerName = _paramArray select 0;
_artilleryUnit = _paramArray select 1;
_radarUnit = _paramArray select 2;

// Add check for item and distance
_validateAction = [_radarUnit] call reapercrew_counterBattery_fnc_validateNotification;
if (_validateAction) then {
	diag_log format ["[COUNTER BATTERY]: Marker was updated with params %1 and %2", _markerName, _artilleryUnit];
	_markerName setMarkerAlphaLocal 1;
	_markerName setMarkerTextLocal (format ["%1", [daytime, "HH:MM"] call BIS_fnc_timeToString]);
} else {
	diag_log format ["[COUNTER BATTERY]: Marker wasn't updated as validation check failed", _markerName, _artilleryUnit];
};