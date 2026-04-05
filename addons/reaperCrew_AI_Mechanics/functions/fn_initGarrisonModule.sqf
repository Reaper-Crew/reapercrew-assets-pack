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
if (!isServer) exitWith {["Server checked failed - Not running garrison init"] call reapercrew_common_fnc_remoteLog};

// Get logic variables
_maxCount = _logic getVariable ["maxCount",50];
_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];
_logicArea2D = [getPos _logic, _logicArea select 0, _logicArea select 1];
_useRegularTroops = _logic getVariable ["regularTroops",true];
_useEliteTroops = _logic getVariable ["eliteTroops",false];
_useSpecialForces = _logic getVariable ["specialTroops",false];
_codeOnSpawnGroup = _logic getVariable ["codeOnSpawnGroup",""];
_minUnitsPerBuilding = _logic getVariable ["minUnitsPerBuilding", 4];
_maxUnitsPerBuilding = _logic getVariable ["maxUnitsPerBuilding", 10];
_minPositionDistance = _logic getVariable ["minPositionDistance", 3];

// Build array of available squads as [classnames, skill] pairs
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

// Wait for a synchronised trigger to activate (if one exists)
_syncedTrigger = (synchronizedObjects _logic) select {_x isKindOf "EmptyDetector"};
if (count _syncedTrigger > 0) then {
	_syncedTrigger = _syncedTrigger select 0;
	waitUntil {sleep 5; triggerActivated _syncedTrigger};
};

// Call activate function
[
  _maxCount,
  _logic,
  _logicArea,
  _troopsArrays,
  _codeOnSpawnGroup,
  reaperCrew_reinforcements_side,
  _minUnitsPerBuilding,
  _maxUnitsPerBuilding,
  _minPositionDistance
] call reapercrew_ai_mechanics_fnc_activateGarrisonModule;
