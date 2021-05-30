# Reinforcements System

## Overview

The reinforcements system within this mod is designed to provide mission makers with a way of programatically creating reinforcements for specific areas, without the need for scripting. The key objective of this system is mission performance, and as such, all of the functionality is designed to be fully headless client compatible.

This is not designed to be a replacement for systems like LAMBS or Zeus Enhanced, but simply to compliment some of the already present functionality. In fact, this system utilises LAMBS Task Rush in order to make the reinforcing AI a little bit more aggressive.

The system will work with our without HCs, but I'd highly encourage the use of headless clients, as some of the functionality can be quite demanding.

## Settings & Debugging

All of the settings for this system can be found in the CBA settings menu under 'Reaper Crew - Reinforcements'.

![CBA Settings](https://imgur.com/hl7I5rh.png)

### Settings

| Setting Label | Purpose | Example |
|---------------|---------|---------|
| Reinforcement Units | This setting is an array of classnames that determines the units that a reinforcements team will be comprised of. These can be units of any side, but they will be automatically switched to the side defined in the 'Opposition Faction' settings upon creation. A key aspect here is to make sure that the vehicles you select in the next settings can hold all of the reinforcements group. | O_Soldier_SL_F, O_Soldier_F, O_Soldier_LAT_F, O_soldier_M_F, O_Soldier_TL_F, O_Soldier_AR_F, O_Soldier_A_F, O_medic_F |
| Transport Vehicles | The purpose of this settings is to allocate vehicles that can be used by the motorised reinforcements. Upon spawning a reinforcements group, a random vehicle from this list will be selected. | O_Truck_02_transport_F, O_Truck_02_covered_F |
| Transport Helicopters | Similar to the above, this list determines what transport helicopters are available for the reinforcements groups. A random vehicle will be selected from this list upon the creation of a reinforcements group | O_Heli_Light_02_unarmed_F, O_Heli_Transport_04_bench_F |

### Debugging

By default, the debug settings will be disabled as their output can be very verbose, especially if there are a lot of reinforcement modules, but you can utilise these settings to ensure that spawn points are being detected.

## Spawn Points

A key aspect of the reinforcements system is that it creates the AI at the point at which they are needed, so that we don't have extra AI hanging around on the map, putting additional stress on the server and a drain on FPS. With this in mind, we need to ensure that AI do not spawn in the sight of the players, since this can be a game-breaking experience for most. Each reinforcements module has an 'inner' and 'outer' zone to dermine whether or not it's an active spawn point. The outer zone is used to determine that the players are within an acceptable range from spawnpoint, so that we can avoid spawning AI on the other side of the map and making them travel a long distance for no reason. The inner zone on the other hand, checks that the players are beyond a certain distance from the spawnpoint, to avoid issues with AI spawning directly in front of them (or worse, on top of them).

For example, the infantry spawn point has a minimum distance of 500m and an outer distance of 2km. When visualised on a map it looks like this:

![Infantry Spawnpoint](https://imgur.com/qZjrcRS.png)

Spawnpoints should be placed out of sight from the players, in compounds and terrain features like defilades or the reverse slopes of hills. You can place as many spawn points as you'd like, and the reinforcements system will automatically take care of which points should be active.

### Spawnpoint Zones

| Spawnpoint Type     | Outer Zone | Inner Zone |
|---------------------|------------|------------|
| Infantry Spawnpoint | 2km        | 500m       |
| Vehicle Spawnpoint  | 4km        | 1km        |
| Aircraft Spawnpoint | 20km       | 5km        |

## Module Configuration

When you place a reinforcements module, you have the ability to define the area that it monitors. To prevent FPS drops, the module will only spawn new units once the number of AI within it's configured zone drops below a threshold defined within the module configuration. If, during the process of creating reinforcements, the number of AI exceeds the zone threshold, the module will stop spawning any more units until the number of units drops back below the acceptable level. You should aim to make the monitored zone as wide as possible, and in addition to this you should take into consideration the terrain object density. On maps dense with foliage and buildings, you'll want to set the threshold lower to reduce the number of concurrent AI. On more sparse maps on the other hand, you can be a little bit more liberal with the threshold since there are less objects on the map degrading performance.

## Reinforcement Modules

| Module Name | Description | Associated Spawnpoint | Notes |
|-------------|-------------|-----------------------|-------|
| Reinforcements (Infantry - Foot Mobile) | This module will spawn infantry groups who will then move on foot towards the enemy | Infantry Spawnpoint | These units will immediately execute the TaskRush function and therefore won't appear to have any waypoints. These reinforcements won't function correctly unless hostile units are within the rush radius. |
| Reinforcements (Infantry - Motorised) | This will spawn a group of infantry with an empty vehicle which they will use to move towards their dismount position | Vehicle Spawnpoint | Once the units have reached their dismount marker, they'll execute a TaskRush. The vehicle does not have it's own crew, it's crewed exclusively by the spawned group.
| Reinforcements (Infantry - Helicopter) | Used to create helicopter-mounted troops | Aircraft Spawnpoint | Due to the complexities of trying to make two independent units cooporate, once dismounted, the infantry squad will need to walk to a form up position before executing a task rush. It's advisable to make sure the module configuration drops these troops far from players, and preferably out of sight since the form up phase is visually unappealing. |