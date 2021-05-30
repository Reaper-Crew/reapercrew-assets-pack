if (!isServer) exitWith {diag_log "SCENARIO: Server checked failed - skipping reinforcements system"};

diag_log "SCENARIO: Initialising reinforcements system";

// Global Variables
HeadlessClients = [];
InfantrySpawnTriggers = [];
VehicleSpawnTriggers = [];
AircraftSpawnTriggers = [];

activeInfantryTriggers = [];
activeVehicleTriggers = [];
activeAircraftTriggers = [];

rifleSection = reaperCrew_reinforcements_units splitString ",";
enemyTransportGround = reaperCrew_reinforcements_transportGround splitString ",";
enemyTransportHelicopter = reaperCrew_reinforcements_transportHelicopter splitString ",";

// Broadcast variables for use by the HCs
publicVariable "rifleSection";
publicVariable "enemyTransportGround";
publicVariable "enemyTransportHelicopter";

// Local Variables
_triggerCheckArray = [];

// Infantry Spawns
InfantrySpawns = [];
InfantrySpawns = entities "reaperCrew_moduleInfantrySpawn";

// Vehicle Spawns
VehicleSpawns = [];
VehicleSpawns = entities "reaperCrew_moduleVehicleSpawn";

// Aircraft Spawns
AircraftSpawns = [];
AircraftSpawns = entities "reaperCrew_moduleAircraftSpawn";

{
	// Outer Zone
	_outerZone = createTrigger ["EmptyDetector", position _x, true];
	_outerZone setTriggerArea [2000, 2000, 0, false, 20];
	_outerZone setTriggerActivation ["ANYPLAYER", "PRESENT", true];

	// Inner Zone
	_innerZone = createTrigger ["EmptyDetector", position _x, true];
	_innerZone setTriggerArea [500, 500, 0, false, 20];
	_innerZone setTriggerActivation ["ANYPLAYER", "NOT PRESENT", true];

	_triggerCheckArray = [_outerZone, _innerZone];

	InfantrySpawnTriggers pushBack _triggerCheckArray;
} forEach InfantrySpawns;

{
	// Outer Zone
	_outerZone = createTrigger ["EmptyDetector", position _x, true];
	_outerZone setTriggerArea [4000, 4000, 0, false, 20];
	_outerZone setTriggerActivation ["ANYPLAYER", "PRESENT", true];

	// Inner Zone
	_innerZone = createTrigger ["EmptyDetector", position _x, true];
	_innerZone setTriggerArea [1000, 1000, 0, false, 20];
	_innerZone setTriggerActivation ["ANYPLAYER", "NOT PRESENT", true];

	_triggerCheckArray = [_outerZone, _innerZone];

	VehicleSpawnTriggers pushBack _triggerCheckArray;
} forEach VehicleSpawns;

{
	// Outer Zone
	_outerZone = createTrigger ["EmptyDetector", position _x, true];
	_outerZone setTriggerArea [20000, 20000, 0, false, 20];
	_outerZone setTriggerActivation ["ANYPLAYER", "PRESENT", true];

	// Inner Zone
	_innerZone = createTrigger ["EmptyDetector", position _x, true];
	_innerZone setTriggerArea [5000, 5000, 0, false, 20];
	_innerZone setTriggerActivation ["ANYPLAYER", "NOT PRESENT", true];

	_triggerCheckArray = [_outerZone, _innerZone];

	AircraftSpawnTriggers pushBack _triggerCheckArray;
} forEach AircraftSpawns;

[] spawn {
	while { true } do {
		// Reset list of infantry spawns
		activeInfantryTriggers = [];
		{
			if (triggerActivated (_x select 0) and triggerActivated (_x select 1)) then {
				activeInfantryTriggers pushBack (_x select 0);
			};
		} forEach InfantrySpawnTriggers;
		if (reaperCrew_InfantrySpawnCheckbox == true) then {
			diag_log format ["SCENARIO: Found the following infantry spawns: %1", activeInfantryTriggers];
		};
		sleep 60;
	};
};

[] spawn {
	while { true } do {
		// Reset list of vehice spawns
		activeVehicleTriggers = [];
		{
			if (triggerActivated (_x select 0) and triggerActivated (_x select 1)) then {
				activeVehicleTriggers pushBack (_x select 0);
			};
		} forEach VehicleSpawnTriggers;
		if (reaperCrew_VehicleSpawnCheckbox == true) then {
			diag_log format ["SCENARIO: Found the following vehicle spawns: %1", activeVehicleTriggers];
		};
		sleep 60;
	};
};

[] spawn {
	while { true } do {
		// Reset list of vehice spawns
		activeAircraftTriggers = [];
		{
			if (triggerActivated (_x select 0) and triggerActivated (_x select 1)) then {
				activeAircraftTriggers pushBack (_x select 0);
			};
		} forEach AircraftSpawnTriggers;
		if (reaperCrew_AircraftSpawnCheckbox == true) then {
			diag_log format ["SCENARIO: Found the following Aircraft spawns: %1", activeAircraftTriggers];
		};
		sleep 60;
	};
};

// Headless Client check
[] spawn {
	while { true } do {
		// Reset list of headless clients
		HeadlessClients = entities "HeadlessClient_F";
		if (reaperCrew_HCDiscoveryCheckbox == true) then {
			diag_log format ["SCENARIO: Found the following headless clients: %1", HeadlessClients];
		};
		sleep 60;
	};
};