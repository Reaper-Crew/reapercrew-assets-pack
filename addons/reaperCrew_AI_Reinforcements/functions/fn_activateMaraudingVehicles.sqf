params ["_triggerObject"];

[_triggerObject] spawn {
	params ["_triggerObject"];

	// Get Variables
	_vehicleCount = _triggerObject getVariable ["vehicleCount",50];
	_vehicleFrequencyMin = _triggerObject getVariable ["vehicleFrequencyMin",180];
	_vehicleFrequencyMax = _triggerObject getVariable ["vehicleFrequencyMax",240];
	_concurrentVehicles = _triggerObject getVariable ["concurrentVehicles",2];
	_vehiclesArray = _triggerObject getVariable ["vehiclesArray",[]];
	_moduleObject = _triggerObject getVariable ["moduleObject", objnull];

	// Do for as long as trigger is active
	while { triggerActivated _triggerObject } do {

		// Get the available spawnpoints
		_availableSpawnpoints = [_moduleObject, activeVehicleTriggers] call reapercrew_reinforcements_fnc_getAvailableSpawnpoints;

		// If the number of alive vehicles is lower than the number of concurrent vehicles
		if ( ((count _availableSpawnpoints) > 0) && (reaperCrew_pauseVehicleReinforcements == false) && (_vehicleCount > 0) ) then {

			// Output debug information
			if (reaperCrew_ReinforcementsCheckbox == true) then {
				[(format ["Marauding vehicles are active, %1 remain", _vehicleCount])] call reapercrew_common_fnc_remoteLog;
			};

			_randomSpawn = (selectRandom _availableSpawnpoints);

			// Get nearest player position
			_playersInTrigger = (allPlayers inAreaArray _triggerObject);
			_nearestPlayer=([_playersInTrigger,[],{_randomSpawn distance _x},"ASCEND"]call BIS_fnc_sortBy) select 0; 

			if ((count _playersInTrigger) == 0) exitWith {
				["No players within the trigger zone"] call reapercrew_common_fnc_remoteLog;
			};


			[[getPos _randomSpawn, (selectRandom _vehiclesArray), 50, getPos _nearestPlayer], "reapercrew_reinforcements_fnc_spawnHeadlessVehicle"] call reapercrew_common_fnc_executeDistributed;

			_vehicleCount = _vehicleCount - 1;
			_triggerObject setVariable ["vehicleCount",_vehicleCount];

		} else {
			if (reaperCrew_ReinforcementsCheckbox == true) then {
				["Module alive but conditions not met"] call reapercrew_common_fnc_remoteLog;
			};
		};
		_sleepTimer = [_vehicleFrequencyMin,_vehicleFrequencyMax] call BIS_fnc_randomInt;
		sleep _sleepTimer;
		// sleep 20;
	};

};



