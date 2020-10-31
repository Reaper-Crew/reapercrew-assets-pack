/*
 * Author: Xeenenta
 * The waypoint aims to leverage dynamic simulation to allow headless client support. The idea is that this waypoint will fire when the unit is activated in order to fix units in place after the client transfer has taken place.
 *
 * Arguments:
 * 0: Group <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_group] call xeen_garrison_fnc_modulegarrisonwaypoint
 *
 * Public: No
 */

params ["_group", "_position", "_target"];

diag_log format ["GARRISON MODULE: Running waypoint function for group %1", str(_group)];

{
	_x setUnitPos (selectRandom ["UP", "MIDDLE"]);
	_x disableAI "PATH";
	_x disableAI "COVER";
	_x disableAI "RADIOPROTOCOL";
	[_x, "NoVoice"] remoteExec ["setSpeaker", 0, _x];
} forEach _group;
