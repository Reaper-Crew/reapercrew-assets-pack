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
* [] call reapercrew_sabre_counterBattery_fnc_componentLCMRActionDeployRemote
*
* Public: No
*/

params ["_targetUnit", "_playerUnit", "_action"];

// Variables
_currentPosition = getPos _targetUnit;
_vehicleClassname = "reaperCrew_TPQ_50_Static_Container";

switch (_action) do {
	case "DEPLOY": {
		switch (side _playerUnit) do {
			case west: { 
				_vehicleClassname = "reaperCrew_TPQ_50_Static_Blufor";
			};
			case east: { 
				_vehicleClassname = "reaperCrew_TPQ_50_Static_Opfor";
			};
			case independent: { 
				_vehicleClassname = "reaperCrew_TPQ_50_Static_Independent";
			};
		};
	};
	case "REPACK": {
		_vehicleClassname = "reaperCrew_TPQ_50_Static_Container";
		// Remove radar zone
		_radarMarker = _targetUnit getVariable ["_radarZone", ""];
		deleteMarker _radarMarker;
		// Deregister CB
	};
};

{ deleteVehicle _x } forEach crew _targetUnit;
deleteVehicle _targetUnit;

[_currentPosition, _vehicleClassname, _playerUnit] spawn {
	params ["_currentPosition", "_vehicleClassname", "_playerUnit"];
	sleep 5;
	[_currentPosition, 0, _vehicleClassname, (side _playerUnit)] call BIS_fnc_spawnVehicle;
	// Trigger garbage collection
	[] call reapercrew_sabre_counterBattery_fnc_taskGarbageCollect;
};

