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

// Section Crate
[_resupplyObject, "Spawn Section Crate", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "_this distance _target < 3", "_caller distance _target < 3", {}, {}, { [_target, "smallArms"] call reapercrew_logistics_fnc_logisticsCreateSupplyCrate }, {}, [], 5, 1, false, false, true] call BIS_fnc_holdActionAdd;

// Medical Crate
[_resupplyObject, "Spawn Medical Crate", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "_this distance _target < 3", "_caller distance _target < 3", {}, {}, { [_target, "medical"] call reapercrew_logistics_fnc_logisticsCreateSupplyCrate }, {}, [], 5, 1, false, false, true] call BIS_fnc_holdActionAdd;

if (reaperCrew_82mmCheckbox == true) then {
	[_resupplyObject, "Spawn 82mm Mortar Crate", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "_this distance _target < 3", "_caller distance _target < 3", {}, {}, { [_target, "82Mortar"] call reapercrew_logistics_fnc_logisticsCreateSupplyCrate }, {}, [], 5, 1, false, false, true] call BIS_fnc_holdActionAdd;
};

if (reaperCrew_VehicleFuelCheckbox == true) then {
	[_resupplyObject, "Spawn Vehicle Fuel Crate", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "_this distance _target < 3", "_caller distance _target < 3", {}, {}, { [_target, "vehicleFuel"] call reapercrew_logistics_fnc_logisticsCreateSupplyCrate }, {}, [], 5, 1, false, false, true] call BIS_fnc_holdActionAdd;
};

if (reaperCrew_VehicleAmmoCheckbox == true) then {
	[_resupplyObject, "Spawn Vehicle Ammo Crate", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "_this distance _target < 3", "_caller distance _target < 3", {}, {}, { [_target, "vehicleAmmo"] call reapercrew_logistics_fnc_logisticsCreateSupplyCrate }, {}, [], 5, 1, false, false, true] call BIS_fnc_holdActionAdd;
};

if (reaperCrew_transportCheckbox == true) then {
	[_resupplyObject, "Spawn Transport Crate", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "_this distance _target < 3", "_caller distance _target < 3", {}, {}, { [_target, "emptyTransport"] call reapercrew_logistics_fnc_logisticsCreateSupplyCrate }, {}, [], 5, 1, false, false, true] call BIS_fnc_holdActionAdd;
};