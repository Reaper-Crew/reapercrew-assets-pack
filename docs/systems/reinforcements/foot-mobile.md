# Reinforcements: Infantry - Foot Mobile

| Editor Name | Classname |
|-------------|-----------|
| Reinforcements (Infantry - Foot Mobile) | `reaperCrew_moduleReinforcementsHeadlessInfantry` |

Part of the [Reinforcements System](reinforcements-system.md). Found in Eden under `Systems (F5) > Modules > Reaper Crew - Reinforcements`.

## Overview

Infantry spawn at an [Infantry Spawnpoint](spawnpoints.md) and immediately rush toward enemy positions on foot. This is the simplest reinforcement type: no vehicles, no waypoints, direct engagement.

**Best for:** Close-range defence, urban areas, dense terrain.

## Attributes

This module uses the [common infantry module attributes](reinforcements-system.md#common-infantry-module-attributes) only: Reinforcement Count, Zone Limit Mode, Zone Ceiling, Zone Ratio, troop type checkboxes, Rush Mode, Wave Delay, Additional Condition and Code on Spawn.

## Behaviour

1. Spawns infantry group at available spawnpoint
2. Group immediately executes LAMBS `taskRush` with a radius matching the spawnpoint's outer zone, so the rush always covers the ground between the spawnpoint and the players who activated it
3. No waypoints - direct engagement

## Setup

1. Place one or more **Infantry Spawnpoint** modules around the area, out of sight of player approaches
2. Place the **Reinforcements (Infantry - Foot Mobile)** module and resize its area to cover the zone you want defended
3. Optionally synchronise specific spawnpoints to the module; unsynchronised modules use the nearest active Infantry Spawnpoint
4. Configure the attributes (troop types, count, ceiling)

## Worked Example: Defended Town

The players must clear a town that defends itself with waves of infantry from within. Taking the town centre shuts off the reinforcements.

**Eden setup:**

1. Place an **Infantry Spawnpoint** inside a large building on the edge of the town (a warehouse or large house works well - see [placement tips](spawnpoints.md#placement-tips)):
   - Capturable: ticked
   - Inner Zone: `300` (the default 1 km would cover the whole town and disable the spawnpoint as soon as players got close)
   - Resize the outer zone area to around 1.5 km so the module activates as players approach
2. Place a **Reinforcements (Infantry - Foot Mobile)** module over the town:
   - Reinforcement Count: `40`
   - Zone Ceiling: `40`
   - Resize the module area to cover the town
3. Synchronise the spawnpoint to the module

**Result:** As players approach the town, infantry waves spawn at the edge spawnpoint and rush them. When players push into the town centre and reach the spawnpoint's inner zone, the spawnpoint is captured and reinforcements stop. Attribute values not listed are left at their defaults.

## Troubleshooting

See the [general troubleshooting](reinforcements-system.md#general-troubleshooting) section. Foot mobile specific checks:

- Ensure at least one Infantry Spawnpoint is placed and [active](spawnpoints.md#activation-conditions)
- If synchronised to specific spawnpoints, remember activation conditions still apply to them
