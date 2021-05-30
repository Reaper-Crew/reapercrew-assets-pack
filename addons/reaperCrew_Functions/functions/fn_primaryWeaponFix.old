/*
 * Author: Xeenenta
 * Removes a units binoculars and forces them to equipment their primary weapon. This is designed as a workaround for some irritating AI behavior. 
 *
 * Arguments:
 * 0: Logic <LOGIC>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call reaperCrew_fnc_primaryWeaponFix
 *
 * Public: No
 */

params ["_logic"];

// Variables
_units = [];

diag_log "[Reaper Crew - Weapons Fix]: Checking for attached units";
// Check to see if the module was attached
_attachedObject = attachedTo _logic;
if (!isNull _attachedObject) then {
	diag_log "[Reaper Crew - Weapons Fix]: Found attached unit";
	_units pushBack _attachedObject;
};

if (local _attachedObject) then {
	removeAllBinocularItems _attachedObject;
	_attachedObject selectWeapon (primaryWeapon _attachedObject);
}

deleteVehicle _logic;