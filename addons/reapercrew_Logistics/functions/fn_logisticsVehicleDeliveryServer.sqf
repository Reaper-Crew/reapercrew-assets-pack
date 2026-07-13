params ["_vehicleClassname", "_spawnPosition", "_deliveryPoint"];

// Create vehicle
_createdVehicle = createVehicle [_vehicleClassname, _spawnPosition, [], 0, "NONE"];
_createdVehicle setPos _spawnPosition;

_createdVehicle allowDamage false;

// Run custom vehicle code if defined (local only)
if (local _createdVehicle) then {
	_onVehicleCreated = missionNamespace getVariable ["reaperCrew_vehicleDelivery_onVehicleCreated", {}];
	[_createdVehicle, _spawnPosition, _deliveryPoint] call _onVehicleCreated;
};

// Create Driver
_spawnedGroup = [_spawnPosition, civilian, ["C_Man_casual_1_F"], [],[],[],[],[],180] call BIS_fnc_spawnGroup;
// The driver is deleted at the delivery waypoint, so auto-delete the group once it empties
_spawnedGroup deleteGroupWhenEmpty true;
_spawnedGroup allowFleeing 0;

_spawnedGroup setBehaviour "CARELESS";
{
	
	_x disableAI "FSM";
	_x disableAI "AUTOTARGET";
	_x disableAI "AUTOCOMBAT";
	_x setSkill 1;
	_x moveInAny _createdVehicle;

	_x allowDamage false;

	removeAllWeapons _x;
	removeAllItems _x;
	removeAllAssignedItems _x;
	removeUniform _x;
	removeVest _x;
	removeBackpack _x;
	removeHeadgear _x;
	removeGoggles _x;

	_x forceAddUniform "U_BG_Guerilla2_1";
	_x addHeadgear "RC_Beret_01";
	_x linkItem "ItemMap";
	_x linkItem "ItemCompass";
	_x linkItem "ItemWatch";
	_x linkItem "ItemGPS";	

} forEach units _spawnedGroup;

// Run custom driver code if defined (local only)
_onDriverCreated = missionNamespace getVariable ["reaperCrew_vehicleDelivery_onDriverCreated", {}];
{
	if (local _x) then {
		[_x, _createdVehicle, _spawnPosition, _deliveryPoint] call _onDriverCreated;
	};
} forEach units _spawnedGroup;

_waypoint = _spawnedGroup addWaypoint [_deliveryPoint, -1];
_waypoint setWaypointStatements ["true", "(vehicle this) engineOn false; (vehicle this) allowDamage true; {deleteVehicle _x} forEach thisList"];
_waypoint setWaypointTimeout [5, 7.5, 10];
