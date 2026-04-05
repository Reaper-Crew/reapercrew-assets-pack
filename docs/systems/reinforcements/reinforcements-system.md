# Reinforcements System

## Overview

The Reinforcements System provides mission makers with a way to programmatically create dynamic AI reinforcements without requiring any scripting. The system is designed to be performance-friendly and fully headless client compatible, making it ideal for large-scale operations.

This system leverages the LAMBS Rush module for AI behaviour and complements existing tools like Zeus Enhanced.

## Quick Start

1. Configure AI Common settings (faction, unit pools) in CBA Settings
2. Place one or more **Spawnpoint** modules where you want units to spawn
3. Place a **Reinforcement Module** in the area you want defended
4. Synchronize the reinforcement module to specific spawnpoints (optional)
5. Configure module attributes as needed

## CBA Settings

### AI Common Settings

Configure under `Options > Addon Options > Reaper Crew - AI Common`:
- Opposition Faction (EAST/WEST/INDEPENDENT)
- Unit pools (Regular, Elite, Special Forces)
- Skill levels for each troop type
- Transport and fire support vehicle classes

See [AI Common Documentation](../ai/ai-common.md) for details.

### AI Reinforcements Settings

Configure under `Options > Addon Options > Reaper Crew - AI Reinforcements`:

**Live Mission Settings:**
| Setting | Variable | Description |
|---------|----------|-------------|
| Pause Infantry Reinforcements | `reaperCrew_pauseInfantryReinforcements` | Stop infantry spawning |
| Pause Marauding Vehicles | `reaperCrew_pauseVehicleReinforcements` | Stop vehicle spawning |
| Pause Marauding Aircraft | `reaperCrew_pauseAircraftReinforcements` | Stop aircraft spawning |

**Debug Settings:**
| Setting | Variable | Description |
|---------|----------|-------------|
| Debug Spawning Mechanics | `reaperCrew_debugReinforcementsSpawning` | Log unit spawns |
| Debug Waypoint Mechanics | `reaperCrew_debugWaypointMechanics` | Log waypoint configuration |
| Log HC Discovery | `reaperCrew_HCDiscoveryCheckbox` | Debug headless client discovery |
| Log Infantry Spawn Discovery | `reaperCrew_InfantrySpawnCheckbox` | Debug infantry spawnpoints |
| Log Vehicle Spawn Discovery | `reaperCrew_VehicleSpawnCheckbox` | Debug vehicle spawnpoints |
| Log Marine Spawn Discovery | `reaperCrew_MarineSpawnCheckbox` | Debug marine spawnpoints |
| Log Aircraft Spawn Discovery | `reaperCrew_AircraftSpawnCheckbox` | Debug aircraft spawnpoints |

---

## Spawnpoint Modules

Spawnpoints determine where reinforcement units can spawn. All spawnpoints are found in Eden Editor under: `Systems (F5) > Modules > Reaper Crew - Reinforcements`

### Spawnpoint Types & Activation Distances

| Module | Classname | Distance | Best Used For |
|--------|-----------|----------|---------------|
| Infantry Spawnpoint | `reaperCrew_moduleInfantrySpawn` | 2km | Foot mobile infantry |
| Vehicle Spawnpoint | `reaperCrew_moduleVehicleSpawn` | 5km | Motorised infantry, marauding vehicles |
| Aircraft Spawnpoint | `reaperCrew_moduleAircraftSpawn` | 25km | Airborne infantry, marauding aircraft |
| Marine Spawnpoint | `reaperCrew_moduleMarineSpawn` | 7.5km | Marine/amphibious infantry |

### Spawnpoint Activation Conditions

A spawnpoint becomes active when ALL conditions are met:
1. **Player proximity** - At least one player is within the activation distance
2. **Line of sight** - Players cannot directly see the spawnpoint location
3. **Ground contact** - At least one player is touching the ground (not in aircraft)
4. **Additional condition** - Any custom condition specified returns true

### Spawnpoint Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| Additional Condition | String | `"true"` | Custom SQF condition code |

### Spawnpoint Modes of Operation

There are two ways spawnpoints can be linked to reinforcement modules:

**Automatic Mode (Unsynchronized)**
- Leave spawnpoints unsynchronized from reinforcement modules
- The reinforcement module will automatically use the nearest active compatible spawnpoint
- Example: Foot Mobile module uses the nearest active Infantry Spawnpoint

**Manual Mode (Synchronized)**
- Synchronize specific spawnpoints to a reinforcement module
- The module will only use those specific synchronized spawnpoints
- Spawnpoints must still be active (meet activation conditions) to be usable
- Useful for controlling exact spawn locations per objective

**Important:** In both modes, spawnpoint activation conditions still apply. A synchronized spawnpoint that isn't active (players too far, line of sight blocked, custom condition false) will not be used.

