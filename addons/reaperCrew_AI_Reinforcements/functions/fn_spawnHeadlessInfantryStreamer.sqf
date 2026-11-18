/*
 * Author: Xeenenta
 * Spawns a single infantry unit in its own group and sets it to rush.
 *
 * Arguments:
 * 0: Spawn position <ARRAY>
 * 1: Unit classname <STRING>
 * 2: Skill level <NUMBER>
 * 3: Rush mode <BOOLEAN>
 * 4: Code run on the unit, with _thisUnit defined <STRING>
 * 5: Rush radius <NUMBER>
 * 6: Side <SIDE> (default reaperCrew_reinforcements_side)
 *
 * Return Value:
 * None
 *
 * Example:
 * [[2570.89,5566.81,0], "O_Soldier_F", 50, true, "true", 75] call reapercrew_reinforcements_fnc_spawnHeadlessInfantryStreamer
 *
 * Public: No
 */

params ["_spawnPos", "_class", "_skill", "_rushMode", "_codeOnSpawn", "_rushRadius", ["_side", reaperCrew_reinforcements_side]];

[_spawnPos, _class, _skill, _rushMode, _codeOnSpawn, _rushRadius, _side] spawn {
	params ["_spawnPos", "_class", "_skill", "_rushMode", "_codeOnSpawn", "_rushRadius", "_side"];

	// Group is local to this machine and is deleted by the engine once empty
	_group = createGroup [_side, true];
	_unit = _group createUnit [_class, _spawnPos, [], 0, "NONE"];

	// Dynamic simulation is managed by the server
	[_group, true] remoteExec ["enableDynamicSimulation", 2];
	[_unit, false] remoteExec ["triggerDynamicSimulation", 2];

	_unit setSkill (_skill / 100);

	if (_rushMode) then {
		_unit disableAI "FSM";
		[_group, _rushRadius] spawn lambs_wp_fnc_taskRush;
	};

	_codeCompile = compile format ['params ["_thisUnit"]; %1', _codeOnSpawn];
	[_unit] call _codeCompile;

	[format ["Streamer spawned %1", _class]] call reapercrew_common_fnc_remoteLog;
};
