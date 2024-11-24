_vehicleClasses = reaperCrew_vehicleResupplyDeliveryClasses splitString ",";
_actionsList = [];

{
	_vehicleDisplayName = (configFile >> "cfgVehicles" >> _x >> "displayName") call BIS_fnc_getCfgData;

	// Define ACE Actions
	_crateAction = [_vehicleDisplayName,_vehicleDisplayName,'a3\ui_f\data\igui\cfg\simpletasks\types\car_ca.paa', 
	{
		params ["_target", "_player", "_actionParams"];
		// diag_log (_actionParams);
		// diag_log (_this);
		// [] call reapercrew_common_fnc_remoteLog
		_vehicleFromParam = _actionParams select 0;
		player setVariable ["logistics_requestedVehicle", _vehicleFromParam];
		[] call reapercrew_logistics_fnc_logisticsVehicleDeliveryLocalTrigger;
	},
	{
		_allowedGroups = reaperCrew_vehicleResupplyDeliveryGroups splitString ",";
		count (entities "reaperCrew_moduleResupplyVehicleSpawnpoint") > 0 && ((groupId (group player)) in _allowedGroups)
	},
	{},
	[_x] // Vehicle Classname
	] call ace_interact_menu_fnc_createAction;
	_actionsList pushBack _crateAction;

} forEach _vehicleClasses;

{
	[player, 1, ["ACE_SelfActions", "reapercrew_ACE_Logistics"], _x] call ace_interact_menu_fnc_addActionToObject;
} forEach _actionsList;