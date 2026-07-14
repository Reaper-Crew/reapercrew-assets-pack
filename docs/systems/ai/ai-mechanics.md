# AI Mechanics System

## Overview

The AI Mechanics system provides six specialised modules for creating dynamic AI behaviours in your missions. All modules are found in Eden Editor under: `Systems (F5) > Modules > Reaper Crew - AI Mechanics`

## Module Pages

| Module | Page | Purpose |
|--------|------|---------|
| Garrison Area | [garrison.md](garrison.md) | Automatically populate buildings with AI units |
| Patrol Area | [patrol.md](patrol.md) | Spawn patrolling groups that roam a defined area |
| Suppress Area | [suppress-position.md](suppress-position.md) | Create coordinated suppressive fire positions |
| Convoy | [convoy.md](convoy.md) | Create vehicle convoys that respond to contact |
| Unlimited Ammo | [unlimited-ammo.md](unlimited-ammo.md) | Give synchronised vehicles infinite ammunition |
| Surrender Area | [surrender-area.md](surrender-area.md) | Force synchronised AI to surrender via ACE when players enter an area |

## Shared Concepts

### Troop Pools and Skill

The Garrison and Patrol modules draw their units from the troop pools (Regular, Elite, Special Forces) configured in the [AI Common](ai-common.md) CBA settings. Skill levels are applied automatically per troop type from the same settings. Each module selects pools via its troop type checkboxes.

### Dynamic Simulation

Units spawned by the Garrison and Patrol modules use dynamic simulation for performance: groups sleep until a player comes near. Spawned units will not trigger other dynamically simulated units to activate - only players can, so a garrison waking up never chain-activates the rest of the map.

### Headless Client Distribution

Spawning work is distributed across headless clients where available (one dispatch per group), with dispatches staggered one every 3 seconds so a mid-mission activation doesn't spawn every group in one frame and cause jitter.

### Deferred Spawning

The Garrison and Patrol modules support deferred spawning: synchronise a trigger to the module and nothing spawns until the trigger activates. Any trigger condition works - area presence, a scripted variable, task states. Without a synchronised trigger, units spawn at mission start.

### Code on Spawn

Modules with a Code on Spawn attribute execute the given SQF for each spawned group, with the group available as `_thisGroup`:

```sqf
{
    _x addItem "ACE_CableTie";
} forEach (units _thisGroup);
```

### Group Cleanup

Spawned groups are marked for engine auto-deletion once every member is dead, so empty groups never accumulate towards the per-side group limit.

## Dependencies

- **CBA_A3** - settings framework
- **ACE3** - captives (Surrender Area)
- **LAMBS Danger** - building search (Garrison), patrols (Patrol), task rush (Convoy)
- **ZEN Enhanced** - suppressive fire (Suppress Area)
