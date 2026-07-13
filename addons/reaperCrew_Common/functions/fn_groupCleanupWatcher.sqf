/*
 * Author: Xeenenta
 * Safety net against the engine's per-side group limit (~288 groups per side): every 15
 * minutes, deletes all empty groups owned by this machine. Spawners are expected to mark
 * their own groups with deleteGroupWhenEmpty, but anything that slips through (side
 * changes, joins, third-party spawns) is swept up here before the limit is silently hit.
 *
 * Runs on every machine (postInit) because deleteGroup only works on local groups - the
 * server, each headless client and each player client cleans up its own.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call reapercrew_common_fnc_groupCleanupWatcher
 *
 * Public: No
 */

[] spawn {
	while { true } do {
		sleep 900;

		private _deleted = 0;
		{
			if (local _x && {units _x isEqualTo []}) then {
				deleteGroup _x;
				_deleted = _deleted + 1;
			};
		} forEach allGroups;

		if (_deleted > 0) then {
			[format ["groupCleanupWatcher: deleted %1 empty local groups (%2 groups remain)", _deleted, count allGroups]] call reapercrew_common_fnc_remoteLog;
		};
	};
};
