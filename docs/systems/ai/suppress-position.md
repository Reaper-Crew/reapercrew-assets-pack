# Suppress Position Module

| Editor Name | Classname |
|-------------|-----------|
| Suppress Area | `reaperCrew_moduleSuppressPosition` |

Part of the [AI Mechanics System](ai-mechanics.md). Found in Eden under `Systems (F5) > Modules > Reaper Crew - AI Mechanics`.

## Overview

The Suppress Position module creates a trigger area where synchronized gunners will provide suppressive fire on players who enter the zone.

## Quick Start

1. Place the **Suppress Area** module in Eden Editor
2. Place one or more static weapons or vehicles with gunners
3. Synchronize the gunners to the module (drag sync line)
4. Resize the trigger area as needed
5. Configure activation conditions if required

## Attributes

| Attribute | Property | Type | Default | Description |
|-----------|----------|------|---------|-------------|
| Activation Code | `ActivationCode` | String | `"true"` | Additional condition for trigger activation |

## Area Configuration

- Default area: 25m x 25m (with 20m height)
- Trigger activates when any player is present AND touching ground
- Gunners fire at random players within the trigger area

## How It Works

1. Module creates a trigger at its position
2. Synchronized objects (gunners) are stored
3. When players enter: trigger activates after 10-second delay
4. Each gunner targets random players in the zone
5. Uses ZEN's `zen_ai_fnc_suppressiveFire` for realistic suppression
6. Gunners continue firing while trigger is active

## Synchronization

**Important:** You must synchronize gunner units to the module:
1. Place static weapons (e.g., HMGs, GMGs) with AI crew
2. Select the static weapon or gunner unit
3. Hold Alt and drag to the module to create sync line
4. Multiple gunners can be synchronized to one module

## Custom Activation Conditions

By default, the module activates when any player enters the trigger area AND is on the ground. The **Activation Code** attribute lets you add additional conditions that must also be true before gunners will fire.

**Examples:**

```sqf
// Only activate after a variable is set (e.g., by another trigger or script)
ambushTriggered

// Only activate after a task is complete
(taskState "task_1") == "SUCCEEDED"

// Only activate when another trigger is active
triggerActivated myCustomTrigger

// Default - always activate when players present
true
```

## Worked Example: Ambush Kill Zone on a Bridge

Players must cross a bridge on the mission route. Two machine gun positions on the far bank open up on anyone crossing, but only once the ambush has been sprung elsewhere.

**Eden setup:**

1. Place a **Suppress Area** module over the bridge and resize its area to cover the full span plus the near bank approach
2. Place two HMG static weapons with AI gunners on the far bank, 200 to 400 m away, each with clear line of sight to the bridge from a different angle
3. Synchronise both gunners to the module
4. Set Activation Code to: `bridgeAmbushSprung`
5. In the trigger or script that starts the ambush, set: `bridgeAmbushSprung = true;`

**Result:** The gunners hold fire until the ambush variable is set and a player is on the bridge area. From then on they lay sustained suppressive fire on random players in the zone, re-targeting every few seconds, while players are pinned in the kill zone. Pair with a [Foot Mobile reinforcement module](../reinforcements/foot-mobile.md) to close the trap.

## Tips

- Position gunners with good line of sight to the trigger area
- Use multiple gunners for overlapping fields of fire
- The 10-second delay helps prevent instant engagement
- Gunners will re-target every 1-10 seconds randomly
- Combine with the [Unlimited Ammo module](unlimited-ammo.md) so sustained fire never runs dry

## Troubleshooting

**Gunners not firing:**
- Verify ZEN Enhanced is loaded
- Check gunners are properly synchronized to module
- Ensure activation code returns true
- Verify players are inside the trigger area AND on ground
