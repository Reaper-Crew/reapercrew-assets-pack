/*
* Author: Xeenenta
* A function used to determine and add a pathway variable
*
* Arguments:
* 0: Vehicle Object <OBJECT>
* 1: Group <GROUP>
* 1: Type of slots <STRING> Options: FULL, CARGO
*
* Return Value:
* Size of group <INT>
*
* Example:
* [myVehicle, myGroup, "FULL"] call reapercrew_reinforcements_fnc_adjustGroupToVehicle
*
* Public: No
*/

params ["_groupVehicle", "_group", "_type"];

_groupVehicleSize = 0;

switch (_type) do {
	case "FULL": { 
		_groupVehicleSize = count (fullCrew [_groupVehicle, "", true]);
	};
	case "CARGO": { 
		_groupVehicleSize = (count (fullCrew [_groupVehicle, "cargo", true]))
	};
};

_groupSize = count (units _group);

while { _groupSize >  _groupVehicleSize} do {
	_deleteUnit = selectRandom (units _group);
	deleteVehicle _deleteUnit;
	_groupSize = count (units _group);
};

_groupSize;