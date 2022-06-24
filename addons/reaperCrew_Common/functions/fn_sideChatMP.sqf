/*
 * Author: Xeenenta
 * Randomises the gear of a unit based on configuration values
 *
 * Arguments:
 * 0: Side <SIDE> 
 * 1: Identity Entry <STRING> 
 * 2: Message String <STRING> 
 *
 * Return Value:
 * None
 *
 * Example:
 * [west, "HQ", "This is a message"] call reapercrew_common_fnc_sideChatMP
 *
 * Public: No
 */

params ["_side", "_identity", "_message"];

[[_side, _identity], _message] remoteExec ["sideChat"];