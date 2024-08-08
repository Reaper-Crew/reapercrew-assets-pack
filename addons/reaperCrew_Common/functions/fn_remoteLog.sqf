/*
* Author: Xeenenta
* A function used to log remote output
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_common_fnc_remoteLog
*
* Public: No
*/

params ["_logMessage"];

_name = "";
if (name player == "") then {
	_name = "SERVER";
} else {
	_name = name player;
};

call BIS_fnc_log;

// Determine the message
_fullMessage = format ["[%1](%2): %3", _fnc_scriptNameParent, _name, _logMessage];

// If isMultiplayer == false then we are local, put the output to systemChat
if (isMultiplayer == false) then {
	systemChat _fullMessage;
};

// Always log to server rpt
[_fullMessage] remoteExec ["diag_log", 2];

// If isMultiplayer == true and hasInterface == true, then we are a client in MP, send log to central server
// If isMultiplayer == true and isDedicated == true, then we are the server, so just log it locally





