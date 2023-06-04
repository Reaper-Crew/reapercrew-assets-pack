/*
 * Author: Xeenenta
 * Modifies the contents of an ammo crate
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call reapercrew_logistics_fnc_logisticsInitCrateIDF
 *
 * Public: No
 */

params ["_supplyCrate"];

// Only run when object local
if (!local _supplyCrate) exitWith {diag_log "[LOGISTICS]: Local check failed - skipping crate init"};

_IDFOffensive = reaperCrew_IDFExplosiveRounds splitString ",";
_IDFUtility = reaperCrew_IDFUtility splitString ",";

clearItemCargoGlobal _supplyCrate;
clearWeaponCargoGlobal _supplyCrate;
clearMagazineCargoGlobal _supplyCrate;
clearBackpackCargoGlobal _supplyCrate;

{_supplyCrate addMagazineCargoGlobal [_x, 50];} forEach _IDFOffensive;
{_supplyCrate addMagazineCargoGlobal [_x, 25];} forEach _IDFUtility;