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
 * [_logic] call reapercrew_reinforcements_fnc_activateInfantryModuleAirbourne
 *
 * Public: No
 */

params ["_triggerObject"];

// Don't run if the array isn't available
while {isNil "activeAircraftTriggers"} do {
	if (reaperCrew_debugReinforcementsSpawning == true) then {
		["Vehicle triggers undefined, sleeping"] call reapercrew_common_fnc_remoteLog;
	};
	sleep 15;
};

// Get variables from the trigger
_reinforcementsCount = _triggerObject getVariable ["reinforcementCount",50];
_zoneThresholdValue = _triggerObject getVariable ["zoneThreshold",20];
_zoneThresholdMode = _triggerObject getVariable ["zoneThresholdMode","THRESHOLD"];
_directionMin = _triggerObject getVariable ["directionMin",90];
_directionMax = _triggerObject getVariable ["directionMax",180];
_distanceMin = _triggerObject getVariable ["distanceMin",500];
_distanceMax = _triggerObject getVariable ["distanceMax",800];
_rushMode = _triggerObject getVariable ["rushMode",false];
_reinforcementGroups = _triggerObject getVariable ["troopArrays", [[],20]];
_codeOnSpawnGroup = _triggerObject getVariable ["codeOnSpawnGroup",""];
_waveDelay = _triggerObject getVariable ["waveDelay",60];
_moduleObject = _triggerObject getVariable ["moduleObject", objnull];
_deliveryMode = _triggerObject getVariable ["deliveryMode", "LAND"];

// Run code only while the trigger is activated
while { triggerActivated _triggerObject } do {

	// Get a count of the number of units within the trigger area
	_allOpforUnits = (allUnits select {side _x == reaperCrew_reinforcements_side});
	_opforUnits = _allOpforUnits inAreaArray _triggerObject;
	_opforCounter = count _opforUnits;

	// Calculate the zone threshold based on the selected mode
	_zoneThreshold = [_zoneThresholdValue, _zoneThresholdMode, _triggerObject] call reapercrew_reinforcements_fnc_getZoneThreshold;

	// Select aircraft & group
	_availableAircraft = reaperCrew_reinforcements_transportHelicopter splitString ",";
	_reinforcementsAircraft = selectRandom (_availableAircraft);
	_reinforcementsGroupSelection = selectRandom _reinforcementGroups;
	_reinforcementsGroup = _reinforcementsGroupSelection select 0;
	_reinforcementsGroupSkill = _reinforcementsGroupSelection select 1;
	_unitCount = count _reinforcementsGroup;

	// Get the available spawnpoints
	_availableSpawnpoints = [_moduleObject, activeAircraftTriggers] call reapercrew_reinforcements_fnc_getAvailableSpawnpoints;

	// Only run if; Zone above threshold, Reinforcements remain and spawn points are available
	if ((_opforCounter < _zoneThreshold) and (_reinforcementsCount > _unitCount) and (reaperCrew_pauseInfantryReinforcements == false) and ((count _availableSpawnpoints) > 0 )) then {

		// Output debug information if enabled
		if (reaperCrew_debugReinforcementsSpawning == true) then {
			[(format ["Spawning a group of %1 units using vehicle of %2 class - %3 reinforcements remain", count _reinforcementsGroup, _reinforcementsAircraft, _reinforcementsCount])] call reapercrew_common_fnc_remoteLog;
		};

		// Find landing position
		_distance = [_distanceMin, _distanceMax] call BIS_fnc_randomInt;
		_direction = [_directionMin, _directionMax] call BIS_fnc_randomInt;
		_searchCenterPos = _triggerObject getPos [_distance, _direction];
		_searchRadius = 0;
		_landingPosition = [];
		_spawnTrigger = (selectRandom _availableSpawnpoints);
		
		while { (count _landingPosition) == 0 } do {

			// Increment search criteria
			_searchRadius = _searchRadius + 100;
			private _candidatePos = _searchCenterPos findEmptyPosition [0, _searchRadius, _reinforcementsAircraft];

			if (reaperCrew_debugWaypointMechanics == true) then {
				[(format ["Searching grid %1 with a radius of %2", (mapGridPosition _searchCenterPos), _searchRadius])] call reapercrew_common_fnc_remoteLog;
			};

			if (count _candidatePos > 0) then {
				// Reject positions with obstacles that could damage the helicopter on approach or landing
				private _obstacles = nearestTerrainObjects [_candidatePos, ["TREE", "BUILDING", "ROCK", "ROCKS", "FENCE", "WALL"], 25];
				if (count _obstacles == 0) then {
					_landingPosition = _candidatePos;
				};
			};

			// Fallback after 500m — accept any position to avoid infinite search
			if (_searchRadius > 500 && count _landingPosition == 0) then {
				if (count _candidatePos > 0) then {
					_landingPosition = _candidatePos;
				} else {
					_landingPosition = +_searchCenterPos;
				};
				if (reaperCrew_debugWaypointMechanics == true) then {
					["Search radius exceeded, using best available position"] call reapercrew_common_fnc_remoteLog;
				};
			};
		};

		_reinforcementsPathway = _spawnTrigger getVariable ["_reinforcementsPathway", []];

		[[_landingPosition, getPos _spawnTrigger, _reinforcementsAircraft, _reinforcementsGroup, _reinforcementsGroupSkill, _codeOnSpawnGroup, _reinforcementsPathway, _deliveryMode, _rushMode], "reapercrew_reinforcements_fnc_spawnHeadlessInfantryAirbourne"] call reapercrew_common_fnc_executeDistributed;

		// Adjust the number of available reinforcements
		_reinforcementsCount = _reinforcementsCount - _unitCount;
		_triggerObject setVariable ["reinforcementCount",_reinforcementsCount];

	};
	sleep _waveDelay;
};
if (reaperCrew_debugReinforcementsSpawning == true) then {
	["Helicopter spawning has ended"] call reapercrew_common_fnc_remoteLog;
};