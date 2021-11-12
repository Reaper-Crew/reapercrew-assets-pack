// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

// Only run on the server
if (!isServer) exitWith {diag_log "SCENARIO: Server checked failed - Not initialising init for infantry spawns"};

// Don't run if the array isn't available
while {isNil "activeInfantryTriggers"} do {
	if (reaperCrew_InfantrySpawnCheckbox == true) then {
		diag_log "SCENARIO: Infantry triggers undefined, sleeping";
	};
	sleep 15;
};

diag_log "SCENARIO: Initialising infantry spawnpoint module";

// Get variables
_additionalCondition = _logic getVariable ["additionalCondition", "true"];
_triggerCondition = format ["(this && { [objNull, 'VIEW'] checkVisibility [eyePos _x, getPosASL thisTrigger] == 0 } count thisList > 0) && {isTouchingGround _x} count thisList > 0 && %1", _additionalCondition];

// Create detection trigger
_outerZone = createTrigger ["EmptyDetector", position _logic, true];
_outerZone setTriggerArea [2000, 2000, 0, false, -1];
_outerZone setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_outerZone setTriggerStatements [_triggerCondition, " activeInfantryTriggers pushBack thisTrigger; ", " activeInfantryTriggers = activeInfantryTriggers - [thisTrigger]; "];

if (reaperCrew_InfantrySpawnCheckbox == true) then {
	diag_log format ["SCENARIO: Trigger condition is: %1", _triggerCondition];
};







// Global Variables
// activeInfantryTriggers = [];

// // Variables
// _infantrySpawnModules = entities "reaperCrew_moduleInfantrySpawn";

// {
// 	// Get Variable
// 	_additionalCondition = _x getVariable ["additionalCondition", "true"];

// 	_triggerCondition = format ["(this && { [objNull, 'VIEW'] checkVisibility [eyePos _x, getPosASL thisTrigger] == 0 } count thisList > 0) && {isTouchingGround _x} count thisList > 0 && %1", _additionalCondition];

// 	// Create detection trigger
// 	_outerZone = createTrigger ["EmptyDetector", position _x, true];
// 	_outerZone setTriggerArea [2000, 2000, 0, false, -1];
// 	_outerZone setTriggerActivation ["ANYPLAYER", "PRESENT", true];
// 	_outerZone setTriggerStatements [_triggerCondition, " activeInfantryTriggers pushBack thisTrigger; ", " activeInfantryTriggers = activeInfantryTriggers - [thisTrigger]; "];

// 	diag_log format ["Trigger condition is: %1", _triggerCondition];

// } forEach _infantrySpawnModules;

// [] spawn {



// };