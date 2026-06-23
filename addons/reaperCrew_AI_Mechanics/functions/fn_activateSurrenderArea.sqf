/*
 * Author: Xeenenta
 * Activates the Surrender Area module. Iterates through synchronised units
 * and forces them to surrender via ACE captives, with configurable delay
 * and stagger timing.
 *
 * Arguments:
 * 0: Trigger Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [thisTrigger] call reapercrew_ai_mechanics_fnc_activateSurrenderArea
 *
 * Public: No
 */

params ["_triggerObject"];

["reapercrew_ai_mechanics_fnc_activateSurrenderArea", "Surrender Area activated"] call reapercrew_common_fnc_remoteLog;

// Retrieve stored configuration
_syncedUnits = _triggerObject getVariable ["_syncedUnits", []];
_surrenderDelay = _triggerObject getVariable ["_surrenderDelay", 5];
_surrenderStagger = _triggerObject getVariable ["_surrenderStagger", 1];
_dropWeapons = _triggerObject getVariable ["_dropWeapons", false];
_ejectFromVehicles = _triggerObject getVariable ["_ejectFromVehicles", true];

// Initial delay before surrender begins
if (_surrenderDelay > 0) then {
	sleep _surrenderDelay;
};

// Process each synced unit
{
	_unit = _x;

	// Skip non-infantry objects (modules, vehicles, etc. that might be synced)
	if !(_unit isKindOf "Man") then { continue };

	// Skip dead units
	if (!alive _unit) then { continue };

	// Skip units already surrendering
	if (_unit getVariable ["ace_captives_isSurrendering", false]) then { continue };

	// Handle units in vehicles
	if (!isNull objectParent _unit) then {
		if (_ejectFromVehicles) then {
			_unit action ["Eject", vehicle _unit];
			// Wait for dismount with timeout
			_timeout = diag_tickTime + 15;
			waitUntil { sleep 0.5; (isNull objectParent _unit) || (diag_tickTime > _timeout) };

			if (!isNull objectParent _unit) then {
				["reapercrew_ai_mechanics_fnc_activateSurrenderArea", format ["Unit %1 failed to eject, skipping", _unit]] call reapercrew_common_fnc_remoteLog;
				continue;
			};
		} else {
			continue;
		};
	};

	// Stop AI combat behaviour
	_unit disableAI "MOVE";
	_unit disableAI "AUTOCOMBAT";
	_unit disableAI "FSM";
	_unit setBehaviour "CARELESS";
	_unit setCombatMode "BLUE";

	// Drop primary weapon if configured
	if (_dropWeapons) then {
		_primaryWeapon = primaryWeapon _unit;
		if (_primaryWeapon != "") then {
			_unit removeWeaponGlobal _primaryWeapon;
		};
	};

	// Surrender via ACE using CBA targetEvent for correct locality
	["ACE_captives_setSurrendered", [_unit, true], _unit] call CBA_fnc_targetEvent;

	["reapercrew_ai_mechanics_fnc_activateSurrenderArea", format ["Unit %1 surrendered", _unit]] call reapercrew_common_fnc_remoteLog;

	// Stagger between units
	if (_surrenderStagger > 0) then {
		sleep _surrenderStagger;
	};
} forEach _syncedUnits;

["reapercrew_ai_mechanics_fnc_activateSurrenderArea", format ["Surrender Area complete, processed %1 units", count _syncedUnits]] call reapercrew_common_fnc_remoteLog;
