/*
* Author: Xeenenta
* This function executes the main init function on the server
*
* Arguments:
* 0: Classname of listener <STRING>
* 1: Container Object <OBJECT>
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_counterBattery_fnc_clientContainerDeploy
*
* Public: No
*/

params ["_listenerClassname", "_containerObject"];

["Deploying Listening Post...", 5, {true}, {

	// Get passed params
	_passedParams = _this select 0;
	_listenerClassname = _passedParams select 0;
	_containerObject = _passedParams select 1;

	// Call server function
	[_listenerClassname, _containerObject] remoteExec ["reapercrew_counterBattery_fnc_containerDeploy", 2];

}, {}, [_listenerClassname, _containerObject]] call CBA_fnc_progressBar;

