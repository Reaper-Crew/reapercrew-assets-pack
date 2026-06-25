/*
 * Author: Xeenenta
 * Initialises a motorised vehicle spawnpoint. Delegates the shared zone/trigger/capture work
 * to fn_initSpawnpoint, then extracts the vehicle pathway.
 *
 * Arguments:
 * 0: _logic <OBJECT> - Module logic object
 *
 * Return Value:
 * None
 *
 * Example:
 * [logic] call reapercrew_reinforcements_fnc_initVehicleSpawnpoint
 *
 * Public: No
 */

params [["_logic", objNull, [objNull]]];

// Only run on the server
if (!isServer) exitWith {["Server check failed - Not initialising init for Vehicle spawns"] call reapercrew_common_fnc_remoteLog;};

_outerZone = [_logic, "activeVehicleTriggers", 5000, 2500, "Vehicle Spawnpoint", "VehicleSpawn"] call reapercrew_reinforcements_fnc_initSpawnpoint;

[_logic, _outerZone] call reapercrew_reinforcements_fnc_getPathway;
