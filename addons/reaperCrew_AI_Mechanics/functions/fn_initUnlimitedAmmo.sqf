/*
* Author: Xeenenta
* Applies unlimited ammo to all vehicles synchronised to this module.
* The Fired EH runs where the vehicle is local and setVehicleAmmo has
* local effect, so the EH is added on all machines via remoteExec with
* JIP to handle locality transfers.
*
* Arguments:
* 0: Logic <LOGIC>
* 1: Synchronised Units <ARRAY>
* 2: Activated <BOOL>
*
* Return Value:
* None
*
* Example:
* [_logic] call reapercrew_ai_mechanics_fnc_initUnlimitedAmmo
*
* Public: No
*/

_logic = param [0, objNull, [objNull]];
_units = param [1, [], [[]]];
_activated = param [2, true, [true]];

if (!isServer) exitWith {};

_syncedVehicles = synchronizedObjects _logic;

{
	if (_x isKindOf "AllVehicles" && !(_x isKindOf "Man")) then {
		[_x, {
			params ["_vehicle"];
			_vehicle addEventHandler ["Fired", {
				(_this select 0) setVehicleAmmo 1;
			}];
		}] remoteExec ["call", 0, _x];
	};
} forEach _syncedVehicles;
