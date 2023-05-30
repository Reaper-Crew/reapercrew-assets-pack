/*
* Author: Xeenenta
* A function used to determine and add a pathway variable
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_reinforcements_fnc_getPathway
*
* Public: No
*/

params ["_spawnpointModule", "_spawnpointTrigger"];

_pathway = [];

_syncObjects = [_spawnpointModule,["reaperCrew_modulePathWaypoint"]] call BIS_fnc_synchronizedObjects;

{
	_pathway pushBack (getPos _x);
} forEach _syncObjects;

_spawnpointTrigger setVariable ["_reinforcementsPathway", _pathway, true];