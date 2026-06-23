/*
 * Author: Dom, adapted by Xeenenta
 * Returns the unit's role description, stripping text after the "@" separator.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Role Description <STRING>
 *
 * Example:
 * [_unit] call reapercrew_player_management_fnc_getRole
 *
 * Public: No
 */

params [["_unit", player, [objNull]]];

private _roleDescription = roleDescription _unit;

// Strip everything after "@" (used for section naming in Eden)
private _index = _roleDescription find "@";
if (_index isNotEqualTo -1) then {
	_roleDescription = _roleDescription select [0, _index];
};

_roleDescription
