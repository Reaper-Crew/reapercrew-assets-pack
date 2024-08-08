/*
* Author: Xeenenta
* TODO
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_sabre_counterBattery_fnc_taskRemoveStaleMarkers
*
* Public: No
*/

{
	_artilleryObjectReference = _x select 0;
	_markerReference = _x select 1;
	_markerTime = _x select 2;
	_markerTimeBelow = (diag_tickTime - 1800);

	if (_markerTime < _markerTimeBelow) then {
		[format ["Removing stale marker %1", _markerReference]] call reapercrew_common_fnc_remoteLog;
		deleteMarker _markerReference;
	};

} forEach DatalinkBluForDiscoverableFires + DatalinkOpForDiscoverableFires + DatalinkIndForDiscoverableFires;