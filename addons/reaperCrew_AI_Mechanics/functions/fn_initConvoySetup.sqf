/*
* Author: Xeenenta
* Calls the activate script for convoy configuration and passes in the variables from the module
*
* Arguments:
* 0: Logic <LOGIC>
* 1: 
*
* Return Value:
* None
*
* Example:
* [_logic] call reapercrew_ai_mechanics_fnc_initConvoySetup
*
* Public: No
*/

// 

// Variables
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

if (count (synchronizedObjects _logic) == 0) exitWith { diag_log "Nothing sync'd" };

[_logic, (synchronizedObjects _logic)] call myTag_fnc_initConvoy;

[_logic] call reapercrew_ai_mechanics_fnc_activateConvoySetup;