/*
* Author: Xeenenta
* Garrisons the nearby buildings
*
* Arguments:
* 0: Max Count <NUMBER>
* 1: Logic <LOGIC>
* 2: Area Data <ARRAY>
* 3: Troop Arrays <ARRAY>
* 4: Code on spawn <STRING>
* 5: Group Side <SIDE>
* 6: Min Units Per Building <NUMBER>
* 7: Max Units Per Building <NUMBER>
* 8: Min Position Distance <NUMBER>
*
* Return Value:
* None
*
* Example:
* [50, _logic, [50,50,0,false,-1], [], "true", east, 4, 10, 3] call reapercrew_ai_mechanics_fnc_activateGarrisonModule
*
* Public: No
*/

// Variables
params ["_maxCount", "_logic", "_logicAreaData", "_troopArrays", "_codeOnSpawn", "_groupSide", "_minPerBuilding", "_maxPerBuilding", "_minDistance"];

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

// Group positions by their parent building
_buildingMap = createHashMap;
{
	_pos = _x;
	_building = nearestBuilding _pos;
	_key = str _building;
	_existing = _buildingMap getOrDefault [_key, []];
	_existing pushBack _pos;
	_buildingMap set [_key, _existing];
} forEach _buildingsListUnique;

// Apply per-building filtering
_buildingGroups = [];
_totalUnits = 0;
{
	_positions = _y;

	// Filter positions that are too close together within this building
	_spacedPositions = [];
	{
		_pos = _x;
		if (_spacedPositions findIf {_pos distance _x < _minDistance} == -1) then {
			_spacedPositions pushBack _pos;
		};
	} forEach _positions;

	_posCount = count _spacedPositions;

	// Skip buildings that don't meet the minimum
	if (_posCount < _minPerBuilding) then {
		continue;
	};

	// Cap to maximum positions per building, randomly selected
	if (_posCount > _maxPerBuilding) then {
		_spacedPositions = _spacedPositions call BIS_fnc_arrayShuffle;
		_spacedPositions = _spacedPositions select [0, _maxPerBuilding];
		_posCount = _maxPerBuilding;
	};

	// Respect the global max unit count
	if ((_totalUnits + _posCount) > _maxCount) then {
		_remaining = _maxCount - _totalUnits;
		if (_remaining < _minPerBuilding) then {
			continue;
		};
		_spacedPositions = _spacedPositions select [0, _remaining];
		_posCount = _remaining;
	};

	_buildingGroups pushBack _spacedPositions;
	_totalUnits = _totalUnits + _posCount;

	// Stop if we've hit the global cap
	if (_totalUnits >= _maxCount) then {
		break;
	};
} forEach _buildingMap;

// Call spawn script for each building, distributing across headless clients. Dispatches are
// staggered so a mid-mission activation doesn't spawn every group in one frame and cause jitter.
{
	[[_logicPosition, _x, _troopArrays, _codeOnSpawn, _groupSide], "reapercrew_ai_mechanics_fnc_remoteGarrisonSpawn"] call reapercrew_common_fnc_executeDistributed;
	sleep 3;
} forEach _buildingGroups;
