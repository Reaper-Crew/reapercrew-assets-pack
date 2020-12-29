// Get all notable locations with 25km of an object
_nearbyLocations = nearestLocations [(getMarkerPos "hq"), ["Airport", "NameCity", "NameCityCapital", "NameMarine", "NameVillage", "FlatArea", "FlatAreaCity"], 30000];
// Select one of the locations at random
_randomLocation = selectRandom _nearbyLocations;
// Get the position of the location
_locationPos = locationPosition _randomLocation;

// Create a task
[true, ["pickupTask"], ["Pickup infantry in the field", "Pickup troops"], _locationPos, "ASSIGNED", 1, true] call BIS_fnc_taskCreate;

// Create a trigger to pop smoke
_trigger = createTrigger ["EmptyDetector", _locationPos];
_trigger setTriggerArea [1500,1500,0,false];
_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_trigger setTriggerStatements ["this", "[getPos thisTrigger] call reapercrew_training_fnc_createLZSmoke;", ""];

// Create a trigger to spawn mounting troops
_triggerMount = createTrigger ["EmptyDetector", _locationPos];
_triggerMount setTriggerArea [500,500,0,false];
_triggerMount setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_triggerMount setTriggerStatements ["this && {isTouchingGround _x} count thisList > 0;", "[getPos thisTrigger] call reapercrew_training_fnc_createPickupTroops;", ""];

// Create a trigger to spawn mounting troops
_triggerEnd = createTrigger ["EmptyDetector", (getPos player)];
_triggerEnd setTriggerArea [0,0,0,false];
_triggerEnd setTriggerActivation ["NONE", "PRESENT", false];
_triggerEnd setTriggerStatements ["!alive (assignedVehicle player) || !canMove (assignedVehicle player);", "'loser' call BIS_fnc_endMission;", ""];