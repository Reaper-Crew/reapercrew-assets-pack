# Reinforcements: Infantry - Streamer

| Editor Name | Classname |
|-------------|-----------|
| Reinforcements (Infantry - Streamer) | `reaperCrew_moduleReinforcementsStreamer` |

Part of the [Reinforcements System](reinforcements-system.md). Found in Eden under `Systems (F5) > Modules > Reaper Crew - Reinforcements`.

## Overview

A one-shot module that spawns individual infantry, each in its own group, and sends them at the players. Units appear at the module's position one at a time, which produces a trickle of contacts instead of a squad-sized assault.

Once players enter the module area it activates and cannot be stopped. After the last unit spawns, the module and its trigger delete themselves. Spawned units remain.

**Best for:** Single ambush points, harassment, a scripted rush at a set moment.

## Attributes

| Attribute | Default | Description |
|-----------|---------|-------------|
| Unit Count | 10 | Number of units to spawn |
| Spawn Interval (seconds) | 2 | Time between each unit |
| Regular Troops | Ticked | Include the regular troop pool from [AI Common](../ai/ai-common.md) |
| Elite Troops | Unticked | Include the elite troop pool |
| Special Forces | Unticked | Include the special forces pool |
| Enable Rush | Ticked | Units rush the nearest players. Untick to control their behaviour yourself |
| Additional Condition | `true` | Extra condition that must be true for the module to activate |
| Code on Spawn | `true` | Code run once per unit. `_thisUnit` is the spawned unit |

Zone Ceiling, Zone Ratio and Wave Delay do not apply. The module ignores the infantry reinforcements pause switch.

## Behaviour

1. Activates when a player is on the ground inside the module area and the Additional Condition is true
2. Each unit picks a ticked troop pool at random, then a random classname from that pool, and takes that pool's skill level
3. Units spawn at the module's position, one every Spawn Interval, until Unit Count is reached
4. With Enable Rush ticked, each unit executes LAMBS `taskRush` with a radius of 150% of the module area's larger side
5. Code on Spawn runs for each unit
6. The module and its trigger are deleted after the last unit spawns

Spawning continues if players leave the area.

## Setup

1. Place the **Reinforcements (Infantry - Streamer)** module where units should appear
2. Resize its area to cover the ground players cross to trigger it
3. Tick at least one troop pool. A module with none ticked does not initialise
4. Set Unit Count and Spawn Interval

## Code on Spawn

`_thisUnit` is the spawned unit. To give each unit a smoke grenade:

```sqf
_thisUnit addMagazine "SmokeShell";
```

## Troubleshooting

See the [general troubleshooting](reinforcements-system.md#general-troubleshooting) section. Streamer specific checks:

- Confirm at least one troop pool is ticked
- Confirm the Additional Condition evaluates to true
- Players must be on the ground to activate the module, so a player in a parachute or helicopter does not trigger it