### Supporting Modules

**Path Waypoint** (`reaperCrew_modulePathWaypoint`)
- Used when you want vehicle-based reinforcements to follow a specific waypoint path to their destination
- Commonly used to navigate difficult terrain in a specific way
- Synchronize to spawnpoints in traversal order

**Marine LZ** (`reaperCrew_moduleMarineLZ`)
- Defines landing zones for marine reinforcements
- Required for marine spawnpoints to function
- Can be linked to multiple spawnpoints - all linked spawnpoints will be able to use that LZ
- Doesn't have to be 1:1

---

## Reinforcement Modules

### Common Attributes

All infantry reinforcement modules share these attributes:

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| Reinforcement Count | Number | 50 | Total units to spawn over time |
| Zone Threshold Mode | Combo | THRESHOLD | How the zone threshold value is interpreted. **Threshold**: static maximum enemy count. **Player Ratio**: threshold value is multiplied by the number of players in the zone |
| Zone Threshold | Number | 20 | In Threshold mode: maximum enemy count in the zone. In Ratio mode: number of enemy per player |
| Regular Troops | Checkbox | true | Include regular troops from unit pool |
| Elite Troops | Checkbox | false | Include elite troops from unit pool |
| Special Forces | Checkbox | false | Include special forces from unit pool |
| Rush Mode | Checkbox | false | Makes AI more prone to aggressively pushing player positions irrespective of the amount of contact |
| Wave Delay | Number | 60 | Seconds between spawn waves |
| Additional Condition | String | `"true"` | Custom spawn condition |
| Code on Spawn | String | `"true"` | SQF code executed when group spawns |

### Infantry - Foot Mobile

| Editor Name | Classname |
|-------------|-----------|
| Infantry - Foot Mobile | `reaperCrew_moduleReinforcementsHeadlessInfantry` |

Infantry spawn and immediately rush toward enemy positions on foot.

**Behaviour:**
1. Spawns infantry group at available spawnpoint
2. Group immediately executes LAMBS `taskRush` with 2km radius
3. No waypoints - direct engagement

**Best for:** Close-range defence, urban areas, dense terrain

**Associated Spawnpoint:** Infantry Spawnpoint

### Infantry - Motorised

| Editor Name | Classname |
|-------------|-----------|
| Infantry - Motorised | `reaperCrew_moduleReinforcementsHeadlessInfantryMotorised` |

Infantry spawn with a transport vehicle and drive to a dismount position, then rush. They will either drive to randomly calculated dismount positions based on the module variables, or drive to path waypoint positions if configured.

**Additional Attributes:**

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| Direction Min | Number | 90 | Minimum approach direction (degrees) |
| Direction Max | Number | 180 | Maximum approach direction (degrees) |
| Distance Min | Number | 500 | Minimum dismount distance (meters) |
| Distance Max | Number | 800 | Maximum dismount distance (meters) |

**Behaviour:**
1. Spawns infantry group at spawnpoint
2. Creates transport vehicle (from AI Common settings)
3. Group boards vehicle (size adjusted to vehicle capacity)
4. Vehicle drives to dismount position (path waypoints if defined)
5. Group dismounts and executes `taskRush`
6. Vehicle is cleaned up

**Best for:** Mid-range reinforcement, roads, open terrain

**Associated Spawnpoint:** Vehicle Spawnpoint

### Infantry - Airborne (Helicopter)

| Editor Name | Classname |
|-------------|-----------|
| Infantry - Airborne | `reaperCrew_moduleReinforcementsHeadlessInfantryHelicopter` |

Infantry are delivered by helicopter to a landing zone, then rush. Supports two delivery modes: landing or fastroping.

**Additional Attributes:**

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| Delivery Mode | Combo | LAND | LAND: helicopter lands and troops disembark. FASTROPE: helicopter hovers and troops fastrope down (requires ACE Fastroping) |
| Direction Min | Number | 90 | Minimum approach direction (degrees) |
| Direction Max | Number | 180 | Maximum approach direction (degrees) |
| Distance Min | Number | 500 | Minimum landing distance (meters) |
| Distance Max | Number | 800 | Maximum landing distance (meters) |

**Behaviour (LAND mode):**
1. Creates helipad at landing position (auto-deleted after 10 minutes)
2. Spawns helicopter at spawnpoint (flies at 250m altitude)
3. Spawns infantry group in helicopter cargo (size adjusted to capacity)
4. Helicopter flies path waypoints (if defined)
5. Helicopter performs transport unload at helipad
6. Infantry form up then execute `taskRush`
7. Helicopter returns to spawn and is deleted

