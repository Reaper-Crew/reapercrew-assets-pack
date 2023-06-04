params ["_knowledgeData", "_side", "_artilleryUnit"];

// diag_log format ["[COUNTER BATTERY]: Running search and update for %1", _side];
["SABRE", "COUNTER BATTERY", format ["Running search and update for %1", _side]] call reapercrew_common_fnc_remoteLog;

// Search Records
_isFound = false;
_isInArea = false;
_foundRecord = [];
_parentObject = [];
_mapMarker = "";
_mapTime = 0;
{
	_parentObject = _x;
	["SABRE", "COUNTER BATTERY", format ["Searching record %1", _parentObject]] call reapercrew_common_fnc_remoteLog;
	_artilleryObjectReference = _x select 0;
	if (_artilleryObjectReference == _artilleryUnit) exitWith {_foundRecord = _x; _isFound = true; _isFoundIndex = _forEachIndex; ["SABRE", "COUNTER BATTERY", "Found match"] call reapercrew_common_fnc_remoteLog;};
} forEach _knowledgeData;

// If record was found: Check is the unit is still within the marked zone
if (_isFound) then {
	_mapMarker = _foundRecord select 1;
	_mapTime = _foundRecord select 2;
	if (_artilleryUnit inArea _mapMarker) then {
		_isInArea = true;
	} else {
		_isInArea = false;
	};
};

if (_isFound) then {
	_mapMarker = _foundRecord select 1;
	_mapTime = _foundRecord select 2;
	// If isFound and _isInArea, then update existing
	if (_isInArea) then {
		if ( reaperCrew_sabreCounterBattery_DebugEvents ) then {
			["SABRE", "COUNTER BATTERY", format ["Association with %1 and %2 exists - updating entry", _x, _artilleryUnit]] call reapercrew_common_fnc_remoteLog;
			// Update Marker in the global space
    		[(getPos _artilleryUnit), _mapMarker] call reapercrew_sabre_counterBattery_fnc_componentLCMRMarkerSetup;

			// Update time parameter
			_parentObject set [2, (diag_tickTime)];
		};
	} else {
		// If isFound but NOT _isInArea, add a new icon
		if ( reaperCrew_sabreCounterBattery_DebugEvents ) then {
			["SABRE", "COUNTER BATTERY", format ["Association with %1 and %2 exists, but _isInArea false - Disassociating", _x, _artilleryUnit]] call reapercrew_common_fnc_remoteLog;
		};
		// Loop through and remove any entries with a reference to that object
		diag_log _knowledgeData;
		_knowledgeDataReplica = _knowledgeData;
		{
			_recordObject = _x select 0;
			_recordMarker = _x select 1;
			_recordTime = _x select 2;
			if (_recordObject == _artilleryUnit) then {
				_knowledgeData deleteAt _forEachIndex;
			}
		} forEach _knowledgeDataReplica;
		diag_log _knowledgeData;
		// Recreate the marker record without the unit associated
		_dissassociateEntry = [SabreDummyObject, _mapMarker, _mapTime];
		// Delete existing
		_knowledgeData deleteAt _isFoundIndex;
		// Readd
		_knowledgeData pushBack _dissassociateEntry;
		// Generate a new marker
		_markerName = [(getPos _artilleryUnit)] call reapercrew_sabre_counterBattery_fnc_componentLCMRMarkerSetup;
		// Add to data
		_knowledgeData pushBackUnique [_artilleryUnit, _markerName, (diag_tickTime)];
		diag_log _knowledgeData;
	};

} else {
	// Not found at all, create a new marker
	["SABRE", "COUNTER BATTERY", format ["No association with %1 and %2 exists - creating", _x, _artilleryUnit]] call reapercrew_common_fnc_remoteLog;
	// Generate a new marker
	_markerName = [(getPos _artilleryUnit)] call reapercrew_sabre_counterBattery_fnc_componentLCMRMarkerSetup;
	// Add to data
	_knowledgeData pushBackUnique [_artilleryUnit, _markerName, (diag_tickTime)]
};

switch (_side) do {
	case west: { 		
		DatalinkBluForDiscoverableFires = _knowledgeData;
	};
	case east: { 
		DatalinkOpForDiscoverableFires = _knowledgeData;
	};
	case independent: { 
		DatalinkIndForDiscoverableFires = _knowledgeData;
	};
};
