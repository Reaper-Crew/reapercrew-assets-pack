/*
 * Author: Xeenenta
 * Eden module init for convoy setup. Validates sync'd objects and calls the
 * convoy activation function.
 *
 * Arguments:
 * 0: Logic <OBJECT> - the module logic
 * 1: Units <ARRAY> - synchronised units
 * 2: Activated <BOOL> - whether the module is activated
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic, _units, _activated] call reapercrew_ai_mechanics_fnc_initConvoySetup
 *
 * Public: No
 */

// 

// Variables
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

if (synchronizedObjects _logic isEqualTo []) exitWith { ["Nothing sync'd"] call reapercrew_common_fnc_remoteLog };

[_logic, (synchronizedObjects _logic)] call myTag_fnc_initConvoy;

[_logic] call reapercrew_ai_mechanics_fnc_activateConvoySetup;
