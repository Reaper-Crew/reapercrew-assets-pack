# Marauding Vehicles & Aircraft

| Editor Name | Classname |
|-------------|-----------|
| Marauding Vehicles | `reaperCrew_moduleReinforcementsHeadlessMaraudingVehicles` |
| Marauding Aircraft | `reaperCrew_moduleReinforcementsHeadlessMaraudingAircrafts` |

Part of the [Reinforcements System](reinforcements-system.md). Found in Eden under `Systems (F5) > Modules > Reaper Crew - Reinforcements`.

## Overview

Marauding modules provide a persistent flow of enemy vehicles or aircraft into an area, creating constant contact for fire support teams. Use of these modules helps ensure that fire support platforms like CAS and MBTs always have plenty of contact, without detracting from the role of the infantry. As with the rest of the reinforcements system, they are fully headless client compatible.

Both modules use the [spawnpoint modules](spawnpoints.md): Marauding Vehicles uses the Vehicle Spawnpoint and Marauding Aircraft uses the Aircraft Spawnpoint. All spawnpoint behaviour (outer activation zone, inner exclusion zone, the Capturable option and Debug Markers) applies exactly as it does for the infantry reinforcement modules.

## Behaviour

1. The module creates a trigger matching its drawn area and waits for players to enter it
2. Once players are detected, vehicles or aircraft begin spawning at an available spawnpoint with their crew
3. Each vehicle receives a Search And Destroy waypoint placed on the position of the player nearest the chosen spawnpoint, so vehicles head for the actual fight rather than just the centre of the module
4. Spawning continues at a random interval between Frequency Min and Max until the configured count is exhausted or players leave the zone
5. Crews are marked for engine auto-deletion once every member is dead, so empty groups never accumulate towards the per-side group limit

## Marauding Vehicles Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| Vehicle Count | Number | 25 | Total vehicles to spawn |
| Frequency Min | Number | 180 | Minimum seconds between spawns |
| Frequency Max | Number | 240 | Maximum seconds between spawns |
| Heavy Armour | Checkbox | true | Include heavy armour (MBTs) |
| Light Armour | Checkbox | true | Include light armour (APCs/IFVs) |
| Technicals | Checkbox | true | Include technicals |
| Additional Condition | String | `"true"` | Custom SQF condition appended to the activation check. While it returns false the module stops spawning, even with players still in the area |

The vehicle classes for each category are defined in the AI Common CBA settings.

## Marauding Aircraft Attributes

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

## Live Pausing

Marauding spawning can be paused mid-mission via the CBA settings menu under `Reaper Crew - AI Reinforcements > Live Mission Settings` (Pause Marauding Vehicles / Pause Marauding Aircraft). These can be toggled repeatedly during the mission as required. The Additional Condition attribute offers scripted control per module: while it returns false the module stops spawning without requiring players to leave the zone.

## Logging

The marauding modules write their diagnostic output (spawn activity, remaining vehicle/aircraft counts and spawnpoint availability) to the server log automatically. There are no debug toggles to enable.

## Worked Example: Armour Pressure for Fire Support Teams

A long overwatch phase where an attached fire support team has a steady supply of vehicle targets.

**Eden setup:**

1. Place a **Vehicle Spawnpoint** behind a ridge out of line of sight, 3 to 5 km from the overwatch position
2. Optionally place **Path Waypoint** modules along a valley road and synchronise them to the spawnpoint in traversal order, so vehicles approach along a predictable axis
3. Place a **Marauding Vehicles** module over the engagement area:
   - Vehicle Count: `15`
   - Frequency Min / Max: `240` / `420`
   - Heavy Armour: unticked (keep it to light armour and technicals if the team only has light launchers)

**Result:** While players observe the engagement area, a vehicle spawns behind the ridge every four to seven minutes, follows the valley road and hunts player positions with a Search And Destroy waypoint. Untick vehicle classes to match the anti-armour capability of the players. Attribute values not listed are left at their defaults.

## Troubleshooting

See the [general troubleshooting](reinforcements-system.md#general-troubleshooting) section. Marauding specific checks:

- Place spawnpoints in clear areas away from obstacles; aircraft spawnpoints need altitude clearance
- Ensure path waypoints avoid obstacles, mountains and tall structures if used
- Verify the vehicle/aircraft classnames for the ticked categories are set in the AI Common CBA settings
- Check the pause settings under Live Mission Settings are unticked
