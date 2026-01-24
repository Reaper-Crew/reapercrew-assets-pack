# SABRE - Counter Battery

## Overview

The Counter-Battery component provides a mechanism for players and AI to organically detect the presence of opposing indirect fire assets without requiring game master or mission designer intervention. The system works with any modded content through configurable classname detection.

## Quick Start

1. Enable Counter-Battery in CBA Settings (`Options > Addon Options > Reaper Crew - SABRE (Counter Battery)`)
2. Configure detectable artillery classnames in CBA Settings
3. Place a Sentinel Radar unit from Eden Editor
4. Ensure the radar has an AI crew member
5. Give players the `DataLinkTablet` item to view detections

---

## Radar Systems

### Sentinel Radar

The Sentinel is a mobile counter-battery radar mounted on an MRAP chassis.

#### Vehicle Variants

| Classname | Faction | Camouflage |
|-----------|---------|------------|
| `reaperCrew_Sentinel_west_wdl` | BluFor (WEST) | Woodland |
| `reaperCrew_Sentinel_west_dst` | BluFor (WEST) | Desert |
| `reaperCrew_Sentinel_east_wdl` | OpFor (EAST) | Woodland |
| `reaperCrew_Sentinel_east_dst` | OpFor (EAST) | Desert |
| `reaperCrew_Sentinel_independent_wdl` | Independent | Woodland |
| `reaperCrew_Sentinel_independent_dst` | Independent | Desert |

#### Specifications

| Property | Value |
|----------|-------|
| Base Vehicle | B_MRAP_01_F |
| Detection Radius | 6,180 meters (~6.2km) |
| Transmission Distance | 250 meters |
| Crew Positions | Driver only |
| Cargo | None |
| Sling Load | Yes (4 cargo points) |

---

## Using the Radar

### Detection Requirements

For the radar to detect enemy artillery, ALL conditions must be met:

1. **Range** - Artillery must be within the radar's 6.18km detection radius (visible as map marker)
2. **Engine** - Radar engine must be running
3. **Crew** - Radar must be crewed by an AI unit
4. **Alive** - Radar unit must not be destroyed

### Managing the Radar

The radar functions as a vehicle with standard considerations:

**Fuel:**
- Engine runs at idle, consuming fuel slowly
- Monitor fuel levels and refuel as needed
- Use ACE interact menu to check fuel status

**Thermal Signature:**
- Running engine generates heat over time
- Hot engines are visible to thermal imaging
- Can be targeted by ATGMs, aircraft, and tanks
- Site radar in protected or concealed positions

**ACE Interaction Menu:**
- Start Engine - Enable radar detection
- Stop Engine - Disable radar (conserve fuel/hide thermal)
- Check Fuel - Display current fuel percentage

---

## Detection Mechanics

### How Detection Works

1. **Artillery Registration:** System scans for configured artillery classnames every 5 minutes
2. **Event Handler:** "Fired" event handler attached to registered artillery
3. **Shot Detection:** When artillery fires, nearby radars check if unit is in range
4. **Marker Creation:** Detection creates/updates a map marker at the artillery position

### Marker System

**Initial Detection:**
- Creates elliptical marker (250m x 250m)
- Color: Red
- Random offset of 230m from actual position

**Subsequent Detections:**
- Marker shrinks by 10 pixels per detection (minimum 50m x 50m)
- Position refines toward actual location
- Timestamp updated for stale marker tracking

**Marker Lifecycle:**
- Markers older than 30 minutes are automatically deleted
- Markers dissociate from moving units (last known position)

### Detection Logic Flow

```
Artillery Fires
    ↓
For Each Active Radar:
    ↓
Is Radar Alive? → No → Skip
    ↓ Yes
Is Engine On? → No → Skip
    ↓ Yes
Is Artillery in Range? → No → Skip
    ↓ Yes
Is Artillery Enemy Faction? → No → Skip
    ↓ Yes
Create/Update Marker
    ↓
Add to Faction's Discoverable Fires
```

---

## CBA Settings

Configure under `Options > Addon Options > Reaper Crew - SABRE (Counter Battery)`:

### Init Settings

| Setting | Variable | Type | Default | Description |
|---------|----------|------|---------|-------------|
| Activate Counter Battery | `reaperCrew_sabreCounterBattery_ActivateSystem` | Checkbox | false | Enable the counter-battery system |

### Asset Detection

| Setting | Variable | Type | Default | Description |
|---------|----------|------|---------|-------------|
| Detectable Artillery | `reaperCrew_sabreCounterBattery_LauncherClassnames` | Editbox | `B_MBT_01_arty_F,O_MBT_02_arty_F` | Comma-separated list of artillery classnames |

