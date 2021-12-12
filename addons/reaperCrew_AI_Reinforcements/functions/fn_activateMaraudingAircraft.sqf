params ["_triggerObject"];

diag_log "fn_activateMaraudingAircrafts activated";
diag_log (allVariables _triggerObject);
diag_log (_triggerObject getVariable ["AircraftsArray",[]]);


[_triggerObject] spawn {
	params ["_triggerObject"];

	// Get Variables
	_AircraftCount = _triggerObject getVariable ["AircraftCount",50];
	_AircraftFrequencyMin = _triggerObject getVariable ["AircraftFrequencyMin",180];
	_AircraftFrequencyMax = _triggerObject getVariable ["AircraftFrequencyMax",240];
	_AircraftsArray = _triggerObject getVariable ["AircraftsArray",[]];

	// Do for as long as trigger is active
	while { triggerActivated _triggerObject } do {

		// If the number of alive Aircrafts is lower than the number of concurrent Aircrafts
		if ( ((count activeAircraftTriggers) > 0) && (reaperCrew_pauseAircraftReinforcements == false) && (_AircraftCount > 0) ) then {
			diag_log "THE IF CONDITION WORKS";

			// Output debug information
			if (reaperCrew_ReinforcementsCheckbox == true) then {
				diag_log format ["SCENARIO: Marauding Aircrafts are active, %1 remain", _AircraftCount];
			};

			_randomSpawn = (selectRandom activeAircraftTriggers);
			[[getPos _randomSpawn, (selectRandom _AircraftsArray), 50, getPos _triggerObject], "reapercrew_reinforcements_fnc_spawnHeadlessVehicle"] call reapercrew_common_fnc_executeDistributed;

			_AircraftCount = _AircraftCount - 1;
			_triggerObject setVariable ["AircraftCount",_AircraftCount];

		} else {
			if (reaperCrew_ReinforcementsCheckbox == true) then {
				diag_log "SCENARIO: Module alive but conditions not met";
			};
		};
		_sleepTimer = [_AircraftFrequencyMin,_AircraftFrequencyMax] call BIS_fnc_randomInt;
		sleep _sleepTimer;
		// sleep 20;
	};

};



