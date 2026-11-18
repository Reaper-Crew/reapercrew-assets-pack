/*
 * Author: Xeenenta
 * Activation loop for marauding vehicles. Spawns vehicles with SAD waypoints at available spawnpoints.
 *
 * Arguments:
 * 0: _triggerObject <OBJECT> - Trigger object containing vehicle spawn settings
 *
 * Return Value:
 * None
 *
 * Example:
 * [trigger] call reapercrew_reinforcements_fnc_activateMaraudingVehicles
 *
 * Public: No
 */

params ["_triggerObject"];

[_triggerObject] spawn {
	params ["_triggerObject"];

	// Get Variables
	_concurrentVehicles = _triggerObject getVariable ["concurrentVehicles",2];
	_vehiclesArray = _triggerObject getVariable ["vehiclesArray",[]];
	_moduleObject = _triggerObject getVariable ["moduleObject", objNull];

	// Do for as long as trigger is active
	while { triggerActivated _triggerObject } do {

		// Read each pass so values set on the trigger mid-loop are picked up
		_vehicleCount = _triggerObject getVariable ["vehicleCount",50];
		_vehicleFrequencyMin = _triggerObject getVariable ["vehicleFrequencyMin",180];
		_vehicleFrequencyMax = _triggerObject getVariable ["vehicleFrequencyMax",240];

		// Get the available spawnpoints
		_availableSpawnpoints = [_moduleObject, activeVehicleTriggers] call reapercrew_reinforcements_fnc_getAvailableSpawnpoints;

		// If the number of alive vehicles is lower than the number of concurrent vehicles
		if ( ((count _availableSpawnpoints) > 0) && (!reaperCrew_pauseVehicleReinforcements) && (_vehicleCount > 0) ) then {

			// Output debug information
			[(format ["Marauding vehicles are active, %1 remain", _vehicleCount])] call reapercrew_common_fnc_remoteLog;

			_randomSpawn = (selectRandom _availableSpawnpoints);

			// Get nearest player position
			_playersInTrigger = (allPlayers inAreaArray _triggerObject);
			_nearestPlayer=([_playersInTrigger,[],{_randomSpawn distance _x},"ASCEND"]call BIS_fnc_sortBy) select 0; 

			if ((count _playersInTrigger) == 0) exitWith {
				["No players within the trigger zone"] call reapercrew_common_fnc_remoteLog;
			};


			[[getPos _randomSpawn, (selectRandom _vehiclesArray), 50, getPos _nearestPlayer], "reapercrew_reinforcements_fnc_spawnHeadlessVehicle"] call reapercrew_common_fnc_executeDistributed;

			_triggerObject setVariable ["vehicleCount", ((_triggerObject getVariable ["vehicleCount", 0]) - 1) max 0];

		} else {
			["Module alive but conditions not met"] call reapercrew_common_fnc_remoteLog;
		};
		_sleepTimer = [_vehicleFrequencyMin,_vehicleFrequencyMax] call BIS_fnc_randomInt;
		sleep _sleepTimer;
		// sleep 20;
	};

};



