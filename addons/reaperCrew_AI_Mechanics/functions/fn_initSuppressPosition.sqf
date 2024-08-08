/*
* Author: Xeenenta
* Suppress random players within a position
*
* Arguments:
* 0: Logic <LOGIC>
* 1: 
*
* Return Value:
* None
*
* Example:
* [_logic] call reapercrew_ai_mechanics_fnc_initSuppressPosition
*
* Public: No
*/

// Variables
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];
_logicArea2D = [getPos _logic, _logicArea select 0, _logicArea select 1];
_additionalCondition = _logic getVariable ["ActivationCode", "true"];

// Only run on the server
if (!isServer) exitWith {["Server check failed - Not running suppress init"] call reapercrew_common_fnc_remoteLog;};

// Create a trigger
_activationTrigger = createTrigger ["EmptyDetector", (getPos _logic), false];
_activationTrigger setTriggerArea [_logicArea select 0, _logicArea select 1, 0, false, _logicArea select 2];
_activationTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];

_triggerCondition = format ["(this && {isTouchingGround _x} count thisList > 0) && %1", _additionalCondition];
_activationTrigger setTriggerStatements [_triggerCondition, "[thisTrigger] call reapercrew_ai_mechanics_fnc_activateSuppressPosition;", ""];

_activationTrigger setVariable ["_syncGunners", (synchronizedObjects _logic)];






