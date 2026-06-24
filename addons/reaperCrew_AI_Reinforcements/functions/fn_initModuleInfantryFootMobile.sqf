/*
 * Author: Xeenenta
 * Initialises a foot mobile infantry module. Reads attributes, builds troop arrays, and creates an activation trigger.
 *
 * Arguments:
 * 0: _logic <OBJECT> - Module logic object
 *
 * Return Value:
 * None
 *
 * Example:
 * [logic] call reapercrew_reinforcements_fnc_initModuleInfantryFootMobile
 *
 * Public: No
 */

// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

// Don't run if the array isn't available
while {isNil "activeInfantryTriggers"} do {
	["Infantry triggers undefined, sleeping"] call reapercrew_common_fnc_remoteLog;
	sleep 60;
};

// Get variables
_reinforcementsCount = _logic getVariable ["reinforcementCount",50];
_zoneCeiling = _logic getVariable ["zoneCeiling",80];
_zoneRatio = _logic getVariable ["zoneRatio",3];
_zoneLimitMode = _logic getVariable ["zoneLimitMode","CEILING"];
_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];
_logicArea2D = [getPos _logic, _logicArea select 0, _logicArea select 1];
_useRegularTroops = _logic getVariable ["regularTroops",true];
_useEliteTroops = _logic getVariable ["eliteTroops",false];
_useSpecialForces = _logic getVariable ["specialTroops",false];
_rushMode = _logic getVariable ["rushMode",false];
_codeOnSpawnGroup = _logic getVariable ["codeOnSpawnGroup",""];
_waveDelay = _logic getVariable ["waveDelay",60];
_additionalCondition = _logic getVariable ["additionalCondition",true];

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

// Create trigger
_activationTrigger = createTrigger ["EmptyDetector", (getPos _logic), false];
_activationTrigger setTriggerArea [_logicArea select 0, _logicArea select 1, 0, false, -1];
_activationTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_activationTrigger setTriggerInterval 5;

// Set trigger variables
_activationTrigger setVariable ["troopArrays", _troopsArrays];
_activationTrigger setVariable ["reinforcementCount", _reinforcementsCount];
_activationTrigger setVariable ["zoneCeiling", _zoneCeiling];
_activationTrigger setVariable ["zoneRatio", _zoneRatio];
_activationTrigger setVariable ["zoneLimitMode", _zoneLimitMode];
_activationTrigger setVariable ["logicArea2D", _logicArea2D];
_activationTrigger setVariable ["rushMode", _rushMode];
_activationTrigger setVariable ["codeOnSpawnGroup", _codeOnSpawnGroup];
_activationTrigger setVariable ["waveDelay", _waveDelay];
_activationTrigger setVariable ["moduleObject", _logic];

// Track units spawned by this module (may be outside the zone) and keep the array pruned of dead/null entries
_logic setVariable ["spawnedUnits", [], true];
[_logic] call reapercrew_reinforcements_fnc_watchSpawnedUnits;

_triggerCondition = format ["(this && {isTouchingGround _x} count thisList > 0) && %1", _additionalCondition];

_activationTrigger setTriggerStatements [_triggerCondition, "[thisTrigger] call reapercrew_reinforcements_fnc_activateInfantryModuleFootMobile;", ""];

["Initialised foot mobile infantry module"] call reapercrew_common_fnc_remoteLog;
