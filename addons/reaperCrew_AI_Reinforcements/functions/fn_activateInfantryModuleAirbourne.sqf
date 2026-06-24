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
	["Aircraft triggers undefined, sleeping"] call reapercrew_common_fnc_remoteLog;
	sleep 15;
};

// Get variables from the trigger
_reinforcementsCount = _triggerObject getVariable ["reinforcementCount",50];
_zoneCeiling = _triggerObject getVariable ["zoneCeiling",80];
_zoneRatio = _triggerObject getVariable ["zoneRatio",3];
_zoneLimitMode = _triggerObject getVariable ["zoneLimitMode","CEILING"];
_directionMin = _triggerObject getVariable ["directionMin",90];
_directionMax = _triggerObject getVariable ["directionMax",180];
_distanceMin = _triggerObject getVariable ["distanceMin",500];
_distanceMax = _triggerObject getVariable ["distanceMax",800];
_rushMode = _triggerObject getVariable ["rushMode",false];
_reinforcementGroups = _triggerObject getVariable ["troopArrays", [[],20]];
_codeOnSpawnGroup = _triggerObject getVariable ["codeOnSpawnGroup",""];
_waveDelay = _triggerObject getVariable ["waveDelay",60];
_moduleObject = _triggerObject getVariable ["moduleObject", objNull];
_deliveryMode = _triggerObject getVariable ["deliveryMode", "LAND"];

// Run code only while the trigger is activated
while { triggerActivated _triggerObject } do {

	// Count all humanoid units in the zone (players, civilians and enemies) so the ceiling caps total load
	_opforCounter = [_triggerObject, _moduleObject] call reapercrew_reinforcements_fnc_getZoneUnitCount;

	// Calculate the effective zone ceiling based on the selected mode
	_effectiveCeiling = [_zoneCeiling, _zoneRatio, _zoneLimitMode, _triggerObject] call reapercrew_reinforcements_fnc_getZoneCeiling;

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
	if ((_opforCounter < _effectiveCeiling) and (_reinforcementsCount > _unitCount) and (!reaperCrew_pauseInfantryReinforcements) and ((count _availableSpawnpoints) > 0 )) then {

		// Output debug information if enabled
		[(format ["Spawning a group of %1 units using vehicle of %2 class - %3 reinforcements remain", count _reinforcementsGroup, _reinforcementsAircraft, _reinforcementsCount])] call reapercrew_common_fnc_remoteLog;

		// Find landing position
		_distance = [_distanceMin, _distanceMax] call BIS_fnc_randomInt;
		_direction = [_directionMin, _directionMax] call BIS_fnc_randomInt;
		_searchCenterPos = _triggerObject getPos [_distance, _direction];
		_searchRadius = 0;
		_landingPosition = [];
		_spawnTrigger = (selectRandom _availableSpawnpoints);
		
		while { _landingPosition isEqualTo [] } do {
			sleep 0.1; // Yield each iteration to avoid blocking the scheduler

			// Increment search criteria
			_searchRadius = _searchRadius + 100;
			private _candidatePos = _searchCenterPos findEmptyPosition [0, _searchRadius, _reinforcementsAircraft];

			[(format ["Searching grid %1 with a radius of %2", (mapGridPosition _searchCenterPos), _searchRadius])] call reapercrew_common_fnc_remoteLog;

			if (count _candidatePos > 0) then {
				// Reject positions with obstacles that could damage the helicopter on approach or landing
				private _obstacles = nearestTerrainObjects [_candidatePos, ["TREE", "BUILDING", "ROCK", "ROCKS", "FENCE", "WALL"], 25];
				if (_obstacles isEqualTo []) then {
					_landingPosition = _candidatePos;
				};
			};

			// Fallback after 500m - accept any position to avoid infinite search
			if (_searchRadius > 500 && count _landingPosition == 0) then {
				if (count _candidatePos > 0) then {
					_landingPosition = _candidatePos;
				} else {
					_landingPosition = +_searchCenterPos;
				};
				["Search radius exceeded, using best available position"] call reapercrew_common_fnc_remoteLog;
			};
		};

		_reinforcementsPathway = _spawnTrigger getVariable ["_reinforcementsPathway", []];

		private _resolvedDeliveryMode = _deliveryMode;
		if (_deliveryMode == "RANDOM") then {
			_resolvedDeliveryMode = selectRandom ["LAND", "FASTROPE"];
		};

		[[_landingPosition, getPos _spawnTrigger, _reinforcementsAircraft, _reinforcementsGroup, _reinforcementsGroupSkill, _codeOnSpawnGroup, _reinforcementsPathway, _resolvedDeliveryMode, _rushMode, _moduleObject], "reapercrew_reinforcements_fnc_spawnHeadlessInfantryAirbourne"] call reapercrew_common_fnc_executeDistributed;

		// Adjust the number of available reinforcements
		_reinforcementsCount = _reinforcementsCount - _unitCount;
		_triggerObject setVariable ["reinforcementCount",_reinforcementsCount];

	};
	sleep _waveDelay;
};
["Helicopter spawning has ended"] call reapercrew_common_fnc_remoteLog;
