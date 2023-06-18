/*
	fn_listAllGroups;
	Author: Stanhope
    Edited by: Havoc
	Description: fires a hint with a list of all the player grouped by squad with their weight next to it.
	
	effect: local
*/

private _allGroupsWithPlayers = [];

{_allGroupsWithPlayers pushBackUnique group _x} forEach ([] call BIS_fnc_listPlayers);
_allGroupsWithPlayers = [_allGroupsWithPlayers, [], {groupId _x}, "ASCEND"] call BIS_fnc_sortBy;

private _str = "";

{
    _str = _str + ([_x] call reapercrew_player_groups_fnc_getGroupListST);
	_str = _str + "<br/>";
} forEach _allGroupsWithPlayers;

hintSilent (parseText _str);