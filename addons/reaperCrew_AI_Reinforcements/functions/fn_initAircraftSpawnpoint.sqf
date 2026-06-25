/*
 * Author: Xeenenta
 * Initialises an aircraft spawnpoint. Delegates the shared zone/trigger/capture work to
 * fn_initSpawnpoint, then extracts the aircraft pathway.
 *
 * Arguments:
 * 0: _logic <OBJECT> - Module logic object
 *
 * Return Value:
 * None
 *
 * Example:
 * [logic] call reapercrew_reinforcements_fnc_initAircraftSpawnpoint
 *
 * Public: No
 */

params [["_logic", objNull, [objNull]]];

// Only run on the server
if (!isServer) exitWith {["Server check failed - Not initialising init for Aircraft spawns"] call reapercrew_common_fnc_remoteLog;};

_outerZone = [_logic, "activeAircraftTriggers", 25000, 12500, "Aircraft Spawnpoint", "AircraftSpawn"] call reapercrew_reinforcements_fnc_initSpawnpoint;

[_logic, _outerZone] call reapercrew_reinforcements_fnc_getPathway;
