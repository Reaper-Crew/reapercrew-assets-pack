/*
 * Author: Xeenenta
 * Spawns an airbourne infantry squad
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object, [], 90, 180, 500, 800] call reapercrew_reinforcements_fnc_spawnHeadlessInfantryHelicopter
 *
 * Public: No
 */

params ["_targetObject","_spawnPoint",  "_directionMin", "_directionMax", "_distanceMin", "_distanceMax"];

[_targetObject,_spawnPoint, _directionMin, _directionMax, _distanceMin, _distanceMax] spawn {
	params ["_targetObject","_spawnPoint",  "_directionMin", "_directionMax", "_distanceMin", "_distanceMax"];
	diag_log "SCENARIO: Running reinforcement spawn script";

	// Random distance/direction
	_distance = [_distanceMin, _distanceMax] call BIS_fnc_randomInt;
	_direction = [_directionMin, _directionMax] call BIS_fnc_randomInt;
	_dismountPos = _targetObject getPos [_distance, _direction];
	
	_rallyPoint = getPos _targetObject;

	_spawnDirection = _spawnPoint getDir _dismountPos;
	_spawnPoint set [2, 250];

	private _vehicle = createVehicle [(selectRandom enemyTransportHelicopter), _spawnPoint, [], 0, "FLY"];
	_vehicle setPos _spawnPoint;
	_vehicle setDir _spawnDirection;
	// Create the vehicle crew
	private _vehicleGroup = createGroup [reaperCrew_reinforcements_side, true];
	createVehicleCrew _vehicle;

	crew _vehicle joinSilent _vehicleGroup;
	_vehicleGroup addVehicle _vehicle;

	_vehicleGroup selectLeader commander _vehicle;
	_vehicleGroup allowFleeing 0;

	_vehicleGroup setBehaviour "CARELESS";
    _vehicle flyInHeight 250;

	driver _vehicle setSkill 1;

	// Spawn the group
	_spawnedGroup = [_spawnPoint, reaperCrew_reinforcements_side, rifleSection, [],[],[], [],[],180] call BIS_fnc_spawnGroup;
	_spawnedGroup allowFleeing 0;
	{
		_x triggerDynamicSimulation false;
		_x moveInCargo _vehicle;
	} forEach units _spawnedGroup;

	private _waypoint = _vehicleGroup addWaypoint [_dismountPos, -1];
	_waypoint setWaypointType "TR UNLOAD";

	private _waypoint = _vehicleGroup addWaypoint [_spawnPoint, -1];
    _waypoint setWaypointStatements ["true", "deleteVehicle vehicle this; {deleteVehicle _x} forEach thisList"];
    _waypoint setWaypointTimeout [5, 7.5, 10];

	sleep 5;
	_spawnedGroup setBehaviour "AWARE";

	// Dismount
	_waypoint =_spawnedGroup addWaypoint [_dismountPos, -1];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointForceBehaviour true;
	_waypoint setWaypointBehaviour "CARELESS";
	_waypoint setWaypointCompletionRadius 200;
	_waypoint setWaypointTimeout [10, 10, 10];

	_waypoint = _spawnedGroup addWaypoint [_dismountPos, -1];
	_waypoint setWaypointType "SCRIPTED";
	_waypoint setWaypointStatements ["true", "[this, 2000] spawn lambs_wp_fnc_taskRush;"];
	_waypoint setWaypointForceBehaviour true;
	_waypoint setWaypointBehaviour "AWARE";


	// Select Vehicle
	// [(selectRandom enemyTransportHelicopter), rifleSection, _spawnPoint, _dismountPos, _rallyPoint, true, 0, 0, 250] call zen_modules_fnc_moduleSpawnReinforcements;

};