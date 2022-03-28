

/*
* Author: Xeenenta
* Garrisons the nearby buildings
*
* Arguments:
* 0: Max Count <NUMBER>
* 1: Area <ARRAY>
* 2: Troop Arrays <ARRAY>
* 3: Code on spawn <STRING>
*
* Return Value:
* None
*
* Example:
* [50, [[0,0,0],0,0], [], "true"] call reapercrew_ai_mechanics_fnc_activateGarrisonModule
*
* Public: No
*/

// Variables
params ["_maxCount", "_logic", "_logicAreaData", "_troopArrays", "_codeOnSpawn", "_groupSide"];

// Extract Position data
_logicPosition = getPos _logic;

_logicRadiusA = _logicAreaData select 0;
_logicRadiusB = _logicAreaData select 1;
_logicAngle = _logicAreaData select 2;
_logicIsRectangle = _logicAreaData select 3;
_logicRadiusC = _logicAreaData select 4;

_logicPosition3D = [(getPos _logic), _logicRadiusA, _logicRadiusB, _logicAngle, _logicIsRectangle, _logicRadiusC];

// Get a list of buildings with both radius
_buildingsData = [];

{

	_buildingsData = [_logicPosition, _x, true, false] call lambs_main_fnc_findBuildings;
	_buildingsData = _buildingsData select { (random 1 > 0.5) || {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 6]]}};
	if (_logicPosition3D isNotEqualTo []) then {
		_buildingsData = _buildingsData select { _x inArea _logicPosition3D };
	};

} forEach [_logicRadiusA, _logicRadiusB];

// Filter for unique values
_buildingsListUnique = [];
{
	_buildingsListUnique pushBackUnique _x;
} forEach _buildingsData;

// Call spawn script
[[_logicPosition, _buildingsListUnique, _maxCount, _troopArrays, _codeOnSpawn, _groupSide], "reapercrew_ai_mechanics_fnc_remoteGarrisonSpawn"] call reapercrew_common_fnc_executeDistributed;