**Behaviour (FASTROPE mode):**
1. Spawns helicopter at spawnpoint (flies at 250m altitude)
2. Spawns infantry group in helicopter cargo (size adjusted to capacity)
3. Helicopter flies path waypoints (if defined)
4. Helicopter approaches waypoint position, descends to 25m AGL
5. Helicopter is manually positioned directly over the waypoint using `setVelocityTransformation`
6. Helicopter is pinned in place; ACE `deployAI` deploys ropes and sends units down sequentially
7. Script waits for all units to reach the ground before releasing the helicopter
8. FRIES is stowed, helicopter returns to spawn and is deleted
9. Infantry form up then execute `taskRush`

**Fastrope Requirements:**
- ACE Fastroping must be loaded
- The helicopter must have `ace_fastroping_enabled` in its config (vanilla and most major mod helicopters have this via ACE compat patches - RHS, CUP, 3CB, etc.)
- If the helicopter does not have ACE fastroping config, the waypoint completes immediately and troops remain aboard. A warning is logged to RPT

**Known Issues (Fastrope):**
- Ropes may appear to hang slightly above ground level despite being functionally long enough (34.5m default vs 25m hover height). This is a visual issue within ACE's rope physics
- In MP, other clients may see minor visual jitter on the helicopter during deployment. The position hold uses `setPosASL` (global effect) but `setVelocity` and `setVectorDirAndUp` are local-effect commands. The helicopter remains functionally pinned

**Best for:** Rapid deployment, bypassing terrain, long-range reinforcement. FASTROPE mode is ideal for deploying into areas without flat landing zones

**Associated Spawnpoint:** Aircraft Spawnpoint

### Infantry - Marine

| Editor Name | Classname |
|-------------|-----------|
| Infantry - Marine | `reaperCrew_moduleReinforcementsHeadlessInfantryMarine` |

Infantry spawn with a boat and land at predefined Marine LZ locations.

**Behaviour:**
1. Spawns infantry group with boat at marine spawnpoint
2. Group boards boat
3. Boat travels to synchronized Marine LZ
4. Group dismounts and executes `taskRush` (2km radius)

**Requirements:**
- Marine Spawnpoint must have Marine LZ modules synchronized

**Best for:** Amphibious operations, coastal objectives, island terrain

**Associated Spawnpoint:** Marine Spawnpoint + Marine LZ

**Troubleshooting:**
- Verify Marine LZ modules are synchronized → Marine Spawnpoint
- Ensure LZ positions are accessible by boat (water/beach)

---

## Marauding Modules

Marauding modules provide a persistent flow of enemy vehicles or aircraft into an area, creating constant contact for fire support teams.

### Marauding Vehicles

| Editor Name | Classname |
|-------------|-----------|
| Marauding Vehicles | `reaperCrew_moduleReinforcementsHeadlessMaraudingVehicles` |

**Attributes:**

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| Vehicle Count | Number | 25 | Total vehicles to spawn |
| Frequency Min | Number | 180 | Minimum seconds between spawns |
| Frequency Max | Number | 240 | Maximum seconds between spawns |
| Heavy Armour | Checkbox | true | Include heavy armour (MBTs) |
| Light Armour | Checkbox | true | Include light armour (APCs/IFVs) |
| Technicals | Checkbox | true | Include technicals |

**Behaviour:**
1. Waits for players to enter module area
2. Spawns vehicle with crew at available vehicle spawnpoint
3. Vehicle receives SAD (Search And Destroy) waypoint - automatically moves to a player location rather than just the centre of the module
4. Continues spawning until vehicle count reached

**Associated Spawnpoint:** Vehicle Spawnpoint

**Troubleshooting:**
- Place spawnpoints in clear areas away from obstacles
- Ensure path waypoints avoid obstacles if used

### Marauding Aircraft

| Editor Name | Classname |
|-------------|-----------|
| Marauding Aircraft | `reaperCrew_moduleReinforcementsHeadlessMaraudingAircrafts` |

**Attributes:**

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| Aircraft Count | Number | 25 | Total aircraft to spawn |
| Frequency Min | Number | 180 | Minimum seconds between spawns |
| Frequency Max | Number | 240 | Maximum seconds between spawns |
| Fixed Wing Bombers | Checkbox | true | Include bomber aircraft |
| Fixed Wing Fighters | Checkbox | true | Include fighter aircraft |
| Rotary CAS Heavy | Checkbox | true | Include attack helicopters |
| Rotary CAS Light | Checkbox | true | Include light helicopters |

**Associated Spawnpoint:** Aircraft Spawnpoint

**Troubleshooting:**
- Place aircraft spawnpoints in clear areas with sufficient altitude clearance
- Ensure flight paths avoid mountains and tall structures

---

## Zone Threshold & Wave Mechanics

### Zone Threshold

