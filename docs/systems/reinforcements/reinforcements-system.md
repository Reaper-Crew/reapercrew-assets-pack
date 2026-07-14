# Reinforcements System

## Overview

The Reinforcements System provides mission makers with a way to programmatically create dynamic AI reinforcements without requiring any scripting. The system is designed to be performance-friendly and fully headless client compatible, making it ideal for large-scale operations.

This system leverages the LAMBS Rush module for AI behaviour and complements existing tools like Zeus Enhanced.

## Module Pages

| Page | Covers |
|------|--------|
| [Spawnpoints](spawnpoints.md) | All four spawnpoint types, zones, activation conditions, Capturable, Path Waypoint, Marine LZ, custom pathing |
| [Infantry - Foot Mobile](foot-mobile.md) | Infantry that spawn and rush on foot |
| [Infantry - Motorised](motorised.md) | Infantry delivered by transport vehicle |
| [Infantry - Helicopter](helicopter.md) | Infantry delivered by helicopter (land, fastrope or random) |
| [Infantry - Marine](marine.md) | Infantry delivered by boat to Marine LZs |
| [Marauding Vehicles & Aircraft](marauding.md) | Persistent vehicle and air pressure on an area |

## Quick Start

1. Configure AI Common settings (faction, unit pools) in CBA Settings
2. Place one or more [Spawnpoint](spawnpoints.md) modules where you want units to spawn
3. Place a reinforcement module in the area you want defended
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

## Common Infantry Module Attributes

All four infantry reinforcement modules share these attributes:

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

The motorised and helicopter modules add direction and distance attributes for placing dismount points and LZs, and the helicopter module adds a delivery mode. See the individual module pages.

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

Without synchronization, the module uses ALL available spawnpoints of the appropriate type. See [Spawnpoints](spawnpoints.md#modes-of-operation) for details.

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
