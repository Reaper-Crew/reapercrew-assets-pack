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
* [] call reapercrew_sabre_counterBattery_fnc_componentLCMRActionDeployLocal
*
* Public: No
*/

params ["_targetUnit", "_playerUnit", "_action"];

["Deploying Listening Post...", 5, {true}, {

	// Get passed params
	_passedParams = _this select 0;
	_targetUnit = _passedParams select 0;
	_playerUnit = _passedParams select 1;
	_action = _passedParams select 2;

	// // Call server function
	[_targetUnit, _playerUnit, _action] remoteExec ["reapercrew_sabre_counterBattery_fnc_componentLCMRActionDeployRemote", 2];

}, {}, [_targetUnit, _playerUnit, _action]] call CBA_fnc_progressBar;