/*
 * Author: Xeenenta
 * Adds custom ACE self-interaction actions to the player.
 * Currently adds a "Group Info" action to view group/unit information.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call reapercrew_player_management_fnc_addACEActions
 *
 * Public: No
 */

_AceAction = [
	"GroupInfo",
	"Group Info",
	"",
	{ [] call reapercrew_player_groups_fnc_listAllGroups; },
	{true}
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _AceAction] call ace_interact_menu_fnc_addActionToObject;
