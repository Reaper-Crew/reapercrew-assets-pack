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
 * [_object] call reapercrew_fnc_logisticsAddActions
 *
 * Public: No
 */

params ["_resupplyObject"];

// Section Crate
[_resupplyObject, "Spawn Section Crate", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "_this distance _target < 3", "_caller distance _target < 3", {}, {}, { [_target] call reapercrew_fnc_logisticsCreateSupplyCrate }, {}, [], 5, 1, false, false, true] call BIS_fnc_holdActionAdd;

// Medical Crate
[_resupplyObject, "Spawn Medical Crate", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", "_this distance _target < 3", "_caller distance _target < 3", {}, {}, { [_target] call reapercrew_fnc_logisticsCreateMedicalCrate }, {}, [], 5, 1, false, false, true] call BIS_fnc_holdActionAdd;