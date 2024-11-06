// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

// Only run on the server
if (!isServer) exitWith {["Server checked failed - Not initialising init for infantry spawns"] call reapercrew_common_fnc_remoteLog;};

// Don't run if the array isn't available
while {isNil "activeInfantryTriggers"} do {
	if (reaperCrew_InfantrySpawnCheckbox == true) then {
		["Infantry triggers undefined, sleeping"] call reapercrew_common_fnc_remoteLog;
	};
	sleep 15;
};

["Initialising infantry spawnpoint module"] call reapercrew_common_fnc_remoteLog;

// Get variables
_additionalCondition = _logic getVariable ["additionalCondition", "true"];
_triggerCondition = format ["(this && { [objNull, 'VIEW'] checkVisibility [eyePos _x, getPosASL thisTrigger] == 0 } count thisList > 0) && {isTouchingGround _x} count thisList > 0 && %1", _additionalCondition];

// Create detection trigger
_outerZone = createTrigger ["EmptyDetector", position _logic, false];
_outerZone setTriggerArea [2000, 2000, 0, false, -1];
_outerZone setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_outerZone setTriggerStatements [_triggerCondition, " activeInfantryTriggers pushBack thisTrigger; ", " activeInfantryTriggers = activeInfantryTriggers - [thisTrigger]; "];
_outerZone setTriggerInterval 30;

if (reaperCrew_InfantrySpawnCheckbox == true) then {
	[(format ["Trigger condition is: %1", _triggerCondition])] call reapercrew_common_fnc_remoteLog;
};

// Associate the created trigger with the module that created it
_logic setVariable ["spawnpointTrigger", _outerZone, true];