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
 * [_object] call reapercrew_logistics_fnc_logisticsCreateFuelSource
 *
 * Public: No
 */

params ["_supplyCrate"];

[_supplyCrate, 100] call ace_refuel_fnc_makeSource;