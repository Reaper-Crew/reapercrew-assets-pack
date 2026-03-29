/*
 * Author: Xeenenta
 * Initialises the Interaction Objective module. Adds a hold action to all synchronised
 * objects that sets a global variable to true when completed. Used for scripted objectives
 * such as "download intel", "plant explosives", "activate radio", etc.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call reapercrew_mission_mechanics_fnc_initInteractionObjective
 *
 * Public: No
 */

_logic = param [0, objNull, [objNull]];

if (!isServer) exitWith {
	["Server check failed - not running interaction objective init"] call reapercrew_common_fnc_remoteLog;
};

// Read module attributes
private _actionText = _logic getVariable ["actionText", "Interact"];
private _actionDuration = _logic getVariable ["actionDuration", 5];
private _actionCondition = _logic getVariable ["actionCondition", "true"];
private _completionVariable = _logic getVariable ["completionVariable", ""];

// Validate
private _syncedObjects = synchronizedObjects _logic;

if (count _syncedObjects == 0) exitWith {
	["ERROR: Interaction Objective module has no synchronised objects"] call reapercrew_common_fnc_remoteLog;
};

if (_completionVariable isEqualTo "" || _completionVariable isEqualTo 0) exitWith {
	["ERROR: Interaction Objective module has no completion variable defined"] call reapercrew_common_fnc_remoteLog;
};

// Initialise the completion variable to false on all machines
missionNamespace setVariable [_completionVariable, false, true];

// Add hold action to each synchronised object on all clients (with JIP)
{
	[
		_x,
		_actionText,
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		_actionCondition,
		"_caller distance _target < 3",
		{},
		{},
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			_arguments params ["_variableName"];
			missionNamespace setVariable [_variableName, true, true];
			[(format ["Interaction objective complete: %1 (by %2)", _variableName, name _caller])] call reapercrew_common_fnc_remoteLog;
		},
		{},
		[_completionVariable],
		_actionDuration,
		0,
		true,
		false
	] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
} forEach _syncedObjects;

[(format ["Interaction Objective initialised — variable: %1, objects: %2, text: %3, duration: %4s", _completionVariable, count _syncedObjects, _actionText, _actionDuration])] call reapercrew_common_fnc_remoteLog;
