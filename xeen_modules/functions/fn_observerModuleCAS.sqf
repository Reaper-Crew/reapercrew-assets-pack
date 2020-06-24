params ["_targetObject", "_approachDirection", "_vehicleClass", "_attackType", "_minimumDistance", "_middleDistance", "_maximumDistance"];

// Calculate a random relative location
_dir = round random 360;
_dis = round random [_minimumDistance,_middleDistance,_maximumDistance];
_target = _targetObject getRelPos [_dis, _dir];

private ["_pos","_class","_type","_dir","_dummy"];

_dummy = "LaserTargetCBase" createVehicle _target;
_dummy enableSimulation false; _dummy hideObject true;
_dummy setVariable ["vehicle",_vehicleClass];
_dummy setVariable ["type",_attackType];
_dummy setDir _approachDirection;

[_dummy,nil,true] call BIS_fnc_moduleCAS;

[_dummy] spawn {
	sleep 10;

	deleteVehicle (_this select 0);
};

true