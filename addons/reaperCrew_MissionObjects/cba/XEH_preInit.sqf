// Spoofer (EW case) pick-up and placement. Server handles the create and delete; clients raise requests through CBA.
// Events for missions: "rc_spoofer_placed" [object, placer] (placer objNull for Eden or script placement),
// "rc_spoofer_pickedUp" [player, positionASL].

if (isServer) then {
	rc_spoofer_placing = objNull;

	["rc_spoofer_pickUpRequest", {
		params ["_object", "_player"];
		if (isNull _object || !alive _object) exitWith {};
		if (_object getVariable ["rc_spoofer_taken", false]) exitWith {};
		_object setVariable ["rc_spoofer_taken", true];
		private _pos = getPosASL _object;
		deleteVehicle _object;
		["rc_spoofer_pickUpGrant", [_player, _pos], _player] call CBA_fnc_targetEvent;
		["rc_spoofer_pickedUp", [_player, _pos]] call CBA_fnc_globalEvent;
	}] call CBA_fnc_addEventHandler;

	["rc_spoofer_placeRequest", {
		params ["_player", "_posASL", "_dir"];
		rc_spoofer_placing = _player;
		private _object = createVehicle ["reaperCrew_EwCase", ASLToATL _posASL, [], 0, "CAN_COLLIDE"];
		rc_spoofer_placing = objNull;
		_object setDir _dir;
		_object setPosASL _posASL;
	}] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
	["rc_spoofer_pickUpGrant", {
		params ["_player", "_posASL"];
		if (_player canAdd "reaperCrew_Spoofer_Item") then {
			_player addItem "reaperCrew_Spoofer_Item";
		} else {
			["rc_spoofer_placeRequest", [_player, _posASL, getDir _player]] call CBA_fnc_serverEvent;
		};
	}] call CBA_fnc_addEventHandler;

	private _pickUp = [
		"rc_spoofer_pickUp",
		"Pick up spoofer",
		"",
		{ [_target, _player] call reapercrew_missionobjects_fnc_spooferPickUp; },
		{ _player canAdd "reaperCrew_Spoofer_Item" }
	] call ace_interact_menu_fnc_createAction;
	["reaperCrew_EwCase", 0, ["ACE_MainActions"], _pickUp] call ace_interact_menu_fnc_addActionToClass;

	private _place = [
		"rc_spoofer_place",
		"Place spoofer",
		"",
		{ [_player] call reapercrew_missionobjects_fnc_spooferPlace; },
		{ "reaperCrew_Spoofer_Item" in (items _player) }
	] call ace_interact_menu_fnc_createAction;
	["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment"], _place, true] call ace_interact_menu_fnc_addActionToClass;		// inheritance on: without it the action lands on the bare CAManBase class only
};
