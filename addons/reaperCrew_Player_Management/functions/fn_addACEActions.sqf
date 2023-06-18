_AceAction = [
	"GroupInfo",
	"Group Info",
	"",
	{ [] call reapercrew_player_groups_fnc_listAllGroups; },
	{true}
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _AceAction] call ace_interact_menu_fnc_addActionToObject;