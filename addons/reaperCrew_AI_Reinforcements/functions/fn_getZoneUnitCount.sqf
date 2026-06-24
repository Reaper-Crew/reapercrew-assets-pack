/*
* Author: Xeenenta
* Counts every living humanoid within the trigger area, regardless of side. This is
* used as the load measure for the zone ceiling so that players and civilians count
* toward the cap, not just enemy reinforcements. Includes agent based ambient
* civilians and units mounted in vehicles (their position resolves to the vehicle).
*
* If a module object is supplied, the count also includes that module's still-living
* spawned units that have not yet reached the zone (e.g. vehicle/airborne reinforcements
* ingressing from outside). This stops the module overspawning while a wave is inbound.
*
* Arguments:
* 0: Trigger Object <OBJECT>
* 1: Module Object <OBJECT> (optional) - reinforcement module whose spawned units to include
*
* Return Value:
* Number of humanoid units counted against the zone cap <NUMBER>
*
* Example:
* [_triggerObject, _moduleObject] call reapercrew_reinforcements_fnc_getZoneUnitCount
*
* Public: No
*/

params ["_triggerObject", ["_moduleObject", objNull]];

// Build the pool of things that could be in the zone. allUnits gives players and AI but
// excludes agents, so append the agent objects to also catch scripted ambient civilians
private _candidates = allUnits + (agents apply {agent _x});

// Reduce that pool to living humanoids (CAManBase covers players, AI and civilians; excludes
// animals/objects) that fall inside the trigger area. inAreaArray respects the trigger's actual
// ellipse, and units mounted in vehicles resolve to the vehicle's position so they are included
private _inZone = (_candidates select {alive _x && {_x isKindOf "CAManBase"}}) inAreaArray _triggerObject;

// Base load measure: everyone physically in the zone right now
private _total = count _inZone;

// Track how many counted units are inbound (outside the zone) purely for the debug log below
private _outsideCount = 0;

// If called with a module, also account for that module's reinforcements that have spawned but
// not yet arrived - otherwise the zone under-reports and the module keeps spawning waves on top
if (!isNull _moduleObject) then {

	// The units this module has spawned, filtered to those still valid and alive
	private _spawned = (_moduleObject getVariable ["spawnedUnits", []]) select {!isNull _x && {alive _x}};

	// Remove the ones already counted in _inZone (they have arrived), leaving only those still
	// inbound from outside the zone. The array subtraction is what prevents double-counting
	private _outside = _spawned - _inZone;
	_outsideCount = count _outside;

	// Add the still-inbound units so the cap reflects everything heading for the zone
	_total = _total + (count _outside);
};

// Debug breakdown so every module type can see how the cap figure was reached
[format ["Zone unit count: %1 in zone + %2 inbound (tracked) = %3 total", count _inZone, _outsideCount, _total]] call reapercrew_common_fnc_remoteLog;

_total
