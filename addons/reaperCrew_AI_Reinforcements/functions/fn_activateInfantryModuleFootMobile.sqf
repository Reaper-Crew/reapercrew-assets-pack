/*
 * Author: Xeenenta
 * Activation loop for foot mobile reinforcements. While the trigger is active, spawns
 * infantry groups at available spawnpoints when the zone is below its threshold.
 *
 * Arguments:
 * 0: Trigger Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [thisTrigger] spawn reapercrew_reinforcements_fnc_activateInfantryModuleFootMobile
 *
 * Public: No
 */

params ["_triggerObject"];

// Wait for the spawnpoint system to initialise
while {isNil "activeInfantryTriggers"} do {
	if (reaperCrew_InfantrySpawnCheckbox) then {
		["Infantry triggers undefined, sleeping"] call reapercrew_common_fnc_remoteLog;
	};
	sleep 15;
};

[_triggerObject] spawn {
	params ["_triggerObject"];

	// Get variables from the trigger
	_reinforcementsCount = _triggerObject getVariable ["reinforcementCount",50];
	_zoneCeiling = _triggerObject getVariable ["zoneCeiling",80];
	_zoneRatio = _triggerObject getVariable ["zoneRatio",3];
	_zoneLimitMode = _triggerObject getVariable ["zoneLimitMode","CEILING"];
	_reinforcementGroups = _triggerObject getVariable ["troopArrays", [[],20]];
	_rushMode = _triggerObject getVariable ["rushMode",false];
	_codeOnSpawnGroup = _triggerObject getVariable ["codeOnSpawnGroup",""];
	_waveDelay = _triggerObject getVariable ["waveDelay",60];
	_moduleObject = _triggerObject getVariable ["moduleObject", objNull];

	while { triggerActivated _triggerObject } do {

		// Count enemy units in the zone
		_opforCount = count ((allUnits select {side _x == reaperCrew_reinforcements_side}) inAreaArray _triggerObject);

		// Calculate the effective zone ceiling based on the selected mode
		_effectiveCeiling = [_zoneCeiling, _zoneRatio, _zoneLimitMode, _triggerObject] call reapercrew_reinforcements_fnc_getZoneCeiling;

		if (reaperCrew_ReinforcementsCheckbox) then {
			[(format ["Reinforcements module is active, found %1 enemies within the zone", _opforCount])] call reapercrew_common_fnc_remoteLog;
			[(format ["Available squad choices: %1", _reinforcementGroups])] call reapercrew_common_fnc_remoteLog;
		};

		// Select a random squad from the troop arrays
		_randomSquad = selectRandom _reinforcementGroups;
		_squadArray = _randomSquad select 0;
		_squadSkill = _randomSquad select 1;
		_squadCount = count _squadArray;

		// Get spawnpoints that are currently available (not on cooldown)
		_availableSpawnpoints = [_moduleObject, activeInfantryTriggers] call reapercrew_reinforcements_fnc_getAvailableSpawnpoints;

		// Only spawn if zone is below threshold, reinforcements remain, and spawnpoints exist
		if ((_opforCount < _effectiveCeiling) and (_reinforcementsCount > _squadCount) and (!reaperCrew_pauseInfantryReinforcements) and ((count _availableSpawnpoints) > 0)) then {

			_randomSpawn = selectRandom _availableSpawnpoints;

			[[getPos _randomSpawn, _squadArray, _squadSkill, _rushMode, _codeOnSpawnGroup], "reapercrew_reinforcements_fnc_spawnHeadlessInfantry"] call reapercrew_common_fnc_executeDistributed;

			_reinforcementsCount = _reinforcementsCount - _squadCount;
			_triggerObject setVariable ["reinforcementCount", _reinforcementsCount];

			if (reaperCrew_ReinforcementsCheckbox) then {
				[(format ["Reinforcements created, %1 infantry remain", _reinforcementsCount])] call reapercrew_common_fnc_remoteLog;
			};
		};

		sleep _waveDelay;
	};
};
