/*
 * Author: Xeenenta
 * Draws debug markers for a spawnpoint: the outer zone, the inner zone, and a labelled
 * centre marker. Used to visualise the activation and exclusion radii while tuning.
 *
 * Arguments:
 * 0: _logic       <OBJECT> - Spawnpoint module logic object (used as the marker key and position)
 * 1: _outerRadius <NUMBER> - Outer zone radius in metres
 * 2: _innerRadius <NUMBER> - Inner zone radius in metres
 * 3: _typeLabel   <STRING> - Spawnpoint type, shown as the centre marker text
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic, 2000, 1000, "Infantry Spawnpoint"] call reapercrew_reinforcements_fnc_createSpawnpointDebugMarkers
 *
 * Public: No
 */

params ["_logic", "_outerRadius", "_innerRadius", "_typeLabel"];

_id = format ["rc_sp_%1", _logic];
_pos = getPos _logic;

// Outer zone
_outer = createMarker [format ["%1_outer", _id], _pos];
_outer setMarkerShape "ELLIPSE";
_outer setMarkerBrush "Border";
_outer setMarkerColor "ColorBlue";
_outer setMarkerSize [_outerRadius, _outerRadius];

// Inner zone
_inner = createMarker [format ["%1_inner", _id], _pos];
_inner setMarkerShape "ELLIPSE";
_inner setMarkerBrush "Border";
_inner setMarkerColor "ColorRed";
_inner setMarkerSize [_innerRadius, _innerRadius];

// Centre marker with the spawnpoint type as its label
_centre = createMarker [format ["%1_centre", _id], _pos];
_centre setMarkerType "mil_dot";
_centre setMarkerColor "ColorBlack";
_centre setMarkerText _typeLabel;

[format ["Created debug markers for %1 (outer %2m, inner %3m)", _typeLabel, _outerRadius, _innerRadius]] call reapercrew_common_fnc_remoteLog;
