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
* [] call reapercrew_counterBattery_fnc_radarInit
*
* Public: No
*/

params ["_radarUnit"];

// Server Check
if (!isServer) exitWith {diag_log "[COUNTER BATTERY]: Server checked failed - not running radar init"};

// Don't init if system is disabled
if !(reaperCrew_fireSupport_ActivateSystem) exitWith { diag_log "[COUNTER BATTERY]: System disabled - not running radar init"; };

// Make sure the required variable is declared
while {isNil "playerCounterBatterySystems"} do {
	if (reaperCrew_fireSupport_debugCounterBatteryDetection) then {
		diag_log "[COUNTER BATTERY]: Radar registration failed, missing variable, sleeping";
	};
	sleep 15;
};

// Lock the vehicle
_radarUnit setVehicleLock "LOCKED";

// Register asset in the pool
playerCounterBatterySystems pushback _radarUnit;
// playerCounterBatterySystems = playerCounterBatterySystems + _radarUnit;
diag_log format ["[COUNTER BATTERY]: Registered radar unit: %1", _radarUnit];

// Establish radar zone
// Get config reference
_detectionZone = getNumber (configFile >> "CfgVehicles" >> (typeOf _radarUnit) >> "counterBattery" >> "detectionRadius");
// Create Marker
_randomName = [100000000,99999999] call BIS_fnc_randomInt;
_randomMarkerName = format ["RadarZone%1", _randomName];

_radarZone = createMarker [_randomMarkerName, (getPos _radarUnit)];
_radarZone setMarkerColor "ColorOrange";
_radarZone setMarkerShape "ELLIPSE";
_radarZone setMarkerSize [_detectionZone, _detectionZone];
_radarZone setMarkerBrush "Border";
// _radarZone setMarkerAlpha 0;

// Save variables to object namespace
_radarUnit setVariable ["_radarZone", _radarZone, true];
_radarUnit setVariable ["_radarKnowledge", [], true];

// Add Actions
[
	_radarUnit,
	["Switch Generator On",
	{ params ["_target", "_caller", "_actionId", "_arguments"]; _target engineOn true; },
	nil,
	1.5,
	false,
	false,
	"",
	"_this distance _target < 5 && (isEngineOn _target) == false",
	5]
] remoteExec ["addAction", 0, true];

[
	_radarUnit,
	["Switch Generator Off",
	{ params ["_target", "_caller", "_actionId", "_arguments"]; _target engineOn false; },
	nil,
	1.5,
	false,
	false,
	"",
	"_this distance _target < 5 && (isEngineOn _target) == true",
	5]
] remoteExec ["addAction", 0, true];

[
	_radarUnit,
	["Check fuel level",
	{ params ["_target", "_caller", "_actionId", "_arguments"]; hint format ["Generator has %1 % fuel", ((fuel _target) * 100)]; },
	nil,
	1.5,
	false,
	false,
	"",
	"_this distance _target < 5",
	5]
] remoteExec ["addAction", 0, true];