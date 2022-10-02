/*
 * Author: Xeenenta
 * Function that executes locally to configure the Insignia
 *
 * Arguments:
 * 0: Logic <LOGIC>
 * 1: 
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call reapercrew_player_management_fnc_setUnitInsigniaLocal
 
 *
 * Public: No
 */

if (hasInterface) then {

	_roleDesc = roleDescription player;
	_groupName = groupId (group player);

	diag_log format ["[PLAYER MANAGEMENT]: Setting role insignia. Current role is: %1 and group is %2", _roleDesc, _groupName];

	// Create classname
	// Remove invalid characters
	_characterDict = [
		["-","_"],
		[" ",""]
	];
	{
		_roleDesc = (_roleDesc regexReplace [_x select 0, _x select 1]);
		_groupName = (_groupName regexReplace [_x select 0, _x select 1]); 
	} forEach _characterDict;

	// Overwrite group leaders role names
	_isPlatoonCommander = ["Platoon Commander", _roleDesc] call BIS_fnc_inString;
	_isSectionCommander = ["Section Commander", _roleDesc] call BIS_fnc_inString;
	_isVehicleCommander = ["Vehicle Commander", _roleDesc] call BIS_fnc_inString;
	_isBatteryCommander = ["Battery Commander", _roleDesc] call BIS_fnc_inString;

	// Role names with extensions
	if ( _isPlatoonCommander ) then {
		_roleDesc = "PlatoonCommander";
		player setRank "COLONEL";
	};
	if ( _isSectionCommander ) then {
		_roleDesc = "SectionCommander";
		player setRank "COLONEL";
		player assignTeam "YELLOW";
	};
	if ( _isVehicleCommander ) then {
		_roleDesc = "VehicleCommander";
		player setRank "COLONEL";
	};
	if ( _isBatteryCommander ) then {
		_roleDesc = "BatteryCommander";
		player setRank "COLONEL";
	};	

	// Build String
	_constructClass = format ["reaperCrew_%1_%2", _groupName, _roleDesc];

	_classCheck = isClass (configFile >> "CfgUnitInsignia" >> _constructClass);

	if !(_classCheck) then {
		// If not found, set to default
		_constructClass = "reaperCrew_default_insignia";
		diag_log "[PLAYER MANAGEMENT]: Classname not found, using default signature";
	};
	diag_log format ["[PLAYER MANAGEMENT]: Using constructed classname %1", _constructClass];
	
	[player, _constructClass] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];

};