_vehicleClasses = reaperCrew_vehicleResupplyDeliveryClasses splitString ",";
_actionsList = [];

{
	_vehicleDisplayName = (configFile >> "cfgVehicles" >> _x >> "displayName") call BIS_fnc_getCfgData;

	_actionCode = (compile (format ['["Spawning Vehicle...", 2, {true}, {["%1"] call reapercrew_logistics_fnc_logisticsVehicleDeliveryLocalTrigger; hint "Vehicle requested";},{}, [_target]] call CBA_fnc_progressBar;', _x]));

	// Define ACE Actions
	_crateAction = [_vehicleDisplayName,_vehicleDisplayName,'a3\ui_f\data\igui\cfg\simpletasks\types\car_ca.paa', _actionCode,{
		_allowedGroups = reaperCrew_vehicleResupplyDeliveryGroups splitString ",";
		count (entities "reaperCrew_moduleResupplyVehicleSpawnpoint") > 0 && ((groupId (group player)) in _allowedGroups)
	}] call ace_interact_menu_fnc_createAction;
	_actionsList pushBack _crateAction;

} forEach _vehicleClasses;

{
	[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _x] call ace_interact_menu_fnc_addActionToObject;
} forEach _actionsList;