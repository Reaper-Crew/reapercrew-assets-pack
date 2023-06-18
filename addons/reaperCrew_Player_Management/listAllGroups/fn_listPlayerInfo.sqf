/*
    File: fn_listPlayerInfo.sqf
    Author: Havoc
    Description: Show hint containing player and player group information.
*/

private _str = "";

_str = _str + ([player] call reapercrew_player_groups_fnc_getUnitInfoST);
_str = _str + "<br/><br/>";
_str = _str + ([group player] call reapercrew_player_groups_fnc_getGroupListST);

hintSilent (parseText _str);