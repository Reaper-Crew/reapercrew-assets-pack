/*
 * Author: Xeenenta
 * Causes a static turret to scan a radius in front of them
 *
 * Arguments:
 * 0: Logic <LOGIC>
 * 1: 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call reaperCrew_Func_scanAreaModuleInit
 *
 * Public: No
 */

params ["_logic"];

diag_log "SCAN AREA: Initialising";

// Variables
_units = [];

diag_log "SCAN AREA: Checking for attached units";
// Check to see if the module was attached
_attachedObject = attachedTo _logic;
if (!isNull _attachedObject) then {
	diag_log "SCAN AREA: Found attached unit";
	_units pushBack _attachedObject;
};

diag_log "SCAN AREA: Checking for synchronised units";
// Check to see if the module has syncronised units
_syncObjects = synchronizedObjects _logic;
// Check if the array is empty
if (count _syncObjects > 0) then {
	// If not empty, push all of the sync units into the _units array
	{
		_units pushBack _x;
	} forEach _syncObjects;
};

diag_log "SCAN AREA: Checking _units array element count";
// Check that the array of units isn't empty
if (count _units == 0) exitWith {
	diag_log "SCAN AREA: No units assigned, exiting";
};

_unit = _units select 0;

diag_log format ["SCAN AREA: Affected Units: %1", _units ];

[_unit] spawn {

	params ["_unit", "_unitDir"];

	_counter = 0;
	_positionValue = [];
	_positionsArray = [];
	_unitDirLower = (getDir _unit) - 45;
	_currentDirection = 0;

	{
		_currentDirection = _unitDirLower + (5 * _x);
		diag_log format ["SCAN AREA: Direction: %1", _currentDirection ];
		_positionValue = _unit getRelPos [100, _currentDirection];
		_positionsArray pushBack (_positionValue);
	} forEach [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1];

	diag_log format ["SCAN AREA: Position Array: %1", _positionsArray ];

	while {alive _unit} do {
		{
			_unit lookAt _x;
			sleep 0.2;
		} forEach _positionsArray;
	};

diag_log "SCAN AREA: Finished";

};