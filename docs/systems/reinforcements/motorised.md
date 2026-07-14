# Reinforcements: Infantry - Motorised

| Editor Name | Classname |
|-------------|-----------|
| Reinforcements (Infantry - Motorised) | `reaperCrew_moduleReinforcementsHeadlessInfantryMotorised` |

Part of the [Reinforcements System](reinforcements-system.md). Found in Eden under `Systems (F5) > Modules > Reaper Crew - Reinforcements`.

## Overview

Infantry spawn with a transport vehicle at a [Vehicle Spawnpoint](spawnpoints.md) and drive to a dismount position, then rush. They will either drive to randomly calculated dismount positions based on the module attributes, or drive to [path waypoint](spawnpoints.md#custom-pathing) positions if configured.

**Best for:** Mid-range reinforcement, roads, open terrain.

## Attributes

In addition to the [common infantry module attributes](reinforcements-system.md#common-infantry-module-attributes):

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| Direction Min | Number | 90 | Minimum approach direction (degrees) |
| Direction Max | Number | 180 | Maximum approach direction (degrees) |
| Distance Min | Number | 500 | Minimum dismount distance (meters) |
| Distance Max | Number | 800 | Maximum dismount distance (meters) |

The direction and distance attributes describe where the dismount position is placed relative to the module centre: a random bearing between Direction Min and Max, at a random distance between Distance Min and Max.

## Behaviour

1. Spawns infantry group at spawnpoint
2. Creates transport vehicle (from AI Common settings)
3. Group boards vehicle (size adjusted to vehicle capacity)
4. Vehicle drives to dismount position (path waypoints if defined)
5. Group dismounts and executes `taskRush` with a radius of the module's Distance Max attribute plus 500 m, so the rush always covers the ground from the furthest possible dismount point back to the module area
6. Vehicle is cleaned up

## Setup

1. Place one or more **Vehicle Spawnpoint** modules 2 to 5 km from the defended area, near roads
2. Place the **Reinforcements (Infantry - Motorised)** module over the area to defend
3. Set Direction Min/Max to the bearing range you want the dismounts to arrive on
4. Set Distance Min/Max so dismounts happen short of player positions, not among them
5. Optionally synchronise **Path Waypoint** modules to the spawnpoint to force a specific route

## Worked Example: Counter-Attack from a Neighbouring Village

Players assault a town; a garrison in a neighbouring village 3 km to the north sends motorised reinforcements.

**Eden setup:**

1. Place a **Vehicle Spawnpoint** in the neighbouring village. Leave its attributes at default
2. Place a **Reinforcements (Infantry - Motorised)** module over the assaulted town:
   - Reinforcement Count: `30`
   - Distance Min / Max: `400` / `700` (dismount outside the town so trucks are not driving into player positions)
   - Direction Min / Max: `315` / `45` (dismounts arrive on the northern arc, facing the village they came from)
3. Synchronise the Vehicle Spawnpoint to the module

**Result:** While players are in the town area, trucks lift troops from the village, drive south, dismount them 400 to 700 m north of the town and the troops rush in. The empty trucks are removed. Attribute values not listed are left at their defaults.

## Troubleshooting

See the [general troubleshooting](reinforcements-system.md#general-troubleshooting) section. Motorised specific checks:

- Verify transport vehicle classnames are set in the AI Common CBA settings
- Place spawnpoints near roads; vehicles spawned in rough terrain may struggle to pathfind
- If vehicles take odd routes, force the route with [Path Waypoints](spawnpoints.md#custom-pathing)
