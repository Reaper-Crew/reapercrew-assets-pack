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
 * [] call reapercrew_reinforcements_fnc_spawnHeadlessInfantryAirbourne
 *
 * Public: No
 */

params ["_landingPosition", "_spawnPosition", "_aircraftClass", "_reinforcementsGroup", "_reinforcementsGroupSkill", "_codeOnSpawnGroup", ["_waypointsList", []]];

diag_log "[REINFORCEMENTS]: Running reinforcements script";

// Create Helipad
_helipad = "Land_HelipadEmpty_F" createVehicle _landingPosition;

// Delete helipad after 10 mins
[_helipad] spawn {
	params ["_helipad"];
	sleep 600;
	deleteVehicle _helipad;
};

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

// If a pathway is defined, use that instead of random
if (count _waypointsList > 0) then {
	_arrayLength = (count _waypointsList) - 1;
	_landingPosition = _waypointsList select _arrayLength;

	{
		// MOVE
		_waypoint =_helicopterCrew addWaypoint [_x, -1];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointForceBehaviour true;
		_waypoint setWaypointBehaviour "CARELESS";
	} forEach _waypointsList;
};

// Transport Unload
_waypoint = _helicopterCrew addWaypoint [_landingPosition, 50];
_waypoint setWaypointType "TR UNLOAD";
_waypoint waypointAttachVehicle _helipad;

// // Return to base - REMOVED TEMPORARILY DUE TO BUG
// if (count _waypointsList > 0) then {
//     reverse _waypointsList;
// 	{
// 		// MOVE
// 		_waypoint =_helicopterCrew addWaypoint [_x, -1];
// 		_waypoint setWaypointType "MOVE";
// 		_waypoint setWaypointForceBehaviour true;
// 		_waypoint setWaypointBehaviour "CARELESS";
// 	} forEach _waypointsList;
// };

_waypoint = _helicopterCrew addWaypoint [_spawnPosition, -1];
_waypoint setWaypointStatements ["true", "deleteVehicle vehicle this; {deleteVehicle _x} forEach thisList"];
 _waypoint setWaypointTimeout [5, 7.5, 10];

// Create Infantry
_infantryGroup = [_spawnPosition, reaperCrew_reinforcements_side, _reinforcementsGroup, [],[],[], [],[],180] call BIS_fnc_spawnGroup;
_infantryGroup allowFleeing 0;
{
	_x triggerDynamicSimulation false;
	_x moveInCargo _helicopter;
	_x setSkill (_reinforcementsGroupSkill / 100);
	if (_rushMode) then {
		_x disableAI "FSM";
	};
} forEach units _infantryGroup;

// FAILSAFE: Adjust group to match vehicle size
[_helicopter, _infantryGroup, "CARGO"] call reapercrew_reinforcements_fnc_adjustGroupToVehicle;

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
_waypoint setWaypointStatements ["true", "[this, 2000] spawn lambs_wp_fnc_taskRush; [leader this] call reapercrew_reinforcements_fnc_adjustGroupLeader;"];
_waypoint setWaypointForceBehaviour true;
_waypoint setWaypointBehaviour "AWARE";

_infantryGroup;

// Run extra code
_extraCodeString = format ['params ["_thisGroup"]; %1', _codeOnSpawnGroup];
_codeCompile = compile _extraCodeString;
[_infantryGroup] call _codeCompile;