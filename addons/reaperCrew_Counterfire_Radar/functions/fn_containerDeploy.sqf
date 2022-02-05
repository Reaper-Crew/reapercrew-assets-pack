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

// Get current classname
_currentPosition = getPosATL _containerObject;
_currentDirection = getDir _containerObject;
// Delete the old one
deleteVehicle _containerObject;
// Create the new vehicle
_listenerClassname createVehicle _currentPosition;
_containerObject setDir _currentDirection;