The zone threshold prevents over-spawning. The system counts enemy units in the reinforcement module's trigger area and compares against the threshold. The threshold can operate in two modes, selectable per module:

**Threshold Mode (default):**
The zone threshold value is used as a static maximum. Spawning pauses when the enemy count in the zone reaches or exceeds this value.

**Player Ratio Mode:**
The zone threshold value is multiplied by the number of players currently inside the zone. This scales AI density proportionally to the player count, keeping the challenge consistent regardless of attendance. The effective threshold is calculated by `fn_getZoneThreshold`:

```
effectiveThreshold = zoneThresholdValue * (number of players in zone)
```

If no players are in the zone, the effective threshold is 0 and no spawning occurs.

**Common behaviour:**
- Spawning pauses when `opforCount >= effectiveThreshold`
- Spawning resumes when enemy count drops below the threshold
- Default threshold value: 20

### Wave Delay & Cooldowns

**Wave Delay:** Time between spawn attempts (default: 60 seconds)

**Spawnpoint Cooldown:**
- After spawning, spawnpoint is temporarily disabled
- Cooldown duration: `waveDelay + 2` seconds
- Prevents multiple units spawning at same location rapidly

### Spawn Conditions

For spawning to occur, ALL conditions must be true:
1. Enemy count < Zone threshold
2. Reinforcements remaining > 0
3. Pause setting is OFF
4. At least one spawnpoint is available
5. Additional condition returns true

---

## Custom Pathing

### Path Waypoint Setup

1. Place Path Waypoint modules along desired route
2. Select all waypoints and the spawnpoint
3. Synchronize waypoints to spawnpoint in order (first synced = first waypoint)
4. The last waypoint becomes the final destination

**Important:** Synchronization order determines traversal order.

### Position Drift

A random drift of up to 50m is applied to final positions to prevent:
- Multiple vehicles/helicopters landing at exact same location
- Collisions and explosions
- "Arma space program" incidents

---

## Code Examples

### Custom Spawn Code

The `codeOnSpawn` parameter executes when a group spawns. The spawned group is available as `_thisGroup`.

**Add Equipment:**
```sqf
{
    _x addItem "ACE_CableTie";
    _x addMagazine "SmokeShellGreen";
} forEach (units _thisGroup);
```

**Set Behaviour:**
```sqf
_thisGroup setBehaviour "STEALTH";
_thisGroup setSpeedMode "LIMITED";
```

**Disable Fleeing:**
```sqf
_thisGroup allowFleeing 0;
```

**Custom Skill:**
```sqf
{ _x setSkill 0.95 } forEach (units _thisGroup);
```

### Additional Conditions

**Variable Check:**
```sqf
townAttacked
```

**Trigger Activation:**
```sqf
triggerActivated myTrigger
```

**Time-Based:**
```sqf
time > 600
```

**Player Count:**
```sqf
count allPlayers > 10
```

**Combined Conditions:**
```sqf
(townAttacked) && (time > 300)
```

### Runtime Control

**Pause Reinforcements:**
```sqf
// Pause all infantry
reaperCrew_pauseInfantryReinforcements = true;

// Resume
reaperCrew_pauseInfantryReinforcements = false;
```

**Check Active Spawnpoints:**
```sqf
// View active triggers in debug
diag_log format ["Active Infantry: %1", activeInfantryTriggers];
diag_log format ["Active Vehicle: %1", activeVehicleTriggers];
diag_log format ["Active Aircraft: %1", activeAircraftTriggers];
diag_log format ["Active Marine: %1", activeMarineTriggers];
```

---

## Synchronization

### Dedicated Spawnpoints

To restrict a reinforcement module to specific spawnpoints:
1. Place the reinforcement module
2. Place desired spawnpoints
3. Synchronize spawnpoints → reinforcement module

Without synchronization, the module uses ALL available spawnpoints of the appropriate type.

### Marine LZ Synchronization

Marine spawnpoints require synchronized Marine LZ modules:
1. Place Marine Spawnpoint
2. Place Marine LZ modules at desired beach landing locations
3. Synchronize Marine LZ modules → Marine Spawnpoint

---

## General Troubleshooting

### Units Not Spawning

- **Check faction:** Ensure `reaperCrew_reinforcements_side` is correctly set
- **Check classnames:** Verify unit classnames in AI Common settings are valid and ensure there are no spaces
- **Check pause settings:** Ensure pause checkboxes are unchecked
- **Check conditions:** Verify additional condition code returns true
- **Check spawnpoints:** Ensure spawnpoints are placed and within range

### Wrong Units Spawning

- Verify troop type checkboxes match desired unit pools
- Check AI Common settings for correct classnames

### Performance Issues

- Reduce reinforcement count
- Increase wave delay
- Use fewer simultaneous modules
