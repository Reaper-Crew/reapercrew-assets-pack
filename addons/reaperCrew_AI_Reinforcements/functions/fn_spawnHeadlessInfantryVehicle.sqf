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

params ["_landingPosition", "_spawnPosition", "_vehicleClass", "_reinforcementsGroup", "_reinforcementsGroupSkill", "_codeOnSpawnGroup"];

diag_log "[REINFORCEMENTS]: Running reinforcements script";

// Create the transport vehicle
_vehicle = createVehicle [_vehicleClass, _spawnPosition];
_vehicle setPos _spawnPosition;
_vehicle setDir (_spawnPosition getDir _landingPosition);

diag_log _reinforcementsGroup;

// Create the infantry group
_spawnedGroup = [_spawnPosition, reaperCrew_reinforcements_side, _reinforcementsGroup, [],[],[], [],[],180] call BIS_fnc_spawnGroup;
_spawnedGroup allowFleeing 0;
_spawnedGroup addVehicle _vehicle;
{
	_x triggerDynamicSimulation false;
	_x setSkill (_reinforcementsGroupSkill / 100);
	//_x moveInAny _vehicle;
	if (_rushMode) then {
		_x disableAI "FSM";
	};
} forEach units _spawnedGroup;

_spawnedGroup setBehaviour "AWARE";

// Add Waypoints
// Get In
_waypoint =_spawnedGroup addWaypoint [_spawnPosition, -1];
_waypoint setWaypointType "GETIN";
_waypoint waypointAttachVehicle _vehicle;
_waypoint setWaypointForceBehaviour true;
_waypoint setWaypointBehaviour "CARELESS";
// Dismount
_waypoint =_spawnedGroup addWaypoint [_landingPosition, -1];
_waypoint setWaypointType "GETOUT";
_waypoint setWaypointForceBehaviour true;
_waypoint setWaypointBehaviour "CARELESS";
// Rush
_waypoint =_spawnedGroup addWaypoint [_landingPosition, -1];
_waypoint setWaypointType "SCRIPTED";
_waypoint setWaypointStatements ["true", " [this, 2000] spawn lambs_wp_fnc_taskRush; [(assignedVehicle leader this)] call reapercrew_reinforcements_fnc_cleanupVehicle;"];
_waypoint setWaypointForceBehaviour true;
_waypoint setWaypointBehaviour "AWARE";

driver _vehicle setSkill 1; // Always get the driver to high skill for better driving

// Run extra code
_extraCodeString = format ['params ["_thisGroup"]; %1', _codeOnSpawnGroup];
_codeCompile = compile _extraCodeString;
[_spawnedGroup] call _codeCompile;