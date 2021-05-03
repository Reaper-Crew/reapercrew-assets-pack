/*
 * Author: Xeenenta
 * Post-init function to kick off local Insignia function
 *
 * Arguments:
 * 0: Logic <LOGIC>
 * 1: 
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call reapercrew_fnc_setUnitInsigniaGlobal
 *
 * Public: No
 */

if (isServer) then {
	remoteExecCall ["reapercrew_fnc_setUnitInsigniaLocal", 0, true];
};