// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

// Only run on the server
if (!isServer) exitWith {["Server checked failed - Not initialising init for marine spawns"] call reapercrew_common_fnc_remoteLog;};

// Don't run if the array isn't available
while {isNil "activeMarineTriggers"} do {
	if (reaperCrew_MarineSpawnCheckbox == true) then {
		["Marine triggers undefined, sleeping"] call reapercrew_common_fnc_remoteLog;
	};
	sleep 15;
};

["Initialising Marine spawnpoint module"] call reapercrew_common_fnc_remoteLog;

// Get variables
_additionalCondition = _logic getVariable ["additionalCondition", "true"];
_triggerCondition = format ["(this && { [objNull, 'VIEW'] checkVisibility [eyePos _x, getPosASL thisTrigger] == 0 } count thisList > 0) && {isTouchingGround _x} count thisList > 0 && %1", _additionalCondition];

// Create detection trigger
_outerZone = createTrigger ["EmptyDetector", position _logic, false];
_outerZone setTriggerArea [7500, 7500, 0, false, -1];
_outerZone setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_outerZone setTriggerStatements [_triggerCondition, " activeMarineTriggers pushBack thisTrigger; ", " activeMarineTriggers = activeMarineTriggers - [thisTrigger]; "];
_outerZone setTriggerInterval 30;

if (reaperCrew_MarineSpawnCheckbox == true) then {
	[(format ["Trigger condition is: %1", _triggerCondition])] call reapercrew_common_fnc_remoteLog;
};

// Save connected LZs as variable
// Select a random syncronised landing point
_syncObjects = synchronizedObjects _logic;
_syncLZs = [];
{
	if (typeOf _x == "reaperCrew_moduleMarineLZ") then {
		_syncLZs pushBack _x;
	};
} forEach _syncObjects;

_outerZone setVariable ["connectedLZs", _syncLZs];

// Associate the created trigger with the module that created it
_logic setVariable ["spawnpointTrigger", _outerZone, true];