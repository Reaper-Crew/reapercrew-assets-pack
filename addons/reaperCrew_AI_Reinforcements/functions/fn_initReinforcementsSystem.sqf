// Create variables
activeInfantryTriggers = [];
activeVehicleTriggers = [];
activeAircraftTriggers = [];
activeMarineTriggers = [];

if (!isServer) exitWith {["Server checked failed - skipping reinforcements system"] call reapercrew_common_fnc_remoteLog;};

// Output debug information
[] spawn {

	// Infantry Spawns
	while { true } do {
		if (reaperCrew_InfantrySpawnCheckbox == true) then {
			[(format ["Found the following active infantry triggers: %1", activeInfantryTriggers])] call reapercrew_common_fnc_remoteLog;
		};
		sleep 15;
	};

};

[] spawn {

	// Vehicle Spawns
	while { true } do {
		if (reaperCrew_VehicleSpawnCheckbox == true) then {
			[(format ["Found the following active vehicle triggers: %1", activeVehicleTriggers])] call reapercrew_common_fnc_remoteLog;
		};
		sleep 15;
	};

};

[] spawn {

	// Aircraft Spawns
	while { true } do {
		if (reaperCrew_AircraftSpawnCheckbox == true) then {
			[(format ["Found the following active aircraft triggers: %1", activeAircraftTriggers])] call reapercrew_common_fnc_remoteLog;
		};
		sleep 15;
	};

};

[] spawn {

	// Aircraft Spawns
	while { true } do {
		if (reaperCrew_MarineSpawnCheckbox == true) then {
			[(format ["Found the following active marine triggers: %1", activeMarineTriggers])] call reapercrew_common_fnc_remoteLog;
		};
		sleep 15;
	};

};