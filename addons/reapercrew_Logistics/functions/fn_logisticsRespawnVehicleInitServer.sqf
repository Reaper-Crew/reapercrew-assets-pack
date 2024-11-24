/*
 * Author: Xeenenta
 * Adds the create actions to the passed object
 *
 * Arguments:
 * 0: N/A
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call reapercrew_logistics_fnc_logisticsRespawnVehicleInitServer
 *
 * Public: No
 */
 
params ["_logic"];

// Variables
_units = [];

if !(isServer) exitWith {["Server check failed - not running"] call reapercrew_common_fnc_remoteLog;};

// Check for attached units - If used in Zeus
["Checking for attached units"] call reapercrew_common_fnc_remoteLog;
_attachedObject = attachedTo _logic;
if (!isNull _attachedObject) then {
	[format ["Found attached unit: %1", _attachedObject]] call reapercrew_common_fnc_remoteLog;
	_units pushBack _attachedObject;
};

// Checking for attached units - If used in Eden
["Checking for synchronizedObjects"] call reapercrew_common_fnc_remoteLog;
_syncObjects = synchronizedObjects _logic;
// Check if the array is empty
if (count _syncObjects > 0) then {
	// If not empty, push all of the sync units into the _units array
	{
		[format ["Found syncronised unit: %1", _x]] call reapercrew_common_fnc_remoteLog;
		_units pushBack _x;
	} forEach _syncObjects;
};

// Check to see if we've picked up any units at all
if (count _units == 0) exitWith {["No units defined, exiting"] call reapercrew_common_fnc_remoteLog;};

[(format ["Affected Units: %1", _units])] call reapercrew_common_fnc_remoteLog;

// Setup logistical vehicle - Only picks the first in the array!
_selectedUnit = _units select 0;
[(format ["Selected Units: %1", _selectedUnit])] call reapercrew_common_fnc_remoteLog;

// Setup Unit
_selectedUnit allowDamage false;
// Public Variable
missionNamespace setVariable ["reaperCrew_respawn_vehicle", _selectedUnit];

[_selectedUnit] spawn {
	params ["_respawnVehicle"];
	while {reaperCrew_respawnVehicleRefreshSupplies} do {
		// Small Arms
		[_respawnVehicle] call reapercrew_logistics_fnc_logisticsInitCrateSmallArms;
		// Medical
		_respawnVehicle addItemCargoGlobal ["ACE_bloodIV", 15];
		_respawnVehicle addItemCargoGlobal ["ACE_bloodIV_500", 12];
		_respawnVehicle addItemCargoGlobal ["ACE_bloodIV_250", 4];
		_respawnVehicle addItemCargoGlobal ["ACE_elasticBandage", 100];
		_respawnVehicle addItemCargoGlobal ["ACE_quikclot", 100];
		_respawnVehicle addItemCargoGlobal ["ACE_packingBandage", 100];
		_respawnVehicle addItemCargoGlobal ["ACE_adenosine", 20];
		_respawnVehicle addItemCargoGlobal ["ACE_epinephrine", 50];
		_respawnVehicle addItemCargoGlobal ["ACE_morphine", 20];
		_respawnVehicle addItemCargoGlobal ["ACE_tourniquet", 20];
		_respawnVehicle addItemCargoGlobal ["ACE_splint", 20];
		_respawnVehicle addItemCargoGlobal ["ACE_personalAidKit", 2];	
		sleep (reaperCrew_respawnVehicleRefreshSuppliesFrequency * 60);
	};
};

// Add event handler to players
[] remoteExec ["reapercrew_logistics_fnc_logisticsRespawnVehicleInitPlayer", 0, true];



// reaperCrew_IDFCrate
// reaperCrew_VehicleFuelCheckbox
// reaperCrew_VehicleAmmoCheckbox