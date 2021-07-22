/*
 * Author: Xeenenta
 * This init function runs and starts the counter battery system
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call reaperCrew_fireSupport_fnc_systemInit
 *
 * Public: No
 */

// Only run this on the server
if (!isServer) exitWith {diag_log "SCENARIO: Server checked failed - skipping reinforcements system"};

// Check that the system is enabled
if (reaperCrew_fireSupport_ActivateSystem == true) then {
	diag_log "SCENARIO: Initialising counter battery system";
} else {
	diag_log "SCENARIO: Counter battery system is disabled, exiting";
	//exitWith { false; };
	// Kill the function
};

// Global Variables
allArtilleryAssets = [];
registeredArtilleryAssets = [];
counterBatterySystems = [];
batteryPositioningData = [];

// Get a list of all of the counter battery systems available
counterBatterySystems = entities "reaperCrew_TPQ_49";
// Assign all CB systems a blank alerted list
{
	_x setVariable ["alertedUnits", []];
} forEach counterBatterySystems;

// Spawn a long running task to gather the list of enemy assets
[] spawn {

	while { reaperCrew_fireSupport_ActivateSystem } do {

		// Get a list of all of the counter battery systems available
		counterBatterySystems = entities "reaperCrew_TPQ_49";
		{
			_variableCheck = isNil { _x getVariable "alertedUnits" };
			if (_variableCheck) then {
				_x setVariable ["alertedUnits", []];
			};
		} forEach counterBatterySystems;

		// Find all the enemy assets on the map
		_assetsList = reaperCrew_fireSupport_enemyAssets splitString ",";
		{
			_discoveredAssets = entities _x;
			{
				allArtilleryAssets pushBackUnique _x;
				// Check if there is a detectedMarker variable
				_variableCheck = isNil { _x getVariable "detectedMarker" };
				if (_variableCheck) then {
					_x setVariable ["detectedMarker", ""];
				};
			} forEach _discoveredAssets;
		} forEach _assetsList;

		// Register new assets
		{
			if !(_x in registeredArtilleryAssets) then {
				// Add event handler
				_x addEventHandler ["fired", { [_this select 0] call reaperCrew_fireSupport_fnc_triggerFired; }];
				registeredArtilleryAssets pushBackUnique _x;
				if (reaperCrew_fireSupport_debugAssetDetection == true) then {
					diag_log format ["SCENARIO: Registered artillery asset: %1", _x];
				};
			};
		} forEach allArtilleryAssets;


		// Debug Information
		if (reaperCrew_fireSupport_debugAssetDetection == true) then {
			diag_log format ["SCENARIO: Found the following counter battery systems: %1", counterBatterySystems];
			diag_log format ["SCENARIO: Found the following artillery platforms: %1", allArtilleryAssets];
		}; 

		sleep 180;
	};

};

// // Spawn a long running task to clear up old markers
// [] spawn {
// 	while { true } do {
// 		sleep 60;
// 		// Loop through each map marker
// 		{

// 		} allMapMarkers;

// 	};

// };