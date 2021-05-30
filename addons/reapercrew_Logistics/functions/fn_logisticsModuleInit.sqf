/*
 * Author: Xeenenta
 * Runs the logisticsAddActions function against attached/synchornised units
 *
 * Arguments:
 * 0: Logic <LOGIC>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call reapercrew_logistics_fnc_logisticsModuleInit
 *
 * Public: No
 */

params ["_logic"];

// Variables
_units = [];

diag_log "RESUPPLY POINT: Checking for attached units";
// Check to see if the module was attached
_attachedObject = attachedTo _logic;
if (!isNull _attachedObject) then {
	diag_log "RESUPPLY POINT: Found attached unit";
	_units pushBack _attachedObject;
};

diag_log "RESUPPLY POINT: Checking for synchronised units";
// Check to see if the module has syncronised units
_syncObjects = synchronizedObjects _logic;
// Check if the array is empty
if (count _syncObjects > 0) then {
	// If not empty, push all of the sync units into the _units array
	{
		_units pushBack _x;
	} forEach _syncObjects;
};

diag_log "RESUPPLY POINT: Checking _units array element count";
// Check that the array of units isn't empty
if (count _units == 0) exitWith {
	diag_log "RESUPPLY POINT: No units assigned, exiting";
};

diag_log format ["RESUPPLY POINT: Affected Units: %1", _units ];

{
	[_x] call reapercrew_logistics_fnc_logisticsAddActions;
} forEach _units;