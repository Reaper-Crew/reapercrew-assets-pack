/*
 * Author: Xeenenta
 * This function is run once the trigger for vehicle reinforcements is activated
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call reapercrew_reinforcements_fnc_activateInfantryModuleMotorised
 *
 * Public: No
 */

params ["_triggerObject"];

["REINFORCEMENTS", "activateInfantryModuleMotorised", "Function activated"] call reapercrew_common_fnc_remoteLog;

// Don't run if the array isn't available
while {isNil "activeVehicleTriggers"} do {
	if (reaperCrew_debugReinforcementsSpawning == true) then {
		["REINFORCEMENTS", "activateInfantryModuleMotorised", "Vehicle triggers undefined, sleeping"] call reapercrew_common_fnc_remoteLog;
	};
	sleep 15;
};

[_triggerObject] spawn {
	params ["_triggerObject"];

	// Get variables from the trigger
	_reinforcementsCount = _triggerObject getVariable ["reinforcementCount",50];
	_zoneThreshold = _triggerObject getVariable ["zoneThreshold",20];
	_directionMin = _triggerObject getVariable ["directionMin",90];
	_directionMax = _triggerObject getVariable ["directionMax",180];
	_distanceMin = _triggerObject getVariable ["distanceMin",500];
	_distanceMax = _triggerObject getVariable ["distanceMax",800];
	_rushMode = _triggerObject getVariable ["rushMode",false];
	_reinforcementGroups = _triggerObject getVariable ["troopArrays", [[],20]];
	_codeOnSpawnGroup = _triggerObject getVariable ["codeOnSpawnGroup",""];
	_waveDelay = _triggerObject getVariable ["waveDelay",60];

	// Run code only while the trigger is activated
	while { triggerActivated _triggerObject } do {

		// Get a count of the number of units within the trigger area
		_allOpforUnits = (allUnits select {side _x == reaperCrew_reinforcements_side});
		_opforUnits = _allOpforUnits inAreaArray _triggerObject;
		_opforCounter = count _opforUnits;

		// Select Vehicle & group
		_availableVehicle = reaperCrew_reinforcements_transportGround splitString ",";
		_reinforcementsVehicle = selectRandom (_availableVehicle);
		_reinforcementsGroupSelection = selectRandom _reinforcementGroups;

		_reinforcementsGroup = _reinforcementsGroupSelection select 0;
		_reinforcementsGroupSkill = _reinforcementsGroupSelection select 1;
		
		_unitCount = count _reinforcementsGroup;

		// Only run if; Zone above threshold, Reinforcements remain and spawn points are available
		if ((_opforCounter < _zoneThreshold) and (_reinforcementsCount > _unitCount) and (reaperCrew_pauseInfantryReinforcements == false) and ((count activeVehicleTriggers) > 0 )) then {

			// Output debug information if enabled
			if (reaperCrew_debugReinforcementsSpawning == true) then {
				["REINFORCEMENTS", "activateInfantryModuleMotorised", (format ["Spawning a group of %1 units using vehicle of %2 class - %3 reinforcements remain", count _reinforcementsGroup, _reinforcementsVehicle, _reinforcementsCount])] call reapercrew_common_fnc_remoteLog;
			};

			// Find landing position
			_distance = [_distanceMin, _distanceMax] call BIS_fnc_randomInt;
			_direction = [_directionMin, _directionMax] call BIS_fnc_randomInt;
			_searchCenterPos = _triggerObject getPos [_distance, _direction];
			_searchRadius = 0;
			_landingPosition = [];
			_spawnTrigger = (selectRandom activeVehicleTriggers);

			while { (count _landingPosition) == 0 } do {

				// Increment search criteria
				_searchRadius = _searchRadius + 100;
				_landingPosition = _searchCenterPos findEmptyPosition [0, _searchRadius, _reinforcementsVehicle];

				if (reaperCrew_debugWaypointMechanics == true) then {
					["REINFORCEMENTS", "activateInfantryModuleMotorised", (format ["Searching grid %1 with a radius of %2", (mapGridPosition _searchCenterPos), _searchRadius])] call reapercrew_common_fnc_remoteLog;
				};

				if (_searchRadius > 200) then {
					_landingPosition pushBack _searchCenterPos;
					if (reaperCrew_debugWaypointMechanics == true) then {
						["REINFORCEMENTS", "activateInfantryModuleMotorised", "Search radius exceeded, defaulting to center point"] call reapercrew_common_fnc_remoteLog;
					};
				};

			};

			if (reaperCrew_debugWaypointMechanics == true) then {
				["REINFORCEMENTS", "activateInfantryModuleMotorised", (format ["Search complete, found position of %1", _landingPosition])] call reapercrew_common_fnc_remoteLog;
			};

			_reinforcementsPathway = _spawnTrigger getVariable ["_reinforcementsPathway", []];

			[[_landingPosition, getPos _spawnTrigger, _reinforcementsVehicle, _reinforcementsGroup, _reinforcementsGroupSkill, _codeOnSpawnGroup, _reinforcementsPathway], "reapercrew_reinforcements_fnc_spawnHeadlessInfantryVehicle"] call reapercrew_common_fnc_executeDistributed;

			// Adjust the number of available reinforcements
			_reinforcementsCount = _reinforcementsCount - _unitCount;
			_triggerObject setVariable ["reinforcementCount",_reinforcementsCount];

		};
		sleep _waveDelay;
	};
	if (reaperCrew_debugReinforcementsSpawning == true) then {
		["REINFORCEMENTS", "activateInfantryModuleMotorised", "Vehicle spawning has ended"] call reapercrew_common_fnc_remoteLog;
	};
};