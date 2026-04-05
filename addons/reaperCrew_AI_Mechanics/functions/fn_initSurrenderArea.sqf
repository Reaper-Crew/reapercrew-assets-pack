/*
 * Author: Xeenenta
 * Initialises the Surrender Area module. Creates a trigger in the module's area
 * that causes synchronised AI units to surrender via ACE when players enter.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call reapercrew_ai_mechanics_fnc_initSurrenderArea
 *
 * Public: No
 */

_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

// Read module area and attributes
_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];
_additionalCondition = _logic getVariable ["reaperCrew_moduleSurrenderArea_activationCode", "true"];
_surrenderDelay = _logic getVariable ["reaperCrew_moduleSurrenderArea_surrenderDelay", 5];
_surrenderStagger = _logic getVariable ["reaperCrew_moduleSurrenderArea_surrenderStagger", 1];
_dropWeapons = _logic getVariable ["reaperCrew_moduleSurrenderArea_dropWeapons", false];
_ejectFromVehicles = _logic getVariable ["reaperCrew_moduleSurrenderArea_ejectFromVehicles", true];

if (!isServer) exitWith {
	["reapercrew_ai_mechanics_fnc_initSurrenderArea", "Server check failed - Not running surrender init"] call reapercrew_common_fnc_remoteLog;
};

// Get synced AI units
_syncedUnits = synchronizedObjects _logic;

if (_syncedUnits isEqualTo []) exitWith {
	["reapercrew_ai_mechanics_fnc_initSurrenderArea", "WARNING: No units synchronised to Surrender Area module"] call reapercrew_common_fnc_remoteLog;
};

// Create a trigger matching the module's area (non-repeating, surrender is one-shot)
_activationTrigger = createTrigger ["EmptyDetector", (getPos _logic), false];
_activationTrigger setTriggerArea [_logicArea select 0, _logicArea select 1, 0, false, _logicArea select 2];
_activationTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];

// Trigger fires when players on foot are present and additional condition is met
_triggerCondition = format ["(this && {isTouchingGround _x} count thisList > 0) && %1", _additionalCondition];
_activationTrigger setTriggerStatements [_triggerCondition, "[thisTrigger] spawn reapercrew_ai_mechanics_fnc_activateSurrenderArea;", ""];

// Store configuration on the trigger for the activation function
_activationTrigger setVariable ["_syncedUnits", _syncedUnits];
_activationTrigger setVariable ["_surrenderDelay", _surrenderDelay];
_activationTrigger setVariable ["_surrenderStagger", _surrenderStagger];
_activationTrigger setVariable ["_dropWeapons", _dropWeapons];
_activationTrigger setVariable ["_ejectFromVehicles", _ejectFromVehicles];

["reapercrew_ai_mechanics_fnc_initSurrenderArea", format ["Surrender Area initialised with %1 synced units", count _syncedUnits]] call reapercrew_common_fnc_remoteLog;
