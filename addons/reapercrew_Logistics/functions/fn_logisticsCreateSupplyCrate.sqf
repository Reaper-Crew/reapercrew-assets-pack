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

params ["_resupplyObject", "_crateType", ["_spawningPlayer", objNull]];

_classname = "";

switch (_crateType) do {
	case "smallArms": {
		_classname = "ReaperCrew_SupplyCrateSmallArms";
	};
	case "medical": {
		_classname = "ReaperCrew_PlasticCase_Medical";
	};
	case "indirectFires": {
		_classname = "ReaperCrew_SupplyCrateIDF";
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
_supplyCrate = _classname createVehicle [0,0,0];
[_resupplyObject, _supplyCrate, [([-10,10] call BIS_fnc_randomInt), -3, 0], 0] call BIS_fnc_relPosObject;
_supplyCrate enableSimulationGlobal true;

switch (_crateType) do {
	case "smallArms": {
		[_supplyCrate] call reapercrew_logistics_fnc_logisticsInitCrateSmallArms;
	};
	case "medical": {
		_classname = "ReaperCrew_PlasticCase_Medical";
	};
	case "indirectFires": {
		_classname = "ReaperCrew_SupplyCrateIDF";
		[_supplyCrate] call reapercrew_logistics_fnc_logisticsInitCrateIDF;
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

// Removing because code temporarily broken
// if !(isNull _spawningPlayer) then {
// 	[_spawningPlayer, _supplyCrate] remoteExec ["ace_dragging_fnc_carryObject", _spawningPlayer]
// };

// Return the created crate
_supplyCrate;