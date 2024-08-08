/*
* Author: Xeenenta
* The init call for the SABRE system
*
* Arguments:
* N/A
*
* Return Value:
* None
*
* Example:
* [] call reapercrew_sabre_main_fnc_initialiseSabreSystem
*
* Public: No
*/

if (!isServer) exitWith {["Server checked failed - not running SABRE init"] call reapercrew_common_fnc_remoteLog;};

// TODO replace with CBA variable
if !( true ) exitWith { ["System disabled - not running SABRE init"] call reapercrew_common_fnc_remoteLog; };

["Initialising system"] call reapercrew_common_fnc_remoteLog;

// Declare variables
// DiscoverableFires FORMAT [ArtilleryUnit, markerName, Marker Time]

// Blufor
// Fixed Contents
DatalinkBluForHQElements = [];
DatalinkBluForCounterBatteryElements = [];
DatalinkBluForFiresElements = [];
// Discoverables
DatalinkBluForDiscoverableFires = [];

// Opfor
// Fixed Contents
DatalinkOpForHQElements = [];
DatalinkOpForCounterBatteryElements = [];
DatalinkOpForFiresElements = [];
// Discoverables
DatalinkOpForDiscoverableFires = [];

// Independent
// Fixed Contents
DatalinkIndForHQElements = [];
DatalinkIndForCounterBatteryElements = [];
DatalinkIndForFiresElements = [];
// Discoverables
DatalinkIndForDiscoverableFires = [];

// Dummy object
SabreDummyObject = "Land_HelipadEmpty_F" createVehicle [0,0,0];

// Start scheduled tasks

// Indicate startup completed
DataLinkSystemStarted = true;
