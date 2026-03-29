/*
* Author: Xeenenta
* This function will execute a function on the remote client to save their loadout
*
* Arguments:
* 0: Attached Player <OBJECT>
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_player_management_fnc_savePlayerLoadoutGlobal
*
* Public: No
*/

params ["_logic"];

// Only run on the server
if (!isServer) exitWith { ["Failed server check - exiting"] call reapercrew_common_fnc_remoteLog; };

// Variables
_units = [];

["Checking for attached units"] call reapercrew_common_fnc_remoteLog;
// Check to see if the module was attached
_attachedObject = attachedTo _logic;
if (!isNull _attachedObject) then {
	["Found attached unit"] call reapercrew_common_fnc_remoteLog;
	_units pushBack _attachedObject;
};

// Check that the array of units isn't empty
if (count _units == 0) exitWith {
	["No units assigned, exiting"] call reapercrew_common_fnc_remoteLog;
};

{
	[(format ["Executing save script on %1", name(_x)])] call reapercrew_common_fnc_remoteLog;
	remoteExec ["reapercrew_player_management_fnc_savePlayerLoadoutLocal", _x];
} forEach _units;

deleteVehicle _logic;