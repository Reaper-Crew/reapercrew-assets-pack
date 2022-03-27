/*
* Author: Xeenenta
* Garrisons the nearby buildings
*
* Arguments:
* 0: Logic <LOGIC>
* 1: 
*
* Return Value:
* None
*
* Example:
* [_logic] call reapercrew_ai_mechanics_fnc_initGarrisonModule
*
* Public: No
*/

// Variables
params ["_logic"];

// Only run on the server
if (!isServer) exitWith {diag_log "[GARRISON]: Server checked failed - Not running garrison init"};

// Get logic variables
_maxCount = _logic getVariable ["maxCount",50];
_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];
_logicArea2D = [getPos _logic, _logicArea select 0, _logicArea select 1];
_useRegularTroops = _logic getVariable ["regularTroops",true];
_useEliteTroops = _logic getVariable ["eliteTroops",false];
_useSpecialForces = _logic getVariable ["specialTroops",false];
_codeOnSpawnGroup = _logic getVariable ["codeOnSpawnGroup",""];

// Build array of available squads
_troopsArrays = [];

if (_useRegularTroops) then {
	_troopsArrays append (reaperCrew_reinforcements_regularTroops splitString ",");
};
if (_useEliteTroops) then {
  _troopsArrays append (reaperCrew_reinforcements_eliteTroops splitString ",");
};
if (_useSpecialForces) then {
  _troopsArrays append (reaperCrew_reinforcements_specialForces splitString ",");
};

// Call activate function
[
  _maxCount,
  _logic,
  _logicArea,
  _troopsArrays,
  _codeOnSpawnGroup
] call reapercrew_ai_mechanics_fnc_activateGarrisonModule;