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
		case "Platoon Sergeant": {
			[player, "ReaperCrew_PlatoonSergeant"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player setRank "MAJOR";
		};
		case "Logistics Commander": {
			[player, "ReaperCrew_jtac"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
		case "Platoon JTAC": {
			[player, "ReaperCrew_jtac"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
		case "Platoon Medic": {
			[player, "ReaperCrew_platoonMedic"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player setRank "CAPTAIN";
		};
		case "Section 2IC": {
			[player, "ReaperCrew_2IC"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player setRank "MAJOR";
		};
		case "Medic": {
			[player, "ReaperCrew_Medic"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
			player setRank "CAPTAIN";
		};
		case "Machine Gunner": {
			[player, "ReaperCrew_Machinegunner"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
		case "Marksman": {
			[player, "ReaperCrew_Marksman"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
		case "Rifleman": {
			[player, "ReaperCrew_Rifleman"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
		case "Rifleman (AT)": {
			[player, "ReaperCrew_AT"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
		case "Rifleman (AA)": {
			[player, "ReaperCrew_AA"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
		case "Engineer": {
			[player, "ReaperCrew_Engineer"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
		case "Explosives Specialist": {
			[player, "ReaperCrew_EOD"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
		default {
			[player, "reaperCrewInsignia"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		};
	};

	_isPlatoonCommander = ["Platoon Commander", _roleDesc] call BIS_fnc_inString;
	_isSectionCommander = ["Section Commander", _roleDesc] call BIS_fnc_inString;

	// Role names with extensions
	if ( _isPlatoonCommander ) then {
		[player, "ReaperCrew_PlatoonCommander"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		player setRank "COLONEL";
	};
	if ( _isSectionCommander ) then {
		[player, "ReaperCrew_SectionCommander"] remoteExecCall ["BIS_fnc_setUnitInsignia", 0, true];
		player setRank "COLONEL";
	};

};