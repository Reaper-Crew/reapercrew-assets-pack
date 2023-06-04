# Reinforcements System

## Overview

The objective of this system is to provide a way for mission makers to programatically create reinforcements (or the appearance of a more densely populated area), in a way that is performance (more specifically client FPS) friendly and does not require an scripting in order to make work. 

A key feature of this system is that it is fully headless client compatible, therefore it should be the preferred method for reinforcements, since it's able to make full use of available resources. That said - this system will function without HCs for the purpose of local testing. 

This is not designed to be a full replacement for LAMBS or Zeus Enhanced (and in fact it leverages the LAMBS Rush module quite heavily), but is deisnged to compliment some of the already present features.

## Settings

All of the settings for this system can be managed from the CBA settings menu.

### AI Common

![CBA Settings](/docs/systems/reinforcements/settings-common-preview.jpg)

The AI Common settings are primarily leveraged by the reinforcements sytems, but can be utilised either directly in scripts if required, or by some of the other miscellaneous systems such as the Garrison module.

Please note: the "opposition faction" is the side that the AI will be spawned as, and should be one that is hostile to the players.

![CBA Settings](/docs/systems/reinforcements/settings-reinforcements-preview.jpg)

The "AI reinforcements" settings focus specifically on the reinforcements system, and contains various debugging options, as well the the ability to toggle live misson settings (eg: to pause reinforcements in an ongoing mission).

## Spawnpoints

The spawnpoints determine where units relating to different types of reinforcements can spawn. For anything that utilises vehicles, spawnpoints should be placed in relatively clear areas, free from debris and obstructions (owing to ArmA AI's questionable pathfinding ability.). Infantry spawnpoints are far less constrained and can be placed in thick forrest or vegetation if required.

### Spawnpoint Activation

Spawnpoints are considered active when certain conditions are met:

* Players are inside of a maximum activation distance (differs per spawnpoint, outlined below).
* Players cannot directly see the spawnpoint (to hopefully stop any game-breaking AI spawning right in front of you)
* Any additional conditions specified have been achieved (more on this later)

#### Distances

| Spawnpoint Type     | Outer Zone |
|---------------------|------------|
| Infantry Spawnpoint | 2km        |
| Vehicle Spawnpoint  | 5km        |
| Marine Spawnpoint   | 7.5km        |
| Aircraft Spawnpoint | 25km       |

### Default behavior

#### Infantry

The behavior of foot mobile AI is very simple. They will spawn and then attempt to rush to the players position directly, so the following explanations of pathing behavior will not apply to them.

#### Ground vehicles & aircraft

When no custom path is specified, assets spawned will pick a random position between the minimum and maximum distances as specified in the relevent reinforcements module. The system will perform a basic check to see if it can find the best suitable landing spot in a given area, but will limit this search to the immediately vicinity in the interests of time and performance. 

For example, the system will prefer to attempt to land a helicopter in a clearing, rather than just into a cluster of tree if it can help it - However if a valid position cannot be determined, the system will just default to the specified position and the AI will make it's best effort to get there. 

#### Marine

Since the areas for landing boats must be a little bit more precisely defined, marine reinforcements can only be mapped to specific landing points using the "Marine LZ" module, and cannot automatically calcuate a landing position like the other modules can.

### Custom Conditions

In addition to the built-in behavior of spawnpoints, the modules allow you to specify a custom condition. This condition just uses the normal ArmA scripting syntax and could be used to, for example, check if a variable is set to true like so:

```townCaptured == true```

or to see if a trigger is activated:

```triggerActivated myTownTrigger```

The condition of each spawnpoint is assessed every 30 seconds, rather than the default 0.5 seconds, since the queries are relatively demanding.

### Custom Pathing

![CBA Settings](/docs/systems/reinforcements/custom-path.jpg)

If you'd like the AI to travel in a very specific path to the dismount position, then you can use the "Path Waypoint" module to achieve this. Simply place down the modules on the route to the dismount position and then syncronise them to the spawnpoint **in the order that you'd like them to be traversed in** (This bit is very important!). The last waypoint in the chain will be treated as the end position.

There will be a small drift on the final position (by up to 50m) to help mitigate a situation where multiple helicopters or vehicles attempt to place themselves into exactly the same position - resulting in either explosions, or a contribution to the ArmA space program.

### Cooldowns

Once used, a vehicle spawnpoint will be deactived as to stop multiple units spawning on the same position in rapid succession. The cooldown period will the "wave delay" + 2 seconds, at which point the spawnpoint will be marked as available for use again.

### Additional spawnpoint considerations

When placing spawnpoints as a mission maker, ensure that they are well out of the players view - in compounds and terrain features like defilades or the reverse slopes of hills - Since having AI spawn directly in view is generally considering a game-breaking experience.

## Reinforcement Modules

TBC

### Module Configuration

### Common Settings

<!-- | Attribute
|---
| Reinforcment Count
| Zone Threshold
| Unit types
| Enable Rush Mode
| Wave delay
| Additional Condition
| Code on Spawn -->

### Infantry - Foot Mobile

### Infantry - Motorised

### Infantry - Airbourne

### Infantry - Marine

<!-- | Module Name | Description | Associated Spawnpoint | Notes |
|-------------|-------------|-----------------------|-------|
| Reinforcements (Infantry - Foot Mobile) | This module will spawn infantry groups who will then move on foot towards the enemy | Infantry Spawnpoint | These units will immediately execute the TaskRush function and therefore won't appear to have any waypoints. These reinforcements won't function correctly unless hostile units are within the rush radius. |
| Reinforcements (Infantry - Motorised) | This will spawn a group of infantry with an empty vehicle which they will use to move towards their dismount position | Vehicle Spawnpoint | Once the units have reached their dismount marker, they'll execute a TaskRush. The vehicle does not have it's own crew, it's crewed exclusively by the spawned group.
| Reinforcements (Infantry - Airbourne) | Used to create helicopter-mounted troops | Aircraft Spawnpoint | Due to the complexities of trying to make two independent units cooporate, once dismounted, the infantry squad will need to walk to a form up position before executing a task rush. It's advisable to make sure the module configuration drops these troops far from players, and preferably out of sight since the form up phase is visually unappealing. |
| Reinforcements (Infantry - Marine) | Troops will spawn with an empty boat, once mounted they will make their way to one of the predefined Marine LZs and dismount. On dismount, infantry will perform a TaskRush with a maximum range of 2km | -->











