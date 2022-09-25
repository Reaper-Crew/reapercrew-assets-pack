/*
* Author: Xeenenta
* This function will execute a function on the remote client to reset their fatigue status
*
* Arguments:
* 0: Attached Player <OBJECT>
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_player_management_fnc_fixPlayerFatigueGlobal
*
* Public: No
*/

params ["_logic"];

// Only run on the server
if (!isServer) exitWith { diag_log "[PLAYER MANAGEMENT]: Failed server check - exiting"; };

// Variables
_units = [];

diag_log "[PLAYER MANAGEMENT]: Checking for attached units";
// Check to see if the module was attached
_attachedObject = attachedTo _logic;
if (!isNull _attachedObject) then {
	diag_log "[PLAYER MANAGEMENT]: Found attached unit";
	_units pushBack _attachedObject;
};

// Check that the array of units isn't empty
if (count _units == 0) exitWith {
	diag_log "[PLAYER MANAGEMENT]: No units assigned, exiting";
};

{
	diag_log format ["[PLAYER MANAGEMENT]: Executing fatigue fix script on %1", name(_x)];
	remoteExec ["reapercrew_player_management_fnc_fixPlayerFatigueLocal", _x];
} forEach _units;

deleteVehicle _logic;