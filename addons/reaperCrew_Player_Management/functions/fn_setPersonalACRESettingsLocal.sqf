/*
 * Author: Xeenenta
 * Configures the player's PRR channel based on their group and assigns
 * multi-PTT bindings based on available radios.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call reapercrew_player_management_fnc_setPersonalACRESettingsLocal
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

// Wait for ACRE to finish initialising
sleep 15;

["Running client ACRE configuration"] call reapercrew_common_fnc_remoteLog;

// Group name to PRR channel mapping
private _groupChannelMap = createHashMap;
_groupChannelMap set ["Zero", 12];
_groupChannelMap set ["Reaper-1-1", 1];
_groupChannelMap set ["Reaper-1-2", 2];
_groupChannelMap set ["Reaper-1-3", 3];
_groupChannelMap set ["Thunder", 4];
_groupChannelMap set ["Hammer", 5];
_groupChannelMap set ["Fury", 6];
_groupChannelMap set ["Fury-1", 6];
_groupChannelMap set ["Fury-2", 6];
_groupChannelMap set ["Foxhound-1", 7];
_groupChannelMap set ["Foxhound-2", 7];
_groupChannelMap set ["Foxhound-3", 7];
_groupChannelMap set ["Shadow", 8];
_groupChannelMap set ["Viper", 9];
_groupChannelMap set ["Phantom", 10];
_groupChannelMap set ["Ugly-1", 11];
_groupChannelMap set ["Ugly-2", 11];
_groupChannelMap set ["Sentinel", 13];

// Set PRR channel based on group
private _personalRadio = ["ACRE_PRC343"] call acre_api_fnc_getRadioByType;

// acre_api_fnc_getRadioByType returns "" if the player has no radio of that type
if (_personalRadio != "") then {
	private _groupName = groupId (group player);
	private _channel = _groupChannelMap getOrDefault [_groupName, -1];
	if (_channel > 0) then {
		[_personalRadio, _channel] call acre_api_fnc_setRadioChannel;
	};
};

// Configure multi-PTT based on available radios
private _interteamRadio = ["ACRE_PRC148"] call acre_api_fnc_getRadioByType;
private _longRangeRadio = ["ACRE_PRC152"] call acre_api_fnc_getRadioByType;

if (_longRangeRadio != "" && {_interteamRadio != ""}) then {
	// All three radios (officer)
	[[ _personalRadio, _interteamRadio, _longRangeRadio]] call acre_api_fnc_setMultiPushToTalkAssignment;
	[_longRangeRadio, 2] call acre_api_fnc_setRadioChannel;
} else {
	if (_longRangeRadio != "") then {
		// PRR + long range (pilot)
		[[ _personalRadio, _longRangeRadio]] call acre_api_fnc_setMultiPushToTalkAssignment;
		[_longRangeRadio, 2] call acre_api_fnc_setRadioChannel;
	} else {
		if (_interteamRadio != "") then {
			// PRR + inter-team
			[[ _personalRadio, _interteamRadio]] call acre_api_fnc_setMultiPushToTalkAssignment;
		};
	};
};
