/*
	File: fn_getWeight.sqf
	Author: Stanhope
*/

params ["_unit"];

private _weight = [_unit] call ace_common_fnc_getWeight;
private _index = _weight find "kg";
private _returnVal = -1;

if (_index != 0) then {
	_returnVal = parseNumber (_weight select [0, _index]);
};

_returnVal