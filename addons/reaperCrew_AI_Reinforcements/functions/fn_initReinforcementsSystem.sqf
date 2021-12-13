// Create variables
activeInfantryTriggers = [];
activeVehicleTriggers = [];
activeAircraftTriggers = [];

// Output debug information
[] spawn {

	// Infantry Spawns
	while { true } do {
		if (reaperCrew_InfantrySpawnCheckbox == true) then {
			diag_log format ["SCENARIO: Found the following active infantry triggers: %1", activeInfantryTriggers];
		};
		sleep 15;
	};

};

[] spawn {

	// Vehicle Spawns
	while { true } do {
		if (reaperCrew_VehicleSpawnCheckbox == true) then {
			diag_log format ["SCENARIO: Found the following active vehicle triggers: %1", activeVehicleTriggers];
		};
		sleep 15;
	};

};

[] spawn {

	// Aircraft Spawns
	while { true } do {
		if (reaperCrew_AircraftSpawnCheckbox == true) then {
			diag_log format ["SCENARIO: Found the following active aircraft triggers: %1", activeAircraftTriggers];
		};
		sleep 15;
	};

};