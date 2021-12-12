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
_rushMode = _triggerObject getVariable ["rushMode",false];
_reinforcementGroups = _triggerObject getVariable ["troopArrays", [[],20]];

// Run code only while the trigger is activated
while { triggerActivated _triggerObject } do {

	// Get a count of the number of units within the trigger area
	_allOpforUnits = (allUnits select {side _x == reaperCrew_reinforcements_side});
	_opforUnits = _allOpforUnits inAreaArray _triggerObject;
	_opforCounter = count _opforUnits;

	// Select aircraft & group
	_availableAircraft = reaperCrew_reinforcements_transportHelicopter splitString ",";
	_reinforcementsAircraft = selectRandom (_availableAircraft);
	_reinforcementsGroupSelection = selectRandom _reinforcementGroups;
	_reinforcementsGroup = _reinforcementsGroupSelection select 0;
	_reinforcementsGroupSkill = _reinforcementsGroupSelection select 1;
	_unitCount = count _reinforcementsGroup;

	// Only run if; Zone above threshold, Reinforcements remain and spawn points are available
	if ((_opforCounter < _zoneThreshold) and (_reinforcementsCount > _unitCount) and (reaperCrew_pauseInfantryReinforcements == false) and ((count activeAircraftTriggers) > 0 )) then {

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

		[[_landingPosition, getPos _spawnTrigger, _reinforcementsAircraft, _reinforcementsGroup, _reinforcementsGroupSkill], "reapercrew_reinforcements_fnc_spawnHeadlessInfantryAirbourne"] call reapercrew_common_fnc_executeDistributed;

		// Adjust the number of available reinforcements
		_reinforcementsCount = _reinforcementsCount - _unitCount;
		_triggerObject setVariable ["reinforcementCount",_reinforcementsCount];

	};
	sleep 60;
};
diag_log "SCENARIO: Helicopter spawning has ended";