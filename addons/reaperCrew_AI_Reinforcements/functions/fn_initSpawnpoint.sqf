/*
 * Author: Xeenenta
 * Shared initialisation for every reinforcement spawnpoint type. Resolves the outer zone
 * from the module's drawn area (falling back to a per-type default), applies the inner
 * exclusion zone and capture latch to the detection trigger, and optionally draws debug
 * markers. Type-specific follow-up (pathways, LZ collection) is left to the caller.
 *
 * Arguments:
 * 0: _logic        <OBJECT> - Spawnpoint module logic object
 * 1: _arrayName    <STRING> - Global active-trigger array name (e.g. "activeInfantryTriggers")
 * 2: _defaultOuter <NUMBER> - Outer radius used when the module has no drawn area
 * 3: _defaultInner <NUMBER> - Inner radius used when the module has no innerZone set
 * 4: _typeLabel    <STRING> - Human readable spawnpoint type, used for logs and debug markers
 * 5: _varPrefix    <STRING> - Trigger variable name prefix, for readable names in the debug logs
 *
 * Return Value:
 * The created detection trigger <OBJECT> so the caller can attach type-specific data.
 *
 * Example:
 * [_logic, "activeInfantryTriggers", 2000, 1000, "Infantry Spawnpoint", "InfantrySpawn"] call reapercrew_reinforcements_fnc_initSpawnpoint
 *
 * Public: No
 */

params ["_logic", "_arrayName", "_defaultOuter", "_defaultInner", "_typeLabel", "_varPrefix"];

// Wait for the array created by fn_initReinforcementsSystem
while {isNil _arrayName} do {
	[format ["%1 triggers undefined, sleeping", _typeLabel]] call reapercrew_common_fnc_remoteLog;
	sleep 15;
};

[format ["Initialising %1 module", _typeLabel]] call reapercrew_common_fnc_remoteLog;

// Outer zone from the drawn module area, falling back to the per-type default
_logicArea = _logic getVariable ["objectarea", []];
_outerRadius = if (_logicArea isEqualTo [] || {(_logicArea select 0) <= 0}) then { _defaultOuter } else { _logicArea select 0 };

// Inner zone (metres), clamped so it never exceeds the outer zone
_innerRadius = (_logic getVariable ["innerZone", _defaultInner]) min _outerRadius;
_capturable = _logic getVariable ["capturable", false];

// Condition: player present + line of sight + touching ground + additionalCondition
//          + no in-zone player inside the inner radius
//          + the spawnpoint has not been captured
_additionalCondition = _logic getVariable ["additionalCondition", "true"];
_triggerCondition = format [
	"(this && { [objNull, 'VIEW'] checkVisibility [eyePos _x, getPosASL thisTrigger] == 0 } count thisList > 0)"
  + " && {isTouchingGround _x} count thisList > 0"
  + " && ({ isTouchingGround _x && {(thisTrigger distance2D _x) < (thisTrigger getVariable ['innerRadius', 0])} } count thisList) == 0"
  + " && !(thisTrigger getVariable ['spawnpointCaptured', false])"
  + " && %1", _additionalCondition];

// Create detection trigger
_outerZone = createTrigger ["EmptyDetector", position _logic, false];
_outerZone setVariable ["innerRadius", _innerRadius];
_outerZone setVariable ["moduleLogic", _logic];
_outerZone setTriggerArea [_outerRadius, _outerRadius, 0, false, -1];
_outerZone setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_outerZone setTriggerStatements [
	_triggerCondition,
	format ["%1 pushBack thisTrigger;", _arrayName],
	format ["%1 = %1 - [thisTrigger];", _arrayName]
];
_outerZone setTriggerInterval 30;
// Not referenced in code, but gives readable names in the active-trigger debug logs.
// The grid plus a random integer keeps multiple spawnpoints in the same grid distinct.
_outerZone setVehicleVarName (format ["%1_%2_%3", _varPrefix, mapGridPosition _logic, [10, 99] call BIS_fnc_randomInt]);

[format ["%1 trigger condition is: %2 (outer %3m, inner %4m)", _typeLabel, _triggerCondition, _outerRadius, _innerRadius]] call reapercrew_common_fnc_remoteLog;

// Associate the created trigger with the module that created it
_logic setVariable ["spawnpointTrigger", _outerZone, false];

// Capture latch (one-way) - only when the spawnpoint is capturable.
// The first time a player reaches the inner zone the spawnpoint is permanently disabled.
if (_capturable) then {
	[_logic, _outerZone, _innerRadius, _typeLabel] spawn {
		params ["_logic", "_trigger", "_inner", "_typeLabel"];
		waitUntil {
			sleep 5;
			{ isTouchingGround _x && {_logic distance2D _x < _inner} } count (allPlayers - entities "HeadlessClient_F") > 0
		};
		_trigger setVariable ["spawnpointCaptured", true, true];
		_logic setVariable ["reaperCrew_spawnpointCaptured", true, true]; // mission-maker queryable
		[format ["%1 captured and permanently disabled", _typeLabel]] call reapercrew_common_fnc_remoteLog;
	};
};

// Debug markers - only when enabled on this spawnpoint
if (_logic getVariable ["debugMarkers", false]) then {
	[_logic, _outerRadius, _innerRadius, _typeLabel] call reapercrew_reinforcements_fnc_createSpawnpointDebugMarkers;
};

// Return the trigger so the caller can perform its own type-specific follow-up
_outerZone
