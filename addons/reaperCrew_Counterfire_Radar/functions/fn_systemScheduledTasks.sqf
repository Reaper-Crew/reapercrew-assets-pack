/*
* Author: Xeenenta
* This function will be launched during the init phase and will run for the duration of the mission to perform some long running repetative functions
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_counterBattery_fnc_systemScheduledTasks
*
* Public: No
*/

// Output debug information
[] spawn {
	while { reaperCrew_fireSupport_ActivateSystem } do {
		// Output list of counter battery systems
		if ( reaperCrew_fireSupport_debugCounterBatteryDetection ) then {
			diag_log format ["[COUNTER BATTERY]: Found the following radar systems: %1", playerCounterBatterySystems];
		};
		// Output a list of detected AI assets
		if ( reaperCrew_fireSupport_debugAIAssetDetection ) then {
			diag_log format ["[COUNTER BATTERY]: Found the following AI assets: %1", AIArtilleryPlatforms];
		};
		sleep 60;
	};
};

// Pickup AI artillery assets
[] spawn {
	// Run while the system is active
	while { reaperCrew_fireSupport_ActivateSystem } do {
		// Wait for global variable

		// Get all entities
		_assetClasses = reaperCrew_fireSupport_enemyAssets splitString ",";
		_assetList = entities [_assetClasses, [], false, true];
		{
			if !(_x in AIArtilleryPlatforms) then {
				// Add event handler
				_x addEventHandler ["fired", {
					[_this select 0] call reapercrew_counterBattery_fnc_eventFired;
				}];
				// Add to registered list
				AIArtilleryPlatforms pushBackUnique _x;
				// Output debug info
				if ( reaperCrew_fireSupport_debugAIAssetDetection ) then {
					diag_log format ["[COUNTER BATTERY]: Registered artillery asset: %1", _x];
				};
			};
		} forEach _assetList;
		sleep 60;
	};
	
};

true;