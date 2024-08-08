/*
 * Author: Xeenenta
 * Configures the PRR based on the players group
 *
 * Arguments:
 * 0: 
 * 1: 
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call reapercrew_player_management_fnc_setPersonalACRESettingsLocal
 *
 * Public: No
 */

// Only execute on players
sleep 15;

diag_log "[Reaper Crew]: Running client ACRE configuration";

if (hasInterface) then {
	_personalRadio = [];
	_interteamRadio = [];
	_longRangeRadio = [];

	// Add the radios to variables
	_personalRadio = ["ACRE_PRC343"] call acre_api_fnc_getRadioByType;

	// Set the radio channels for the short range
	switch (groupId (group player)) do {
		case "Zero": {
			[_personalRadio, 12] call acre_api_fnc_setRadioChannel;
		};
		case "Reaper-1-1": {
			[_personalRadio, 1] call acre_api_fnc_setRadioChannel;
		};
		case "Reaper-1-2": {
			[_personalRadio, 2] call acre_api_fnc_setRadioChannel;
		};
		case "Reaper-1-3": {
			[_personalRadio, 3] call acre_api_fnc_setRadioChannel;
		};
		case "Thunder": {
			[_personalRadio, 4] call acre_api_fnc_setRadioChannel;
		};
		case "Hammer": {
			[_personalRadio, 5] call acre_api_fnc_setRadioChannel;
		};
		// Fury
		case "Fury": {
			[_personalRadio, 6] call acre_api_fnc_setRadioChannel;
		};
		case "Fury-1": {
			[_personalRadio, 6] call acre_api_fnc_setRadioChannel;
		};
		case "Fury-2": {
			[_personalRadio, 6] call acre_api_fnc_setRadioChannel;
		};
		// Foxhound
		case "Foxhound-1": {
			[_personalRadio, 7] call acre_api_fnc_setRadioChannel;
		};
		case "Foxhound-2": {
			[_personalRadio, 7] call acre_api_fnc_setRadioChannel;
		};
		case "Foxhound-3": {
			[_personalRadio, 7] call acre_api_fnc_setRadioChannel;
		};
		case "Shadow": {
			[_personalRadio, 8] call acre_api_fnc_setRadioChannel;
		};
		case "Viper": {
			[_personalRadio, 9] call acre_api_fnc_setRadioChannel;
		};
		case "Phantom": {
			[_personalRadio, 10] call acre_api_fnc_setRadioChannel;
		};
		// Ugly
		case "Ugly-1": {
			[_personalRadio, 11] call acre_api_fnc_setRadioChannel;
		};
		case "Ugly-2": {
			[_personalRadio, 11] call acre_api_fnc_setRadioChannel;
		};
		// Sentinel
		case "Sentinel": {
			[_personalRadio, 13] call acre_api_fnc_setRadioChannel;
		};
	};

	// Assign the PTT values
	_interteamRadio = ["ACRE_PRC148"] call acre_api_fnc_getRadioByType;
	_longRangeRadio = ["ACRE_PRC152"] call acre_api_fnc_getRadioByType;


	// Check for LRR
	// If just team radio
	if (!isNil "_interteamRadio") then {
		_success = [ [ _personalRadio, _interteamRadio] ] call acre_api_fnc_setMultiPushToTalkAssignment;
	};
	// If team radio and LRR (Officer most likely)
	if (!isNil "_longRangeRadio" && !isNil "_interteamRadio") then {
		_success = [ [ _personalRadio, _interteamRadio, _longRangeRadio] ] call acre_api_fnc_setMultiPushToTalkAssignment;
		[_longRangeRadio, 2] call acre_api_fnc_setRadioChannel;
	};
	// IF LRR but no team radio, pilot most likely
	if (!isNil "_longRangeRadio" && isNil "_interteamRadio") then {
		_success = [ [ _personalRadio, _longRangeRadio] ] call acre_api_fnc_setMultiPushToTalkAssignment;
		[_longRangeRadio, 2] call acre_api_fnc_setRadioChannel;
	};
	
};







