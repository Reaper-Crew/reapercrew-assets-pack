/*
 * Author: Xeenenta
 * This init function runs and starts the counter battery system
 *
 * Arguments:
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit] call reaperCrew_fireSupport_fnc_triggerFired
 *
 * Public: No
 */

params ["_unit"];

if (reaperCrew_fireSupport_debugEventHandlers == true) then {
	diag_log format ["SCENARIO: Fired EH triggered for unit: %1", _unit];
};

// Loop through each CB system
{

	if (reaperCrew_fireSupport_debugEventHandlers == true) then {
		diag_log format ["SCENARIO: Checking CB Radar: %1", _unit];
	};

	// Is the system active?
	_attachedGenerator = isNil { _x getVariable "attachedGenerator" };
	_attachedController = isNil { _x getVariable "attachedController" };
	if (_attachedGenerator or _attachedController) exitWith { diag_log format ["SCENARIO: Radar %1 is not online", _x]; };

	// Is the system within range?
	// Check left blank for now

	// Check if the unit has already been alerted
	_variableCheck = isNil { _x getVariable "alertedUnits" };
	if (_variableCheck) exitWith { 
		if (reaperCrew_fireSupport_debugEventHandlers == true) then {
			diag_log format ["SCENARIO: alertedUnits not defined for %1", _x];
		};
	};

	_alertedUnits = _x getVariable "alertedUnits";
	if (reaperCrew_fireSupport_debugEventHandlers == true) then {
		diag_log format ["SCENARIO: Current _unit value is: %1", _unit];
		diag_log format ["SCENARIO: Retrieved alertedUnits value of: %1", _alertedUnits];
	};
	if (_unit in _alertedUnits) exitWith {
		// Update the alert
		[_x, _unit, "update"] call reaperCrew_fireSupport_fnc_alertUnit;
		// Debug Info
		if (reaperCrew_fireSupport_debugEventHandlers == true) then {
			diag_log format ["SCENARIO: Radar %1 is already aware of %2 - not alerting", _x, _unit];
		};
		// if (true) exitWith { true };
	};

	// Alert the unit
	[_x, _unit, "fresh"] call reaperCrew_fireSupport_fnc_alertUnit;

} forEach counterBatterySystems;