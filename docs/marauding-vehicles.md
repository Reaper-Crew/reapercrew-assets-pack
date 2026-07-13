# Marauding System

## Overview

This system is used to provide a persistent flow of vehicle contact into an objective area. Use of this module will help to ensure that fire support platforms like CAS and MBTs always have plenty of contact, without detracting from the role of the infantry. As with the reinforcements system, it's designed to be fully HC compatible.

## Settings & Logging

### Settings

All of the settings for this system can be found in the CBA Settings menu under 'Reaper Crew - Reinforcements'.

![CBA Settings](https://imgur.com/eRP3r3B.png)

### Logging

The marauding modules write their diagnostic output (spawn activity, remaining vehicle/aircraft counts and spawnpoint availability) to the server log automatically. There are no debug toggles to enable.

### Live Pausing

The system supports the pausing of the reinforcements system mid-mission. You can do this via the CBA settings menu under the 'Live Mission Settings' section:

![CBA Settings](https://imgur.com/tR4uMHs.png)

This setting can be toggle repeatedly during the mission as required.

## Spawn Points

Both of the marauding modules utilise the spawnpoint modules that are part of the [Reinforcements System](systems/reinforcements/reinforcements-system.md).

The 'Marauding Vehicles' module utilises the 'Vehicle Spawnpoint' module.

The 'Marauding Aircraft' module utilises the 'Aircraft Spawnpoint' module.

All spawnpoint behaviour (outer activation zone, inner exclusion zone, the Capturable option and Debug Markers) applies to the marauding modules exactly as it does to the reinforcement modules - see the [Spawnpoint Modules](systems/reinforcements/reinforcements-system.md#spawnpoint-modules) section for details.

## Quick Start

When you place the 'Marauding Vehicles' module you'll be able to configure and area for the logic to cover. This will form the basis for our 'active zone'. The module will create a trigger in the place of the logic area, and wait until the players are present within this zone before continuing.

Once players have been detected in the zone, vehicles will begin spawning and making their way to the location with a 'Seek and Destroy' waypoint. The waypoint is placed on the position of the player nearest to the chosen spawnpoint, so vehicles head for the actual fight rather than just the centre of the module.

Vehicle crews are marked for engine auto-deletion once every member is dead, so empty groups never accumulate towards the per-side group limit.

### Module Configuration

#### Ground Vehicles

* **Vehicle Count** - This will determine the total number of vehicles that will be spawned by this module
* **Vehicle Frequency Min (seconds)** - This is the minimum amount of seconds between vehicles spawning.
* **Vehicle Frequency Max (seconds)** - This is the maximum amount of seconds between vehicles spawning.
* **Heavy Armour** - Include the 'Heavy Armour' units that have been defined in the settings
* **Light Armour** - Include the 'Light Armour' units that have been defined in the settings
* **Technicals** - Include the 'Technicals' that have been defined in the settings
* **Additional Condition** - A custom SQF condition appended to the activation check. While it returns false the module stops spawning, even with players still in the area - useful for stopping the module from script without requiring players to leave the zone.

### Aircraft

* **Aircraft Count** - This will determine the total number of Aircrafts that will be spawned by this module
* **Aircraft Frequency Min (seconds)** - This is the minimum amount of seconds between Aircrafts spawning.
* **Aircraft Frequency Max (seconds)** - This is the maximum amount of seconds between Aircrafts spawning.
* **Fixed Wing (Bombers)** - Include the bomber aircraft that have been defined in the settings
* **Fixed Wing (Fighters)** - Include the fighter aircraft that have been defined in the settings
* **Rotary CAS (Heavy)** - Include the attack helicopters that have been defined in the settings
* **Rotary CAS (Light)** - Include the light helicopters that have been defined in the settings
* **Additional Condition** - A custom SQF condition appended to the activation check. While it returns false the module stops spawning, even with players still in the area - useful for stopping the module from script without requiring players to leave the zone.