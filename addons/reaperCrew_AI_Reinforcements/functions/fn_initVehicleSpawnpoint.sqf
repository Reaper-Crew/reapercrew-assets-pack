// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

// Only run on the server
if (!isServer) exitWith {diag_log "[REINFORCEMENTS]: Server checked failed - Not initialising init for Vehicle spawns"};

// Don't run if the array isn't available
while {isNil "activeVehicleTriggers"} do {
	if (reaperCrew_VehicleSpawnCheckbox == true) then {
		diag_log "[REINFORCEMENTS]: Vehicle triggers undefined, sleeping";
	};
	sleep 15;
};

diag_log "[REINFORCEMENTS]: Initialising Vehicle spawnpoint module";

// Get variables
_additionalCondition = _logic getVariable ["additionalCondition", "true"];
_triggerCondition = format ["(this && { [objNull, 'VIEW'] checkVisibility [eyePos _x, getPosASL thisTrigger] == 0 } count thisList > 0) && {isTouchingGround _x} count thisList > 0 && %1", _additionalCondition];

// Create detection trigger
_outerZone = createTrigger ["EmptyDetector", position _logic, false];
_outerZone setTriggerArea [5000, 5000, 0, false, -1];
_outerZone setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_outerZone setTriggerStatements [_triggerCondition, " activeVehicleTriggers pushBack thisTrigger; ", " activeVehicleTriggers = activeVehicleTriggers - [thisTrigger];"];
_outerZone setTriggerInterval 30;

[_logic, _outerZone] call reapercrew_reinforcements_fnc_getPathway;

if (reaperCrew_VehicleSpawnCheckbox == true) then {
	diag_log format ["[REINFORCEMENTS]: Trigger condition is: %1", _triggerCondition];
};

