# Unlimited Ammo Module

| Editor Name | Classname |
|-------------|-----------|
| Unlimited Ammo | `reaperCrew_moduleUnlimitedAmmo` |

Part of the [AI Mechanics System](ai-mechanics.md). Found in Eden under `Systems (F5) > Modules > Reaper Crew - AI Mechanics`.

## Overview

The Unlimited Ammo module gives synchronised vehicles infinite ammunition. Ammo is replenished instantly after each shot via a Fired event handler.

## Quick Start

1. Place the **Unlimited Ammo** module in Eden Editor
2. Place the vehicle(s) you want to have unlimited ammo
3. Synchronise the vehicle(s) to the module
4. Preview or start the mission

## How It Works

1. Module initialises on server
2. Iterates all synchronised vehicles
3. Adds a `Fired` event handler to each vehicle on all machines (JIP-safe)
4. The event handler resets vehicle ammo to full after every shot
5. Handles locality transfers automatically - the EH fires wherever the vehicle is local

## Worked Example: Sustained Fire Ambush

An ambush position needs its static weapons to keep firing for the whole engagement without running dry.

**Eden setup:**

1. Place two HMG static weapons with AI gunners overlooking the kill zone
2. Place a [Suppress Area](suppress-position.md) module over the kill zone and synchronise both guns to it
3. Place an **Unlimited Ammo** module anywhere convenient and synchronise both guns to it as well

**Result:** The gunners suppress players in the kill zone indefinitely. Each shot is instantly replenished, so the guns never pause to reload beyond their normal firing rhythm and never run out mid-engagement.

## Tips

- Sync any vehicle type - works with static weapons, armour, aircraft, etc.
- Multiple vehicles can be synced to a single module

## Troubleshooting

**Vehicle runs out of ammo:**
- Verify the vehicle is synchronised to the module (check sync line in Eden)
- Ensure the vehicle is not a `Man` unit - only vehicles are processed
