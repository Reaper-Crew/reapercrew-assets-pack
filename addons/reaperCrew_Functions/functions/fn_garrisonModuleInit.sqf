/*
 * Author: reaperCrewenta
 * Garrisons the nearby buildings
 *
 * Arguments:
 * 0: Logic <LOGIC>
 * 1: 
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic] call reaperCrew_fnc_garrisonModuleInit
 *
 * Public: No
 */

// TEMP REWORK
params ["_logic"];

_logicLocation = (getPos _logic);
_radius = 50;
_number = 5;

//params ["_logicLocation", "_radius", "_number"];

diag_log format ["Recieved logic %1", _logicLocation];

// Module specific behavior. Function can extract arguments from logic and use them.

diag_log "GARRISON MODULE: Garrison Process started";

// Check to see if HQ variables are present
if (isNil "reaperCrew_garrisonUnits") then {
  diag_log "GARRISON MODULE: reaperCrew_garrisonUnits not defined, using default";
  reaperCrew_garrisonUnits = "O_Soldier_F,O_Soldier_AR_F";
  publicVariable "reaperCrew_garrisonUnits";
};
if (isNil "reaperCrew_forcesSide") then {
  diag_log "GARRISON MODULE: reaperCrew_forcesSide not defined, using default";
  reaperCrew_forcesSide = east;
  publicVariable "reaperCrew_forcesSide";
};

// Variables
_maxSpread = _radius; //_logic getVariable ["GarrisonSpread",100];
_maxPerBuilding = _number; //_logic getVariable ["MaxPerBuilding",3];
_garrisonUnits = reaperCrew_garrisonUnits splitString ",";
  
[_logicLocation, _maxSpread, _garrisonUnits, _maxPerBuilding] spawn {

  diag_log "GARRISON MODULE: Started spawn";

  // Variables
  //_garrisonlogic = _this select 0;
  _logicLocation = _this select 0;
  _maxSpread = _this select 1;
  _garrisonUnits = _this select 2;
  _maxPerBuilding = _this select 3;
  
  diag_log format ["GARRISON MODULE: Garrison radius %1 with max %2 per building", _maxSpread, _maxPerBuilding];
  diag_log format ["GARRISON MODULE: Finding buildings near %1", _logicLocation];

  // Get all of the buildings with the radius
  _garrisonBuildings = nearestObjects [_logicLocation , ["house"], _maxSpread ];

  {
    diag_log format ["GARRISON MODULE: Processing building - %1", str(_x)];

    // Get each available position in the building
    _building = _x;
    _buildingPositions = [_x] call BIS_fnc_buildingPositions;

    // Get MaxPerBuilding random selects from that array
    _randomBuildingPositions = [];
    _randomBuildingPositionsCount = 1;

    // Get some random building positions
    while {_randomBuildingPositionsCount <= _maxPerBuilding} do {
      _randomBuildingPositions pushBackUnique (selectRandom _buildingPositions);
      _randomBuildingPositionsCount = _randomBuildingPositionsCount + 1;
    };

    // Create Group
    _buildingGroup = createGroup reaperCrew_forcesSide;

    //Add a rifleman to the group for every single position
    {
      _buildingUnit = (selectRandom _garrisonUnits) createUnit [_x, _buildingGroup];
    } forEach _randomBuildingPositions;

    {
      // Increase the units height by 1.2m to get them out of the floor
      _x setPos [getPos _x select 0, getPos _x select 1, (getPos _x select 2) +1.2];
    } forEach units _buildingGroup;

    // Toggle group settings
    _buildingGroup enableDynamicSimulation true;
    _buildingGroup deleteGroupWhenEmpty true;

    // Get to location of the leader
    _leaderUnit = leader _buildingGroup;
    _leaderLocation = getPos _leaderUnit;

    // Add a waypoint for headless client support
    _wp = _buildingGroup addWaypoint [_leaderLocation, 0];
    _wp setWaypointType "SCRIPTED";
    _wp setWaypointBehaviour "AWARE";
    [_buildingGroup, 0] setWaypointSpeed "LIMITED";
    _wp setWaypointStatements ["true", "[thisList] call reaperCrew_fnc_garrisonModuleWaypoint"];

    sleep 2;

  } forEach _garrisonBuildings;



};

// Delete the logic
deleteVehicle _logic;

// Module function is executed by spawn command, so returned value is not necessary, but it's good practice.
true