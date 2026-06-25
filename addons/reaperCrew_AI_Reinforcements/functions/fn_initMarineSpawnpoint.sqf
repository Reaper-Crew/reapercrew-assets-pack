/*
 * Author: Xeenenta
 * Initialises a marine spawnpoint. Delegates the shared zone/trigger/capture work to
 * fn_initSpawnpoint, then stores the synchronised marine LZ modules on the trigger.
 *
 * Arguments:
 * 0: _logic <OBJECT> - Module logic object
 *
 * Return Value:
 * None
 *
 * Example:
 * [logic] call reapercrew_reinforcements_fnc_initMarineSpawnpoint
 *
 * Public: No
 */

params [["_logic", objNull, [objNull]]];

// Only run on the server
if (!isServer) exitWith {["Server check failed - Not initialising init for marine spawns"] call reapercrew_common_fnc_remoteLog;};

_outerZone = [_logic, "activeMarineTriggers", 7500, 3750, "Marine Spawnpoint", "MarineSpawn"] call reapercrew_reinforcements_fnc_initSpawnpoint;

// Store connected LZs so the marine activation loop can pick a landing point
_syncLZs = [];
{
	if (typeOf _x == "reaperCrew_moduleMarineLZ") then {
		_syncLZs pushBack _x;
	};
} forEach synchronizedObjects _logic;

_outerZone setVariable ["connectedLZs", _syncLZs];
