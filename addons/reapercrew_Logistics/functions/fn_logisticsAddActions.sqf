/*
 * Author: Xeenenta
 * Adds the create actions to the passed object
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call reapercrew_logistics_fnc_logisticsAddActions
 *
 * Public: No
 */

params ["_resupplyObject"];

_actionsList = [];

// Section Crate
_crateAction = ['Spawn Section Crate','Spawn Section Crate','', { 
	["Spawning crate...", 5, {true}, {
		_recievedParams = _this select 0;
		_target = _recievedParams select 0;
		_type = _recievedParams select 1;
		[_target, _type, player] remoteExec ["reapercrew_logistics_fnc_logisticsCreateSupplyCrate", 2];
	}, {}, [_target, "smallArms"]] call CBA_fnc_progressBar;
},{true}] call ace_interact_menu_fnc_createAction;
_actionsList pushBack _crateAction;

// Medical Crate
_crateAction = ['Spawn Medical Crate','Spawn Medical Crate','', { 
	["Spawning crate...", 5, {true}, {
		_recievedParams = _this select 0;
		_target = _recievedParams select 0;
		_type = _recievedParams select 1;
		[_target, _type, player] remoteExec ["reapercrew_logistics_fnc_logisticsCreateSupplyCrate", 2]
	}, {}, [_target, "medical"]] call CBA_fnc_progressBar; 
},{true}] call ace_interact_menu_fnc_createAction;
_actionsList pushBack _crateAction;

// Indirect Fires Crate
if (reaperCrew_IDFCrate == true) then {
	_crateAction = ['Spawn IDF Crate','Spawn IDF Crate','', { 
		["Spawning crate...", 5, {true}, {
			_recievedParams = _this select 0;
			_target = _recievedParams select 0;
			_type = _recievedParams select 1;
			[_target, _type, player] remoteExec ["reapercrew_logistics_fnc_logisticsCreateSupplyCrate", 2]
		}, {}, [_target, "indirectFires"]] call CBA_fnc_progressBar; 
	},{true}] call ace_interact_menu_fnc_createAction;
	_actionsList pushBack _crateAction;
};

if (reaperCrew_VehicleFuelCheckbox == true) then {
	_crateAction = ['Spawn Vehicle Fuel Crate','Spawn Vehicle Fuel Crate','', { 
		["Spawning crate...", 5, {true}, {
			_recievedParams = _this select 0;
			_target = _recievedParams select 0;
			_type = _recievedParams select 1;
			[_target, _type, player] remoteExec ["reapercrew_logistics_fnc_logisticsCreateSupplyCrate", 2]
		}, {}, [_target, "vehicleFuel"]] call CBA_fnc_progressBar; 
	},{true}] call ace_interact_menu_fnc_createAction;
	_actionsList pushBack _crateAction;
};

if (reaperCrew_VehicleAmmoCheckbox == true) then {
	_crateAction = ['Spawn Vehicle Ammo Crate','Spawn Vehicle Ammo Crate','', { 
		["Spawning crate...", 5, {true}, {
			_recievedParams = _this select 0;
			_target = _recievedParams select 0;
			_type = _recievedParams select 1;
			[_target, _type, player] remoteExec ["reapercrew_logistics_fnc_logisticsCreateSupplyCrate", 2]
		}, {}, [_target, "vehicleAmmo"]] call CBA_fnc_progressBar; 
	},{true}] call ace_interact_menu_fnc_createAction;
	_actionsList pushBack _crateAction;
};

if (reaperCrew_transportCheckbox == true) then {
	_crateAction = ['Spawn Transport Crate','Spawn Transport Crate','', { 
		["Spawning crate...", 5, {true}, {
			_recievedParams = _this select 0;
			_target = _recievedParams select 0;
			_type = _recievedParams select 1;
			[_target, _type, player] remoteExec ["reapercrew_logistics_fnc_logisticsCreateSupplyCrate", 2]
		}, {}, [_target, "emptyTransport"]] call CBA_fnc_progressBar; 
	},{true}] call ace_interact_menu_fnc_createAction;
	_actionsList pushBack _crateAction;
};

// Add actions to object
{
	[_resupplyObject, 0, ["ACE_MainActions"], _x] call ace_interact_menu_fnc_addActionToObject;
} forEach _actionsList;