# Garrison Area Module

| Editor Name | Classname |
|-------------|-----------|
| Garrison Area | `reaperCrew_moduleGarrison` |

Part of the [AI Mechanics System](ai-mechanics.md). Found in Eden under `Systems (F5) > Modules > Reaper Crew - AI Mechanics`.

## Overview

The Garrison Area module automatically spawns AI units and places them in nearby buildings. Units are distributed across buildings with one group per building, and skill levels are automatically applied based on the troop type selected (configured via CBA settings in [AI Common](ai-common.md)).

## Quick Start

1. Place the **Garrison Area** module in Eden Editor
2. Resize the module's area to cover the buildings you want garrisoned
3. Configure the troop types and maximum unit count
4. (Optional) Synchronise a trigger to the module to defer spawning until the trigger activates
5. Preview or start the mission

## Attributes

| Attribute | Property | Type | Default | Description |
|-----------|----------|------|---------|-------------|
| Max Units | `MaxUnits` | Number | 50 | Maximum number of AI to spawn in the area |
| Regular Troops | `regularTroops` | Checkbox | true | Include regular troops from unit pool |
| Elite Troops | `eliteTroops` | Checkbox | false | Include elite troops from unit pool |
| Special Forces | `specialTroops` | Checkbox | false | Include special forces from unit pool |
| Min Units Per Building | `minUnitsPerBuilding` | Number | 4 | Buildings with fewer valid positions are skipped |
| Max Units Per Building | `maxUnitsPerBuilding` | Number | 10 | Caps the number of units placed in any single building |
| Min Position Distance | `minPositionDistance` | Number | 3 | Minimum distance (metres) between positions within a building |
| Code on Spawn | `codeOnSpawn` | String | `"true"` | Custom SQF code executed when each building group spawns |

## Area Configuration

- Default area: 5m x 5m
- Use the area tool to resize and reshape the garrison zone
- Buildings within the area will be considered for occupation

## How It Works

1. Module initialises on server and waits for a synchronised trigger to activate (if one exists)
2. Finds all buildings in the configured area using LAMBS
3. Filters buildings with valid interior positions (ceiling check)
4. Groups positions by building
5. Filters positions within each building by minimum distance to prevent clustering
6. Applies per-building min/max limits (skips buildings below minimum, caps at maximum)
7. Respects the global max unit count across all buildings
8. Spawns one group per building, distributed across headless clients, with dispatches staggered (one every 3 seconds) so a mid-mission activation doesn't spawn every group in one frame and cause jitter
9. Each unit is assigned a random stance (UP/MIDDLE) with pathfinding disabled
10. Skill is automatically set based on the troop type (Regular/Elite/SF) from CBA settings
11. Groups are marked for engine auto-deletion once every member is dead, so empty groups never accumulate towards the per-side group limit

## Deferred Spawning

To defer spawning until later in the mission, synchronise a trigger to the module. The module waits until the trigger activates before spawning any units. Any trigger condition works - area presence, a scripted variable, task states, etc. Without a synchronised trigger, the garrison spawns at mission start.

## Code Examples

**Add Custom Equipment:**
```sqf
{
    _x addItem "ACE_CableTie";
    _x addMagazine "SmokeShell";
} forEach (units _thisGroup);
```

## Worked Example: Defended Compound

Players must assault a walled compound held by dug-in defenders. Attribute values not listed are left at their defaults.

**Eden setup:**

1. Place a **Garrison Area** module over the compound and resize the area to cover its buildings:
   - Max Units: `30`
   - Regular Troops: ticked
   - Min Units Per Building: `3` (occupy the smaller outbuildings too)
   - Max Units Per Building: `6` (spread the defence rather than packing one structure)
2. To save server load at mission start, place a trigger (Anybody Present, area covering the approach to the compound) and synchronise it to the module

**Result:** Nothing spawns until players enter the approach trigger. The compound then fills with defenders at one group per building, spread across every structure with three or more usable positions, and players have to clear it room by room. Skill comes from the AI Common CBA settings.

Use one Garrison Area per defended location. Do not layer garrison modules over the same buildings; if you want a stronger defence in one part of a town, draw the areas so they cover separate buildings.

## Tips

- Place module centre in areas with dense buildings
- Keep Max Units reasonable (40-60) for performance
- Units use dynamic simulation for performance optimisation
- Each building spawns as a separate group, distributed across headless clients
- Synchronise a trigger to defer spawning and reduce mission startup load
- Group spawns are staggered (one every 3 seconds), so large garrisons take a short while to fully populate after activation
- Garrison units will not trigger other dynamically simulated units to activate - only players can
- Skill levels are inherited from the CBA AI Common settings for each troop type

## Troubleshooting

**Units not spawning:**
- Verify buildings exist in the module area
- Check that selected troop pools have valid classnames
- Ensure at least one troop type checkbox is enabled
- If a trigger is synchronised to the module, check that it has activated
- Buildings with fewer positions than Min Units Per Building will be skipped
- Groups spawn one every 3 seconds - large garrisons take time to fully populate
