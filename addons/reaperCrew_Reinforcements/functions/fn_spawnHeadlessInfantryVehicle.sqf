/*
 * Author: Xeenenta
 * Spawns a motorised infantry squad
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object, [], 90, 180, 500, 800] call reapercrew_reinforcements_fnc_spawnHeadlessInfantryVehicle
 *
 * Public: No
 */

params ["_targetObject","_spawnPoint",  "_directionMin", "_directionMax", "_distanceMin", "_distanceMax"];

[_targetObject,_spawnPoint, _directionMin, _directionMax, _distanceMin, _distanceMax] spawn {
	params ["_targetObject","_spawnPoint",  "_directionMin", "_directionMax", "_distanceMin", "_distanceMax"];
	diag_log "SCENARIO: Running reinforcement spawn script";

	// Spawn the group
	_spawnedGroup = [_spawnPoint, reaperCrew_reinforcements_side, rifleSection, [],[],[], [],[],180] call BIS_fnc_spawnGroup;
	_spawnedGroup allowFleeing 0;
	{
		_x triggerDynamicSimulation false;
	} forEach units _spawnedGroup;

	// Add vehicle
	_transportVehicle = (selectRandom enemyTransportGround) createVehicle _spawnPoint;
	_spawnedGroup addVehicle _transportVehicle;

	sleep 5;

	_spawnedGroup setBehaviour "AWARE";

	// Random distance/direction
	_distance = [_distanceMin, _distanceMax] call BIS_fnc_randomInt;
	_direction = [_directionMin, _directionMax] call BIS_fnc_randomInt;
	_dismountPos = _targetObject getPos [_distance, _direction];

	driver _transportVehicle setSkill 1;

	// Add Waypoints
	// Get In
	_waypoint =_spawnedGroup addWaypoint [_spawnPoint, -1];
	_waypoint setWaypointType "GETIN";
	_waypoint setWaypointForceBehaviour true;
	_waypoint setWaypointBehaviour "CARELESS";

	// Dismount
	_waypoint =_spawnedGroup addWaypoint [_dismountPos, -1];
	_waypoint setWaypointType "GETOUT";
	_waypoint setWaypointForceBehaviour true;
	_waypoint setWaypointBehaviour "CARELESS";

	// Rush
	_waypoint =_spawnedGroup addWaypoint [_dismountPos, -1];
	_waypoint setWaypointType "SCRIPTED";
	_waypoint setWaypointStatements ["true", " [this, 2000] spawn lambs_wp_fnc_taskRush; [(assignedVehicle leader this)] call reapercrew_reinforcements_fnc_cleanupVehicle;"];
	_waypoint setWaypointForceBehaviour true;
	_waypoint setWaypointBehaviour "AWARE";
};











