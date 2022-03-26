params ["_triggerObject"];

// Don't run if the array isn't available
while {isNil "activeInfantryTriggers"} do {
	if (reaperCrew_InfantrySpawnCheckbox == true) then {
		diag_log "[REINFORCEMENTS]: Infantry triggers undefined, sleeping";
	};
	sleep 15;
};

[_triggerObject] spawn {
	params ["_triggerObject"];

	// Get Variables
	_reinforcementsCount = _triggerObject getVariable ["reinforcementCount",50];
	_zoneThreshold = _triggerObject getVariable ["zoneThreshold",20];
	_reinforcementGroups = _triggerObject getVariable ["troopArrays", [[],20]];
	_rushMode = _triggerObject getVariable ["rushMode",false];
	_codeOnSpawnGroup = _triggerObject getVariable ["codeOnSpawnGroup",""];
	_waveDelay = _triggerObject getVariable ["waveDelay",60];

	// Do for as long as trigger is active
	while { triggerActivated _triggerObject } do {

		// Get a count of the number of units in the area
		_opforCount = count ((allUnits select {side _x == reaperCrew_reinforcements_side}) inAreaArray _triggerObject);

		// Output debug information
		if (reaperCrew_ReinforcementsCheckbox == true) then {
			diag_log format ["[REINFORCEMENTS]: Reinforcements module is active, found %1 enemies within the zone", _opforCount];
			diag_log format ["[REINFORCEMENTS]: Available squad choices: %1", _reinforcementGroups];
		};

		// Select a random squad
		_randomSquad = selectRandom _reinforcementGroups;
		_squadArray = _randomSquad select 0;
		_squadSkill = _randomSquad select 1;
		_squadCount = count _squadArray;

		// Only spawn if the following conditions are met
		if ((_opforCount < _zoneThreshold) and (_reinforcementsCount > _squadCount) and (reaperCrew_pauseInfantryReinforcements == false) and ((count activeInfantryTriggers) > 0 )) then {
			
			// Select a random spawnpoint
			_randomSpawn = (selectRandom activeInfantryTriggers);

			// Send the command to spawn units
			[[getPos _randomSpawn, _squadArray, _squadSkill, _rushMode, _codeOnSpawnGroup], "reapercrew_reinforcements_fnc_spawnHeadlessInfantry"] call reapercrew_common_fnc_executeDistributed;

			// Reduce the number of available reinforcements
			_reinforcementsCount = (_reinforcementsCount - _squadCount);
			_triggerObject setVariable ["reinforcementCount", _reinforcementsCount];

			// Output debug information
			if (reaperCrew_ReinforcementsCheckbox == true) then {
				diag_log format ["[REINFORCEMENTS]: Reinforcements created, %1 infantry remain", _reinforcementsCount];
			};

		};

		sleep _waveDelay;
	};








};


