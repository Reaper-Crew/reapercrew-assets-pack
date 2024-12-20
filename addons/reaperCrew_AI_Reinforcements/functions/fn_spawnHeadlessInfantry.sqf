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

params ["_spawnPoint", "_squadArray", "_squadSkill", "_rushMode", "_codeOnSpawnGroup"];

[_spawnPoint, _squadArray, _squadSkill, _rushMode, _codeOnSpawnGroup] spawn {
	params ["_spawnPoint", "_squadArray", "_squadSkill", "_rushMode", "_codeOnSpawnGroup"];
	["Running reinforcement spawn script"] call reapercrew_common_fnc_remoteLog;
	// Spawn the group
	_spawnedGroup = [_spawnPoint, reaperCrew_reinforcements_side, _squadArray, [],[],[],[],[],180] call BIS_fnc_spawnGroup;
	{
		_x triggerDynamicSimulation false;
	} forEach units _spawnedGroup;

	sleep 5;
	_spawnedGroup setBehaviour "AWARE";

	{
		if (_rushMode) then {
			_x disableAI "FSM";
		};
		_x setSkill (_squadSkill / 100);
	} forEach units _spawnedGroup;

	sleep 5;

	// Make them rush
	[_spawnedGroup, 2000] spawn lambs_wp_fnc_taskRush;

	// Run extra code
	_extraCodeString = format ['params ["_thisGroup"]; %1', _codeOnSpawnGroup];
	_codeCompile = compile _extraCodeString;
	[_spawnedGroup] call _codeCompile;
};


