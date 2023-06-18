/*
    File: fn_getUnitWeightST.sqf
    Author: Havoc
    Description: Returns the weight from the given unit in the form of structured text.
*/

params ["_unit"];

private _unitWeight = [_unit] call reapercrew_player_groups_fnc_getWeight;
private _unitWeightColour = [_unitWeight] call reapercrew_player_groups_fnc_getWeightColour;

(format ["<t color='#%1'>%2kg</t>", _unitWeightColour, _unitWeight])