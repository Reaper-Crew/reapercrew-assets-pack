/*
 * Author: Xeenenta
 * Create a standard ammo crate
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call reapercrew_fnc_logisticsCreateSupplyCrate
 *
 * Public: No
 */

params ["_resupplyObject"];

// Small Arms
_rifleMagazines = reaperCrew_rifleMagazines splitString ",";
_grenadierAmmo = reaperCrew_grenadierAmmo splitString ",";
_sidearmMagazines = reaperCrew_sidearmMagazines splitString ",";
_machinegunMagazines = reaperCrew_machinegunMagazines splitString ",";
_marksmanMagazines = reaperCrew_MarksmanMagazines splitString ",";

// Launchers
_launcherAmmo = reaperCrew_LauncherAmmo splitString ",";
_singleUseLaunchers = reaperCrew_SingleUseLaunchers splitString ",";

// Projectiles
_lethalGrenades = reaperCrew_lethalGrenades splitString ",";
_nonLethalGrenades = reaperCrew_nonLethalGrenades splitString ",";
_smokeGrenades = reaperCrew_smokeGrenades splitString ",";
_allGrenades = _lethalGrenades + _nonLethalGrenades + _smokeGrenades;

// Crate Variables
_supplyCrate = "B_supplyCrate_F" createVehicle position player;
[_resupplyObject, _supplyCrate, [([-5,5] call BIS_fnc_randomInt), -3, 0], 0] call BIS_fnc_relPosObject;

clearItemCargoGlobal _supplyCrate;
clearWeaponCargoGlobal _supplyCrate;
clearMagazineCargoGlobal _supplyCrate;
clearBackpackCargoGlobal _supplyCrate;

// Small Arms
{_supplyCrate addMagazineCargoGlobal [_x, 64];} forEach _rifleMagazines;
{_supplyCrate addMagazineCargoGlobal [_x, 20];} forEach _grenadierAmmo;
{_supplyCrate addMagazineCargoGlobal [_x, 40];} forEach _sidearmMagazines;
{_supplyCrate addMagazineCargoGlobal [_x, 20];} forEach _machinegunMagazines;
{_supplyCrate addMagazineCargoGlobal [_x, 30];} forEach _marksmanMagazines;

// Launchers
{_supplyCrate addMagazineCargoGlobal [_x, 10];} forEach _launcherAmmo;
{_supplyCrate addWeaponCargoGlobal  [_x, 10];} forEach _singleUseLaunchers;

// Projectiles
{_supplyCrate addMagazineCargoGlobal [_x, 20];} forEach _allGrenades;