/*
 * Author: Xeenenta
 * This function is run once the trigger for helicopter reinforcements is activated
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call reapercrew_reinforcements_fnc_moduleSpawnReinforcementsAirbourneTrigger
 *
 * Public: No
 */

params ["_triggerObject"];

// Get variables from the trigger
_reinforcementsCount = _triggerObject getVariable ["reinforcementCount",50];
_zoneThreshold = _triggerObject getVariable ["zoneThreshold",20];
_directionMin = _triggerObject getVariable ["directionMin",90];
_directionMax = _triggerObject getVariable ["directionMax",180];
_distanceMin = _triggerObject getVariable ["distanceMin",500];
_distanceMax = _triggerObject getVariable ["distanceMax",800];

// Group selection - this will be eventually replaced
_unitGroup = reaperCrew_reinforcements_units splitString ",";
_unitCount = count _unitGroup;


// Run code only while the trigger is activated
while { triggerActivated _triggerObject } do {

	// Get a count of the number of units within the trigger area
	_allOpforUnits = (allUnits select {side _x == reaperCrew_reinforcements_side});
	_opforUnits = _allOpforUnits inAreaArray _triggerObject;
	_opforCounter = count _opforUnits;

	// Only run if; Zone above threshold, Reinforcements remain and spawn points are available
	if ((_opforCounter < _zoneThreshold) and (_reinforcementsCount > _unitCount) and (reaperCrew_pauseInfantryReinforcements == false) and ((count activeAircraftTriggers) > 0 )) then {

		// Select aircraft & group
		_reinforcementsAircraft = selectRandom (enemyTransportHelicopter);
		_reinforcementsGroup = reaperCrew_reinforcements_units splitString ",";

		// Output debug information if enabled
		if (reaperCrew_ReinforcementsCheckbox == true) then {
			diag_log format ["SCENARIO: Spawning a group of %1 units using helicopter of %2 class - %3 reinforcements remain", count _reinforcementsGroup, _reinforcementsAircraft, _reinforcementsCount];
		};

		// Find landing position
		_distance = [_distanceMin, _distanceMax] call BIS_fnc_randomInt;
		_direction = [_directionMin, _directionMax] call BIS_fnc_randomInt;
		_searchCenterPos = _triggerObject getPos [_distance, _direction];
		_searchRadius = 0;
		_landingPosition = [];
		_spawnTrigger = (selectRandom activeAircraftTriggers);
		
		while { (count _landingPosition) == 0 } do {

			// Increment search criteria
			_searchRadius = _searchRadius + 100;
			_landingPosition = _searchCenterPos findEmptyPosition [0, _searchRadius, _reinforcementsAircraft];

			if (reaperCrew_ReinforcementsCheckbox == true) then {
				diag_log format ["SCENARIO: Searching grid %1 with a radius of %2", (mapGridPosition _searchCenterPos), _searchRadius];
			};

		};

		if (reaperCrew_ReinforcementsCheckbox == true) then {
			diag_log format ["SCENARIO: Search complete, found position of %1", _landingPosition];
		};

		// Call function to spawn
		if (count HeadlessClients > 0) then {
			// If a headless client is available, spawn it with RemoteExec
			_selectedClient = selectRandom HeadlessClients;
			[_landingPosition, getPos _spawnTrigger, _reinforcementsAircraft, _reinforcementsGroup] remoteExec ["reapercrew_reinforcements_fnc_moduleSpawnReinforcementsAirbourneRemote", _selectedClient];
			
			if (reaperCrew_ReinforcementsCheckbox == true) then {
				diag_log format ["SCENARIO: Spawning reinforcements on client %1 at grid %2", name(_selectedClient), (mapGridPosition _spawnTrigger)];
			};
		} else {
			[_landingPosition, getPos _spawnTrigger, _reinforcementsAircraft, _reinforcementsGroup] remoteExec ["reapercrew_reinforcements_fnc_moduleSpawnReinforcementsAirbourneRemote", 2];
			// If no HCs are available, spawn it on the server
			if (reaperCrew_ReinforcementsCheckbox == true) then {
				diag_log format ["SCENARIO: Spawning reinforcements at grid %1", (mapGridPosition _spawnTrigger)];
			};
		};

		// Adjust the number of available reinforcements
		_reinforcementsCount = _reinforcementsCount - _unitCount;
		_triggerObject setVariable ["reinforcementCount",_reinforcementsCount];

	};
	sleep 60;
};
diag_log "SCENARIO: Helicopter spawning has ended";

// 	// Output debug information if enabled
// 	if (reaperCrew_ReinforcementsCheckbox == true) then {
// 		diag_log format ["SCENARIO: Reinforcements logic area is: %1", _logicArea];
// 		diag_log format ["SCENARIO: Reinforcements logic area 2D is: %1", _logicArea2D];
// 		diag_log format ["SCENARIO: Direction minimum is: %1", _directionMin];
// 		diag_log format ["SCENARIO: Direction maximum is: %1", _directionMax];
// 	};

	// Don't do anything while above the zone threshold
	// while {_opforCounter > _zoneThreshold} do {
	// 	// Recount the units
	// 	_allOpforUnits = (allUnits select {side _x == reaperCrew_reinforcements_side});
	// 	_opforUnits = (_allOpforUnits) inAreaArray _logicArea2D;
	// 	_opforCounter = count _opforUnits;
	// 	// Output debug information
	// 	if (reaperCrew_ReinforcementsCheckbox == true) then {
	// 		diag_log format ["SCENARIO: Reinforcements module is active, found %1 enemies within the zone", _opforCounter];
	// 	};
	// 	sleep 30;
	// };

// 	// Start the reinforcements loop
// 	while {_reinforcementsCount > _unitCount} do {
// 		// Recount the units in the zone
// 		_allOpforUnits = (allUnits select {side _x == reaperCrew_reinforcements_side});
// 		_opforUnits = _allOpforUnits inAreaArray _logicArea2D;
// 		_opforCounter = count _opforUnits;

// 		// Output debug information
// 		if (reaperCrew_ReinforcementsCheckbox == true) then {
// 			diag_log format ["SCENARIO: Reinforcements module is active, found %1 enemies within the zone", _opforCounter];
// 		};

// 		if (reaperCrew_pauseInfantryReinforcements == false) then {
// 			// If below the threshold and spawn point available, spawn an enemy group
// 			if (_opforCounter < _zoneThreshold && (count activeAircraftTriggers) > 0 ) then {
// 				// Select a random spawn point
// 				_randomTrigger = (selectRandom activeAircraftTriggers);
// 				_triggerPos = getPos _randomTrigger;


// 				// Reduce the number of available reinforcements
// 				_reinforcementsCount = _reinforcementsCount - _unitCount;
// 				if (reaperCrew_ReinforcementsCheckbox == true) then {
// 					diag_log format ["SCENARIO: Reinforcements created, %1 infantry remain", _reinforcementsCount];
// 				};
// 				sleep 60;
// 			} else {
// 				sleep 60;
// 			};
// 		} else {
// 			diag_log "SCENARIO: Infantry Spawning is currently paused, sleeping for 1 min";
// 			sleep 60;
// 		};
// 	};
// };

true