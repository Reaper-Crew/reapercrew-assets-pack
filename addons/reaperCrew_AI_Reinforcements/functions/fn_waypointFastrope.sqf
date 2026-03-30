/*
 * Author: mharis001 (ZEN Enhanced), adapted by Xeenenta
 * Scripted waypoint that makes a group fastrope at the waypoint's position.
 * Requires ACE Fastroping to be loaded and the helicopter to have ace_fastroping_enabled
 * in its config. If the helicopter is not configured for fastroping, the waypoint completes
 * immediately and troops remain aboard for the next waypoint.
 *
 * Changes from ZEN original:
 * - Removed ZEN macro dependencies
 * - Hover height raised to 25m for terrain clearance
 * - Uses getTerrainHeightASL for correct altitude on procedural waypoints
 *
 * Arguments:
 * 0: Group <GROUP>
 * 1: Waypoint Position <ARRAY>
 *
 * Return Value:
 * Waypoint Finished <BOOL>
 *
 * Example:
 * _waypoint setWaypointScript "rc_assets_pack\addons\reaperCrew_AI_Reinforcements\functions\fn_waypointFastrope.sqf"
 *
 * Public: No
 */

#define FASTROPE_HEIGHT 25
#define MOVE_DELAY 3
#define HEIGHT_DISTANCE 2000
#define MANUAL_DISTANCE 100
#define MANUAL_SPEED 12

params ["_group", "_waypointPosition"];

["Fastrope: Waypoint script started"] call reapercrew_common_fnc_remoteLog;

// Exit if ACE Fastroping is not loaded
if (!isClass (configFile >> "CfgPatches" >> "ace_fastroping")) exitWith {
	["Fastrope: ABORT - ACE Fastroping not loaded"] call reapercrew_common_fnc_remoteLog;
	true
};

private _vehicle = vehicle leader _group;
[(format ["Fastrope: Vehicle: %1, Group: %2", typeOf _vehicle, _group])] call reapercrew_common_fnc_remoteLog;

// Exit if the helicopter has no passengers that can be deployed
private _cargoCount = {assignedVehicleRole _x select 0 == "cargo"} count crew _vehicle;
if (_cargoCount == 0) exitWith {
	["Fastrope: ABORT - no cargo units in vehicle"] call reapercrew_common_fnc_remoteLog;
	true
};
[(format ["Fastrope: Found %1 cargo units to deploy", _cargoCount])] call reapercrew_common_fnc_remoteLog;

// Check the helicopter has ACE fastroping config - deployAI requires this
private _config = configOf _vehicle;
private _configEnabled = getNumber (_config >> "ace_fastroping_enabled");
[(format ["Fastrope: ace_fastroping_enabled = %1", _configEnabled])] call reapercrew_common_fnc_remoteLog;

if (_configEnabled == 0) exitWith {
	[(format ["Fastrope: ABORT - %1 has no ace_fastroping_enabled config, fastrope not possible", typeOf _vehicle])] call reapercrew_common_fnc_remoteLog;
	true
};

// Equip FRIES if needed (config value 2 means FRIES required)
if (_configEnabled == 2) then {
	if (isNull (_vehicle getVariable ["ace_fastroping_FRIES", objNull])) then {
		["Fastrope: Equipping FRIES (config requires it)"] call reapercrew_common_fnc_remoteLog;
		_vehicle call ace_fastroping_fnc_equipFRIES;
		sleep 0.1; // equipFRIES uses execNextFrame
	} else {
		["Fastrope: FRIES already equipped"] call reapercrew_common_fnc_remoteLog;
	};
};

// Increase the skill of the pilot for better flying
private _driver = driver _vehicle;
private _skill = skill _driver;

_driver allowFleeing 0;
_driver setSkill 1;

// Set the group's behaviour to careless to prevent it from flying away in combat
private _behaviour = behaviour _vehicle;
_group setBehaviour "CARELESS";

["Fastrope: Approaching waypoint position"] call reapercrew_common_fnc_remoteLog;

private _nextMove = CBA_missionTime;
private _adjustHeight = true;

waitUntil {
	if (CBA_missionTime >= _nextMove) then {
		_vehicle doMove _waypointPosition;
		_nextMove = CBA_missionTime + MOVE_DELAY;
	};

	if (_adjustHeight && {_vehicle distance2D _waypointPosition < HEIGHT_DISTANCE}) then {
		_vehicle flyInHeight FASTROPE_HEIGHT;
		_adjustHeight = false;
		["Fastrope: Set fly-in height for final approach"] call reapercrew_common_fnc_remoteLog;
	};

	sleep 0.5;

	_vehicle distance2D _waypointPosition < MANUAL_DISTANCE
};

