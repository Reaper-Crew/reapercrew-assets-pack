/*
* Author: Xeenenta
* Shows or hides a flashing treatment notification on the patient's screen.
* Called with a medic name to start, or false to stop.
*
* Arguments:
* 0: Medic Name <STRING> or <BOOL> false to stop
*
* Return Value:
* None
*
* Example:
* ["Sgt. Smith"] call reapercrew_player_management_fnc_showTreatmentNotification
* [false] call reapercrew_player_management_fnc_showTreatmentNotification
*
* Public: No
*/

params ["_nameOrStop"];

// Stop notification
if (_nameOrStop isEqualType false) exitWith {
	missionNamespace setVariable ["reaperCrew_treatmentActive", false];
};

// Start notification
private _medicName = _nameOrStop;
missionNamespace setVariable ["reaperCrew_treatmentActive", true];

// Don't stack multiple notification loops
if (!isNil "reaperCrew_treatmentNotificationRunning" && {reaperCrew_treatmentNotificationRunning}) exitWith {
	missionNamespace setVariable ["reaperCrew_treatmentMedicName", _medicName];
};

missionNamespace setVariable ["reaperCrew_treatmentNotificationRunning", true];
missionNamespace setVariable ["reaperCrew_treatmentMedicName", _medicName];

// Create a layer for the notification
private _layer = "reaperCrew_treatmentLayer" call BIS_fnc_rscLayer;

[] spawn {
	private _fadeIn = true;
	disableSerialization;

	while {missionNamespace getVariable ["reaperCrew_treatmentActive", false] && {alive player}} do {
		private _medicName = missionNamespace getVariable ["reaperCrew_treatmentMedicName", ""];
		private _text = format ["<t size='1.4' color='#ffffff' align='center' shadow='2'>%1 is treating you</t>", _medicName];
		private _alpha = if (_fadeIn) then { 1 } else { 0.3 };

		("reaperCrew_treatmentLayer" call BIS_fnc_rscLayer) cutRsc ["RscDynamicText", "PLAIN", -1, false];

		private _display = uiNamespace getVariable ["BIS_dynamicText", displayNull];
		if (!isNull _display) then {
			private _ctrl = _display displayCtrl 9999;
			_ctrl ctrlSetStructuredText parseText _text;
			_ctrl ctrlSetPosition [
				safeZoneX,
				safeZoneY + safeZoneH * 0.15,
				safeZoneW,
				safeZoneH * 0.1
			];
			_ctrl ctrlSetFade 0;
			_ctrl ctrlCommit 0;
			_ctrl ctrlSetFade (1 - _alpha);
			_ctrl ctrlCommit 0.8;
		};

		_fadeIn = !_fadeIn;
		sleep 0.8;
	};

	// Clean up
	("reaperCrew_treatmentLayer" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
	missionNamespace setVariable ["reaperCrew_treatmentNotificationRunning", false];
};
