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
 * [] call reaperCrew_fnc_setPersonalACRESettingsLocal
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
		case "Reaper-1-4": {
			[_personalRadio, 4] call acre_api_fnc_setRadioChannel;
		};
		case "Reaper-1-5": {
			[_personalRadio, 5] call acre_api_fnc_setRadioChannel;
		};
		case "Reaper-1-6": {
			[_personalRadio, 6] call acre_api_fnc_setRadioChannel;
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







