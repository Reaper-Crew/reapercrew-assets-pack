/*
 * Author: Xeenenta
 * This function is run once the trigger for marine reinforcements is activated
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call reapercrew_reinforcements_fnc_activateInfantryModuleMarine
 *
 * Public: No
 */

params ["_triggerObject"];

// Don't run if the array isn't available
while {isNil "activeMarineTriggers"} do {
	if (reaperCrew_MarineSpawnCheckbox == true) then {
		["Marine triggers undefined, sleeping"] call reapercrew_common_fnc_remoteLog;
	};
	sleep 15;
};

[_triggerObject] spawn {
	params ["_triggerObject"];

	// Get variables from the trigger
	_reinforcementsCount = _triggerObject getVariable ["reinforcementCount",50];
	_zoneThreshold = _triggerObject getVariable ["zoneThreshold",20];
	_rushMode = _triggerObject getVariable ["rushMode",false];
	_reinforcementGroups = _triggerObject getVariable ["troopArrays", [[],20]];
	_codeOnSpawnGroup = _triggerObject getVariable ["codeOnSpawnGroup",""];
	_waveDelay = _triggerObject getVariable ["waveDelay",60];
	_moduleObject = _triggerObject getVariable ["moduleObject", objnull];

	// Run code only while the trigger is activated
	while { triggerActivated _triggerObject } do {

		// Get a count of the number of units within the trigger area
		_allOpforUnits = (allUnits select {side _x == reaperCrew_reinforcements_side});
		_opforUnits = _allOpforUnits inAreaArray _triggerObject;
		_opforCounter = count _opforUnits;

		// Select Marine & group
		_availableMarine = reaperCrew_reinforcements_transportBoat splitString ",";
		_reinforcementsMarine = selectRandom (_availableMarine);
		_reinforcementsGroupSelection = selectRandom _reinforcementGroups;

		_reinforcementsGroup = _reinforcementsGroupSelection select 0;
		_reinforcementsGroupSkill = _reinforcementsGroupSelection select 1;
		
		_unitCount = count _reinforcementsGroup;

		_boatLZ = objNull;

		// Get the available spawnpoints
		_availableSpawnpoints = [_moduleObject, activeMarineTriggers] call reapercrew_reinforcements_fnc_getAvailableSpawnpoints;

		// Only run if; Zone above threshold, Reinforcements remain and spawn points are available
		if ((_opforCounter < _zoneThreshold) and (_reinforcementsCount > _unitCount) and (reaperCrew_pauseInfantryReinforcements == false) and ((count _availableSpawnpoints) > 0 )) then {

			// Output debug information if enabled
			if (reaperCrew_ReinforcementsCheckbox == true) then {
				[(format ["Spawning a group of %1 units using Marine of %2 class - %3 reinforcements remain", count _reinforcementsGroup, _reinforcementsMarine, _reinforcementsCount])] call reapercrew_common_fnc_remoteLog;
			};

			// Select a random spawnpoint
			_boatSpawnpoint = (selectRandom _availableSpawnpoints);
			_availableLZs = _boatSpawnpoint getVariable ["connectedLZs",[]];

			if (count _availableLZs > 0) then {
				[(format ["Chosen Spawnpoint has no %1 LZs", (count _availableLZs)])] call reapercrew_common_fnc_remoteLog;
				_boatLZ = (selectRandom _availableLZs);
				[[_boatLZ, getPos _boatSpawnpoint, _reinforcementsMarine, _reinforcementsGroup, _reinforcementsGroupSkill, _codeOnSpawnGroup], "reapercrew_reinforcements_fnc_spawnHeadlessInfantryVehicle"] call reapercrew_common_fnc_executeDistributed;
				// Adjust the number of available reinforcements
				_reinforcementsCount = _reinforcementsCount - _unitCount;
				_triggerObject setVariable ["reinforcementCount",_reinforcementsCount];
			} else {
				["Chosen Spawnpoint has no associated LZ."] call reapercrew_common_fnc_remoteLog;
			};

		};
		sleep _waveDelay;
	};
	["Marine spawning has ended"] call reapercrew_common_fnc_remoteLog;
};