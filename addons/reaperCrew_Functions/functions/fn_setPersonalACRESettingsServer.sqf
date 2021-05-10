/*
 * Author: Xeenenta
 * Configures the PRR based on the players group
 *
 * Arguments:
 * 0: 
 * 1: 
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call reaperCrew_fnc_setPersonalACRESettingsServer
 *
 * Public: No
 */

// Only run this on a server
if (isServer) then {
	diag_log "[Reaper Crew]: Starting JIP ACRE auto-configuation";
	[] remoteExec ["reaperCrew_fnc_setPersonalACRESettingsLocal", 0, true];
};

