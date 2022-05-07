/*
* Author: Xeenenta
* This function add event handlers to all of the players that join the session allowing them to pickup when new events are publish from the counter battery system
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_counterBattery_fnc_playerCBAEventHandlers
*
* Public: No
*/

_markerUpdate = ["playerCBMarkerUpdate", 
	{  
		[_this] call reapercrew_counterBattery_fnc_MarkerUpdate; 
	}
] call CBA_fnc_addEventHandler;

_markerAdd = ["playerCBMarkerAdd", 
	{  
		[_this] call reapercrew_counterBattery_fnc_MarkerAdd; 
	}
] call CBA_fnc_addEventHandler;