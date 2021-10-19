/*
 * Author: Xeenenta
 * This function is run during the init phase of the Helicopter reinforcements module and should setup the necessary triggers in order to start the reinforcements process.
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call reapercrew_reinforcements_fnc_moduleSpawnReinforcementsAirbourneInit
 *
 * Public: No
 */

// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

_randomTrigger = objNull;
_reinforcementsCount = _logic getVariable ["reinforcementCount",50];
_zoneThreshold = _logic getVariable ["zoneThreshold",20];
_directionMin = _logic getVariable ["directionMin",90];
_directionMax = _logic getVariable ["directionMax",180];
_distanceMin = _logic getVariable ["distanceMin",500];
_distanceMax = _logic getVariable ["distanceMax",800];

_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];
_logicArea2D = [getPos _logic, _logicArea select 0, _logicArea select 1];

// Create a trigger
_activationTrigger = createTrigger ["EmptyDetector", (getPos _logic), false];
_activationTrigger setTriggerArea [_logicArea select 0, _logicArea select 1, 0, false, -1];
_activationTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];

// Assign required variable to trigger
_activationTrigger setVariable ["reinforcementCount", _reinforcementsCount];
_activationTrigger setVariable ["zoneThreshold", _zoneThreshold];
_activationTrigger setVariable ["directionMin", _directionMin];
_activationTrigger setVariable ["directionMax", _directionMax];
_activationTrigger setVariable ["distanceMin", _distanceMin];
_activationTrigger setVariable ["distanceMax", _distanceMax];

_activationTrigger setTriggerStatements ["(this && {isTouchingGround _x} count thisList > 0)", "[thisTrigger] spawn reapercrew_reinforcements_fnc_moduleSpawnReinforcementsAirbourneTrigger;", "diag_log 'SCENARIO: The trigger has been deactivated'"];

