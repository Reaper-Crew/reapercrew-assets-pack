/*
* Author: Xeenenta
* This init function runs when a radar unit is created in order to register it and determine it's active zone
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_sabre_counterBattery_fnc_initialiseComponentLCMR
*
* Public: No
*/

params ["_radarUnit"];

// ["SABRE", "COUNTER BATTERY", "Testing remote logging"] call reapercrew_common_fnc_remoteLog;

// Server Check
if (!isServer) exitWith {["SABRE", "COUNTER BATTERY", "isServer check failed - not running radar init"] call reapercrew_common_fnc_remoteLog;};

//3Den check
if (is3DEN) exitWith {["SABRE", "COUNTER BATTERY", "is3DEN check failed - not running radar init"] call reapercrew_common_fnc_remoteLog;};

// Suspend Check
if !(canSuspend) exitWith {["SABRE", "COUNTER BATTERY", "canSuspend check failed - not running radar init"] call reapercrew_common_fnc_remoteLog;};

// Don't init if system is disabled
if !(reaperCrew_sabreCounterBattery_ActivateSystem) exitWith { ["SABRE", "COUNTER BATTERY", "System disabled - not running radar init"] call reapercrew_common_fnc_remoteLog; };

while {isNil "DataLinkSystemStarted"} do {
	if (reaperCrew_sabreCounterBattery_DebugTasks) then {
		["SABRE", "COUNTER BATTERY", "System not started, pausing radar init"] call reapercrew_common_fnc_remoteLog;
	};
	sleep 15;
};

// Establish radar zone
// Get config reference
_detectionZone = getNumber (configFile >> "CfgVehicles" >> (typeOf _radarUnit) >> "counterBattery" >> "detectionRadius");
// Create Marker
_randomName = [1000,9999] call BIS_fnc_randomInt;
_randomMarkerName = format ["RadarZone%1", _randomName];
_radarZone = createMarker [_randomMarkerName, (getPos _radarUnit)];

// Configure Vehicle
_radarUnit setVehicleLock "LOCKED";
_radarUnit engineOn true;
_radarUnit setVehicleRadar 1;

// Register based on classname
switch (side _radarUnit) do {
	case west: { 
		_radarZone setMarkerColor "colorBLUFOR";
		DatalinkBluForCounterBatteryElements pushBackUnique _radarUnit;
	};
	case east: { 
		_radarZone setMarkerColor "colorOPFOR";
		DatalinkOpForCounterBatteryElements pushBackUnique _radarUnit;
	};
	case independent: { 
		_radarZone setMarkerColor "colorIndependent"; 
		DatalinkIndForCounterBatteryElements pushBackUnique _radarUnit;
	};
};

["SABRE", "COUNTER BATTERY", (format ["Registered radar unit: %1", _radarUnit])] call reapercrew_common_fnc_remoteLog;

// _radarZone setMarkerColor "ColorOrange";
_radarZone setMarkerShape "ELLIPSE";
// _radarZone setMarkerSize [250, 250];
_radarZone setMarkerSize [_detectionZone, _detectionZone];
_radarZone setMarkerBrush "Border";
_radarZone setMarkerAlpha 0;

// Save variables to object namespace
_radarUnit setVariable ["_radarZone", _radarZone, true];
_radarUnit setVariable ["_radarKnowledge", [], true];

// Update the zone every 60 seconds
[_radarUnit] spawn {
	_radarMarker = _radarUnit getVariable "_radarZone";
	while { alive _radarUnit } do {
		_radarMarkerPos = getMarkerPos _radarMarker;
		_radarUnitPos = getPos _radarUnit;
		_radarUnitPosAdjusted = [_radarUnitPos select 0, _radarUnitPos select 1, 0];
		if (_radarMarkerPos != _radarUnitPosAdjusted) then {
			// Adjust Pos
			["SABRE", "COUNTER BATTERY", (format ["Adjusted marker position for: %1", _radarUnit])] call reapercrew_common_fnc_remoteLog;
			_radarMarker setMarkerPos _radarUnitPosAdjusted;
		};
	};
};