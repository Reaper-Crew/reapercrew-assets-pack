/*
 * Author: Reaper Crew
 * Class init of the EW case (CBA extended init). On the server raises "rc_spoofer_placed" with the object and the
 * player who placed it, or objNull when Eden or a script created it.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_object"];
if (!isServer) exitWith {};
private _placer = missionNamespace getVariable ["rc_spoofer_placing", objNull];
["rc_spoofer_placed", [_object, _placer]] call CBA_fnc_globalEvent;
