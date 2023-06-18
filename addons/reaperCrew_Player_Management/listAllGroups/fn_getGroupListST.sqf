/*
    File: fn_getGroupListST.sqf
    Author: Havoc
    Description: Returns information from the given group in the form of structured text.
*/

params [
	["_group", []]
];

if (count units _group == 0) exitWith {
    // TODO: Return something signifying the group is empty for whatever purpose
};

_units = [units _group, [], {if (_x isEqualTo (leader group _x)) exitWith { 1 }; 0 }, "DESCEND"] call BIS_fnc_sortBy;

private _str = format ["<t font='PuristaBold' align='left' size='1.4'>%1</t>", toUpper (groupId _group)];
{
	private _unitName = name _x;
	private _unitRole = [_x] call reapercrew_player_groups_fnc_getUnitRole;
	private _unitWeight = [_x] call reapercrew_player_groups_fnc_getWeight;

	if (_x == leader group _x) then {
		_unitName = _unitName + "<img image='a3\ui_f\data\igui\cfg\cursors\leader_ca.paa'/>"
	};

	_unitRole = (format ["(%1) ", [_x] call reapercrew_player_groups_fnc_getUnitWeightST]) + _unitRole;

	_str = _str + format ["<br/><t font='PuristaLight' valign='bottom' align='left'>• %1</t>
<t font='PuristaBold' valign='bottom' align='right'>%2</t>", _unitName, _unitRole];
} forEach _units;

_str
