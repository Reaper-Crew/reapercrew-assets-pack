params ["_position"];

["TaskSucceeded",["","Purple Smoke deployed"]] call BIS_fnc_showNotification;

_markingGroup = createGroup sideLogic;
"ModuleSmokePurple_F" createUnit [
	_position,
	_markingGroup,
	"this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true];"
];