/*
* Author: Xeenenta
* Adds event handlers to notify patients when they are being treated.
* Displays a flashing message on the patient's screen for the duration
* of the treatment. Runs as postInit on each client.
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_player_management_fnc_initTreatmentNotification
*
* Public: No
*/

if (!hasInterface) exitWith {};

// Listen for treatment starting on this machine (we are the medic)
["ace_treatmentStarted", {
	params ["_medic", "_patient", "_bodyPart", "_classname"];

	// Only notify if treating someone else
	if (_medic isEqualTo _patient) exitWith {};

	// Get the medic's name and send notification to the patient
	private _medicName = [_medic, false, true] call ace_common_fnc_getName;
	[_medicName] remoteExec ["reapercrew_player_management_fnc_showTreatmentNotification", _patient];
}] call CBA_fnc_addEventHandler;

// Listen for treatment ending (success or failure) on this machine
["ace_treatmentSucceded", {
	params ["_medic", "_patient"];
	if (_medic isEqualTo _patient) exitWith {};
	[false] remoteExec ["reapercrew_player_management_fnc_showTreatmentNotification", _patient];
}] call CBA_fnc_addEventHandler;

["ace_treatmentFailed", {
	params ["_medic", "_patient"];
	if (_medic isEqualTo _patient) exitWith {};
	[false] remoteExec ["reapercrew_player_management_fnc_showTreatmentNotification", _patient];
}] call CBA_fnc_addEventHandler;
