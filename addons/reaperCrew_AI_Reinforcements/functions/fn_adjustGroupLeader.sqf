/*
* Author: Xeenenta
* A workaround function to remove and readd the group leader
*
* Arguments:
* 0: Group Leader <OBJECT>
*
* Return Value:
* N/A
*
* Example:
* [myGroupLeader] call reapercrew_reinforcements_fnc_adjustGroupLeader
*
* Public: No
*/

params ["_groupLeader"];

[_groupLeader] spawn {
	params ["_groupLeader"];
	sleep 30;

	_group = group _groupLeader;
	[_groupLeader] join _group;
};

