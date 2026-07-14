# Patrol Area Module

| Editor Name | Classname |
|-------------|-----------|
| Patrol Area | `reaperCrew_modulePatrol` |

Part of the [AI Mechanics System](ai-mechanics.md). Found in Eden under `Systems (F5) > Modules > Reaper Crew - AI Mechanics`.

## Overview

The Patrol Area module fills a zone with patrolling AI. It spawns variable sized groups up to a maximum unit count, drawn from the regular, elite and special forces troop pools (configured via CBA settings in [AI Common](ai-common.md)), and assigns each group a LAMBS patrol confined to the module's area. Skill levels are applied automatically based on the troop type selected.

## Quick Start

1. Place the **Patrol Area** module in Eden Editor
2. Resize the module's area to cover the zone you want patrolled
3. Configure the troop types, group sizes and maximum unit count
4. (Optional) Synchronise a trigger to the module to defer spawning until the trigger activates
5. Preview or start the mission

## Attributes

| Attribute | Property | Type | Default | Description |
|-----------|----------|------|---------|-------------|
| Max Units | `maxCount` | Number | 50 | Maximum number of AI to spawn across all patrols |
| Regular Troops | `regularTroops` | Checkbox | true | Include regular troops from unit pool |
| Elite Troops | `eliteTroops` | Checkbox | false | Include elite troops from unit pool |
| Special Forces | `specialTroops` | Checkbox | false | Include special forces from unit pool |
| Min Group Size | `minGroupSize` | Number | 3 | Minimum number of units in each patrol group |
| Max Group Size | `maxGroupSize` | Number | 6 | Maximum number of units in each patrol group |
| Code on Spawn | `codeOnSpawn` | String | `"true"` | Custom SQF code executed when each patrol group spawns |

## Area Configuration

- Default area: 100m x 100m
- Use the area tool to resize and reshape the patrol zone (rectangular or elliptical)
- Groups spawn at random positions within the area and patrol the whole zone
- Water positions are rejected when placing groups

## How It Works

1. Module initialises on server and waits for a synchronised trigger to activate (if one exists)
2. Builds the troop pool from the enabled troop types
3. Spawns groups of random size (between Min and Max Group Size) until the Max Units cap is reached, with the final group trimmed so the cap is never exceeded
4. Each group spawns at a random land position inside the area
5. Each group is assigned a LAMBS patrol confined to the zone, distributed across headless clients (one call per group), with dispatches staggered (one every 3 seconds) so a mid-mission activation doesn't spawn every group in one frame and cause jitter
6. Skill is automatically set based on the troop type (Regular/Elite/SF) from CBA settings
7. Groups are marked for engine auto-deletion once every member is dead, so empty groups never accumulate towards the per-side group limit

## Deferred Spawning

To defer spawning until later in the mission, synchronise a trigger to the module. The module waits until the trigger activates before spawning any patrols. Any trigger condition works - area presence, a scripted variable, task states, etc. Without a synchronised trigger, patrols spawn at mission start.

## Code Examples

**Add Custom Equipment:**
```sqf
{
    _x addItem "ACE_CableTie";
    _x addMagazine "SmokeShell";
} forEach (units _thisGroup);
```

## Worked Example: Security Belt Around an Objective

Players must infiltrate a fuel depot at night. The open ground around the depot is covered by roaming patrols, forcing a deliberate approach, while a smaller elite presence patrols inside the depot fence.

**Eden setup:**

1. Place a **Patrol Area** module centred on the depot and resize its area to a 600m x 600m ellipse covering the surrounding ground:
   - Max Units: `24`
   - Min / Max Group Size: `3` / `4` (several small groups cover more ground than a few large ones)
2. Place a second **Patrol Area** module tightly over the depot itself (150m x 150m):
   - Max Units: `8`
   - Regular Troops: unticked, Elite Troops: ticked
   - Code on Spawn: `_thisGroup setSpeedMode "LIMITED";` (a slow walking pace suits sentries)

**Result:** Six to eight small patrols roam the approaches while two tighter elite patrols walk the depot interior. Attribute values not listed are left at their defaults. Skill for each pool comes from the AI Common CBA settings.

## Tips

- Keep Max Units reasonable for performance, especially on larger zones
- Larger areas with smaller groups create a more dispersed patrol presence
- Use Code on Spawn to apply custom behaviour, equipment or skill to each group (`_thisGroup` refers to the spawned group)
- Patrol units use dynamic simulation and will not trigger other dynamically simulated units to activate - only players can
- Group spawns are staggered (one every 3 seconds), so large patrol areas take a short while to fully populate after activation

## Troubleshooting

**Units not spawning:**
- Ensure at least one troop type checkbox is enabled
- Check that selected troop pools have valid classnames
- Verify the module area contains land (groups reject water positions)
- If a trigger is synchronised to the module, check that it has activated
- Groups spawn one every 3 seconds - large patrol areas take time to fully populate