[(format ["Fastrope: Within manual distance, beginning positioning (alt: %1m AGL)", getPos _vehicle select 2])] call reapercrew_common_fnc_remoteLog;

// Manually position the helicopter over the waypoint
private _startPos = getPosASL _vehicle;

// Build target position as ASL: terrain height + hover height
private _endPos = +_waypointPosition;
_endPos set [2, 0];
private _terrainHeight = getTerrainHeightASL _endPos;
_endPos set [2, _terrainHeight + FASTROPE_HEIGHT];

[(format ["Fastrope: Target ASL position: %1 (terrain: %2m, hover: %3m above)", _endPos, _terrainHeight, FASTROPE_HEIGHT])] call reapercrew_common_fnc_remoteLog;

private _initialVelocity = velocity _vehicle;
private _vectorDir = vectorDir _vehicle;
private _vectorUp = vectorUp _vehicle;

private _startTime = CBA_missionTime;
private _totalTime = (_startPos vectorDistance _endPos) / MANUAL_SPEED;

waitUntil {
	_vehicle setVelocityTransformation [
		_startPos,
		_endPos,
		_initialVelocity,
		[0, 0, 0],
		_vectorDir,
		_vectorDir,
		_vectorUp,
		[0, 0, 1],
		(CBA_missionTime - _startTime) / _totalTime
	];

	vectorMagnitude velocity _vehicle < 0.5 && {getPos _vehicle select 2 <= (FASTROPE_HEIGHT + 2)}
};

// Remember which units are cargo before deployment
private _unitsToDeploy = crew _vehicle select {assignedVehicleRole _x select 0 == "cargo"};
[(format ["Fastrope: In position (alt: %1m AGL), deploying %2 units", getPos _vehicle select 2, count _unitsToDeploy])] call reapercrew_common_fnc_remoteLog;

// Pin the helicopter in place during deployment to prevent drift
// ACE's server PFH detaches units if helicopter velocity exceeds 5 m/s
private _hoverPos = getPosASL _vehicle;
private _hoverDir = vectorDir _vehicle;
private _hoverUp = vectorUp _vehicle;
private _holdPosition = true;

_vehicle setVariable ["rc_fastrope_holdPosition", true];

[_vehicle, _hoverPos, _hoverDir, _hoverUp] spawn {
	params ["_vehicle", "_hoverPos", "_hoverDir", "_hoverUp"];
	private _driver = driver _vehicle;
	while {_vehicle getVariable ["rc_fastrope_holdPosition", false]} do {
		// Keep pilot MOVE disabled - deployAI re-enables it asynchronously when it
		// thinks deployment is done, but last units may still be descending
		_driver disableAI "MOVE";
		_vehicle setPosASL _hoverPos;
		_vehicle setVelocity [0, 0, 0];
		_vehicle setVectorDirAndUp [_hoverDir, _hoverUp];
		sleep 0.1;
	};
	_driver enableAI "MOVE";
};

// Deploy AI via ACE - handles ropes, unit extraction, and timing
[_vehicle, false, false] call ace_fastroping_fnc_deployAI;

// Wait for ropes to deploy
["Fastrope: Waiting for ropes to deploy..."] call reapercrew_common_fnc_remoteLog;
waitUntil {
	sleep 0.5;
	_vehicle getVariable ["ace_fastroping_deployedRopes", []] isNotEqualTo []
};
[(format ["Fastrope: Ropes deployed (%1 ropes)", count (_vehicle getVariable ["ace_fastroping_deployedRopes", []])])] call reapercrew_common_fnc_remoteLog;

// Wait for ALL cargo units to actually be out of the vehicle and on the ground
["Fastrope: Waiting for all units to reach the ground..."] call reapercrew_common_fnc_remoteLog;
waitUntil {
	sleep 1;
	private _allOut = _unitsToDeploy findIf {vehicle _x == _vehicle} == -1;
	private _allGrounded = _unitsToDeploy findIf {alive _x && {getPos _x select 2 > 1}} == -1;
	_allOut && _allGrounded
};

// Release the helicopter position hold
_vehicle setVariable ["rc_fastrope_holdPosition", false];

// Wait for ACE to finish its own cleanup (ropes cut)
waitUntil {
	sleep 0.5;
	_vehicle getVariable ["ace_fastroping_deployedRopes", []] isEqualTo []
};

["Fastrope: All units deployed, cleaning up"] call reapercrew_common_fnc_remoteLog;

// Stow FRIES
if !(isNull (_vehicle getVariable ["ace_fastroping_FRIES", objNull])) then {
	_vehicle call ace_fastroping_fnc_stowFRIES;
};

// Restore original state and fly away
_vehicle flyInHeight 100;
_driver setSkill _skill;
_group setBehaviour _behaviour;

["Fastrope: Waypoint complete"] call reapercrew_common_fnc_remoteLog;

true
