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
 * [] call reaperCrew_fnc_disarmModuleKitChange
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

// Heal the player
[player] call ace_medical_treatment_fnc_fullHealLocal;