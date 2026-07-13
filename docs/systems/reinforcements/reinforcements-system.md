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

**Logging:**

The reinforcement system writes its diagnostic output (spawn activity, zone unit count breakdowns, waypoint searches, spawnpoint discovery and headless client distribution) to the server log automatically. There are no debug toggles to enable.

---

## Spawnpoint Modules

Spawnpoints determine where reinforcement units can spawn. All spawnpoints are found in Eden Editor under: `Systems (F5) > Modules > Reaper Crew - Reinforcements`

### Spawnpoint Zones

Each spawnpoint has two concentric zones:

- **Outer zone** - the activation radius. Players within it can trigger reinforcements. The outer zone is taken from the module's drawn area, so you can resize and reshape it in Eden; the values below are the default sizes used when the area is left untouched.
- **Inner zone** - an exclusion radius around the spawnpoint. The spawnpoint will not activate while a player is inside it, so AI never spawn on top of players.

| Module | Classname | Default Outer Zone | Default Inner Zone | Best Used For |
|--------|-----------|--------------------|--------------------|---------------|
| Infantry Spawnpoint | `reaperCrew_moduleInfantrySpawn` | 2km | 1km | Foot mobile infantry |
| Vehicle Spawnpoint | `reaperCrew_moduleVehicleSpawn` | 5km | 2.5km | Motorised infantry, marauding vehicles |
| Aircraft Spawnpoint | `reaperCrew_moduleAircraftSpawn` | 25km | 12.5km | Airborne infantry, marauding aircraft |
| Marine Spawnpoint | `reaperCrew_moduleMarineSpawn` | 7.5km | 3.75km | Marine/amphibious infantry |

### Spawnpoint Activation Conditions

A spawnpoint becomes active when ALL conditions are met:
1. **Player proximity** - At least one player is within the outer zone
2. **Inner zone clear** - No player is inside the inner exclusion zone
3. **Line of sight** - Players cannot directly see the spawnpoint location
4. **Ground contact** - At least one player is touching the ground (not in aircraft)
5. **Not captured** - The spawnpoint has not been captured (see Capturable below)
6. **Additional condition** - Any custom condition specified returns true

### Capturable Spawnpoints

If the **Capturable** attribute is ticked, the spawnpoint is permanently disabled the first time a player reaches its inner zone. This is a one-way latch and lets you place spawnpoints inside objective areas so that taking the objective shuts off its reinforcements. The captured state is published to the `reaperCrew_spawnpointCaptured` variable on the module logic for mission scripting. Capturable is off by default.

### Spawnpoint Attributes

| Attribute | Property | Type | Default | Description |
|-----------|----------|------|---------|-------------|
| Additional Condition | `additionalCondition` | String | `"true"` | Custom SQF condition appended to the activation check |
| Inner Zone | `innerZone` | Number | 1000 | Inner exclusion radius (metres); the spawnpoint is disabled while a player is within it |
| Capturable | `capturable` | Checkbox | false | If ticked, the spawnpoint is permanently disabled once a player reaches the inner zone |
| Debug Markers | `debugMarkers` | Checkbox | false | If ticked, draws map markers for the centre, inner zone and outer zone of the spawnpoint |

