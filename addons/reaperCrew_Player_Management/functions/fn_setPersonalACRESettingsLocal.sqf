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
	_handheldRadio = [];
	_manpackRadio = [];
	// Add the radios to variables
	_personalRadio = ["ACRE_PRC343"] call acre_api_fnc_getRadioByType;
	_handheldRadio = ["ACRE_PRC152"] call acre_api_fnc_getRadioByType;
	_manpackRadio = ["ACRE_PRC117F"] call acre_api_fnc_getRadioByType;
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
	// Check for LRR
	if (!isNil "_handheldRadio") then {
		_success = [ [ _personalRadio, _handheldRadio] ] call acre_api_fnc_setMultiPushToTalkAssignment;
	};
	if (!isNil "_manpackRadio") then {
		_success = [ [ _personalRadio, _manpackRadio] ] call acre_api_fnc_setMultiPushToTalkAssignment;
	};
	
};







