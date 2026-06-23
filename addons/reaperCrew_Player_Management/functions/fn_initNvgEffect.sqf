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

// Modern Warfare NVG colour correction (ACE variant - full desaturate to counter ACE washout)
// [brightness, contrast, offset, [blend RGBA], [colorize RGBA], [desaturate RGBA]]
reaperCrew_nvgColour = [1, 1, 0, [0, 0, 0, 0], [0.522, 0.914, 0.776, 0], [1, 1, 1, 0]];

["visionMode", {
	params ["_unit", "_visionMode"];

	// Only react to NVG activation; destruction is handled inside the spawned script
	if (_visionMode != 1) exitWith {};

	[] spawn {
		// Re-check on a scheduled frame - absorbs transient ACE3 mode changes
		if (currentVisionMode player != 1) exitWith {};

		private _effect = ppEffectCreate ["ColorCorrections", 16735];
		_effect ppEffectAdjust reaperCrew_nvgColour;
		_effect ppEffectForceInNVG true;
		_effect ppEffectCommit 0.01;
		_effect ppEffectEnable true;

		// Hold until NVG mode exits or Zeus is opened (Zeus resets currentVisionMode to 0)
		waitUntil {uiSleep 0.1; currentVisionMode player != 1 || !(isNull findDisplay 312)};
		_effect ppEffectEnable false;
		ppEffectDestroy _effect;

		// If we exited because Zeus was opened, reapply the effect when they leave Zeus
		if !(isNull findDisplay 312) then {
			[] spawn {
				waitUntil {uiSleep 0.1; isNull findDisplay 312};
				if (currentVisionMode player == 1) then {
					private _effect = ppEffectCreate ["ColorCorrections", 16735];
					_effect ppEffectAdjust reaperCrew_nvgColour;
					_effect ppEffectForceInNVG true;
					_effect ppEffectCommit 0.01;
					_effect ppEffectEnable true;
					waitUntil {uiSleep 0.1; currentVisionMode player != 1};
					_effect ppEffectEnable false;
					ppEffectDestroy _effect;
				};
			};
		};
	};
}, true] call CBA_fnc_addPlayerEventHandler;
