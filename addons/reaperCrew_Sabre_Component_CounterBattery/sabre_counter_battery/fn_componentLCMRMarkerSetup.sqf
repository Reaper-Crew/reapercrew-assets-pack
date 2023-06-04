params ["_centerPoint", ["_markerName", ""]];

_offset = 0;

if (_markerName == "") then {
	// Create marker in global space
	_randomName = [1000,9999] call BIS_fnc_randomInt;
	_markerNameString = format ["ArtilleryUnit%1", _randomName]; 
	_markerName = createMarker [_markerNameString, _centerPoint];
	_markerName setMarkerShape "ELLIPSE";
	_markerName setMarkerSize [250, 250];
	_markerName setMarkerBrush "SolidBorder";
	_markerName setMarkerAlpha 0;
	_markerName setMarkerColor "ColorRed";
	// diag_log "Adding marker";
	_offset = 230;
} else {
	// Shrink Dimensions if required
	_markerDimensions = markerSize _markerName;
	_newRadiusA = (_markerDimensions select 0);
	_newRadiusB = (_markerDimensions select 1);
	if ((_markerDimensions select 0) > 50) then {
		_newRadiusA = _newRadiusA - 10;
	};
	if ((_markerDimensions select 1) > 50) then {
		_newRadiusB = _newRadiusB - 10;
	};
	_markerName setMarkerSize [_newRadiusA, _newRadiusB];
	// diag_log "Updating marker";
};

_markerDistance = _centerPoint distance2D (getMarkerPos _markerName);
if (_markerDistance > 0) then {
	_offset = _markerDistance - 10;
};

// Get a random offset
_randomDir = [0,359] call BIS_fnc_randomInt;
// _randomDist = [0,_offset] call BIS_fnc_randomInt;
_newCenter = _centerPoint getPos [_offset, _randomDir];
_markerName setMarkerPos _newCenter;

_markerName;