/*
 * Author: Xeenenta
 * A script designed to be run locally on each player to trigger the proper respawn behavior
 *
 * Arguments:
 * 0: N/A
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call reapercrew_logistics_fnc_logisticsRespawnVehicleInitPlayer
 *
 * Public: No
 */

if !(hasInterface) exitWith {}; // Don't run on HCs

[(format ["Adding respawn event handler for: %1", (name player)])] call reapercrew_common_fnc_remoteLog;

player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
	[_unit, _corpse] spawn {
		params ["_unit", "_corpse"];
		if !(local _unit) exitWith {};
		sleep 2;

		// Get respawn truck from server
    	_respawn_vehicle = [missionNamespace, "reaperCrew_respawn_vehicle", objNull] call BIS_fnc_getServerVariable;
		[(format ["Found respawn vehicle: %1", _respawn_vehicle])] call reapercrew_common_fnc_remoteLog;
		player moveInAny _respawn_vehicle;
	};
}];

_actionsList = [];


// Define ACE Actions
_crateAction = ["Call HQ vehicle","Call HQ vehicle",'a3\ui_f\data\igui\cfg\simpletasks\types\car_ca.paa', 
{
	params ["_target", "_player", "_actionParams"];
	[] call reapercrew_logistics_fnc_logisticsRespawnVehicleRecallPlayer;
},
{
	_allowedGroups = reaperCrew_vehicleResupplyDeliveryGroups splitString ",";
	((groupId (group player)) in _allowedGroups)
},
{},
[] // Vehicle Classname
] call ace_interact_menu_fnc_createAction;
_actionsList pushBack _crateAction;

{
	[player, 1, ["ACE_SelfActions", "reapercrew_ACE_Logistics"], _x] call ace_interact_menu_fnc_addActionToObject;
} forEach _actionsList;