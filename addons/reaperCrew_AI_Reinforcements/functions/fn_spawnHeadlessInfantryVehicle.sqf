/*
 * Author: Xeenenta
 * Code that runs on the headless client/server to spawn the helicopter and associated infantry
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call reapercrew_reinforcements_fnc_spawnHeadlessInfantryVehicle
 *
 * Public: No
 */

params ["_landingPosition", "_spawnPosition", "_vehicleClass", "_reinforcementsGroup", "_reinforcementsGroupSkill", "_codeOnSpawnGroup", ["_waypointsList", []], ["_rushMode", false], ["_moduleObject", objNull], ["_rushRadius", 2000]];

[(format ["[%1]", name player])] call reapercrew_common_fnc_remoteLog;

// Create the transport vehicle
_vehicle = createVehicle [_vehicleClass, _spawnPosition];
_vehicle setPos _spawnPosition;
_vehicle setDir (_spawnPosition getDir _landingPosition);

// Create the infantry group
_spawnedGroup = [_spawnPosition, reaperCrew_reinforcements_side, _reinforcementsGroup, [],[],[], [],[],180] call BIS_fnc_spawnGroup;
_spawnedGroup allowFleeing 0;
// The group is local to this machine, so the engine auto-deletes it once every member is dead,
// preventing empty groups from accumulating towards the per-side group limit
_spawnedGroup deleteGroupWhenEmpty true;
_spawnedGroup addVehicle _vehicle;
{
	// Set on the server so the server does not treat these ingressing units as activators that wake garrisons
	[_x, false] remoteExec ["triggerDynamicSimulation", 2];
	_x setSkill (_reinforcementsGroupSkill / 100);
	//_x moveInAny _vehicle;
	if (_rushMode) then {
		_x disableAI "FSM";
	};
} forEach units _spawnedGroup;

// Register spawned units with the module so the zone counter can track them while they ingress
// (the same group both drives and dismounts, so all of them legitimately count)
if (!isNull _moduleObject) then {
	private _existing = _moduleObject getVariable ["spawnedUnits", []];
	private _updated = _existing + (units _spawnedGroup);
	_moduleObject setVariable ["spawnedUnits", _updated, true];
	[format ["Tracked %1 newly spawned units: module spawnedUnits %2 -> %3", count (units _spawnedGroup), count _existing, count _updated]] call reapercrew_common_fnc_remoteLog;
};

_spawnedGroup setBehaviour "AWARE";

// FAILSAFE: Adjust group to match vehicle size
[_vehicle, _spawnedGroup, "FULL"] call reapercrew_reinforcements_fnc_adjustGroupToVehicle;

[format ["List of available waypoints: %1", _waypointsList], (format ["[%1]", name player])] call reapercrew_common_fnc_remoteLog;

// Add Waypoints
// Get In
_waypoint =_spawnedGroup addWaypoint [_spawnPosition, -1];
_waypoint setWaypointType "GETIN";
_waypoint waypointAttachVehicle _vehicle;
_waypoint setWaypointForceBehaviour true;
_waypoint setWaypointBehaviour "CARELESS";

{ _x moveInAny _vehicle } forEach (units _spawnedGroup);

// If a pathway is defined, use that instead of random
if (count _waypointsList > 0) then {
	_arrayLength = (count _waypointsList) - 1;
	_landingPosition = _waypointsList select _arrayLength;

	{
		// MOVE
		_waypoint =_spawnedGroup addWaypoint [_x, -1];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointForceBehaviour true;
		_waypoint setWaypointBehaviour "CARELESS";
	} forEach _waypointsList;
};
// Dismount
_waypoint =_spawnedGroup addWaypoint [_landingPosition, 50];
_waypoint setWaypointType "GETOUT";
_waypoint setWaypointForceBehaviour true;
_waypoint setWaypointBehaviour "CARELESS";
_dismountPos = waypointPosition _waypoint;
// Rush
_waypoint =_spawnedGroup addWaypoint [_dismountPos, -1];
_waypoint setWaypointType "SCRIPTED";
_waypoint setWaypointStatements ["true", format [" [this, %1] spawn lambs_wp_fnc_taskRush; [(assignedVehicle leader this)] call reapercrew_reinforcements_fnc_cleanupVehicle; thisList apply { _x leaveVehicle (assignedVehicle _x) }; [leader this] call reapercrew_reinforcements_fnc_adjustGroupLeader;", _rushRadius]];
_waypoint setWaypointForceBehaviour true;
_waypoint setWaypointBehaviour "AWARE";

driver _vehicle setSkill 1; // Always get the driver to high skill for better driving

// Run extra code
_extraCodeString = format ['params ["_thisGroup"]; %1', _codeOnSpawnGroup];
_codeCompile = compile _extraCodeString;
[_spawnedGroup] call _codeCompile;
