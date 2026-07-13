/*
* Author: Xeenenta
* Spawns a single patrol group and hands it to LAMBS taskPatrol
*
* Arguments:
* 0: Centre Position <ARRAY> - Module centre, used as the patrol focus
* 1: Spawn Position <ARRAY> - Where the group spawns
* 2: Group Size <NUMBER>
* 3: Troop Arrays <ARRAY> - Array of [classnames, skill] pairs
* 4: Group Side <SIDE>
* 5: Patrol Radius <NUMBER>
* 6: Area Data <ARRAY> - [a, b, angle, isRectangle, c] for confinement
* 7: Code to run on spawn <STRING>
*
* Return Value:
* None
*
* Example:
* [[0,0,0], [10,10,0], 4, [[["O_Soldier_F"], 50]], east, 100, [100,100,0,false,-1], "true"] call reapercrew_ai_mechanics_fnc_remotePatrolSpawn
*
* Public: No
*/

params ["_centre", "_spawnPos", "_groupSize", "_troopArrays", "_groupSide", "_patrolRadius", "_areaData", "_codeOnSpawn"];

// Build a random unit classname array for this patrol, tracking skill per unit
_patrolUnits = [];
_unitSkills = [];
for "_i" from 1 to _groupSize do {
	_selectedTroop = selectRandom _troopArrays;
	_patrolUnits pushBack (selectRandom (_selectedTroop select 0));
	_unitSkills pushBack (_selectedTroop select 1);
};

// Spawn the patrol group
_spawnedGroup = [_spawnPos, _groupSide, _patrolUnits, [],[],[],[],[],180] call BIS_fnc_spawnGroup;
// The group is local to this machine, so the engine auto-deletes it once every member is dead,
// preventing empty groups from accumulating towards the per-side group limit
_spawnedGroup deleteGroupWhenEmpty true;
// Dynamic simulation is managed by the server, so enable it on the server. This group is local to the
// spawning headless client, but enableDynamicSimulation takes a global argument so the remote group is valid.
[_spawnedGroup, true] remoteExec ["enableDynamicSimulation", 2];

_spawnUnitsArray = units _spawnedGroup;

// Set unit attributes and apply skill (mobile, so no PATH disable or doStop)
{
	_x setSkill ((_unitSkills select _forEachIndex) / 100);
	_x disableAI "RADIOPROTOCOL";
	// Set on the server so the server stops treating this unit as an activator that wakes other groups
	[_x, false] remoteExec ["triggerDynamicSimulation", 2];
	[_x, "ACE_NoVoice"] remoteExec ["setSpeaker", 0, _x];
} forEach _spawnUnitsArray;

// Assign the patrol, confined to the module area. Waypoint count uses the LAMBS default (4) and
// dynamic waypointing is always on so patrols are unpredictable.
[_spawnedGroup, _centre, _patrolRadius, 4, _areaData, true] call lambs_wp_fnc_taskPatrol;

// Run extra code
_codeCompile = compile format ['params ["_thisGroup"]; %1', _codeOnSpawn];
[_spawnedGroup] call _codeCompile;
