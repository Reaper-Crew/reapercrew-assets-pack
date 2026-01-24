_AceAction = [
	"GroupInfo",
	"Group Info",
	"",
	{ [] call reapercrew_player_groups_fnc_listAllGroups; },
	{true}
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _AceAction] call ace_interact_menu_fnc_addActionToObject;

// _treatmentCodeTarget = {
// 	params ["_name"];
// 	// Output prompt on remote target
// 	_promptString = format ["%1 is treating you", _name];
// 	cutText [_promptString, "PLAIN DOWN", 10];

// }

// _treatmentCodeCaller = {
// 	// Call the notification event on the remote client
// 	params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem", "_createLitter"];

// 	// Don't pop up if treating yourself
// 	// if (_caller == _target) exitWith {};

// 	[(name _caller)] remoteExec ["treatmentCodeTarget", _target, false];
// };

// ["ace_treatmentStarted", _treatmentCodeCaller] call CBA_fnc_addEventHandler;