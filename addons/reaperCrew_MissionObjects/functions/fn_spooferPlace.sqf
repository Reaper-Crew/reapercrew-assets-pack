/*
 * Author: Reaper Crew
 * Places the carried spoofer on the surface one metre in front of the player, facing them. Works on building
 * floors as well as terrain: the drop point is found by a ray down through geometry.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Placed <BOOL>
 *
 * Example:
 * [player] call reapercrew_missionobjects_fnc_spooferPlace
 *
 * Public: Yes
 */

params ["_player"];
if !("reaperCrew_Spoofer_Item" in (items _player)) exitWith { false };

private _front = AGLToASL (_player modelToWorld [0, 1, 0]);
private _hits = lineIntersectsSurfaces [_front vectorAdd [0, 0, 1.5], _front vectorAdd [0, 0, -3], _player, objNull, true, 1, "GEOM", "NONE"];
private _posASL = if (_hits isEqualTo []) then {
	[_front select 0, _front select 1, getTerrainHeightASL _front]
} else {
	(_hits select 0) select 0
};

_player removeItem "reaperCrew_Spoofer_Item";
["rc_spoofer_placeRequest", [_player, _posASL, getDir _player + 180]] call CBA_fnc_serverEvent;
true
