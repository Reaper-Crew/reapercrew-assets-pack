/*
 * Author: Xeenenta
 * Initialises the reinforcements system. Creates global trigger tracking arrays
 * and spawns a debug logging loop (when enabled via CBA settings).
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
activeInfantryTriggers = [];
activeVehicleTriggers = [];
activeAircraftTriggers = [];
activeMarineTriggers = [];

if (!isServer) exitWith {
	["Server checked failed - skipping reinforcements system"] call reapercrew_common_fnc_remoteLog;
};

// Single debug loop that logs active triggers when the corresponding CBA setting is enabled
[] spawn {
	private _debugConfig = [
		["reaperCrew_InfantrySpawnCheckbox", "infantry", {activeInfantryTriggers}],
		["reaperCrew_VehicleSpawnCheckbox", "vehicle", {activeVehicleTriggers}],
		["reaperCrew_AircraftSpawnCheckbox", "aircraft", {activeAircraftTriggers}],
		["reaperCrew_MarineSpawnCheckbox", "marine", {activeMarineTriggers}]
	];

	while {true} do {
		{
			_x params ["_settingName", "_label", "_triggersCode"];
			if (missionNamespace getVariable [_settingName, false]) then {
				[(format ["Found the following active %1 triggers: %2", _label, call _triggersCode])] call reapercrew_common_fnc_remoteLog;
			};
		} forEach _debugConfig;
		sleep 15;
	};
};
