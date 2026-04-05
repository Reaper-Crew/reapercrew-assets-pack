/*
 * Author: Xeenenta
 * Disarms players
 *
 * Arguments:
 * 0: 
 * 1: 
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call reapercrew_player_management_fnc_disarmModuleKitChange
 *
 * Public: No
 */

removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;


player forceAddUniform "U_BG_Guerilla2_1";
player addHeadgear "RC_Beret_01";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemGPS";	

_roleDesc = roleDescription player;
_isPlatoonCommander = ["Platoon Commander", _roleDesc] call BIS_fnc_inString;
_isPlatoonSergeant = ["Platoon Sergeant", _roleDesc] call BIS_fnc_inString;
_isSectionLeader = ["Section Commander", _roleDesc] call BIS_fnc_inString;
_isSection2IC = ["Section 2IC", _roleDesc] call BIS_fnc_inString;
_isSection3IC = ["Section 3IC", _roleDesc] call BIS_fnc_inString;

[(format ["Role description is %1", _roleDesc])] call reapercrew_common_fnc_remoteLog;
[(format ["Is platoon commander: %1", _isPlatoonCommander])] call reapercrew_common_fnc_remoteLog;
[(format ["Is platoon sergeant: %1", _isPlatoonSergeant])] call reapercrew_common_fnc_remoteLog;

[(format ["Is section commander: %1", _isSectionLeader])] call reapercrew_common_fnc_remoteLog;
[(format ["Is section 2IC: %1", _isSection2IC])] call reapercrew_common_fnc_remoteLog;
[(format ["Is section 3IC: %1", _isSection3IC])] call reapercrew_common_fnc_remoteLog;

if (_isPlatoonCommander or _isPlatoonSergeant) then {
	removeUniform player;
	player forceAddUniform "U_I_ParadeUniform_01_AAF_decorated_F";
};

if (_isSectionLeader or _isSection2IC or _isSection3IC) then {
	removeUniform player;
	player forceAddUniform "U_I_ParadeUniform_01_AAF_F";
};

// Heal the player
[player] call ace_medical_treatment_fnc_fullHealLocal;
