/*
* Author: Xeenenta
* Sync remote client with the server-side SABRE data
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_sabre_network_fnc_networkSync
*
* Public: No
*/

if !(hasInterface) exitWith {["Player check failed - Not starting SABRE sync task", (name player)] call reapercrew_common_fnc_remoteLog;};

if !(canSuspend) exitWith {["canSuspend check failed - not running network sync", (name player)] call reapercrew_common_fnc_remoteLog;};

_hasInit = [currentNamespace, "DataLinkSystemStarted", false] call BIS_fnc_getServerVariable;
while {_hasInit == false} do {
	_hasInit = [currentNamespace, "DataLinkSystemStarted", false] call BIS_fnc_getServerVariable;
	["System not started, pausing scheduled task init", (name player)] call reapercrew_common_fnc_remoteLog;
	sleep 15;
};

// Get the information based on the side of the player
_playerSide = side player;
_playerName = name player;
_LCMRDiscoveryData = [];
_RadarUnits = [];
_RecordsCount = 0;
_action = "SYNC";
_hasSynced = player getVariable ["_sabreHasSync", false];
_syncCounterBattery = player getVariable ["_syncCounterBattery", true];

// Check if player has required equipment
_validSyncCheck = [] call reapercrew_sabre_network_fnc_validateSync;

// If valid sync target, add data
if (_validSyncCheck) then {
	[(format ["TASK: Running SABRE network sync on client %1", _playerName]), (name player)] call reapercrew_common_fnc_remoteLog;
	_action = "SYNC";
	player setVariable ["_sabreHasSync", true];
};
if (!(_hasSynced) && !(_validSyncCheck)) exitWith { diag_log "SABRE: No sync action required - terminating"; };
if !(_validSyncCheck) then {
	[(format ["TASK: Running SABRE network cleanup on client %1", _playerName]), (name player)] call reapercrew_common_fnc_remoteLog;
	_action = "OFFLOAD";
	player setVariable ["_sabreHasSync", false];
};

switch (side player) do {
	case west: { 
		_LCMRDiscoveryData append ([currentNamespace, "DatalinkBluForDiscoverableFires", []] call BIS_fnc_getServerVariable);
		_RadarUnits append ([currentNamespace, "DatalinkBluForCounterBatteryElements", []] call BIS_fnc_getServerVariable);
		[format ["Using %1 data for client %2", _playerSide, _playerName], (name player)] call reapercrew_common_fnc_remoteLog;
	};
	case east: {
		_LCMRDiscoveryData append ([currentNamespace, "DatalinkOpForDiscoverableFires", []] call BIS_fnc_getServerVariable);
		_RadarUnits append ([currentNamespace, "DatalinkOpForCounterBatteryElements", []] call BIS_fnc_getServerVariable);
		[format ["Using %1 data for client %2", _playerSide, _playerName], (name player)] call reapercrew_common_fnc_remoteLog;
	};
	case independent: { 
		_LCMRDiscoveryData append ([currentNamespace, "DatalinkIndForDiscoverableFires", []] call BIS_fnc_getServerVariable);
		_RadarUnits append ([currentNamespace, "DatalinkIndForCounterBatteryElements", []] call BIS_fnc_getServerVariable);
		[format ["Using %1 data for client %2", _playerSide, _playerName], (name player)] call reapercrew_common_fnc_remoteLog;
	};
};

if (_action == "SYNC" && _syncCounterBattery) then {
	// Add Markers
	{ 
		_markerName = _x select 1;
		if (markerAlpha _markerName == 0) then { _RecordsCount = _RecordsCount + 1; };
		_markerName setMarkerAlphaLocal 1;
	} forEach _LCMRDiscoveryData;
	{
		_radarZone = _x getVariable ["_radarZone", ""];
		// diag_log _x;
		// diag_log (_x getVariable ["_radarZone", ""]);
		_radarZone setMarkerAlphaLocal 1;
	} forEach _RadarUnits;
} else {
	// Remove markers
	{ 
		_markerName = _x select 1;
		_markerName setMarkerAlphaLocal 0;
	} forEach _LCMRDiscoveryData;
	{
		_radarZone = _x getVariable ["_radarZone", ""];
		_radarZone setMarkerAlphaLocal 0;
	} forEach _RadarUnits;
};
		
if ( _action == "SYNC" && _RecordsCount > 0 ) then {
	[format ["Alerting on %1 markers for %2", _RecordsCount, _playerName]] call reapercrew_common_fnc_remoteLog;
};