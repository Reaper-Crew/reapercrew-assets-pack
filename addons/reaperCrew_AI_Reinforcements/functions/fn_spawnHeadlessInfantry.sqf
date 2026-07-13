/*
 * Author: Xeenenta
 * Spawns infantry units and sets them to rush
 *
 * Arguments:
 * 0: Object <OBJECT> 
 * 0: Troops <ARRAY>
 * 2: Skill Level <INT>
 * 2: Rush Mode <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[2570.89,5566.81,0], [], 20, false] call reapercrew_reinforcements_fnc_spawnHeadlessInfantry
 *
 * Public: No
 */

params ["_spawnPoint", "_squadArray", "_squadSkill", "_rushMode", "_codeOnSpawnGroup", ["_moduleObject", objNull], ["_rushRadius", 2000]];

[_spawnPoint, _squadArray, _squadSkill, _rushMode, _codeOnSpawnGroup, _moduleObject, _rushRadius] spawn {
	params ["_spawnPoint", "_squadArray", "_squadSkill", "_rushMode", "_codeOnSpawnGroup", "_moduleObject", "_rushRadius"];
	["Running reinforcement spawn script"] call reapercrew_common_fnc_remoteLog;
	// Spawn the group
	_spawnedGroup = [_spawnPoint, reaperCrew_reinforcements_side, _squadArray, [],[],[],[],[],180] call BIS_fnc_spawnGroup;
	// The group is local to this machine, so the engine auto-deletes it once every member is dead,
	// preventing empty groups from accumulating towards the per-side group limit
	_spawnedGroup deleteGroupWhenEmpty true;
	{
		// Set on the server so the server does not treat these ingressing units as activators that wake garrisons
		[_x, false] remoteExec ["triggerDynamicSimulation", 2];
	} forEach units _spawnedGroup;

	// Register spawned units with the module so the zone counter can track them
	if (!isNull _moduleObject) then {
		private _existing = _moduleObject getVariable ["spawnedUnits", []];
		private _updated = _existing + (units _spawnedGroup);
		_moduleObject setVariable ["spawnedUnits", _updated, true];
		[format ["Tracked %1 newly spawned units: module spawnedUnits %2 -> %3", count (units _spawnedGroup), count _existing, count _updated]] call reapercrew_common_fnc_remoteLog;
	};

	sleep 5;
	_spawnedGroup setBehaviour "AWARE";

	{
		if (_rushMode) then {
			_x disableAI "FSM";
		};
		_x setSkill (_squadSkill / 100);
	} forEach units _spawnedGroup;

	sleep 5;

	// Make them rush across the spawnpoint's outer zone
	[_spawnedGroup, _rushRadius] spawn lambs_wp_fnc_taskRush;

	// Run extra code
	_extraCodeString = format ['params ["_thisGroup"]; %1', _codeOnSpawnGroup];
	_codeCompile = compile _extraCodeString;
	[_spawnedGroup] call _codeCompile;
};


