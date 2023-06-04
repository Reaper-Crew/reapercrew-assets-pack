/*
* Author: Xeenenta
* TODO
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_sabre_counterBattery_fnc_taskGarbageCollect
*
* Public: No
*/

// Counter Battery Systems
// Blufor
_deletedCount = 0;
if (count DatalinkBluForCounterBatteryElements > 0) then {
	{
		if !(alive _x) then {
			DatalinkBluForCounterBatteryElements deleteAt _forEachIndex;
			_deletedCount = _deletedCount + 1;
		};
	} forEach DatalinkBluForCounterBatteryElements;
	["SABRE", "COUNTER BATTERY", (format ["TASK OUTPUT: Cleared %1 old radars for WEST", _deletedCount])] call reapercrew_common_fnc_remoteLog;
};

// Opfor
_deletedCount = 0;
if (count DatalinkOpForCounterBatteryElements > 0) then {
	{
		if !(alive _x) then {
			DatalinkOpForCounterBatteryElements deleteAt _forEachIndex;
			_deletedCount = _deletedCount + 1;
		};
	} forEach DatalinkOpForCounterBatteryElements;
	["SABRE", "COUNTER BATTERY", (format ["TASK OUTPUT: Cleared %1 old radars for EAST", _deletedCount])] call reapercrew_common_fnc_remoteLog;
};

// Independent
_deletedCount = 0;
if (count DatalinkIndForCounterBatteryElements > 0) then {
	{
		if !(alive _x) then {
			DatalinkIndForCounterBatteryElements deleteAt _forEachIndex;
			_deletedCount = _deletedCount + 1;
		};
	} forEach DatalinkIndForCounterBatteryElements;
	["SABRE", "COUNTER BATTERY", (format ["TASK OUTPUT: Cleared %1 old radars for INDEPENDENT", _deletedCount])] call reapercrew_common_fnc_remoteLog;
};