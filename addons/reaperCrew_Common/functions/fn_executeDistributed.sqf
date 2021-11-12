/*
 * Author: Xeenenta
 * This function will execute a request on a random headless client if available, or the server in the event that one is not available.
 *
 * Arguments:
 * 0: An array of parameters to be passed to the function <ARRAY>
 * 1: The name of the function to be executed, in string form <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [["test"], "hint"] call reapercrew_common_fnc_executeDistributed;
 *
 * Public: No
 */

params ["_callParams", "_functionName"];

// Check if HC is available
if (count HeadlessClients > 0) then {
	//If yes, execute on random HC
	_selectedClient = selectRandom HeadlessClients;
	_callParams remoteExecCall [_functionName, _selectedClient];
	if (reaperCrew_ReinforcementsCheckbox == true) then {
		diag_log format ["SCENARIO: Headless client is available, sending request to %1", _selectedClient];
	};
} else {
	//If no, execute on server
	_callParams remoteExecCall [_functionName, 2];
	if (reaperCrew_ReinforcementsCheckbox == true) then {
		diag_log "SCENARIO: No headless clients available, executing request on server";
	};
};
