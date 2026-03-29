/*
* Author: Xeenenta
* Calculates the effective zone threshold based on the configured mode.
* In THRESHOLD mode, returns the static value. In RATIO mode, returns
* the value multiplied by the number of players in the trigger area.
*
* Arguments:
* 0: Zone Threshold Value <NUMBER>
* 1: Zone Threshold Mode <STRING> - "THRESHOLD" or "RATIO"
* 2: Trigger Object <OBJECT>
*
* Return Value:
* Effective zone threshold <NUMBER>
*
* Example:
* [20, "THRESHOLD", _triggerObject] call reapercrew_reinforcements_fnc_getZoneThreshold
*
* Public: No
*/

params ["_zoneThresholdValue", "_zoneThresholdMode", "_triggerObject"];

if (_zoneThresholdMode == "RATIO") then {
	private _playerCount = count ((allPlayers - entities "HeadlessClient_F") inAreaArray _triggerObject);
	ceil (_zoneThresholdValue * _playerCount)
} else {
	_zoneThresholdValue
};
