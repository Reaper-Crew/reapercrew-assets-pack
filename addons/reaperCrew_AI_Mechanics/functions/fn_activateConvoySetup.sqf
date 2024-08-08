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
* [_logic] call reapercrew_ai_mechanics_fnc_activateConvoySetup
*
* Public: No
*/

params ["_triggerObject"];

_convoyActivateCondition = _logic getVariable ["ActivationCode","true"];
_convoyActivateCode = compile (format ["sleep 5; %1", _convoyActivateCondition]);

// Random Variable name to support multiple contacts
_convoyContactConditionVariableName = format ["ConvoyContact%1", ([1000,9999] call BIS_fnc_randomInt)];

_convoyContactConditionDeclaration = format ["%1 = false;", _convoyContactConditionVariableName];
_convoyContactConditionDeclarationCode = compile _convoyContactConditionDeclaration;
call _convoyContactConditionDeclarationCode;

_convoyContactConditionCheck = format ["%1 == true", _convoyContactConditionVariableName];
_convoyContactConditionCheckCode = compile _convoyContactConditionCheck;
diag_log _convoyContactConditionCheck;

_convoyContactRuntime = _logic getVariable ["ContactCode","true"];
_convoyContactRuntimeCode = compile _convoyContactRuntime;

// Convoy Settings
_preserveWreckage = true;

// Assume only vehicles are sync'd
_allConvoyVehicles = synchronizedObjects _triggerObject;

// Setup steps
// Disable all simulation
_allConvoyUnits = [];
{
	_allConvoyUnits append (crew _x);
	if (_preserveWreckage) then {

		removeFromRemainsCollector [_x];
	}; 
	
} forEach _allConvoyVehicles;

// Crew units
{
	_x enableSimulationGlobal false;
	_x disableAI "MINEDETECTION";
} forEach _allConvoyUnits;

// Vehicles proper
// Crew units
{
	_x enableSimulationGlobal false;
} forEach _allConvoyVehicles;

// Event handlers to vehicles
{ 
	_x addEventHandler ["Hit", {
		params ["_unit", "_source", "_damage", "_instigator"];

		if (side _unit == side _instigator) exitWith {};
		if (_damage < 0.25) exitWith {};

		_convoyContactConditionVariableName = _unit getVariable ["convoyContactConditionVariableName", ""];
		_convoyContactConditionTrigger = format ["%1 = true;", _convoyContactConditionVariableName];
		_convoyContactConditionTriggerCode = compile _convoyContactConditionTrigger;
		call _convoyContactConditionTriggerCode;

		_unit removeAllEventHandlers "Explosion";
		["Convoy event handler activated"] call reapercrew_common_fnc_remoteLog;
	}];
	_x setVariable ["convoyContactConditionVariableName", _convoyContactConditionVariableName, true];
} forEach _allConvoyUnits;

// Wait until activated
waitUntil _convoyActivateCode;
["Convoy Activated"] call reapercrew_common_fnc_remoteLog;

// Enable sim on all vehicles
{
	_vehicleDriver = driver _x;
	_vehicleDriver enableSimulationGlobal true;
	_x enableSimulationGlobal true;
} forEach _allConvoyVehicles;

waitUntil _convoyContactConditionCheckCode;
["Convoy Contacted"] call reapercrew_common_fnc_remoteLog;

{
	_vehicleUnit = _x;
	_allVehicleOccupants = crew _vehicleUnit;
	// Deplete all fuel to stop movement
	_vehicleUnit setFuel 0;

	[_allVehicleOccupants, _vehicleUnit] spawn {
		params ["_allVehicleOccupants", "_vehicleUnit"];
		{

			_vehicleMember = _x;
			_vehicleMember enableSimulationGlobal true;
			[_vehicleMember] spawn {
				params ["_vehicleMember"];
				sleep 30;
				_vehicleMember enableSimulationGlobal true;
			};
			// Don't dismount gunners
			if (assignedGunner _vehicleUnit == _vehicleMember) then {
				// Do nothing
			} else {
				(group _vehicleMember) setBehaviour "AWARE";
				doStop _vehicleMember;
				[_vehicleMember] orderGetIn false;
				[_vehicleMember] allowGetIn false;
				doGetOut _vehicleMember;
				commandGetOut _vehicleMember;
				unassignVehicle _vehicleMember;
				_vehicleMember leaveVehicle _vehicleUnit;
				_distance = [20,50] call BIS_fnc_randomInt;
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

// Custom Code
call _convoyContactRuntimeCode;

_allConvoyGroups = [];
{
	_allConvoyGroups pushBackUnique (group _x);
} forEach _allConvoyUnits;

sleep 120;
["Rushing units"] call reapercrew_common_fnc_remoteLog;

{
	[_x, 2000] spawn lambs_wp_fnc_taskRush;
	sleep 30;
} forEach _allConvoyGroups;

sleep 1800;
// After 30 mins, add back to GC
addToRemainsCollector _allConvoyVehicles;