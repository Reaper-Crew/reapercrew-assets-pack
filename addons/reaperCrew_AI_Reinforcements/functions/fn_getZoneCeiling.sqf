/*
* Author: Xeenenta
* Calculates the effective zone ceiling based on the configured mode.
* In CEILING mode, returns the static ceiling value. In RATIO_CEILING mode,
* returns the ratio multiplied by player count, capped at the ceiling.
*
* Arguments:
* 0: Zone Ceiling <NUMBER> - Hard maximum AI count
* 1: Zone Ratio <NUMBER> - AI per player multiplier
* 2: Zone Limit Mode <STRING> - "CEILING" or "RATIO_CEILING"
* 3: Trigger Object <OBJECT>
*
* Return Value:
* Effective zone ceiling <NUMBER>
*
* Example:
* [20, 3, "CEILING", _triggerObject] call reapercrew_reinforcements_fnc_getZoneCeiling
*
* Public: No
*/

params ["_zoneCeiling", "_zoneRatio", "_zoneLimitMode", "_triggerObject"];

// reaperCrew_debugOverrideRatio: set in init.sqf to force ratio modules to use ceiling mode
if (_zoneLimitMode == "RATIO_CEILING" && {!( missionNamespace getVariable ["reaperCrew_debugOverrideRatio", false])}) then {
	private _playerCount = count ((allPlayers - entities "HeadlessClient_F") inAreaArray _triggerObject);
	(ceil (_zoneRatio * _playerCount)) min _zoneCeiling
} else {
	if (_zoneLimitMode == "RATIO_CEILING") then {
		["DEBUG: Ratio override active, using ceiling value of %1", _zoneCeiling] call reapercrew_common_fnc_remoteLog;
	};
	_zoneCeiling
};
