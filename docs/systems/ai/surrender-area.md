# Surrender Area Module

| Editor Name | Classname |
|-------------|-----------|
| Surrender Area | `reaperCrew_moduleSurrenderArea` |

Part of the [AI Mechanics System](ai-mechanics.md). Found in Eden under `Systems (F5) > Modules > Reaper Crew - AI Mechanics`.

## Overview

The Surrender Area module causes synchronised AI units to surrender via ACE captives when players enter the module's area. Units surrender one at a time with configurable stagger timing, and can optionally drop weapons and eject from vehicles.

## Quick Start

1. Place the **Surrender Area** module in Eden Editor
2. Place AI units you want to surrender
3. Synchronise the AI units to the module
4. Resize the trigger area as needed
5. Preview or start the mission - when players enter the area, the synced units surrender

## Attributes

| Attribute | Property | Type | Default | Description |
|-----------|----------|------|---------|-------------|
| Activation Code | `reaperCrew_moduleSurrenderArea_activationCode` | String | `"true"` | Additional condition for trigger activation |
| Surrender Delay | `reaperCrew_moduleSurrenderArea_surrenderDelay` | Number | 5 | Seconds to wait after trigger activation before first surrender |
| Surrender Stagger | `reaperCrew_moduleSurrenderArea_surrenderStagger` | Number | 1 | Seconds between each unit surrendering |
| Drop Weapons | `reaperCrew_moduleSurrenderArea_dropWeapons` | Checkbox | false | Units drop their primary weapon when surrendering |
| Eject From Vehicles | `reaperCrew_moduleSurrenderArea_ejectFromVehicles` | Checkbox | true | Units in vehicles are ejected before surrendering |

## How It Works

1. Module initialises on server and retrieves all synchronised units
2. Creates a trigger matching the module's area
3. Trigger activates when any player on foot is present and the activation condition is met
4. After the surrender delay, each synced unit is processed in order:
   - Dead units and non-infantry objects are skipped
   - Units already surrendering are skipped
   - If in a vehicle and eject is enabled, the unit is ejected (with a 15-second timeout)
   - AI movement, autocombat, and FSM are disabled; behaviour set to CARELESS
   - Primary weapon is removed if drop weapons is enabled
   - ACE surrender is triggered via CBA target event for correct locality
   - Stagger delay is applied before processing the next unit
5. Surrender is one-shot and does not repeat

## Worked Example: Broken Garrison After the Assault

Once the players have fought through a village and broken its defence, the remaining rear echelon personnel give up rather than fight.

**Eden setup:**

1. Place a handful of AI units (cooks, drivers, wounded stragglers) in the rear compound of the village
2. Place a **Surrender Area** module over the rear compound and synchronise those units to it:
   - Activation Code: `villageDefenceBroken`
   - Surrender Delay: `3`
   - Surrender Stagger: `2` (a cascading effect, one man giving up after another)
   - Drop Weapons: ticked
3. In a trigger counting the main defence force, set On Activation: `villageDefenceBroken = true;` when the defenders are dead (for example condition `{alive _x} count units defenceGroup < 3`)

**Result:** While the main defence holds, the rear personnel behave normally. Once the defence collapses and players push into the rear compound, the stragglers throw down their weapons and surrender via ACE one after another. Players can then process them as captives.

## Tips

- Synchronise only infantry units - non-Man objects are automatically skipped
- Use the surrender delay to create a realistic hesitation before units give up
- Increase the stagger interval for a more natural cascading surrender effect
- Combine with an activation condition to script when surrender becomes possible (e.g. after a firefight)

## Troubleshooting

**Units not surrendering:**
- Verify ACE3 is loaded (uses ACE captives system)
- Check units are properly synchronised to the module
- Ensure the activation code returns true
- Verify players are inside the trigger area AND on foot
- Check that synced objects are infantry (Man class), not vehicles or modules

**Units stuck in vehicles:**
- Ensure "Eject From Vehicles" is enabled
- Ejection has a 15-second timeout; if it fails the unit is skipped with a log warning
