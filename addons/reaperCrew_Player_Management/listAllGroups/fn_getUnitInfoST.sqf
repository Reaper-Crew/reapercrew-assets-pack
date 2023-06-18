/*
    File: fn_getUnitInfoST.sqf
    Author: Havoc
    Description: Returns information from the given group in the form of structured text.
*/

params ["_unit"];

private _playerName = name _unit;
private _playerRole = [_unit] call reapercrew_player_groups_fnc_getUnitRole;
private _playerWeightST = [_unit] call reapercrew_player_groups_fnc_getUnitWeightST;
private _playerWeapon = getText (configfile >> "CfgWeapons" >> currentWeapon _unit >> "displayName");
if (_playerWeapon isEqualTo "") then { _playerWeapon = "Unarmed"; };

private _str = format
["<t font='PuristaBold' align='left' size='1.4'>PLAYER</t>
<br/>
<t font='PuristaLight' valign='bottom' align='left'>Name</t>
<t font='PuristaBold' valign='bottom' align='right'>%1</t>
<br/>
<t font='PuristaLight' valign='bottom' align='left'>Role</t>
<t font='PuristaBold' valign='bottom' align='right'>%2</t>
<br/>
<t font='PuristaLight' valign='bottom' align='left'>Weight</t>
<t font='PuristaBold' valign='bottom' align='right'>%3</t>
<br/>
<t font='PuristaLight' valign='bottom' align='left'>Weapon</t>
<t font='PuristaBold' valign='bottom' align='right'>%4</t>",
	_playerName, _playerRole, _playerWeightST, _playerWeapon
];

_str
