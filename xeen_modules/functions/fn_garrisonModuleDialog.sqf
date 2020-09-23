/*
 * Author: Xeenenta
 * Opens the dialog menu for the garrison module
 *
 * Arguments:
 * 0: Logic <LOGIC>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call xeen_fnc_garrisonModuleDialog
 *
 * Public: No
 */

// Parameters
params ["_logic"];

_logicLocation = getPos _logic;

diag_log format ["Spawning display with logic %1", _logicLocation];

// Create display
createDialog "garrisonModuleDialog";
_display = findDisplay 99;

// Set Variable
_display setVariable ["_logicLocation", _logicLocation];

diag_log "Finished spawning display";