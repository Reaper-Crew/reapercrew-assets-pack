/*
 * Author: Xeenenta
 * Consolidates the nearby supplies into the cargo container
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call reapercrew_logistics_fnc_logisticsConsolidateSupplies
 *
 * Public: No
 */

params ["_cargoContainer"];

// Get all nearby containers of a specific type
_nearestObjects = nearestObjects [_cargoContainer, ["ReaperCrew_PlasticCase_Medical", "ReaperCrew_SupplyCrate", "ReaperCrew_Shells82", "ReaperCrew_Shells105CUP", "ReaperCrew_Shells122CUP"], 250];

// Loop through each container
{
	// Get a list of supplies
	_itemsList = itemCargo _x;
	_weaponsList = weaponCargo _x;
	_magazineList = magazineCargo _x;

	// Add them to the cargo container
	{_cargoContainer addItemCargoGlobal [_x, 1]; } forEach _itemsList;
	{_cargoContainer addWeaponCargoGlobal [_x, 1]; } forEach _weaponsList;
	{_cargoContainer addMagazineCargoGlobal [_x, 1]; } forEach _magazineList;

	// Delete the old vehicle
	deleteVehicle _x;

} forEach _nearestObjects;