params ["_triggerObject"];

diag_log "fn_activateMaraudingVehicles activated";
diag_log (allVariables _triggerObject);
diag_log (_triggerObject getVariable ["vehiclesArray",[]]);


[_triggerObject] spawn {
	params ["_triggerObject"];

	// Get Variables
	_vehicleCount = _triggerObject getVariable ["vehicleCount",50];
	_vehicleFrequencyMin = _triggerObject getVariable ["vehicleFrequencyMin",180];
	_vehicleFrequencyMax = _triggerObject getVariable ["vehicleFrequencyMax",240];
	_concurrentVehicles = _triggerObject getVariable ["concurrentVehicles",2];
	_vehiclesArray = _triggerObject getVariable ["vehiclesArray",[]];

	// Do for as long as trigger is active
	while { triggerActivated _triggerObject } do {

		// If the number of alive vehicles is lower than the number of concurrent vehicles
		if ( ((count activeVehicleTriggers) > 0) && (reaperCrew_pauseVehicleReinforcements == false) && (_vehicleCount > 0) ) then {
			diag_log "THE IF CONDITION WORKS";

			// Output debug information
			if (reaperCrew_ReinforcementsCheckbox == true) then {
				diag_log format ["[REINFORCEMENTS]: Marauding vehicles are active, %1 remain", _vehicleCount];
			};

			_randomSpawn = (selectRandom activeVehicleTriggers);
			[[getPos _randomSpawn, (selectRandom _vehiclesArray), 50, getPos _triggerObject], "reapercrew_reinforcements_fnc_spawnHeadlessVehicle"] call reapercrew_common_fnc_executeDistributed;

			_vehicleCount = _vehicleCount - 1;
			_triggerObject setVariable ["vehicleCount",_vehicleCount];

		} else {
			if (reaperCrew_ReinforcementsCheckbox == true) then {
				diag_log "[REINFORCEMENTS]: Module alive but conditions not met";
			};
		};
		_sleepTimer = [_vehicleFrequencyMin,_vehicleFrequencyMax] call BIS_fnc_randomInt;
		sleep _sleepTimer;
		// sleep 20;
	};

};



