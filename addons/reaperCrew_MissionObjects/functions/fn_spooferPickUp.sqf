/*
 * Author: Reaper Crew
 * Asks the server to pick up a placed spoofer. The server deletes it and grants the inventory item.
 *
 * Arguments:
 * 0: Spoofer object <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player] call reapercrew_missionobjects_fnc_spooferPickUp
 *
 * Public: Yes
 */

params ["_object", "_player"];
["rc_spoofer_pickUpRequest", [_object, _player]] call CBA_fnc_serverEvent;
