/*
* Author: Xeenenta
* Spawns a garrison group for a single building
*
* Arguments:
* 0: Centre Position <ARRAY>
* 1: Building Positions <ARRAY> - Positions within a single building
* 2: Troop Arrays <ARRAY> - Array of [classnames, skill] pairs
* 3: Code to run on spawn <STRING>
* 4: Side of the spawned group <SIDE>
*
* Return Value:
* None
*
* Example:
* [[0,0,0], [[1,2,3],[4,5,6]], [[["B_Soldier_GL_F"], 50]], "true", east] call reapercrew_ai_mechanics_fnc_remoteGarrisonSpawn
*
* Public: No
*/

params ["_centerPosition", "_buildingPositions", "_troopArrays", "_codeOnSpawn", "_groupSide"];

_unitCount = count _buildingPositions;

// Build a random unit classname array for this building, tracking skill per unit
_garrisonUnits = [];
_unitSkills = [];
for "_i" from 1 to _unitCount do {
	_selectedTroop = selectRandom _troopArrays;
	_garrisonUnits pushBack (selectRandom (_selectedTroop select 0));
	_unitSkills pushBack (_selectedTroop select 1);
};

// Spawn a group for this building
_spawnedGroup = [_centerPosition, _groupSide, _garrisonUnits, [],[],[],[],[],180] call BIS_fnc_spawnGroup;
_spawnedGroup enableDynamicSimulation true;

_spawnUnitsArray = units _spawnedGroup;

// Set unit attributes, apply skill, and move into position
{
	doStop _x;
	_x setUnitPos (selectRandom ["UP", "MIDDLE"]);
	_x setSkill ((_unitSkills select _forEachIndex) / 100);
	_x disableAI "PATH";
	_x disableAI "RADIOPROTOCOL";
	_x triggerDynamicSimulation false;
	[_x, "ACE_NoVoice"] remoteExec ["setSpeaker", 0, _x];
	_x setPos (_buildingPositions select _forEachIndex);
} forEach _spawnUnitsArray;

// Run extra code
_codeCompile = compile format ['params ["_thisGroup"]; %1', _codeOnSpawn];
[_spawnedGroup] call _codeCompile;
