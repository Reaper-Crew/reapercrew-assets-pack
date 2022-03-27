/*
* Author: Xeenenta
* Spawns the troops to garrison
*
* Arguments:
* 0: Center Position <ARRAY>
* 1: Building Positions <ARRAY>
* 2: Max number of AI to spawn <NUMBER>
* 3: An array of units to use to garrison <ARRAY>
* 4: Code to run on spawn <STRING>
*
* Return Value:
* None
*
* Example:
* [[0,0,0], [], 50, ["B_Soldier_GL_F"], "true"] call reapercrew_ai_mechanics_fnc_remoteGarrisonSpawn
*
* Public: No
*/

params ["_centerPosition", "_positions", "_totalCount", "_unitsArray", "_codeOnSpawn"];

_totalIterations = 0;
_garrisonUnits = [];
_spawnUnitsArray = [];

// Determine which number is lower, the number of positions or the max count
if (_totalCount < (count _positions)) then {
	_totalIterations = _totalCount;
} else {
	_totalIterations = (count _positions);
};

// Build a random group array of that size
for "_i" from 1 to _totalIterations do {
	_garrisonUnits pushBack (selectRandom _unitsArray);
};

// Spawn a group of that size
_spawnedGroup = [_centerPosition, reaperCrew_reinforcements_side, _garrisonUnits, [],[],[],[],[],180] call BIS_fnc_spawnGroup;
_spawnedGroup enableDynamicSimulation true;

_spawnUnitsArray = units _spawnedGroup;
// Set unit attributes
{
	doStop _x;
	_x setUnitPos "UP";
	_x disableAI "PATH";
} forEach _spawnUnitsArray;

// Move the units into position
for "_i" from 0 to _totalIterations do {
	(_spawnUnitsArray select _i) setPos (_positions select _i);
};

// Run extra code
_extraCodeString = format ['params ["_thisGroup"]; %1', _codeOnSpawn];
_codeCompile = compile _extraCodeString;
[_spawnedGroup] call _codeCompile;