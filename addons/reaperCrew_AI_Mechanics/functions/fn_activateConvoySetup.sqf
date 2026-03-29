/*
 * Author: Xeenenta
 * Activates a convoy module. Disables simulation on convoy vehicles until an activation
 * condition is met, then waits for contact (Hit EH) before dismounting crew and rushing.
 *
 * Arguments:
 * 0: Trigger Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_triggerObject] call reapercrew_ai_mechanics_fnc_activateConvoySetup
 *
 * Public: No
 */

params ["_triggerObject"];

// Read module attributes
_convoyActivateCondition = _triggerObject getVariable ["ActivationCode","true"];
_convoyActivateCode = compile (format ["sleep 5; %1", _convoyActivateCondition]);

// Generate a unique variable name so multiple convoys don't clash
_convoyContactConditionVariableName = format ["ConvoyContact%1", ([1000,9999] call BIS_fnc_randomInt)];

// Initialise the contact variable to false
_convoyContactConditionDeclaration = format ["%1 = false;", _convoyContactConditionVariableName];
call compile _convoyContactConditionDeclaration;

// Compile the check code for waitUntil
_convoyContactConditionCheck = format ["%1 == true", _convoyContactConditionVariableName];
_convoyContactConditionCheckCode = compile _convoyContactConditionCheck;

_convoyContactRuntime = _triggerObject getVariable ["ContactCode","true"];
_convoyContactRuntimeCode = compile _convoyContactRuntime;

_preserveWreckage = true;

// Collect all synchronised vehicles and their crew
_allConvoyVehicles = synchronizedObjects _triggerObject;
_allConvoyUnits = [];
{
	_allConvoyUnits append (crew _x);
	// Prevent engine garbage collection so wreckage persists
	if (_preserveWreckage) then {
		removeFromRemainsCollector [_x];
	};
} forEach _allConvoyVehicles;

// Freeze all crew and vehicles until activation
{
	_x enableSimulationGlobal false;
	_x disableAI "MINEDETECTION";
} forEach _allConvoyUnits;

{
	_x enableSimulationGlobal false;
} forEach _allConvoyVehicles;

// Add Hit EH to each crew member to detect contact
{
	_x addEventHandler ["Hit", {
		params ["_unit", "_source", "_damage", "_instigator"];

		// Ignore friendly fire and environmental damage
		if (isNull _instigator) exitWith {};
		if (side _unit == side _instigator) exitWith {};
		if (_damage < 0.25) exitWith {};

		// Set the contact variable to true to trigger the dismount sequence
		_convoyContactConditionVariableName = _unit getVariable ["convoyContactConditionVariableName", ""];
		call compile format ["%1 = true;", _convoyContactConditionVariableName];

		_unit removeAllEventHandlers "Hit";
		["Convoy event handler activated"] call reapercrew_common_fnc_remoteLog;
	}];
	_x setVariable ["convoyContactConditionVariableName", _convoyContactConditionVariableName, true];
} forEach _allConvoyUnits;

// Wait for the activation condition before enabling the convoy
waitUntil _convoyActivateCode;
["Convoy Activated"] call reapercrew_common_fnc_remoteLog;

// Enable simulation on vehicles and drivers
{
	(driver _x) enableSimulationGlobal true;
	_x enableSimulationGlobal true;
} forEach _allConvoyVehicles;

// Wait for contact (Hit EH sets the variable to true)
waitUntil _convoyContactConditionCheckCode;
["Convoy Contacted"] call reapercrew_common_fnc_remoteLog;

// Dismount sequence - stop vehicles and order non-gunner crew out
{
	_vehicleUnit = _x;
	_allVehicleOccupants = crew _vehicleUnit;

	// Kill the engine to prevent AI driving off
	_vehicleUnit setFuel 0;

	[_allVehicleOccupants, _vehicleUnit] spawn {
		params ["_allVehicleOccupants", "_vehicleUnit"];
		{
			_vehicleMember = _x;
			_vehicleMember enableSimulationGlobal true;

			// Keep gunners in the vehicle, dismount everyone else
			if (assignedGunner _vehicleUnit != _vehicleMember) then {
				(group _vehicleMember) setBehaviour "AWARE";
				doStop _vehicleMember;
				[_vehicleMember] orderGetIn false;
				[_vehicleMember] allowGetIn false;
				doGetOut _vehicleMember;
				commandGetOut _vehicleMember;
				unassignVehicle _vehicleMember;
				_vehicleMember leaveVehicle _vehicleUnit;

				// Move to a random position nearby
				_distance = [20, 50] call BIS_fnc_randomInt;
				_direction = [0, 360] call BIS_fnc_randomInt;
				_movePos = _vehicleMember getRelPos [_distance, _direction];
				_vehicleMember doMove _movePos;
				_vehicleMember commandMove _movePos;
			};
			sleep 0.5;
		} forEach _allVehicleOccupants;
	};
	sleep 1;
} forEach _allConvoyVehicles;

// Run any custom contact code from the module
call _convoyContactRuntimeCode;

// Collect all unique groups from convoy units
_allConvoyGroups = [];
{
	_allConvoyGroups pushBackUnique (group _x);
} forEach _allConvoyUnits;

// After 2 minutes, order all groups to rush
sleep 120;
["Rushing units"] call reapercrew_common_fnc_remoteLog;
{
	[_x, 2000] spawn lambs_wp_fnc_taskRush;
	sleep 30;
} forEach _allConvoyGroups;

// After 30 minutes, allow engine garbage collection on wreckage
sleep 1800;
addToRemainsCollector _allConvoyVehicles;
