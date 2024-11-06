/*
* Author: Xeenenta
* A function used to determine and add a pathway variable
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_reinforcements_fnc_getAvailableSpawnpoints
*
* Public: No
*/

params ["_reinforcementsModule", "_globalActiveTriggers"];

_result = _globalActiveTriggers;
_syncObjects = [];

_objectsSyncToModule = [_reinforcementsModule,["reaperCrew_moduleReinforcementsBase"], false] call BIS_fnc_synchronizedObjects;

{
	// If sync'd object has a spawnpointTrigger variable, add it to our array
	if !( _x isNil "spawnpointTrigger") then {
		_syncObjects pushBack (_x getVariable "spawnpointTrigger");
	};
} forEach _objectsSyncToModule;

[(format ["Syncronised spawnpoints: %1", _syncObjects])] call reapercrew_common_fnc_remoteLog;
[(format ["Global spawnpoints: %1", _globalActiveTriggers])] call reapercrew_common_fnc_remoteLog;

// Only intersect the arrays if greater than 0, otherwise just return as normal
if ((count _syncObjects) > 0) then {
	_result = _syncObjects arrayIntersect _globalActiveTriggers;
} else {
	_result = _globalActiveTriggers;
};

[(format ["Resulting spawnpoints: %1", _result])] call reapercrew_common_fnc_remoteLog;

_result;