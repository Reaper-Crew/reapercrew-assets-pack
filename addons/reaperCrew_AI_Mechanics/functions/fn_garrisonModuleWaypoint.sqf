/*
 * Author: Xeenenta
 * Sets up garrison units after dynamic simulation transfer. Randomises stance,
 * disables AI PATH/COVER/RADIOPROTOCOL, and suppresses voice on each unit.
 *
 * Arguments:
 * 0: Group <GROUP>
 * 1: Position <ARRAY>
 * 2: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_group, _position, _target] call reapercrew_ai_mechanics_fnc_garrisonModuleWaypoint
 *
 * Public: No
 */

params ["_group", "_position", "_target"];

[(format ["Running waypoint function for group %1", str(_group)])] call reapercrew_common_fnc_remoteLog;

{
	_x setUnitPos (selectRandom ["UP", "MIDDLE"]);
	_x disableAI "PATH";
	_x disableAI "COVER";
	_x disableAI "RADIOPROTOCOL";
	[_x, "NoVoice"] remoteExec ["setSpeaker", 0, _x];
} forEach _group;
