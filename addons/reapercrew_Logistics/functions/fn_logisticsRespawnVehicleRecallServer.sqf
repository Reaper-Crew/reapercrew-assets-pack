params ["_deliveryPoint"];

// Get existing vehicle vehicle
_respawn_vehicle = [missionNamespace, "reaperCrew_respawn_vehicle", objNull] call BIS_fnc_getServerVariable;
[(format ["Found respawn vehicle: %1", _respawn_vehicle])] call reapercrew_common_fnc_remoteLog;

// Create Driver
_spawnedGroup = [[0,0,0], civilian, ["C_Man_casual_1_F"], [],[],[],[],[],180] call BIS_fnc_spawnGroup;
_spawnedGroup allowFleeing 0;

_spawnedGroup setBehaviour "CARELESS";
{
	
	_x disableAI "FSM";
	_x disableAI "AUTOTARGET";
	_x disableAI "AUTOCOMBAT";
	_x setSkill 1;
	_x moveInDriver _respawn_vehicle;

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

_waypoint = _spawnedGroup addWaypoint [_deliveryPoint, -1];
_waypoint setWaypointStatements ["true", "(vehicle this) engineOn false; (vehicle this) allowDamage true; {deleteVehicle _x} forEach thisList"];
_waypoint setWaypointTimeout [5, 7.5, 10];