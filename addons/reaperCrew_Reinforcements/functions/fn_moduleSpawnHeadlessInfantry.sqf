// Argument 0 is module logic.
_logic = param [0,objNull,[objNull]];
_units = param [1,[],[[]]];
_activated = param [2,true,[true]];

if (_activated) then {

	// Don't run if the array isn't available
	while {isNil "activeInfantryTriggers"} do {
		if (reaperCrew_ReinforcementsCheckbox == true) then {
			diag_log "SCENARIO: Infantry triggers undefined, sleeping";
		};
		sleep 60;
	};

	// Variables
	_unitGroup = reaperCrew_reinforcements_units splitString ",";
	_unitCount = count _unitGroup;
	_randomTrigger = objNull;
	_reinforcementsCount = _logic getVariable ["reinforcementCount",50];
	_zoneThreshold = _logic getVariable ["zoneThreshold",20];
	_logicArea = _logic getVariable ["objectarea", [50, 50, 0, false, -1]];
	_logicArea2D = [getPos _logic, _logicArea select 0, _logicArea select 1];

	// Create a trigger, wait for it to be activated
	_activationTrigger = createTrigger ["EmptyDetector", (getPos _logic), true];
	_activationTrigger setTriggerArea [_logicArea select 0, _logicArea select 1, 0, false, 20];
	_activationTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_activationTrigger setTriggerStatements ["this", "", ""];
	waitUntil { triggerActivated _activationTrigger };

	// Get an initial count of the number of units in the area
	_allOpforUnits = (allUnits select {side _x == reaperCrew_reinforcements_side});
	_opforUnits = _allOpforUnits inAreaArray _logicArea2D;
	_opforCounter = count _opforUnits;

	// Output debug information if enabled
	if (reaperCrew_ReinforcementsCheckbox == true) then {
		diag_log format ["SCENARIO: Reinforcements logic area is: %1", _logicArea];
		diag_log format ["SCENARIO: Reinforcements logic area 2D is: %1", _logicArea2D];
	};

	while { triggerActivated _activationTrigger } do {

		// Get a count of the units in the zone
		_allOpforUnits = (allUnits select {side _x == reaperCrew_reinforcements_side});
		_opforUnits = (_allOpforUnits) inAreaArray _logicArea2D;
		_opforCounter = count _opforUnits;
		// Output debug information
		if (reaperCrew_ReinforcementsCheckbox == true) then {
			diag_log format ["SCENARIO: Reinforcements module is active, found %1 enemies within the zone", _opforCounter];
		};

		// Change to IF statements to prevent loop getting into stuck state
		if ((_opforCounter < _zoneThreshold) and (_reinforcementsCount > _unitCount) and (reaperCrew_pauseInfantryReinforcements == false) and ((count activeInfantryTriggers) > 0 )) then {
			
			// Select a random spawn point
			_randomTrigger = (selectRandom activeInfantryTriggers);
			_triggerPos = getPos _randomTrigger;

			if (count HeadlessClients > 0) then {
				// If a headless client is available, spawn it with RemoteExec
				_selectedClient = selectRandom HeadlessClients;
    			[_triggerPos] remoteExecCall ["reapercrew_reinforcements_fnc_spawnHeadlessInfantry", _selectedClient];
				// Output debug information
				if (reaperCrew_ReinforcementsCheckbox == true) then {
					diag_log format ["SCENARIO: Spawning reinforcements on client %1 at grid %2", name(_selectedClient), (mapGridPosition _randomTrigger)];
				};

			} else {
				// If no HCs are available, spawn it on the server
				[_triggerPos] remoteExecCall ["reapercrew_reinforcements_fnc_spawnHeadlessInfantry", 2];
				if (reaperCrew_ReinforcementsCheckbox == true) then {
					diag_log format ["SCENARIO: Spawning reinforcements at grid %1", (mapGridPosition _randomTrigger)];
				};
			};

			// Reduce the number of available reinforcements
			_reinforcementsCount = _reinforcementsCount - _unitCount;
			if (reaperCrew_ReinforcementsCheckbox == true) then {
				diag_log format ["SCENARIO: Reinforcements created, %1 infantry remain", _reinforcementsCount];
			};
		} else {
			if (reaperCrew_ReinforcementsCheckbox == true) then {
				diag_log format ["SCENARIO: Zone above threshold, spawning paused or no spawnpoints available - not spawning reinforcements"];
			};
		};
		sleep 60;
	};
	diag_log format ["SCENARIO: Trigger has been deactivated"];
};

true