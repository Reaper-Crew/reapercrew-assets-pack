/*
 * Author: Xeenenta
 * Activates the suppress position module. Each synchronised gunner independently
 * selects random players in the trigger zone and fires suppressive bursts at them.
 *
 * Arguments:
 * 0: Trigger Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [thisTrigger] call reapercrew_ai_mechanics_fnc_activateSuppressPosition
 *
 * Public: No
 */

params ["_triggerObject"];

["Activated position suppression mechanic"] call reapercrew_common_fnc_remoteLog;

_syncGunners = _triggerObject getVariable ["_syncGunners", []];

// Brief delay before suppression begins
sleep 10;

// Spawn an independent loop for each gunner
{
	[_triggerObject, _x] spawn {
		params ["_triggerObject", "_gunner"];

		while { triggerActivated _triggerObject && alive _gunner } do {
			_allPlayersinZone = allPlayers inAreaArray _triggerObject;

			// Only suppress if there are players in the zone
			if (count _allPlayersinZone > 0) then {
				_randomPlayer = selectRandom _allPlayersinZone;
				[_gunner, getPosATL _randomPlayer, ([1, 10] call BIS_fnc_randomInt), 5, unitPos _gunner] call zen_ai_fnc_suppressiveFire;
			};

			sleep ([1, 10] call BIS_fnc_randomInt);
		};
	};
} forEach _syncGunners;
