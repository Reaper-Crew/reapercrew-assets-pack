# Marauding System

## Overview

This system is used to provide a persistent flow of vehicle contact into an objective area. Use of this module will help to ensure that fire support platforms like CAS and MBTs always have plenty of contact, without detracting from the role of the infantry. As with the reinforcements system, it's designed to be fully HC compatible.

## Settings & Debugging

### Settings

All of the settings for this system can be found in the CBA Settings menu under 'Reaper Crew - Reinforcements'.

![CBA Settings](https://imgur.com/eRP3r3B.png)

### Debugging

Youc an enable debugging for these modules by using the following option under 'Reaper Crew - Reinforcements':

![CBA Settings](https://imgur.com/3ScfrNf.png)

### Live Pausing

The system supports the pausing of the reinforcements system mid-mission. You can do this via the CBA settings menu under the 'Live Mission Settings' section:

![CBA Settings](https://imgur.com/tR4uMHs.png)

This setting can be toggle repeatedly during the mission as required.

## Spawn Points

Both of the marauding modules utlise the spawnpoint modules that are part of the [Reinforcements System](docs/reinforcements-system.md).

The 'Marauding Vehicles' module utilises the 'Vehicle Spawnpoint' module.

The 'Marauding Aircraft' module utilises the 'Aircraft Spawnpoint' module.

## Quick Start

When you place the 'Marauding Vehicles' module you'll be able to configure and area for the logic to cover. This will form the basis for our 'active zone'. The module will create a trigger in the place of the logic area, and wait until the players are present within this zone before continuing.

Once players have been detected in the zone, vehicles will begin spawning and making their way to the location with a 'Seek and Destroy' waypoint.

### Module Configuration

#### Ground Vehicles

* **Vehicle Count** - This will determine the total number of vehicles that will be spawned by this module
* **Vehicle Frequency Min (seconds)** - This is the minimum amount of seconds between vehicles spawning.
* **Vehicle Frequency Max (seconds)** - This is the maximum amount of seconds between vehicles spawning.
* **Vehicle Types** - This combo option determines what types of vehicles should be spawned by the module
  * **Random Mix** - *This will spawn a random vehicle from any of the configured groups.*
  * **Heavy Armour** - *The 'Heavy Armour' units that have been defined in the settings*
  * **Light Armour** - *The 'Light Armour' units that have been defined in the settings*
  * **Technicals** - *The 'Technicals' that have been defined in the settings*

### Aircraft

* **Aircraft Count** - This will determine the total number of Aircrafts that will be spawned by this module
* **Aircraft Frequency Min (seconds)** - This is the minimum amount of seconds between Aircrafts spawning.
* **Aircraft Frequency Max (seconds)** - This is the maximum amount of seconds between Aircrafts spawning.
* **Aircraft Types** - This combo option determines what types of Aircrafts should be spawned by the module
  * **Random Mix** - *This will spawn a random Aircraft from any of the configured groups.*
  * **Light Rotary** - *The 'Light Rotary' aircraft that have been defined in the settings*
  * **Heavy Rotary** - *The 'Heavy Rotary' aircraft that have been defined in the settings*
  * **Fixed Wing** - *The 'Fixed Wing' aircraft that have been defined in the settings*