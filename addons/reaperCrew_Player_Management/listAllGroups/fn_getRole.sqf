/*
    File: fn_getRole.sqf
    Author: Dom
    Description: Gets the units role, removing text after the @
*/

private _roleDescription = roleDescription player;
private _index = _roleDescription find "@";
if (_index isNotEqualTo -1) then {
    _roleDescription = _roleDescription select [0,_index];
};

hint _roleDescription;