/*
* Author: Xeenenta
* This init function runs to add ACE interactiond actions to the shipping containers
*
* Arguments:
* 0: Classname of listener <STRING>
* 1: Container Object <OBJECT>
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_counterBattery_fnc_containerDeploy
*
* Public: No
*/

params ["_listenerClassname", "_containerObject"];

// Remove the radar zone if one is marked
_radarZone = _containerObject getVariable ["_radarZone", ""];
if !(_radarZone == "") then {
	deleteMarker _radarZone;
};

// Get current data
_currentPosition = getPosATL _containerObject;
_currentDirection = getDir _containerObject;
// Delete the old one
deleteVehicle _containerObject;
// Create the new vehicle
createVehicle [_listenerClassname, _currentPosition, [], 0, "CAN_COLLIDE"];
_containerObject setDir _currentDirection;

