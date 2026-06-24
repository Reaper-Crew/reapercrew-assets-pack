/*
 * Author: Xeenenta
 * Initialises the reinforcements system. Creates global trigger tracking arrays
 * and spawns a debug logging loop.
 * Runs as postInit on the server.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call reapercrew_reinforcements_fnc_initReinforcementsSystem
 *
 * Public: No
 */

// Global arrays that track active spawnpoint triggers per type
// Declared before the server check so isNil guards in activation functions
// resolve on all machines (HC scripts check these before proceeding)
activeInfantryTriggers = [];
activeVehicleTriggers = [];
activeAircraftTriggers = [];
activeMarineTriggers = [];

if (!isServer) exitWith {
	["Server checked failed - skipping reinforcements system"] call reapercrew_common_fnc_remoteLog;
};

// Single debug loop that logs active triggers
[] spawn {
	private _debugConfig = [
		["infantry", {activeInfantryTriggers}],
		["vehicle", {activeVehicleTriggers}],
		["aircraft", {activeAircraftTriggers}],
		["marine", {activeMarineTriggers}]
	];

	while {true} do {
		{
			_x params ["_label", "_triggersCode"];
			[(format ["Found the following active %1 triggers: %2", _label, call _triggersCode])] call reapercrew_common_fnc_remoteLog;
		} forEach _debugConfig;
		sleep 15;
	};
};
