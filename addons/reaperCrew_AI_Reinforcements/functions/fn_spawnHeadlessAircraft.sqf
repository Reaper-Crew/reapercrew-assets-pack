/*
 * Author: Xeenenta
 * Spawns a vehicle with a SAD waypoint
 *
 * Arguments:
 * 0: Spawnpoint <ARRAY>
 * 0: Classname <STRING>
 * 2: Skill Level <INT>
 * 2: Destination <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0,0,0], "my_vehicle", 50, [0,0,0]] call reapercrew_reinforcements_fnc_spawnHeadlessAircraft
 *
 * Public: No
 */

params ["_spawnPoint", "_vehicleClassname", "_vehicleSkill", "_destination"];

[_spawnPoint, _vehicleClassname, _vehicleSkill, _destination] spawn {
	params ["_spawnPoint", "_vehicleClassname", "_vehicleSkill", "_destination"];
	diag_log "SCENARIO: Running vehicle reinforcement spawn script";
	// Spawn the group
	_spawnedVehicle = [_spawnPoint, 0, _vehicleClassname, reaperCrew_reinforcements_side] call BIS_fnc_spawnVehicle;
	_spawnedGroup = _spawnedVehicle select 2;

	{
		_x triggerDynamicSimulation false;
		_x setSkill (_vehicleSkill / 100);
	} forEach units _spawnedGroup;

	// Give the unit a SAD waypoint
	sleep 5;
	_spawnedGroup setBehaviour "AWARE";
	_waypoint = _spawnedGroup addWaypoint [_destination, 0];
	_waypoint setWaypointSpeed "NORMAL";
	_waypoint setWaypointType "SAD";
	_waypoint setWaypointBehaviour "SAFE";



};


