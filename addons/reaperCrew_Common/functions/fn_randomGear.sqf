/*
 * Author: Xeenenta
 * Randomises the gear of a unit based on configuration values
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit] call reapercrew_common_fnc_randomGear
 *
 * Public: No
 */

params ["_unit"];

if (!local _unit) exitWith {};

// removeAllWeapons _unit;
// removeAllItems _unit;
// removeAllAssignedItems _unit;
// removeUniform _unit;
// removeVest _unit;
// removeBackpack _unit;
// removeHeadgear _unit;
// removeGoggles _unit;

// Randomise the uniform
private _uniformList = (configOf _unit >> "uniformList") call BIS_fnc_getCfgDataArray;
if (count _uniformList > 0) then {
	_unit forceAddUniform (selectRandom _uniformList);
	// Add uniform items
	for "_i" from 1 to 4 do {_unit addItemToUniform "SmokeShellGreen";};
	for "_i" from 1 to 6 do {_unit addItemToUniform "SmokeShell";};
};

// Randomise the helmet
private _helmetList = (configOf _unit >> "helmetList") call BIS_fnc_getCfgDataArray;
if (count _helmetList > 0) then {
	_unit addHeadgear (selectRandom _helmetList);
};

// Randomise the backpack
private _backpackList = (configOf _unit >> "backpackList") call BIS_fnc_getCfgDataArray;
if (count _backpackList > 0) then {
	_unit addBackpack (selectRandom _backpackList);
};

// Randomise the vest
private _vestList = (configOf _unit >> "vestList") call BIS_fnc_getCfgDataArray;
if (count _vestList > 0) then {
	_unit addVest (selectRandom _vestList);
};

// Randomise the facewear
private _goggleList = (configOf _unit >> "facewearList") call BIS_fnc_getCfgDataArray;
if (count _goggleList > 0) then {
	_unit addGoggles (selectRandom _goggleList);
};

private _binocularClassname = (configOf _unit >> "binocular") call BIS_fnc_getCfgData;
// Add Binoculars
_unit addWeapon _binocularClassname;

// Add primary weapon
private _primaryWeaponClassname = (configOf _unit >> "weaponsList" >> "primaryWeapon" >> "classname") call BIS_fnc_getCfgData;
private _primaryWeaponItems = (configOf _unit >> "weaponsList" >> "primaryWeapon" >> "weaponItems") call BIS_fnc_getCfgDataArray;
private _primaryWeaponMagazine = (configOf _unit >> "weaponsList" >> "primaryWeapon" >> "magazine") call BIS_fnc_getCfgData;
private _primaryWeaponMagazineCount = (configOf _unit >> "weaponsList" >> "primaryWeapon" >> "magazineCount") call BIS_fnc_getCfgData;

if (_primaryWeaponMagazineCount > 0) then {
	// Weapon + items
	_unit addWeapon _primaryWeaponClassname;
	{ _unit addPrimaryWeaponItem _x; } forEach _primaryWeaponItems;
	_unit addPrimaryWeaponItem _primaryWeaponMagazine;

	// Ammo
	for "_i" from 1 to _primaryWeaponMagazineCount do {_unit addItemToVest 	_primaryWeaponMagazine;};
};

// Add Secondary weapon
private _SecondaryWeaponClassname = (configOf _unit >> "weaponsList" >> "SecondaryWeapon" >> "classname") call BIS_fnc_getCfgData;
private _SecondaryWeaponItems = (configOf _unit >> "weaponsList" >> "SecondaryWeapon" >> "weaponItems") call BIS_fnc_getCfgDataArray;
private _SecondaryWeaponMagazine = (configOf _unit >> "weaponsList" >> "SecondaryWeapon" >> "magazine") call BIS_fnc_getCfgData;
private _SecondaryWeaponMagazineCount = (configOf _unit >> "weaponsList" >> "SecondaryWeapon" >> "magazineCount") call BIS_fnc_getCfgData;

if (_SecondaryWeaponMagazineCount > 0) then {
	// Weapon + items
	_unit addWeapon _SecondaryWeaponClassname;
	{ _unit addSecondaryWeaponItem _x; } forEach _SecondaryWeaponItems;
	_unit addSecondaryWeaponItem _SecondaryWeaponMagazine;

	// Ammo
	for "_i" from 1 to _SecondaryWeaponMagazineCount do {_unit addItemToVest 	_SecondaryWeaponMagazine;};
};

// Add Launcher weapon
private _LauncherWeaponClassname = (configOf _unit >> "weaponsList" >> "LauncherWeapon" >> "classname") call BIS_fnc_getCfgData;
private _LauncherWeaponItems = (configOf _unit >> "weaponsList" >> "LauncherWeapon" >> "weaponItems") call BIS_fnc_getCfgDataArray;
private _LauncherWeaponMagazine = (configOf _unit >> "weaponsList" >> "LauncherWeapon" >> "magazine") call BIS_fnc_getCfgData;
private _LauncherWeaponMagazineCount = (configOf _unit >> "weaponsList" >> "LauncherWeapon" >> "magazineCount") call BIS_fnc_getCfgData;

if (_LauncherWeaponMagazineCount > 0) then {
	// Weapon + items
	_unit addWeapon _LauncherWeaponClassname;

	// Ammo
	for "_i" from 1 to _LauncherWeaponMagazineCount do {_unit addItemToVest 	_LauncherWeaponMagazine;};
};

// Add extra items
private _vestItems = (configOf _unit >> "additionalItems" >> "vestItems") call BIS_fnc_getCfgDataArray;
private _backpackItems = (configOf _unit >> "additionalItems" >> "backpackItems") call BIS_fnc_getCfgDataArray;
private _linkedItems = (configOf _unit >> "additionalItems" >> "linkedItems") call BIS_fnc_getCfgDataArray;

{
	_itemClass = _x select 0;
	_itemCount = _x select 1;
	for "_i" from 1 to _itemCount do {_unit addItemToVest _itemClass;};
} forEach _vestItems;

{
	_itemClass = _x select 0;
	_itemCount = _x select 1;
	for "_i" from 1 to _itemCount do {_unit addItemToBackpack _itemClass;};
} forEach _backpackItems;

{
	_unit linkItem _x;
} forEach _linkedItems;
