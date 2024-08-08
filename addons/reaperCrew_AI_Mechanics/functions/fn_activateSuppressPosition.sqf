/*
* Author: Xeenenta
* Suppress random players within a position
*
* Arguments:
* 0: Logic <LOGIC>
* 1: 
*
* Return Value:
* None
*
* Example:
* [_logic] call reapercrew_ai_mechanics_fnc_activateSuppressPosition
*
* Public: No
*/

params ["_triggerObject"];

["AI_MECHANICS", "activateSuppressPosition", "Activated position suppression mechanic"] call reapercrew_common_fnc_remoteLog;

_syncGunners = _triggerObject getVariable ["_syncGunners", []];

sleep 10;

{

	[_triggerObject, _x] spawn {
		params ["_triggerObject", "_gunner"];
		while { triggerActivated _triggerObject && alive _gunner } do {
			// Get all players in the zone
			_allPlayersinZone = (allPlayers inAreaArray _triggerObject);

			// Select one at random
			_randomPlayer = selectRandom _allPlayersinZone;

			["AI_MECHANICS", "activateSuppressPosition", format ["Suppressing player %1", (name _randomPlayer)]] call reapercrew_common_fnc_remoteLog;

			// Begin Supression
			[_gunner, (getPosATL _randomPlayer), ([1,10] call BIS_fnc_randomInt), 5, (UnitPos _gunner)] call zen_ai_fnc_suppressiveFire;

			// Wait
			sleep ([1,10] call BIS_fnc_randomInt);
		};
	};

} forEach _syncGunners;