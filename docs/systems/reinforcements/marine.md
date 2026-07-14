# Reinforcements: Infantry - Marine

| Editor Name | Classname |
|-------------|-----------|
| Reinforcements (Infantry - Marine) | `reaperCrew_moduleReinforcementsHeadlessInfantryMarine` |

Part of the [Reinforcements System](reinforcements-system.md). Found in Eden under `Systems (F5) > Modules > Reaper Crew - Reinforcements`.

## Overview

Infantry spawn with a boat at a [Marine Spawnpoint](spawnpoints.md) and land at predefined [Marine LZ](spawnpoints.md#marine-lz) locations, then rush.

**Best for:** Amphibious operations, coastal objectives, island terrain.

## Attributes

This module uses the [common infantry module attributes](reinforcements-system.md#common-infantry-module-attributes) only: Reinforcement Count, Zone Limit Mode, Zone Ceiling, Zone Ratio, troop type checkboxes, Rush Mode, Wave Delay, Additional Condition and Code on Spawn. Landing positions come from Marine LZ modules, not direction/distance attributes.

## Behaviour

1. Spawns infantry group with boat at marine spawnpoint
2. Group boards boat
3. Boat travels to synchronized Marine LZ
4. Group dismounts and executes `taskRush` (2km radius)

## Requirements

- The Marine Spawnpoint must have at least one **Marine LZ** module synchronised to it
- LZ positions must be reachable by boat (water or beach)

## Setup

1. Place a **Marine Spawnpoint** offshore or on a hostile coastline
2. Place one or more **Marine LZ** modules on beaches near the defended area
3. Synchronise each Marine LZ to the Marine Spawnpoint
4. Place the **Reinforcements (Infantry - Marine)** module over the area to defend

## Worked Example: Coastal Raid Response

Players raid a coastal facility. Enemy marines counter-attack by boat from an offshore island.

**Eden setup:**

1. Place a **Marine Spawnpoint** on the island shoreline
2. Place two or three **Marine LZ** modules on beaches near the facility, spread out so landings vary
3. Synchronise each Marine LZ to the Marine Spawnpoint
4. Place a **Reinforcements (Infantry - Marine)** module over the facility:
   - Reinforcement Count: `30`
   - Wave Delay: `120` (boats take time to arrive; a longer delay stops waves stacking up)

**Result:** While players are in the facility area, boats spawn at the island, motor to a random synchronised LZ, land troops and the troops rush the facility. The inbound troops count towards the [zone ceiling](reinforcements-system.md#zone-ceiling--wave-mechanics) while at sea, so the module will not flood the water with boats. Attribute values not listed are left at their defaults.

## Troubleshooting

See the [general troubleshooting](reinforcements-system.md#general-troubleshooting) section. Marine specific checks:

- Verify Marine LZ modules are synchronised to the Marine Spawnpoint
- Ensure LZ positions are accessible by boat (water/beach)
- Verify boat classnames are set in the AI Common CBA settings
