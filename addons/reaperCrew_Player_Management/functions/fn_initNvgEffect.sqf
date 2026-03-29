/*
* Author: Xeenenta (adapted from PDT-Enhanced-NVG)
* Applies a Modern Warfare style NVG colour correction to the player.
* Listens for vision mode changes and applies/removes the effect accordingly.
* Works in both player and Zeus curator camera views.
* Runs as postInit on each client.
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_player_management_fnc_initNvgEffect
*
* Public: No
*/

if (!hasInterface) exitWith {};
if (!reaperCrew_nvgEffect_enabled) exitWith {};

// Modern Warfare NVG colour correction parameters
// [brightness, contrast, offset, [blend RGBA], [colorize RGBA], [desaturate RGBA]]
reaperCrew_nvgColour = [1, 1, 0, [0, 0, 0, 0], [0.522, 0.914, 0.776, 0], [0.45, 0.45, 0.45, 0]];

// CBA visionMode event uses currentVisionMode focusOn, which covers
// both the player camera and the Zeus curator camera
["visionMode", {
	params ["_unit", "_visionMode"];

	private _effectHandle = missionNamespace getVariable ["reaperCrew_nvgEffect", -1];

	// Vision mode 1 = NVG
	if (_visionMode == 1) then {
		if (_effectHandle == -1) then {
			private _effect = ppEffectCreate ["ColorCorrections", 16735];
			_effect ppEffectAdjust reaperCrew_nvgColour;
			_effect ppEffectCommit 0.01;
			_effect ppEffectEnable true;
			missionNamespace setVariable ["reaperCrew_nvgEffect", _effect];
		};
	} else {
		if (_effectHandle != -1) then {
			ppEffectDestroy _effectHandle;
			missionNamespace setVariable ["reaperCrew_nvgEffect", -1];
		};
	};
}, true] call CBA_fnc_addPlayerEventHandler;
