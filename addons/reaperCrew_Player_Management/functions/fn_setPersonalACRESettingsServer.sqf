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
 * [] call reapercrew_common_fnc_setPersonalACRESettingsServer
 *
 * Public: No
 */

// Only run this on a server
if (isServer) then {
	diag_log "[Reaper Crew]: Starting JIP ACRE auto-configuation";
	[] remoteExec ["reapercrew_player_management_fnc_setPersonalACRESettingsLocal", 0, true];
};

