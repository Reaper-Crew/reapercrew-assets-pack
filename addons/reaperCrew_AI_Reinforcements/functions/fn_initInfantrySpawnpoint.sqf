/*
 * Author: Xeenenta
 * Initialises a foot mobile infantry spawnpoint. Delegates the shared zone/trigger/capture
 * work to fn_initSpawnpoint; infantry has no type-specific follow-up.
 *
 * Arguments:
 * 0: _logic <OBJECT> - Module logic object
 *
 * Return Value:
 * None
 *
 * Example:
 * [logic] call reapercrew_reinforcements_fnc_initInfantrySpawnpoint
 *
 * Public: No
 */

params [["_logic", objNull, [objNull]]];

// Only run on the server
if (!isServer) exitWith {["Server check failed - Not initialising init for infantry spawns"] call reapercrew_common_fnc_remoteLog;};

[_logic, "activeInfantryTriggers", 2000, 1000, "Infantry Spawnpoint", "InfantrySpawn"] call reapercrew_reinforcements_fnc_initSpawnpoint;
