params ["_spawnPosition"];

// Create the infantry team
_groupSide = playerSide;

// Get the players current vehicle
_playerVehicle = assignedVehicle player;

_spawnPosition = _playerVehicle getRelPos [100, (Random 360)];

_pickupGroup = [_spawnPosition, _groupSide, ["B_Soldier_TL_F","B_soldier_AR_F","B_Soldier_GL_F","B_soldier_LAT_F"]] call BIS_fnc_spawnGroup;

// Get the leader of the group
_groupLeader = leader _pickupGroup;

{
	_x assignAsCargo _playerVehicle;
	[_x] orderGetIn true;
} forEach units _pickupGroup;

_groupLeader addEventHandler ["GetInMan", {
	params ["_vehicle", "_role", "_unit", "_turret"];

	// Assign tasking
	["pickupTask","SUCCEEDED"] call BIS_fnc_taskSetState;
	[true, ["dropoffTask"], ["Drop troops back at base", "Drop Off troops"], (getMarkerPos "hq"), "ASSIGNED", 1, true] call BIS_fnc_taskCreate;

	// Create dropoff trigger
	_triggerDropOff = createTrigger ["EmptyDetector", (getMarkerPos "hq")];
	_triggerDropOff setTriggerArea [250,250,0,false];
	_triggerDropOff setTriggerActivation ["ANYPLAYER", "PRESENT", false];
	_triggerDropOff setTriggerStatements ["this && {isTouchingGround _x} count thisList > 0;", '["dropoffTask","SUCCEEDED"] call BIS_fnc_taskSetState; _fullCrew = fullCrew [(assignedVehicle player), "cargo", false] apply { _x select 0 }; { deleteVehicle _x } forEach _fullCrew; [] execVM "fn_startTraining.sqf";', ""];

}];

["TaskSucceeded",["","Fireteam en route"]] call BIS_fnc_showNotification;