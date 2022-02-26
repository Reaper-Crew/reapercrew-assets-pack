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
 * [_logic] call reapercrew_reinforcements_fnc_initModuleInfantryAirbourne
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
_useRegularTroops = _logic getVariable ["regularTroops",true];
_useEliteTroops = _logic getVariable ["eliteTroops",false];
_useSpecialForces = _logic getVariable ["specialTroops",false];
_rushMode = _logic getVariable ["rushMode",false];
_codeOnSpawnGroup = _logic getVariable ["codeOnSpawnGroup",""];
_waveDelay = _logic getVariable ["waveDelay",60];

_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];
_logicArea2D = [getPos _logic, _logicArea select 0, _logicArea select 1];

// Build array of available squads
_troopsArrays = [];
if (_useRegularTroops) then {
	_troopsArrays pushBack [(reaperCrew_reinforcements_regularTroops splitString ","), reaperCrew_reinforcements_regularTroopsDifficulty];
};
if (_useEliteTroops) then {
	_troopsArrays pushBack [(reaperCrew_reinforcements_eliteTroops splitString ","), reaperCrew_reinforcements_eliteTroopsDifficulty];
};
if (_useSpecialForces) then {
	_troopsArrays pushBack [(reaperCrew_reinforcements_specialForces splitString ","), reaperCrew_reinforcements_specialForcesDifficulty];
};

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
_activationTrigger setVariable ["troopArrays", _troopsArrays];
_activationTrigger setVariable ["rushMode", _rushMode];
_activationTrigger setVariable ["codeOnSpawnGroup", _codeOnSpawnGroup];
_activationTrigger setVariable ["waveDelay", _waveDelay];

_activationTrigger setTriggerStatements ["(this && {isTouchingGround _x} count thisList > 0)", "[thisTrigger] spawn reapercrew_reinforcements_fnc_activateInfantryModuleMotorised;", "diag_log 'SCENARIO: The trigger has been deactivated'"];

