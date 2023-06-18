/*
    File: fn_getUnitRole.sqf
    Author: Havoc
    Description: Returns the given unit's role.
*/

params [
	"_unit"
];

private _customRole = _unit getVariable ["DT_role","unassigned"];
if (_customRole isNotEqualTo "unassigned") exitWith {
    getText(missionConfigFile >> "Dynamic_Roles" >> _customRole >> "name");
};

if (roleDescription _unit isEqualTo "") exitWith { "Soldier" };

private _role = (roleDescription _unit splitString "@") # 0;

if (_role isEqualTo "") then { _role = roleDescription _unit };

_role
