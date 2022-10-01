// Create variables
activeInfantryTriggers = [];
activeVehicleTriggers = [];
activeAircraftTriggers = [];
activeMarineTriggers = [];

if (!isServer) exitWith {diag_log "[REINFORCEMENTS]: Server checked failed - skipping reinforcements system"};

// Output debug information
[] spawn {

	// Infantry Spawns
	while { true } do {
		if (reaperCrew_InfantrySpawnCheckbox == true) then {
			diag_log format ["[REINFORCEMENTS]: Found the following active infantry triggers: %1", activeInfantryTriggers];
		};
		sleep 15;
	};

};

[] spawn {

	// Vehicle Spawns
	while { true } do {
		if (reaperCrew_VehicleSpawnCheckbox == true) then {
			diag_log format ["[REINFORCEMENTS]: Found the following active vehicle triggers: %1", activeVehicleTriggers];
		};
		sleep 15;
	};

};

[] spawn {

	// Aircraft Spawns
	while { true } do {
		if (reaperCrew_AircraftSpawnCheckbox == true) then {
			diag_log format ["[REINFORCEMENTS]: Found the following active aircraft triggers: %1", activeAircraftTriggers];
		};
		sleep 15;
	};

};

[] spawn {

	// Aircraft Spawns
	while { true } do {
		if (reaperCrew_MarineSpawnCheckbox == true) then {
			diag_log format ["[REINFORCEMENTS]: Found the following active marine triggers: %1", activeMarineTriggers];
		};
		sleep 15;
	};

};