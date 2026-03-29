/*
 * Author: Xeenenta
 * Initialises the Ambient CAS module. Reads attributes from the module and creates
 * a player-activated trigger that spawns the strike loop when players enter the area.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call reapercrew_ambience_fnc_initAmbientCAS
 *
 * Public: No
 */

_logic = param [0, objNull, [objNull]];

if (!isServer) exitWith {
	["Server check failed - not running ambient CAS init"] call reapercrew_common_fnc_remoteLog;
};

// Read module attributes
private _aircraftClass = _logic getVariable ["aircraftClass", "B_Plane_CAS_01_F"];
private _strikeType = _logic getVariable ["strikeType", 1];
private _strikeDir = _logic getVariable ["strikeDir", 0];
private _proximityEnabled = _logic getVariable ["proximityEnabled", true];
private _proximityRange = _logic getVariable ["proximityRange", 2000];
private _avoidPlayers = _logic getVariable ["avoidPlayers", false];
private _avoidRadius = _logic getVariable ["avoidRadius", 500];
private _delayMin = _logic getVariable ["delayMin", 30];
private _delayMax = _logic getVariable ["delayMax", 180];

private _logicArea = _logic getVariable ["objectarea", [500, 500, 0, false, -1]];

// Create trigger matching the module's area
private _activationTrigger = createTrigger ["EmptyDetector", getPos _logic, false];
_activationTrigger setTriggerArea [_logicArea select 0, _logicArea select 1, 0, false, -1];
_activationTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_activationTrigger setTriggerInterval 5;

// Pass all configuration to the trigger
_activationTrigger setVariable ["aircraftClass", _aircraftClass];
_activationTrigger setVariable ["strikeType", _strikeType];
_activationTrigger setVariable ["strikeDir", _strikeDir];
_activationTrigger setVariable ["proximityEnabled", _proximityEnabled];
_activationTrigger setVariable ["proximityRange", _proximityRange];
_activationTrigger setVariable ["avoidPlayers", _avoidPlayers];
_activationTrigger setVariable ["avoidRadius", _avoidRadius];
_activationTrigger setVariable ["delayMin", _delayMin];
_activationTrigger setVariable ["delayMax", _delayMax];

// Activate the strike loop when players enter; guard against re-entry
_activationTrigger setTriggerStatements [
	"this && {isNil {thisTrigger getVariable 'cas_active'}}",
	"thisTrigger setVariable ['cas_active', true]; [thisTrigger] spawn reapercrew_ambience_fnc_activateAmbientCAS;",
	"thisTrigger setVariable ['cas_active', nil];"
];
