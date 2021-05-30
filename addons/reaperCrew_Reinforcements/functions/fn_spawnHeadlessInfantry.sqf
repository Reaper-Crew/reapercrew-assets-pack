/*
 * Author: Xeenenta
 * Spawns infantry units and sets them to rush
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [[2570.89,5566.81,0]] call reapercrew_reinforcements_fnc_spawnHeadlessInfantry
 *
 * Public: No
 */

params ["_spawnPoint"];

[_spawnPoint] spawn {
	params ["_spawnPoint"];
	diag_log "SCENARIO: Running reinforcement spawn script";
	// Spawn the group
	_spawnedGroup = [_spawnPoint, reaperCrew_reinforcements_side, rifleSection, [],[],[],[],[],180] call BIS_fnc_spawnGroup;
	{
		_x triggerDynamicSimulation false;
	} forEach units _spawnedGroup;

	sleep 5;
	_spawnedGroup setBehaviour "AWARE";

	sleep 5;

	// Make them rush
	[_spawnedGroup, 2000] spawn lambs_wp_fnc_taskRush;
};


