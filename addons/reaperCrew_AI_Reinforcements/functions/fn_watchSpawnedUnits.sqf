/*
* Author: Xeenenta
* Starts a watcher loop that keeps a reinforcement module's "spawnedUnits" array
* accurate by pruning dead or null entries. Shared by all reinforcement module types.
* The array tracks units spawned by the module that may still be outside the zone, so
* the zone counter can account for them; this watcher stops it from going stale.
*
* The loop only writes when an entry has actually died, is a no-op while the array is
* empty, and exits if the module is deleted.
*
* Arguments:
* 0: Module Object <OBJECT>
*
* Return Value:
* None
*
* Example:
* [_logic] call reapercrew_reinforcements_fnc_watchSpawnedUnits
*
* Public: No
*/

params ["_module"];

// Run the prune loop in its own thread so the caller (the module init) returns immediately
[_module] spawn {
	params ["_module"];

	// Keep watching for as long as the module exists; if it is deleted the loop ends and the thread closes
	while {!isNull _module} do {

		// Read the module's current record of the units it has spawned
		private _tracked = _module getVariable ["spawnedUnits", []];

		// Keep only the entries that are still valid units and still alive (drops dead bodies and deleted/null handles)
		private _living = _tracked select {!isNull _x && {alive _x}};

		// Only write back when something was actually removed. _living is a filtered subset of
		// _tracked (select can only drop elements, never add or swap), so an equal count means the
		// two are the identical set - the count is an exact proxy for "did anything change". This
		// avoids needless network traffic on every tick and minimises clashes with the headless
		// client appending new spawns
		if (count _living != count _tracked) then {
			_module setVariable ["spawnedUnits", _living, true];
			if (reaperCrew_ReinforcementsCheckbox) then {
				[format ["Pruned %1 dead/removed units: module spawnedUnits %2 -> %3", (count _tracked) - (count _living), count _tracked, count _living]] call reapercrew_common_fnc_remoteLog;
			};
		};

		// Re-check every 5s. Cheap: it only ever walks this one module's small array, never allUnits,
		// and does nothing at all while the array is empty
		sleep 5;
	};
};
