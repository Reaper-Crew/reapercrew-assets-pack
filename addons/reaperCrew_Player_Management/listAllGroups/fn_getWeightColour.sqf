/*
	File: fn_getWeightColour.sqf
	Author: Stanhope
*/

params ["_weight"];
private _col = "FFFFFF";
if (_weight != -1) then {
	_col = "00FF00";
	if (_weight > 30) then {_col = "FFA500"};
	if (_weight > 35) then {_col = "FF5500"};
	if (_weight > 40) then {_col = "FF2E2E"};
	if (_weight > 45) then {_col = "FF69B4"};
};
_col