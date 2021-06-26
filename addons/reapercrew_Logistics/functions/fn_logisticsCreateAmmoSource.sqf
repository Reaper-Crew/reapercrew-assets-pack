/*
 * Author: Xeenenta
 * Create a standard ammo crate
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * _supplyCrate <OBJECT> 
 *
 * Example:
 * [_object] call reapercrew_logistics_fnc_logisticsCreateAmmoSource
 *
 * Public: No
 */

params ["_supplyCrate"];

[_supplyCrate, true] call ace_rearm_fnc_disable;