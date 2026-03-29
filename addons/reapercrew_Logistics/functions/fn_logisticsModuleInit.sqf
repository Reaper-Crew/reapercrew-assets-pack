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

["Checking for attached units"] call reapercrew_common_fnc_remoteLog;
// Check to see if the module was attached
_attachedObject = attachedTo _logic;
if (!isNull _attachedObject) then {
	["Found attached unit"] call reapercrew_common_fnc_remoteLog;
	_units pushBack _attachedObject;
};

["Checking for synchronised units"] call reapercrew_common_fnc_remoteLog;
// Check to see if the module has syncronised units
_syncObjects = synchronizedObjects _logic;
// Check if the array is empty
if (count _syncObjects > 0) then {
	// If not empty, push all of the sync units into the _units array
	{
		_units pushBack _x;
	} forEach _syncObjects;
};

["Checking _units array element count"] call reapercrew_common_fnc_remoteLog;
// Check that the array of units isn't empty
if (count _units == 0) exitWith {
	["No units assigned, exiting"] call reapercrew_common_fnc_remoteLog;
};

[(format ["Affected Units: %1", _units])] call reapercrew_common_fnc_remoteLog;

{
	[_x] call reapercrew_logistics_fnc_logisticsAddActions;
} forEach _units;