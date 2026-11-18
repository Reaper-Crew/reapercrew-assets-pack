/*
 * Author: Xeenenta
 * Activates a streamer module. Spawns one unit per group at the configured interval, then deletes the trigger and module.
 *
 * Arguments:
 * 0: Trigger Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [thisTrigger] call reapercrew_reinforcements_fnc_activateInfantryModuleStreamer
 *
 * Public: No
 */

params ["_triggerObject"];

[_triggerObject] spawn {
	params ["_triggerObject"];

	_troopArrays = _triggerObject getVariable ["troopArrays", []];
	_unitCount = _triggerObject getVariable ["unitCount", 10];
	_spawnInterval = _triggerObject getVariable ["spawnInterval", 2];
	_rushMode = _triggerObject getVariable ["rushMode", true];
	_codeOnSpawn = _triggerObject getVariable ["codeOnSpawn", "true"];
	_spawnPos = _triggerObject getVariable ["spawnPos", [0, 0, 0]];
	_rushRadius = _triggerObject getVariable ["rushRadius", 75];
	_moduleObject = _triggerObject getVariable ["moduleObject", objNull];

	[format ["Streamer activated, spawning %1 units every %2 seconds", _unitCount, _spawnInterval]] call reapercrew_common_fnc_remoteLog;

	for "_i" from 1 to _unitCount do {
		_category = selectRandom _troopArrays;
		_class = selectRandom (_category select 0);

		[[_spawnPos, _class, _category select 1, _rushMode, _codeOnSpawn, _rushRadius], "reapercrew_reinforcements_fnc_spawnHeadlessInfantryStreamer"] call reapercrew_common_fnc_executeDistributed;

		[format ["Streamer unit %1 of %2 dispatched: %3", _i, _unitCount, _class]] call reapercrew_common_fnc_remoteLog;

		if (_i < _unitCount) then {
			sleep _spawnInterval;
		};
	};

	if (!isNull _moduleObject) then {
		deleteVehicle _moduleObject;
	};
	deleteVehicle _triggerObject;

	["Streamer complete, module and trigger deleted"] call reapercrew_common_fnc_remoteLog;
};
