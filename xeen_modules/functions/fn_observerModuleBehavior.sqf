params ["_supportType","_spotterUnit","_retryTime"];

diag_log "FORWARD OBSERVER: Event triggered";

// Initial Null check
if (isNull _spotterUnit) exitWith { diag_log "FORWARD OBSERVER: Unit is null, exiting"; }; 

// Invoke Spawn call so that sleep functions work
[_supportType, _spotterUnit, _retryTime] spawn {
	// Assign variables inside spawn
	_supportType = _this select 0;
	_spotterUnit = _this select 1;
	_retryTime = _this select 2;
	
	// Keep looping while the spotter is alive
	while { alive _spotterUnit } do {

		// Perform Spotter Condition Checks
		if (isNull _spotterUnit) exitWith { diag_log "FORWARD OBSERVER: Unit is null, exiting"; }; 
		if (!local _spotterUnit) exitWith { diag_log "FORWARD OBSERVER: Unit is not local, exiting"; };
		if (!alive _spotterUnit) exitWith { diag_log "FORWARD OBSERVER: Unit is not alive, exiting"; };
		_aceUnconciousState = _spotterUnit getVariable ["ACE_isUnconscious", false];
		if (_aceUnconciousState) exitWith { diag_log "FORWARD OBSERVER: Unit is unconcious, exiting"; };
		
		// Get the nearest enemy
		_myNearestEnemy = _spotterUnit findNearestEnemy _spotterUnit;
		// Select a random plane attack
		// Check not null
		if ( !isNull _myNearestEnemy ) then {
    	  diag_log "FORWARD OBSERVER: Found nearby enemy";
		  // Check targetKnowledge & distance
		  _knowledge = _spotterUnit knowsAbout _myNearestEnemy;
		  _distance = _spotterUnit distance _myNearestEnemy;

		  //if (_distance <= 300) exitWith {  };
		  if (_distance >= 300) then {
		  	if ( _knowledge > 0 ) then {
				diag_log "FORWARD OBSERVER: Observer has eyes on target";

				// Save current weapons
				_weaponsArray = weapons _spotterUnit;

				// Set up unit for targeting
				diag_log "FORWARD OBSERVER: Started targeting process";
				_spotterUnit lookAt _myNearestEnemy;
				_spotterUnit disableAI "MOVE";
				_directionTo = _spotterUnit getDir _myNearestEnemy;
				_spotterUnit setDir _directionTo;
				_spotterUnit setUnitPos "MIDDLE";
				removeAllWeapons _spotterUnit;
				_spotterUnit addWeapon "Laserdesignator_03";
				_spotterUnit selectWeapon "Laserdesignator_03";

				// Begin ICOM
				// Find nearest players
				//_nearbyEntities = _spotterUnit nearEntities ["Man", 1000];

				// diag_log "FORWARD OBSERVER: Starting ICOM process";
				// {
				// 	if ( isPlayer _x ) then {
				// 		// Get a list of units items
				// 		_itemList = items _x;
				// 		// Play ICOM if the unit has a radio
				// 		diag_log "FORWARD OBSERVER: Checking if player has ICOM device";
				// 		if ("xeen_icom_device" in (items _x) || "xeen_icom_device" in (assigneditems _x)) then {
				// 			diag_log "FORWARD OBSERVER: Found ICOM device on player";
				// 			["icom1"] remoteExec ["playSound", _x]
				// 		};
				// 	};
				// } forEach _nearbyEntities;

				sleep 20;

				// Call the ordinance based on the support type
				switch (_supportType) do {
				  case "82mm": {
				    [_myNearestEnemy, 5, 25, 50, 75, "82"] call xeen_fnc_observerModuleIDF;
				  };
				  case "155mm": {
          	      	[_myNearestEnemy, 5, 25, 50, 75, "155"] call xeen_fnc_observerModuleIDF;
				  };
				  case "planeGunRun": {
					_CASPlane = xeen_observerPlane splitString ",";
          	      	[_myNearestEnemy, _directionTo, (selectRandom _CASPlane), 0, 1, 1, 1] call xeen_fnc_observerModuleCAS;
				  };
				  case "planeMissiles": {
					_CASPlane = xeen_observerPlane splitString ",";
          	      	[_myNearestEnemy, _directionTo, (selectRandom _CASPlane), 1, 1, 1, 1] call xeen_fnc_observerModuleCAS;
				  };
				  case "planeGunMissiles": {
					_CASPlane = xeen_observerPlane splitString ",";
          	      	[_myNearestEnemy, _directionTo, (selectRandom _CASPlane), 2, 1, 1, 1] call xeen_fnc_observerModuleCAS;
				  };
				  case "planeBombStrike": {
					_CASPlane = xeen_observerPlane splitString ",";
          	      	[_myNearestEnemy, _directionTo, (selectRandom _CASPlane), 3, 1, 1, 1] call xeen_fnc_observerModuleCAS;
				  };
				  case "planeRandom": {
					_CASPlane = xeen_observerPlane splitString ",";
					_planeTypes = [0, 1, 2, 3];
          	      	[_myNearestEnemy, _directionTo, (selectRandom _CASPlane), selectRandom _planeTypes, 1, 1, 1] call xeen_fnc_observerModuleCAS;
				  };
				  default {
          	      	diag_log "FORWARD OBSERVER: Invalid support type configured";
				  };
				};

			
				// Finish targetting
				{
					_spotterUnit addWeapon _x;
				} forEach _weaponsArray;

				_spotterUnit removeWeapon "Laserdesignator_03";
				_spotterUnit selectWeapon (primaryWeapon _spotterUnit);
				_spotterUnit enableAI "MOVE";
				_spotterUnit setBehaviour "AWARE";
				diag_log "FORWARD OBSERVER: Finished targeting process";

		    };
		  } else {
		   diag_log "FORWARD OBSERVER: Unit closer than 300m, waiting";
		  };
		};
		// Wait before trying again
		sleep _retryTime;
	};
	diag_log "FORWARD OBSERVER: Spotter is not alive, exiting";
};
true;