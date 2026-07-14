# Reinforcements: Infantry - Helicopter

| Editor Name | Classname |
|-------------|-----------|
| Reinforcements (Infantry - Helicopter) | `reaperCrew_moduleReinforcementsHeadlessInfantryHelicopter` |

Part of the [Reinforcements System](reinforcements-system.md). Found in Eden under `Systems (F5) > Modules > Reaper Crew - Reinforcements`.

## Overview

Infantry are delivered by helicopter from an [Aircraft Spawnpoint](spawnpoints.md) to a landing zone, then rush. Supports three delivery modes: landing, fastroping, or a random choice per helicopter.

**Best for:** Rapid deployment, bypassing terrain, long-range reinforcement. FASTROPE mode is ideal for deploying into areas without flat landing zones.

## Attributes

In addition to the [common infantry module attributes](reinforcements-system.md#common-infantry-module-attributes):

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| Delivery Mode | Combo | LAND | LAND: helicopter lands and troops disembark. FASTROPE: helicopter hovers and troops fastrope down (requires ACE Fastroping). RANDOM: each helicopter independently chooses land or fastrope at random |
| Direction Min | Number | 90 | Minimum approach direction (degrees) |
| Direction Max | Number | 180 | Maximum approach direction (degrees) |
| Distance Min | Number | 500 | Minimum landing distance (meters) |
| Distance Max | Number | 800 | Maximum landing distance (meters) |

The direction and distance attributes describe where the LZ is placed relative to the module centre: a random bearing between Direction Min and Max, at a random distance between Distance Min and Max.

## Behaviour

**LAND mode:**

1. Creates helipad at landing position (auto-deleted after 10 minutes)
2. Spawns helicopter at spawnpoint (flies at 250m altitude)
3. Spawns infantry group in helicopter cargo (size adjusted to capacity)
4. Helicopter flies path waypoints (if defined)
5. Helicopter performs transport unload at helipad
6. Infantry form up then execute `taskRush` with a radius of the module's Distance Max attribute plus 500 m, so the rush always covers the ground from the furthest possible LZ back to the module area
7. Helicopter returns to spawn and is deleted

**FASTROPE mode:**

1. Spawns helicopter at spawnpoint (flies at 250m altitude)
2. Spawns infantry group in helicopter cargo (size adjusted to capacity)
3. Helicopter flies path waypoints (if defined)
4. Helicopter approaches waypoint position, descends to 25m AGL
5. Helicopter is manually positioned directly over the waypoint using `setVelocityTransformation`
6. Helicopter is pinned in place; ACE `deployAI` deploys ropes and sends units down sequentially
7. Script waits for all units to reach the ground before releasing the helicopter
8. FRIES is stowed, helicopter returns to spawn and is deleted
9. Infantry form up then execute `taskRush` with a radius of the module's Distance Max attribute plus 500 m

## Fastrope Requirements

- ACE Fastroping must be loaded
- The helicopter must have `ace_fastroping_enabled` in its config (vanilla and most major mod helicopters have this via ACE compat patches - RHS, CUP, 3CB, etc.)
- If the helicopter does not have ACE fastroping config, the waypoint completes immediately and troops remain aboard. A warning is logged to RPT

## Known Issues (Fastrope)

- Ropes may appear to hang slightly above ground level despite being functionally long enough (34.5m default vs 25m hover height). This is a visual issue within ACE's rope physics
- In MP, other clients may see minor visual jitter on the helicopter during deployment. The position hold uses `setPosASL` (global effect) but `setVelocity` and `setVectorDirAndUp` are local-effect commands. The helicopter remains functionally pinned

## Setup

1. Place an **Aircraft Spawnpoint** at the enemy airbase or staging area (up to 25 km away)
2. Place the **Reinforcements (Infantry - Helicopter)** module over the area to defend
3. Choose the Delivery Mode and set Direction/Distance to control where troops are put down
4. Optionally synchronise **Path Waypoint** modules to the spawnpoint to shape the flight route (for example, around known AA positions)

## Worked Example: Fastrope QRF onto a Hilltop Radar Site

A hilltop radar site with no easy landing ground reacts to attack by fastroping troops onto the summit.

**Eden setup:**

1. Place an **Aircraft Spawnpoint** at an enemy airbase up to 25 km away. Leave attributes at default
2. Place a **Reinforcements (Infantry - Helicopter)** module over the radar site:
   - Reinforcement Count: `24`
   - Zone Limit Mode: `Player Ratio / Ceiling`
   - Zone Ratio: `2`, Zone Ceiling: `30`
   - Delivery Mode: `FASTROPE`
   - Distance Min / Max: `100` / `250` (rope in close to the site)
   - Additional Condition: `radarAlarmRaised`
3. In a trigger around the radar site, set On Activation: `radarAlarmRaised = true; publicVariable "radarAlarmRaised";`

**Result:** Nothing spawns until players trip the alarm trigger. From then on, helicopters lift from the airbase, fly in and fastrope troops close to the summit, scaled to two AI per player in the zone with a hard cap of 30. Attribute values not listed are left at their defaults. Make sure the transport helicopter classes set in AI Common support ACE fastroping.

## Troubleshooting

See the [general troubleshooting](reinforcements-system.md#general-troubleshooting) section. Helicopter specific checks:

- Verify transport helicopter classnames are set in the AI Common CBA settings
- For FASTROPE, confirm the helicopter class supports ACE fastroping (see requirements above); check RPT for the warning if troops stay aboard
- Keep flight paths clear of mountains and tall structures, or shape them with Path Waypoints