### Debugging

| Setting | Variable | Type | Default | Description |
|---------|----------|------|---------|-------------|
| Debug Event Handlers | `reaperCrew_sabreCounterBattery_DebugEvents` | Checkbox | false | Log event handler activity |
| Debug Tasks | `reaperCrew_sabreCounterBattery_DebugTasks` | Checkbox | false | Log scheduled task activity |

---

## Mission Maker Guide

### Basic Setup

1. Place a Sentinel Radar unit from `Empty > Vehicles > reaperCrew_Sentinel_*`
2. Assign an AI crew member to the radar
3. Configure CBA settings with artillery classnames to detect

### Configuring Detectable Artillery

Add classnames for the artillery systems you want detected. Common examples:

**Vanilla:**
```
B_MBT_01_arty_F,O_MBT_02_arty_F,I_Mortar_01_F
```

**RHS:**
```
rhs_2s3_tv,RHS_M109_USARMY_WD,rhs_D30_msv
```

**CUP:**
```
CUP_O_2S1_RU,CUP_B_M119_USMC,CUP_I_M252_AAF
```

### Multiple Radars

- Each faction can have multiple radar units
- Detection areas can overlap for redundancy
- Each radar operates independently

### Radar Placement Considerations

- **Line of Sight:** Radar works regardless of terrain (game limitation)
- **Protection:** Position behind cover from enemy approach
- **Resupply:** Ensure fuel resupply is available
- **Redundancy:** Multiple radars provide coverage if one is destroyed

---

## Scheduled Tasks

The Counter-Battery system runs several background tasks:

| Task | Frequency | Purpose |
|------|-----------|---------|
| Garbage Collection | 5 minutes | Remove dead radar units from tracking arrays |
| Stale Marker Removal | 10 minutes | Delete markers older than 30 minutes |
| Fire Gathering | 5 minutes | Register new artillery units and attach event handlers |

---

## Code Examples

### Custom Artillery Registration

```sqf
// Add custom artillery to detection list at mission start
reaperCrew_sabreCounterBattery_LauncherClassnames = "B_MBT_01_arty_F,O_MBT_02_arty_F,myMod_Artillery_F";
```

### Check Radar Status

```sqf
// Get all BluFor radar units
_bluforRadars = DatalinkBluForCounterBatteryElements;

{
    _isAlive = alive _x;
    _engineOn = isEngineOn _x;
    _fuel = fuel _x;

    diag_log format ["Radar %1: Alive=%2, Engine=%3, Fuel=%4", _x, _isAlive, _engineOn, _fuel];
} forEach _bluforRadars;
```

### Query Detected Artillery

```sqf
// Get all detected enemy fires for BluFor
_detections = DatalinkBluForDiscoverableFires;

{
    _artillery = _x select 0;
    _markerName = _x select 1;
    _timestamp = _x select 2;

    // Calculate age in minutes
    _age = (diag_tickTime - _timestamp) / 60;

    hint format ["Detection: %1 (%2 min old)", _markerName, round _age];
} forEach _detections;
```

### Spawn Radar with Crew

```sqf
// Create a radar unit with AI crew
_spawnPos = getPos player;
_radar = createVehicle ["reaperCrew_Sentinel_west_wdl", _spawnPos, [], 0, "NONE"];

// Create AI driver
_group = createGroup west;
_driver = _group createUnit ["B_Soldier_F", _spawnPos, [], 0, "NONE"];
_driver assignAsDriver _radar;
_driver moveInDriver _radar;

// Start the radar
_radar engineOn true;
```

---

## Known Issues

- **Single Player:** System requires multiplayer; server-only functions do not initialize properly in SP
- **Marker Locality:** Markers may occasionally disappear due to Arma's locality handling

---

## Troubleshooting

### Radar Not Detecting

- Verify engine is running (`isEngineOn _radar`)
- Confirm AI crew is present
- Check artillery classnames are in CBA settings
- Ensure artillery is within 6.18km range
- Verify Counter-Battery system is enabled

### Markers Not Visible

- Ensure player has `DataLinkTablet` item
- Check SABRE Core system is enabled
- Wait up to 15 seconds for network sync

### Wrong Faction Detection

- Radar only detects enemy factions
- BluFor radar detects EAST artillery
- OpFor radar detects WEST artillery
- Independent radar detects both WEST and EAST

### Markers Disappearing

- Markers older than 30 minutes are automatically deleted
- If artillery moves, marker shows last known position
- Network sync issues may cause temporary visibility loss

---

## Related Documentation

- [SABRE Core](sabreCore.md) - Network framework and tablet usage
