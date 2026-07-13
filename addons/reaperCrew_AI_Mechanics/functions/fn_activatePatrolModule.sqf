/*
* Author: Xeenenta
* Plans the patrols and distributes the spawning across headless clients
*
* Arguments:
* 0: Max Count <NUMBER>
* 1: Logic <LOGIC>
* 2: Area Data <ARRAY>
* 3: Troop Arrays <ARRAY>
* 4: Code on spawn <STRING>
* 5: Group Side <SIDE>
* 6: Min Group Size <NUMBER>
* 7: Max Group Size <NUMBER>
*
* Return Value:
* None
*
* Example:
* [50, _logic, [100,100,0,false,-1], [], "true", east, 3, 6] call reapercrew_ai_mechanics_fnc_activatePatrolModule
*
* Public: No
*/

// Variables
params ["_maxCount", "_logic", "_logicAreaData", "_troopArrays", "_codeOnSpawn", "_groupSide", "_minGroupSize", "_maxGroupSize"];

// Nothing to spawn without a troop pool
if (_troopArrays isEqualTo []) exitWith {["No troop tiers enabled - Not running patrol generator"] call reapercrew_common_fnc_remoteLog};

// Extract Position data
_centre = getPos _logic;

_logicRadiusA = _logicAreaData select 0;
_logicRadiusB = _logicAreaData select 1;
_logicAngle = _logicAreaData select 2;
_logicIsRectangle = _logicAreaData select 3;
_logicRadiusC = _logicAreaData select 4;

// Area data passed to LAMBS taskPatrol for hard confinement (centre comes from _pos)
_areaData = [_logicRadiusA, _logicRadiusB, _logicAngle, _logicIsRectangle, _logicRadiusC];
// Full area used for inArea sampling tests
_areaFull = [_centre, _logicRadiusA, _logicRadiusB, _logicAngle, _logicIsRectangle, _logicRadiusC];
// Patrol radius spans the larger axis so groups can roam the whole zone
_patrolRadius = _logicRadiusA max _logicRadiusB;

// Spawn variable sized groups until the global cap is reached
_spawnedTotal = 0;
while {_spawnedTotal < _maxCount} do {

	// Random group size within the configured range, capped so we never overshoot
	_groupSize = _minGroupSize + floor (random ((_maxGroupSize - _minGroupSize) + 1));
	_groupSize = _groupSize min (_maxCount - _spawnedTotal);
	if (_groupSize <= 0) exitWith {};

	// Find a random spawn position within the area (reject water, cap retries)
	_spawnPos = _centre;
	for "_i" from 1 to 20 do {
		_candidate = _centre getPos [random _patrolRadius, random 360];
		if ((_candidate inArea _areaFull) && {!(surfaceIsWater _candidate)}) exitWith {
			_spawnPos = _candidate;
		};
	};

	// Farm the actual spawning and patrol assignment out to a headless client (one call per group)
	[[_centre, _spawnPos, _groupSize, _troopArrays, _groupSide, _patrolRadius, _areaData, _codeOnSpawn], "reapercrew_ai_mechanics_fnc_remotePatrolSpawn"] call reapercrew_common_fnc_executeDistributed;

	_spawnedTotal = _spawnedTotal + _groupSize;

	// Stagger dispatches so a mid-mission activation doesn't spawn every group in one frame and cause jitter
	sleep 3;
};
