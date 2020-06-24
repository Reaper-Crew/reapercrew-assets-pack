params ["_targetObject","_numOfRounds","_minimumDistance", "_middleDistance", "_maximumDistance", "_ordinanceType"];

// Create an empty reference object
_markingObject = "Land_HelipadEmpty_F" createVehicle (getPos _targetObject);

_smokeDeploy = 3;

// Deploy marking smoke
while {_smokeDeploy>0} do {
	_dir = round random 360;
	_dis = round random [25,50,75];
	_target = _markingObject getRelPos [_dis, _dir];

	// Spawn a red grenade directly on the target
	_markingGroup = createGroup sideLogic;
	"ModuleSmokeRed_F" createUnit [
		_target,
		_markingGroup,
		"this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true];"
	];
	_smokeDeploy = _smokeDeploy -1;
};

sleep 30;

while {_numOfRounds>0} do {
	// Calculate a random spread
	_dir = round random 360;
	_dis = round random [_minimumDistance,_middleDistance,_maximumDistance];
	_target = _markingObject getRelPos [_dis, _dir];
	// Command the unit to fire
    
	_dummy = "LaserTargetCBase" createVehicle _target;
	_dummy enableSimulation false; _dummy hideObject true;
	switch (_ordinanceType) do {
		case "82": {
			_dummy setVariable ["type", "Sh_82mm_AMOS"];
		};
		case "155": {
			_dummy setVariable ["type", "Sh_155mm_AMOS_LG"];
		};
		default {
			_dummy setVariable ["type", "Sh_82mm_AMOS"];	
		};
	};
	_dummy setVariable ["type", "Sh_82mm_AMOS"];

	[_dummy,nil,true] call BIS_fnc_moduleProjectile;

	[_dummy] spawn {
		sleep 10;

		deleteVehicle (_this select 0);
	};

	// Wait to fire again
	sleep 5;
	_numOfRounds = _numOfRounds - 1;
};

true