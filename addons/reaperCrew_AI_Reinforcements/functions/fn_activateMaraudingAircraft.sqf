/*
 * Author: Xeenenta
 * Activation loop for marauding aircraft. Spawns aircraft with SAD waypoints at available spawnpoints.
 *
 * Arguments:
 * 0: _triggerObject <OBJECT> - Trigger object containing aircraft spawn settings
 *
 * Return Value:
 * None
 *
 * Example:
 * [trigger] call reapercrew_reinforcements_fnc_activateMaraudingAircraft
 *
 * Public: No
 */

params ["_triggerObject"];

[_triggerObject] spawn {
	params ["_triggerObject"];

	// Get Variables
	_AircraftCount = _triggerObject getVariable ["AircraftCount",50];
	_AircraftFrequencyMin = _triggerObject getVariable ["AircraftFrequencyMin",180];
	_AircraftFrequencyMax = _triggerObject getVariable ["AircraftFrequencyMax",240];
	_AircraftsArray = _triggerObject getVariable ["AircraftsArray",[]];
	_moduleObject = _triggerObject getVariable ["moduleObject", objNull];

	// Do for as long as trigger is active
	while { triggerActivated _triggerObject } do {

		// Get the available spawnpoints
		_availableSpawnpoints = [_moduleObject, activeAircraftTriggers] call reapercrew_reinforcements_fnc_getAvailableSpawnpoints;

		// If the number of alive Aircrafts is lower than the number of concurrent Aircrafts
		if ( ((count _availableSpawnpoints) > 0) && (!reaperCrew_pauseAircraftReinforcements) && (_AircraftCount > 0) ) then {

			// Output debug information
			[(format ["Marauding Aircrafts are active, %1 remain", _AircraftCount])] call reapercrew_common_fnc_remoteLog;

			_randomSpawn = (selectRandom _availableSpawnpoints);

			// Get nearest player position
			_playersInTrigger = (allPlayers inAreaArray _triggerObject);
			_nearestPlayer=([_playersInTrigger,[],{_randomSpawn distance _x},"ASCEND"]call BIS_fnc_sortBy) select 0; 

			if ((count _playersInTrigger) == 0) exitWith {
				["No players within the trigger zone"] call reapercrew_common_fnc_remoteLog;
			};

			[[getPos _randomSpawn, (selectRandom _AircraftsArray), 50, getPos _nearestPlayer], "reapercrew_reinforcements_fnc_spawnHeadlessVehicle"] call reapercrew_common_fnc_executeDistributed;

			_AircraftCount = _AircraftCount - 1;
			_triggerObject setVariable ["AircraftCount",_AircraftCount];

		} else {
			["Module alive but conditions not met"] call reapercrew_common_fnc_remoteLog;
		};
		_sleepTimer = [_AircraftFrequencyMin,_AircraftFrequencyMax] call BIS_fnc_randomInt;
		sleep _sleepTimer;
		// sleep 20;
	};

};



