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
 * [] call reapercrew_reinforcements_fnc_moduleSpawnReinforcementsAirbourneRemote
 *
 * Public: No
 */

params ["_landingPosition", "_spawnPosition", "_aircraftClass", "_reinforcementsGroup"];

diag_log "SCENARIO: Running reinforcements script";

// Create Helipad
_helipad = "Land_HelipadEmpty_F" createVehicle _landingPosition;

// Create Helicopter
// Create vehicle
_helicopter = createVehicle [_aircraftClass, _spawnPosition, [], 0, "FLY"];
_helicopter setPos _spawnPosition;
_helicopter setDir (_spawnPosition getDir _landingPosition);
// Create Helicopter Crew
_helicopterCrew = createGroup [reaperCrew_reinforcements_side, true];
createVehicleCrew _helicopter;
crew _helicopter joinSilent _helicopterCrew;
_helicopterCrew addVehicle _helicopter;
_helicopterCrew selectLeader commander _helicopter;
_helicopterCrew allowFleeing 0;
_helicopterCrew setBehaviour "CARELESS";
_helicopter flyInHeight 250;
driver _helicopter setSkill 1;

// Add Waypoints
// Transport Unload
_waypoint = _helicopterCrew addWaypoint [_landingPosition, -1];
_waypoint setWaypointType "TR UNLOAD";
_waypoint waypointAttachVehicle _helipad;
// Return to base
_waypoint = _helicopterCrew addWaypoint [_spawnPosition, -1];
_waypoint setWaypointStatements ["true", "deleteVehicle vehicle this; {deleteVehicle _x} forEach thisList"];
 _waypoint setWaypointTimeout [5, 7.5, 10];

// Create Infantry
_infantryGroup = [_spawnPosition, reaperCrew_reinforcements_side, _reinforcementsGroup, [],[],[], [],[],180] call BIS_fnc_spawnGroup;
_infantryGroup allowFleeing 0;
{
	_x triggerDynamicSimulation false;
	_x moveInCargo _helicopter;
} forEach units _infantryGroup;

// Form Up
_waypoint =_infantryGroup addWaypoint [_landingPosition, -1];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointForceBehaviour true;
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCompletionRadius 200;
_waypoint setWaypointTimeout [10, 10, 10];

// Task Rush
_waypoint = _infantryGroup addWaypoint [_landingPosition, -1];
_waypoint setWaypointType "SCRIPTED";
_waypoint setWaypointStatements ["true", "[this, 2000] spawn lambs_wp_fnc_taskRush;"];
_waypoint setWaypointForceBehaviour true;
_waypoint setWaypointBehaviour "AWARE";