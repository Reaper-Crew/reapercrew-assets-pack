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
* [] call reapercrew_sabre_fnc_eventFired
*
* Public: No
*/

params ["_artilleryUnit"];

// Only execute on the server
if (!isServer) exitWith {["Server checked failed - not running event handler"] call reapercrew_common_fnc_remoteLog;};

// Only go through radar systems that aren't on the side
_radarSystems = [];
switch (side _artilleryUnit) do {
	case west: { 
		_radarSystems append DatalinkOpForCounterBatteryElements;
		_radarSystems append DatalinkIndForCounterBatteryElements;
	};
	case east: { 
		_radarSystems append DatalinkBluForCounterBatteryElements;
		_radarSystems append DatalinkIndForCounterBatteryElements;
	};
	case independent: { 
		_radarSystems append DatalinkBluForCounterBatteryElements;
		_radarSystems append DatalinkOpForCounterBatteryElements;
	};
	default { _radarSystems = []; };
};
diag_log _radarSystems;

// Loop through the radar systems
{

	// Check that unit is alive
	if (!alive _x) exitWith {["Unit not alive, skipping EH trigger"] call reapercrew_common_fnc_remoteLog;};

	// Check that unit is active
	if (!isEngineOn _x) exitWith {["Unit is not active, skipping EH trigger"] call reapercrew_common_fnc_remoteLog;};
	
	// Check that unit is within radar range
	_radarZone = _x getVariable ["_radarZone", ""];
	_isInArea = _artilleryUnit inArea _radarZone;
	if (!_isInArea) exitWith {["Unit not in radar zone skipping EH trigger"] call reapercrew_common_fnc_remoteLog;};
	
	// Determine if the asset is already known on the network
	_dataLinkKnowledge = [];

	// Determine what datalink knowledge we're working with
	switch (side _x) do {
		case west: { 
			[DatalinkBluForDiscoverableFires, west, _artilleryUnit] call reapercrew_sabre_counterBattery_fnc_componentLCMRMarkerSearch;
		};
		case east: { 
			[DatalinkOpForDiscoverableFires, east, _artilleryUnit] call reapercrew_sabre_counterBattery_fnc_componentLCMRMarkerSearch;
		};
		case independent: { 
			[DatalinkIndForDiscoverableFires, independent, _artilleryUnit] call reapercrew_sabre_counterBattery_fnc_componentLCMRMarkerSearch;
		};
		default { _radarSystems = []; };
	};

} forEach _radarSystems;