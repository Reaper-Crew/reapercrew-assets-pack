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

// Group name to PRR channel mapping.
//
// The number is the absolute PRC343 channel. The radio presents channels in
// blocks of 16, so 1 to 16 show as Block 1 and 17 onwards as Block 2. The
// section signs in reaperCrew_Common state the block and channel a player is
// tuned to, and must be kept in step with this map.
//
// An asset that deploys alone shares a net with the first of its series, so
// Fury and Fury-1 sit together. Later instances are separate elements and take
// their own nets.
private _groupChannelMap = createHashMap;

// Block 1 - manoeuvre and support. A Reaper section's number is its channel.
_groupChannelMap set ["Reaper-1-1", 1];
_groupChannelMap set ["Reaper-1-2", 2];
_groupChannelMap set ["Reaper-1-3", 3];
_groupChannelMap set ["Reaper-1-4", 4];
_groupChannelMap set ["Thunder", 5];
_groupChannelMap set ["Hammer", 6];
_groupChannelMap set ["Fury", 7];
_groupChannelMap set ["Fury-1", 7];
_groupChannelMap set ["Fury-2", 8];
_groupChannelMap set ["Fury-3", 9];
_groupChannelMap set ["Shadow", 10];
_groupChannelMap set ["Anvil", 11];
_groupChannelMap set ["Zero", 12];
_groupChannelMap set ["Sentinel", 13];
_groupChannelMap set ["Sentinel-1", 13];
_groupChannelMap set ["Sentinel-2", 14];
_groupChannelMap set ["Sentinel-3", 15];
_groupChannelMap set ["Sentry", 16];

// Block 2 - logistics and aviation.
_groupChannelMap set ["Foxhound", 17];
_groupChannelMap set ["Foxhound-1", 17];
_groupChannelMap set ["Foxhound-2", 18];
_groupChannelMap set ["Foxhound-3", 19];
_groupChannelMap set ["Viper", 20];
_groupChannelMap set ["Phantom", 21];
_groupChannelMap set ["Phantom-1", 21];
_groupChannelMap set ["Phantom-2", 22];
_groupChannelMap set ["Ugly", 23];
_groupChannelMap set ["Ugly-1", 23];
_groupChannelMap set ["Ugly-2", 24];
_groupChannelMap set ["Ugly-3", 25];

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

// Build PTT assignment from whichever radios the player actually has
private _pttRadios = [];
if (_personalRadio != "") then { _pttRadios pushBack _personalRadio; };
if (_interteamRadio != "") then { _pttRadios pushBack _interteamRadio; };
if (_longRangeRadio != "") then { _pttRadios pushBack _longRangeRadio; };

if (count _pttRadios > 1) then {
	[_pttRadios] call acre_api_fnc_setMultiPushToTalkAssignment;
};

// Set long-range to channel 2 if present
if (_longRangeRadio != "") then {
	[_longRangeRadio, 2] call acre_api_fnc_setRadioChannel;
};