> **Note:** The outer zone is set by resizing the module's area in Eden, not via an attribute. Vehicle, aircraft and marine spawnpoints default their inner zone to half the outer zone; the Inner Zone attribute lets you override it per spawnpoint.

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
| Zone Limit Mode | Combo | CEILING | How the zone limit is calculated. **Ceiling**: fixed maximum total unit count. **Player Ratio / Ceiling**: scales with players but capped at the ceiling |
| Zone Ceiling | Number | 80 | Hard maximum number of units allowed in the zone (counts all humanoids, see [Zone Ceiling & Wave Mechanics](#zone-ceiling--wave-mechanics)) |
| Zone Ratio | Number | 3 | Number of AI per player used to scale the ceiling in Player Ratio / Ceiling mode |
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

Infantry are delivered by helicopter to a landing zone, then rush. Supports three delivery modes: landing, fastroping, or a random choice per helicopter.

**Additional Attributes:**

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| Delivery Mode | Combo | LAND | LAND: helicopter lands and troops disembark. FASTROPE: helicopter hovers and troops fastrope down (requires ACE Fastroping). RANDOM: each helicopter independently chooses land or fastrope at random |
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
| Additional Condition | String | `"true"` | Custom SQF condition appended to the activation check. While it returns false the module stops spawning, even with players still in the area |

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
| Additional Condition | String | `"true"` | Custom SQF condition appended to the activation check. While it returns false the module stops spawning, even with players still in the area |

**Associated Spawnpoint:** Aircraft Spawnpoint

**Troubleshooting:**
- Place aircraft spawnpoints in clear areas with sufficient altitude clearance
- Ensure flight paths avoid mountains and tall structures

---

## Zone Ceiling & Wave Mechanics

### Zone Ceiling

The zone ceiling prevents over-spawning. On each wave the system counts the units in the reinforcement module's trigger area and compares the total against an effective ceiling; while the count is at or above the ceiling, spawning is held.

#### What counts toward the ceiling

The count is a measure of total unit load in the zone, not just enemies. It includes:

- **Every living humanoid currently inside the zone, on any side** - players, civilians and enemies alike, including agent-based ambient civilians and anyone mounted in a vehicle. This means a zone already busy with players and civilians leaves less headroom for spawned AI, so the ceiling reflects the real unit load rather than enemies alone.
- **The module's own reinforcements that have spawned but not yet arrived.** Vehicle-based types (airborne, motorised, marine) spawn their troops outside the zone and then move in. Each module tracks the units it has spawned and counts those still inbound, so it does not keep launching fresh waves while the first is still en route. Units already inside the zone are only counted once.

Inbound units stop being counted once they are killed, and only the deployed infantry counts (a helicopter's transport crew is excluded as it departs; for motorised and marine the same group both drives and dismounts, so it is counted).

The breakdown is logged each evaluation, for example: `Zone unit count: 50 in zone + 16 inbound (tracked) = 66 total`.

> **Note:** The trigger area is two-dimensional (no height limit), so troops still aboard a helicopter passing over the zone are counted as "in zone" rather than "inbound". The total remains correct; only the split between the two figures shifts.

#### Ceiling modes

The effective ceiling is calculated in one of two ways, selectable per module via the Zone Limit Mode attribute:

**Ceiling Mode (default):**
The zone ceiling value is used as a static maximum. Spawning pauses when the zone unit count reaches or exceeds this value.

**Player Ratio / Ceiling Mode:**
The zone ratio is multiplied by the number of players currently inside the zone, but the result is capped at the zone ceiling. This scales AI density proportionally to the player count while guaranteeing a hard upper limit. The effective ceiling works out as:

```
effectiveCeiling = min(ceil(zoneRatio * playerCount), zoneCeiling)
```

If no players are in the zone, the effective ceiling is 0 and no spawning occurs. With many players, the ceiling prevents runaway AI counts.

**Testing Override:**
In singleplayer or low player count testing, ratio-configured modules will barely spawn any units. To force all ratio modules to behave as ceiling-only mode, add the following to your mission's `init.sqf`:

```sqf
reaperCrew_debugOverrideRatio = true;
```

This causes all ratio modules to use their ceiling value directly. A log message is written each time the override takes effect. Remove this line before deploying the mission.

**Common behaviour:**
- Spawning pauses when the zone unit count (in zone plus inbound) reaches or exceeds the effective ceiling
- Spawning resumes when the count drops below the ceiling (for example as units are killed or move off)
- Default ceiling value: 80
- Default ratio value: 3

### Wave Delay & Cooldowns

**Wave Delay:** Time between spawn attempts (default: 60 seconds)

**Spawnpoint Cooldown:**
- After spawning, spawnpoint is temporarily disabled
- Cooldown duration: `waveDelay + 2` seconds
- Prevents multiple units spawning at same location rapidly

### Group Cleanup

Every group spawned by the reinforcement and marauding modules is marked for engine auto-deletion once all of its members are dead. Empty groups therefore never accumulate towards the per-side group limit, no matter how many waves a long mission spawns.

### Spawn Conditions

For spawning to occur, ALL conditions must be true:
1. Zone unit count (in zone plus inbound) < Zone ceiling
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
