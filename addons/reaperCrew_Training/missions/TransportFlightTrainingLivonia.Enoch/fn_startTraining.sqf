// Get the list of DLCs owned by the player
_DLCList = getDLCs 1;
_aircraftList = ["B_Heli_Transport_03_unarmed_F", "B_Heli_Light_01_F", "B_Heli_Transport_01_F", "O_Heli_Transport_04_covered_F", "O_Heli_Light_02_unarmed_F", "I_Heli_Transport_02_F", "I_Heli_light_03_unarmed_F"];

if (1042220 in _DLCList) then {
	_aircraftList = _aircraftList + ["gm_ge_army_ch53g", "gm_ge_army_bo105p1m_vbh_swooper"];
};

_helicopter = (selectRandom (_aircraftList)) createVehicle position helipad1;

// If this is a loop, remove them from the previous vehicle
player leaveVehicle (assignedVehicle player);
unassignVehicle player;
deleteVehicle (assignedVehicle player);
player setPos (getPos helipad1);
player addRating 1000000; 

// Move player into the new vehicle
player assignAsDriver _helicopter;
player moveInDriver _helicopter;

[player] call ace_medical_treatment_fnc_fullHealLocal;
player allowDamage false;

// Get all notable locations with 25km of an object
_nearbyLocations = nearestLocations [(getMarkerPos "hq"), ["Airport", "NameCity", "NameCityCapital", "NameMarine", "NameVillage", "FlatArea", "FlatAreaCity"], 30000];
// Select one of the locations at random
_randomLocation = selectRandom _nearbyLocations;
// Get the position of the location
_locationPos = locationPosition _randomLocation;

_position = _locationPos findEmptyPosition [0,100, "B_Heli_Transport_03_F"];

// Create a task
[true, ["pickupTask"], ["Pickup infantry in the field", "Pickup troops"], _position, "ASSIGNED", 1, true] call BIS_fnc_taskCreate;

// Create a trigger to pop smoke
_trigger = createTrigger ["EmptyDetector", _position];
_trigger setTriggerArea [1500,1500,0,false];
_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_trigger setTriggerStatements ["this", "[getPos thisTrigger] execVM 'fn_createLZSmoke.sqf';", ""];

// Create a trigger to spawn mounting troops
_triggerMount = createTrigger ["EmptyDetector", _position];
_triggerMount setTriggerArea [500,500,0,false];
_triggerMount setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_triggerMount setTriggerStatements ["this && {isTouchingGround _x} count thisList > 0;", "[getPos thisTrigger] execVM 'fn_createPickupTroops.sqf';", ""];

// // Create a trigger to spawn mounting troops
// _triggerEnd = createTrigger ["EmptyDetector", (getPos player)];
// _triggerEnd setTriggerArea [0,0,0,false];
// _triggerEnd setTriggerActivation ["NONE", "PRESENT", false];
// _triggerEnd setTriggerStatements ["!alive (assignedVehicle player) || !canMove (assignedVehicle player);", "'loser' call BIS_fnc_endMission;", ""];

//Start again if the player wrecks their vehicle
_triggerEnd = createTrigger ["EmptyDetector", (getPos player)];
_triggerEnd setTriggerArea [0,0,0,false];
_triggerEnd setTriggerActivation ["NONE", "PRESENT", false];
_triggerEnd setTriggerStatements ["!alive (assignedVehicle player) || !canMove (assignedVehicle player);", "[] execVM 'fn_startTraining.sqf';", ""];