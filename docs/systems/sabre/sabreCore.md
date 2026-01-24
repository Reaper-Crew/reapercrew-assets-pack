# SABRE Core

## Overview

The SABRE (Strategic Awareness Battlefield Reconnaissance Environment) network is a framework for sharing and managing information in the virtual battlespace. It functions as a centralized server-side data repository that clients pull from periodically.

The system uses a **pull model** where clients poll the server for new information every 15 seconds. This architecture ensures efficient network usage while keeping all clients synchronized with the latest battlefield intelligence.

## Quick Start

1. Enable the SABRE network in CBA Settings (`Options > Addon Options > Reaper Crew - SABRE`)
2. Ensure players have the **DataLinkTablet** item in their inventory
3. Place SABRE components as needed (Counter-Battery radar units, etc.)
4. Information will automatically synchronize to players with tablets

## SABRE Tablet

### Item Details

| Property | Value |
|----------|-------|
| Classname | `DataLinkTablet` |
| Display Name | SABRE Tablet |
| Model | UAV Controller (vanilla) |
| Mass | 20 units |

### Usage

Players **must** have the SABRE Tablet in their inventory to receive network data. Without the tablet:
- Map markers from the network will be hidden (alpha=0)
- Detection data will not be visible

Add to player inventory via Arsenal or script:
```sqf
player addItem "DataLinkTablet";
```

---

## Network Architecture

### Data Structures

The SABRE network maintains **faction-separated** data structures on the server. Each faction has its own isolated dataset:

**BluFor (WEST):**
| Variable | Purpose |
|----------|---------|
| `DatalinkBluForHQElements` | Registered HQ elements |
| `DatalinkBluForCounterBatteryElements` | Active radar units |
| `DatalinkBluForFiresElements` | Artillery/launcher units |
| `DatalinkBluForDiscoverableFires` | Detected enemy fires |

**OpFor (EAST):**
| Variable | Purpose |
|----------|---------|
| `DatalinkOpForHQElements` | Registered HQ elements |
| `DatalinkOpForCounterBatteryElements` | Active radar units |
| `DatalinkOpForFiresElements` | Artillery/launcher units |
| `DatalinkOpForDiscoverableFires` | Detected enemy fires |

**Independent:**
| Variable | Purpose |
|----------|---------|
| `DatalinkIndForHQElements` | Registered HQ elements |
| `DatalinkIndForCounterBatteryElements` | Active radar units |
| `DatalinkIndForFiresElements` | Artillery/launcher units |
| `DatalinkIndForDiscoverableFires` | Detected enemy fires |

### Discoverable Fires Data Format

Each detected artillery position is stored as:
```sqf
[ArtilleryUnit, markerName, markerTime]
```

| Field | Type | Description |
|-------|------|-------------|
| ArtilleryUnit | Object | Reference to the artillery/launcher object |
| markerName | String | Identifier of the map marker |
| markerTime | Number | `diag_tickTime` timestamp for stale detection |

### Faction Data Routing

When a client syncs, they receive only their faction's data:

```sqf
switch (side player) do {
    case west: {
        // Receives DatalinkBluForDiscoverableFires
    };
    case east: {
        // Receives DatalinkOpForDiscoverableFires
    };
    case independent: {
        // Receives DatalinkIndForDiscoverableFires
    };
};
```

**Cross-Faction Detection:**
- Radar units detect **only** enemy factions
- Independent faction radars can detect both WEST and EAST forces
- Friendly units never appear in discoverable fires lists

---

## Network Synchronization

### Sync Mechanics

| Parameter | Value |
|-----------|-------|
| Sync Frequency | Every 15 seconds |
| Model | Pull (client requests from server) |
| Validation | Requires DataLinkTablet item |
| Execution | `remoteExec` to all clients (-2) |

### Sync Process

1. Server scheduled task triggers every 15 seconds
2. Client-side sync function executes
3. Tablet validation check performed
4. If valid: markers set to alpha=1 (visible)
5. If invalid: markers set to alpha=0 (hidden)

### Marker Visibility Control

| Action | Effect |
|--------|--------|
| SYNC | Markers alpha=1 (visible to clients with tablets) |
| OFFLOAD | Markers alpha=0 (hidden from clients without tablets) |

---

## CBA Settings

Configure under `Options > Addon Options > Reaper Crew - SABRE`:

### Init Settings

| Setting | Variable | Type | Default | Description |
|---------|----------|------|---------|-------------|
| Activate SABRE Network | `reaperCrew_sabreCore_ActivateSystem` | Checkbox | false | Enable the SABRE network system |

---

## Components

The SABRE system is designed as a modular framework. Individual components can be enabled or disabled based on mission requirements:

| Component | Addon | Description |
|-----------|-------|-------------|
| Counter-Battery | `reaperCrew_Sabre_Component_CounterBattery` | Radar-based indirect fire detection |

Future components will build on this same information-sharing model.

---

## Code Examples

### Check if Player Has Tablet

```sqf
_hasTablet = [player, "DataLinkTablet"] call BIS_fnc_hasItem;
if (_hasTablet) then {
    hint "You have access to SABRE network";
};
```

### Query Faction's Detected Fires

```sqf
// Server-side: Get BluFor detected fires
_bluforDetections = DatalinkBluForDiscoverableFires;

// Iterate detections
{
    _artillery = _x select 0;
    _markerName = _x select 1;
    _timestamp = _x select 2;

    diag_log format ["Detected: %1 at marker %2", _artillery, _markerName];
} forEach _bluforDetections;
```

### Check System Status

```sqf
// Check if SABRE is active
if (reaperCrew_sabreCore_ActivateSystem) then {
    hint "SABRE network is operational";
};

// Check if system has initialized
if (!isNil "DataLinkSystemStarted" && {DataLinkSystemStarted}) then {
    hint "SABRE system initialization complete";
};
```

### Add Custom Data to Network (Advanced)

```sqf
// Server-side: Add a custom HQ element to BluFor network
DatalinkBluForHQElements pushBack _myHQObject;
publicVariable "DatalinkBluForHQElements";
```

---

## Initialization Sequence

1. **PreInit (CBA):** Load CBA settings
2. **Server Init:** `fn_initialiseSabreSystem` - Declare global arrays, create dummy object
3. **Server Init:** `fn_initialiseScheduledTasks` - Start network sync loop (15-second interval)
4. **Client Connect:** `fn_networkSync` begins polling server data

---

## Troubleshooting

### Network Not Syncing

- Verify `reaperCrew_sabreCore_ActivateSystem` is enabled
- Confirm mission is running in multiplayer (system requires server)
- Check that players have `DataLinkTablet` item

### Markers Not Appearing

- Ensure player has SABRE Tablet in inventory
- Verify the component generating markers is active (e.g., Counter-Battery)
- Check that radar/detection units are operational

### Performance Considerations

- Sync occurs every 15 seconds by design
- Large numbers of detections may increase sync payload
- Network bandwidth is minimal due to pull model

---

## Related Documentation

- [Counter-Battery Component](sabreCounterBattery.md) - Radar-based artillery detection
