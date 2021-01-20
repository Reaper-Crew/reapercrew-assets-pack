params ["_attachVehicle"];

diag_log "Creating Radar truck";
diag_log format ["Using vehicle: %1", _attachVehicle];

// Initialise Variables
_createdTurret = [];

// Get Vehicle Data
_vehicleDirection = getDir _attachVehicle;

// Create the AA turret
_createdTurret = [(_attachVehicle getRelPos [5, 90]), _vehicleDirection, "B_Radar_System_01_F", west] call BIS_fnc_spawnVehicle;
_vehicleObject = _createdTurret select 0;
_createdCrew = _createdTurret select 1;
_createdGroup = _createdTurret select 2;

// Attach to the vehicle
_vehicleObject attachTo [_attachVehicle, [0, -7, 1]]; 

//Synchronise the change in multiplayer
_vehicleObject setPos getPos _vehicleObject;