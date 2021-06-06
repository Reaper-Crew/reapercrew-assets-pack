/*
 * Author: Xeenenta
 * Spawns a vehicle with a SAD waypoint
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object, [0,0,0]] call reapercrew_reinforcements_fnc_spawnHeadlessVehicle
 *
 * Public: No
 */

params ["_targetObject","_spawnPoint", "_selection"];

[_targetObject,_spawnPoint, _selection] spawn {
	params ["_targetObject","_spawnPoint", "_selection"];
	diag_log "SCENARIO: Running reinforcement spawn script";
	_randomVehicleClass = "";

	switch (_selection) do {
		case 0: {
			_randomVehicleClass = selectRandom (enemyFireSupportHeavyArmour + enemyFireSupportLightArmour + enemyFireSupportTechnicals);
		};
		case 1: {
			_randomVehicleClass = selectRandom enemyFireSupportHeavyArmour;
		};
		case 2: {
			_randomVehicleClass = selectRandom enemyFireSupportLightArmour;
		};
		case 3: {
			_randomVehicleClass = selectRandom enemyFireSupportTechnicals;
		};
		default {
			_randomVehicleClass = selectRandom (enemyFireSupportHeavyArmour + enemyFireSupportLightArmour + enemyFireSupportTechnicals);
		};
	};

	// Select a random vehicle
	_targetLocation = getPos _targetObject;

	// Spawn vehicle
	_spawnedVehicle = [_spawnPoint, 0, _randomVehicleClass, reaperCrew_reinforcements_side] call BIS_fnc_spawnVehicle;

	// Waypoint
	_vehicleGroup = _spawnedVehicle select 2;
	_waypoint = _vehicleGroup addWaypoint [_targetLocation, 0];
	_waypoint setWaypointSpeed "NORMAL";
	_waypoint setWaypointType "SAD";
	_waypoint setWaypointBehaviour "SAFE";

};