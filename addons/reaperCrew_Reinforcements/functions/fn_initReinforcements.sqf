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

enemyFireSupportHeavyArmour = reaperCrew_reinforcements_fireSupportHeavyArmour splitString ",";
enemyFireSupportLightArmour = reaperCrew_reinforcements_fireSupportLightArmour splitString ",";
enemyFireSupportTechnicals = reaperCrew_reinforcements_fireSupportTechnicals splitString ",";

// Broadcast variables for use by the HCs
// Infantry Reinforcement Settings
publicVariable "rifleSection";
publicVariable "enemyTransportGround";
publicVariable "enemyTransportHelicopter";
// Enemy Vehicle Settings
publicVariable "enemyFireSupportHeavyArmour";
publicVariable "enemyFireSupportLightArmour";
publicVariable "enemyFireSupportTechnicals";

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

	if (reaperCrew_SpawnpointsMapMarkers == true) then {
		_spawnMarkerName = format ["spawnMarker%1", [1,9999] call BIS_fnc_randomInt];
		_outerZoneMarkerName = format ["outerZone%1", [1,9999] call BIS_fnc_randomInt];
		_innerZoneMarkerName = format ["innerZone%1", [1,9999] call BIS_fnc_randomInt];
		// Spawn Point Marker
		_spawnMarker = createMarker [_spawnMarkerName, position _x];
		_spawnMarker setMarkerText "Infantry Spawnpoint";
		_spawnMarker setMarkerColor "colorOPFOR";
		_spawnMarker setMarkerType "mil_warning";
		// Outer Zone
		_outerZoneMarker = createMarker [_outerZoneMarkerName, position _x];
		_outerZoneMarker setMarkerSize [2000, 2000];
		_outerZoneMarker setMarkerColor "ColorBlue";
		_outerZoneMarker setMarkerShape "ELLIPSE";
		_outerZoneMarker setMarkerBrush "Border";
		// Inner Zone
		_innerZoneMarker = createMarker [_innerZoneMarkerName, position _x];
		_innerZoneMarker setMarkerSize [500, 500];
		_innerZoneMarker setMarkerColor "ColorRed";
		_innerZoneMarker setMarkerShape "ELLIPSE";
		_innerZoneMarker setMarkerBrush "Border";
	};

	_triggerCheckArray = [_outerZone, _innerZone];

	InfantrySpawnTriggers pushBack _triggerCheckArray;
} forEach InfantrySpawns;

{
	// Outer Zone
	_outerZone = createTrigger ["EmptyDetector", position _x, true];
	_outerZone setTriggerArea [5000, 5000, 0, false, 20];
	_outerZone setTriggerActivation ["ANYPLAYER", "PRESENT", true];

	// Inner Zone
	_innerZone = createTrigger ["EmptyDetector", position _x, true];
	_innerZone setTriggerArea [1000, 1000, 0, false, 20];
	_innerZone setTriggerActivation ["ANYPLAYER", "NOT PRESENT", true];

	if (reaperCrew_SpawnpointsMapMarkers == true) then {
		_spawnMarkerName = format ["spawnMarker%1", [1,9999] call BIS_fnc_randomInt];
		_outerZoneMarkerName = format ["outerZone%1", [1,9999] call BIS_fnc_randomInt];
		_innerZoneMarkerName = format ["innerZone%1", [1,9999] call BIS_fnc_randomInt];
		// Spawn Point Marker
		_spawnMarker = createMarker [_spawnMarkerName, position _x];
		_spawnMarker setMarkerText "Vehicle Spawnpoint";
		_spawnMarker setMarkerColor "colorOPFOR";
		_spawnMarker setMarkerType "mil_warning";
		// Outer Zone
		_outerZoneMarker = createMarker [_outerZoneMarkerName, position _x];
		_outerZoneMarker setMarkerSize [5000, 5000];
		_outerZoneMarker setMarkerColor "ColorBlue";
		_outerZoneMarker setMarkerShape "ELLIPSE";
		_outerZoneMarker setMarkerBrush "Border";
		// Inner Zone
		_innerZoneMarker = createMarker [_innerZoneMarkerName, position _x];
		_innerZoneMarker setMarkerSize [1000, 1000];
		_innerZoneMarker setMarkerColor "ColorRed";
		_innerZoneMarker setMarkerShape "ELLIPSE";
		_innerZoneMarker setMarkerBrush "Border";
	};

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

	if (reaperCrew_SpawnpointsMapMarkers == true) then {
		_spawnMarkerName = format ["spawnMarker%1", [1,9999] call BIS_fnc_randomInt];
		_outerZoneMarkerName = format ["outerZone%1", [1,9999] call BIS_fnc_randomInt];
		_innerZoneMarkerName = format ["innerZone%1", [1,9999] call BIS_fnc_randomInt];
		// Spawn Point Marker
		_spawnMarker = createMarker [_spawnMarkerName, position _x];
		_spawnMarker setMarkerText "Aircraft Spawnpoint";
		_spawnMarker setMarkerColor "colorOPFOR";
		_spawnMarker setMarkerType "mil_warning";
		// Outer Zone
		_outerZoneMarker = createMarker [_outerZoneMarkerName, position _x];
		_outerZoneMarker setMarkerSize [20000, 20000];
		_outerZoneMarker setMarkerColor "ColorBlue";
		_outerZoneMarker setMarkerShape "ELLIPSE";
		_outerZoneMarker setMarkerBrush "Border";
		// Inner Zone
		_innerZoneMarker = createMarker [_innerZoneMarkerName, position _x];
		_innerZoneMarker setMarkerSize [5000, 5000];
		_innerZoneMarker setMarkerColor "ColorRed";
		_innerZoneMarker setMarkerShape "ELLIPSE";
		_innerZoneMarker setMarkerBrush "Border";
	};

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