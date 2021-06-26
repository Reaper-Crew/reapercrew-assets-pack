/*
 * Author: Xeenenta
 * Create a standard ammo crate
 *
 * Arguments:
 * 0: Object <OBJECT> 
 *
 * Return Value:
 * _supplyCrate <OBJECT> 
 *
 * Example:
 * [_object, "smallArms"] call reapercrew_logistics_fnc_logisticsCreateSupplyCrate
 *
 * Public: No
 */

params ["_resupplyObject", "_crateType"];

_classname = "";

switch (_crateType) do {
	case "smallArms": {
		_classname = "ReaperCrew_PlatoonAmmo_Base";
	};
	case "medical": {
		_classname = "ReaperCrew_PlasticCase_Medical";
	};
	case "82Mortar": {
		_classname = "ReaperCrew_Shells82";
	};
	case "vehicleFuel": {
		_classname = "RC_CargoNet_01_barrels_F";
	};
	case "vehicleAmmo": {
		_classname = "RC_VirtualReammoBox_F";
	};
	case "emptyTransport": {
		_classname = "Land_WoodenCrate_01_F";
	};
};

// Crate Variables
_supplyCrate = _classname createVehicle position player;
[_resupplyObject, _supplyCrate, [([-10,10] call BIS_fnc_randomInt), -3, 0], 0] call BIS_fnc_relPosObject;
_supplyCrate enableSimulationGlobal true;

if (_crateType == "smallArms") then {
	[_supplyCrate] call reapercrew_logistics_fnc_logisticsPopulateSupplyCrate;
};

// Return the created crate
_supplyCrate;