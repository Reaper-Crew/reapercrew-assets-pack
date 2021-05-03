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
 * [] call reapercrew_fnc_setUnitInsigniaLocal
 *
 * Public: No
 */

if (!isServer) then {

	_roleDesc = roleDescription player;

	diag_log format ["[Reaper Crew] Setting role insignia. Current role is: %1", _roleDesc];

	switch (_roleDesc) do {
		case "Platoon Sergeant": {
			[player, "ReaperCrew_PlatoonSergeant"] call BIS_fnc_setUnitInsignia;
		};
		case "Logistics Commander": {
			[player, "ReaperCrew_jtac"] call BIS_fnc_setUnitInsignia;
		};
		case "Platoon JTAC": {
			[player, "ReaperCrew_jtac"] call BIS_fnc_setUnitInsignia;
		};
		case "Platoon Medic": {
			[player, "ReaperCrew_platoonMedic"] call BIS_fnc_setUnitInsignia;
		};
		case "Section 2IC": {
			[player, "ReaperCrew_2IC"] call BIS_fnc_setUnitInsignia;
		};
		case "Medic": {
			[player, "ReaperCrew_Medic"] call BIS_fnc_setUnitInsignia;
		};
		case "Machine Gunner": {
			[player, "ReaperCrew_Machinegunner"] call BIS_fnc_setUnitInsignia;
		};
		case "Marksman": {
			[player, "ReaperCrew_Marksman"] call BIS_fnc_setUnitInsignia;
		};
		case "Rifleman": {
			[player, "ReaperCrew_Rifleman"] call BIS_fnc_setUnitInsignia;
		};
		case "Rifleman (AT)": {
			[player, "ReaperCrew_AT"] call BIS_fnc_setUnitInsignia;
		};
		case "Rifleman (AA)": {
			[player, "ReaperCrew_AA"] call BIS_fnc_setUnitInsignia;
		};
		case "Engineer": {
			[player, "ReaperCrew_Engineer"] call BIS_fnc_setUnitInsignia;
		};
		case "Explosives Specialist": {
			[player, "ReaperCrew_EOD"] call BIS_fnc_setUnitInsignia;
		};
		default {
			[player, "reaperCrewInsignia"] call BIS_fnc_setUnitInsignia;
		};
	};

	_isPlatoonCommander = [_roleDesc, "Platoon Commander"] call BIS_fnc_inString;
	_isSectionCommander = [_roleDesc, "Section Commander"] call BIS_fnc_inString;

	// Role names with extensions
	if ( _isPlatoonCommander ) then {
		[player, "ReaperCrew_PlatoonCommander"] call BIS_fnc_setUnitInsignia;
	};
	if ( _isSectionCommander ) then {
		[player, "ReaperCrew_SectionCommander"] call BIS_fnc_setUnitInsignia;
	};

};