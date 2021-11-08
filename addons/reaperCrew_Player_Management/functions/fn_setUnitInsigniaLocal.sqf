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
 * [] call reapercrew_common_fnc_setUnitInsigniaLocal
 *
 * Public: No
 */

if (hasInterface) then {

	_roleDesc = roleDescription player;

	diag_log format ["[Reaper Crew]: Setting role insignia. Current role is: %1", _roleDesc];

	switch (_roleDesc) do {
		// Zero
		case "Platoon Sergeant": {
			[player, "ReaperCrew_PlatoonSergeant"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player setRank "MAJOR";
		};
		case "Logistics Commander": {
			[player, "ReaperCrew_platoonLogiCommand"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
		case "Platoon JTAC": {
			[player, "ReaperCrew_jtac"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
		case "Platoon Medic": {
			[player, "ReaperCrew_platoonMedic"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
		// Section Roles
		// Yellow
		case "Medic": {
			[player, "ReaperCrew_Medic"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player setRank "CAPTAIN";
			player assignTeam "YELLOW";
		};
		// BLUE
		case "Section 2IC": {
			[player, "ReaperCrew_2IC"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player setRank "MAJOR";
			player assignTeam "RED";
		};
		case "Machine Gunner": {
			[player, "ReaperCrew_Machinegunner"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player assignTeam "BLUE";
		};
		case "Assist. Machine Gunner": {
			[player, "ReaperCrew_MG_ASSIST"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player assignTeam "BLUE";
		};
		case "Sharpshooter": {
			[player, "ReaperCrew_Marksman"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player assignTeam "BLUE";
		};
		// RED
		case "Section 3IC": {
			[player, "ReaperCrew_2IC"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player setRank "MAJOR";
			player assignTeam "BLUE";
		};
		case "Rifleman": {
			[player, "ReaperCrew_Rifleman"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player assignTeam "RED";
		};
		case "Rifleman (AT)": {
			[player, "ReaperCrew_AT"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player assignTeam "RED";
		};
		case "AT Specialist": {
			[player, "ReaperCrew_AT"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player assignTeam "RED";
		};
		case "Assist. AT Specialist": {
			[player, "ReaperCrew_AT"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player assignTeam "RED";
		};
		case "Rifleman (AA)": {
			[player, "ReaperCrew_AA"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player assignTeam "RED";
		};
		case "Engineer": {
			[player, "ReaperCrew_Engineer"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player assignTeam "RED";
		};
		case "Explosives Specialist": {
			[player, "ReaperCrew_EOD"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player assignTeam "RED";
		};
		case "Vehicle Crew": {
			[player, "ReaperCrew_Armoured_Crew"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player assignTeam "GREEN";
		};
		case "Battery Gunner": {
			[player, "ReaperCrew_Artilleryman"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player assignTeam "GREEN";
		};
		default {
			[player, "reaperCrewInsignia"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
	};

	_isPlatoonCommander = ["Platoon Commander", _roleDesc] call BIS_fnc_inString;
	_isSectionCommander = ["Section Commander", _roleDesc] call BIS_fnc_inString;
	_isVehicleCommander = ["Vehicle Commander", _roleDesc] call BIS_fnc_inString;
	_isBatteryCommander = ["Battery Commander", _roleDesc] call BIS_fnc_inString;

	// Role names with extensions
	if ( _isPlatoonCommander ) then {
		[player, "ReaperCrew_PlatoonCommander"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		player setRank "COLONEL";
	};
	if ( _isSectionCommander ) then {
		[player, "ReaperCrew_SectionCommander"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		player setRank "COLONEL";
		player assignTeam "YELLOW";
	};
	if ( _isVehicleCommander ) then {
		[player, "ReaperCrew_Armoured_Commander"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		player setRank "COLONEL";
	};
	if ( _isBatteryCommander ) then {
		[player, "ReaperCrew_Arty_Commander"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		player setRank "COLONEL";
	};
};