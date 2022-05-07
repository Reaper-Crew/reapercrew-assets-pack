/*
* Author: Xeenenta
* This is a local function that will determine if the criteria have been met to either update or add a marker
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_counterBattery_fnc_validateNotification
*
* Public: No
*/

params ["_radarUnit"];

// Check if the unit has the required item
_itemResult = [player, "DataLinkTablet"] call BIS_fnc_hasItem;

// Check the 2D distance
_distanceResult = player distance2D _radarUnit;

// Conditional check
if (_itemResult && _distanceResult < 250) then {
	true;
} else {
	false;
};