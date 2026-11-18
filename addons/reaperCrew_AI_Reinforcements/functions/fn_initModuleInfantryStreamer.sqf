/*
 * Author: Xeenenta
 * Initialises a streamer module. Reads attributes, builds troop arrays, and creates a one-shot activation trigger.
 *
 * Arguments:
 * 0: _logic <OBJECT> - Module logic object
 *
 * Return Value:
 * None
 *
 * Example:
 * [logic] call reapercrew_reinforcements_fnc_initModuleInfantryStreamer
 *
 * Public: No
 */

params [["_logic", objNull, [objNull]]];

// Get variables
_unitCount = _logic getVariable ["unitCount", 10];
_spawnInterval = _logic getVariable ["spawnInterval", 2];
_useRegularTroops = _logic getVariable ["regularTroops", true];
_useEliteTroops = _logic getVariable ["eliteTroops", false];
_useSpecialForces = _logic getVariable ["specialTroops", false];
_rushMode = _logic getVariable ["rushMode", true];
_codeOnSpawn = _logic getVariable ["codeOnSpawn", "true"];
_additionalCondition = _logic getVariable ["additionalCondition", "true"];
_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];

// Build array of available troop categories as [classnames, skill] pairs
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

if (_troopsArrays isEqualTo []) exitWith {
	["Streamer module has no troop category ticked, not initialised"] call reapercrew_common_fnc_remoteLog;
};

_spawnPos = getPosATL _logic;
_rushRadius = ((_logicArea select 0) max (_logicArea select 1)) * 1.5;

// Create trigger
_activationTrigger = createTrigger ["EmptyDetector", _spawnPos, false];
_activationTrigger setTriggerArea [_logicArea select 0, _logicArea select 1, _logicArea param [2, 0], _logicArea param [3, false], -1];
_activationTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_activationTrigger setTriggerInterval 5;

// Set trigger variables
_activationTrigger setVariable ["troopArrays", _troopsArrays];
_activationTrigger setVariable ["unitCount", _unitCount];
_activationTrigger setVariable ["spawnInterval", _spawnInterval];
_activationTrigger setVariable ["rushMode", _rushMode];
_activationTrigger setVariable ["codeOnSpawn", _codeOnSpawn];
_activationTrigger setVariable ["spawnPos", _spawnPos];
_activationTrigger setVariable ["rushRadius", _rushRadius];
_activationTrigger setVariable ["moduleObject", _logic];
_logic setVariable ["activationTrigger", _activationTrigger];

_triggerCondition = format ["(this && {isTouchingGround _x} count thisList > 0) && %1", _additionalCondition];

_activationTrigger setTriggerStatements [_triggerCondition, "[thisTrigger] call reapercrew_reinforcements_fnc_activateInfantryModuleStreamer;", ""];

["Initialised streamer module"] call reapercrew_common_fnc_remoteLog;
