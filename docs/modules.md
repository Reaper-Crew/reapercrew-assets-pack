# Modules

Index of all Eden modules in the pack, grouped by editor category. See the linked system docs for full attribute references.

## Reaper Crew - AI Mechanics

[System documentation](systems/ai/ai-mechanics.md)

| Module | Classname | Purpose |
|--------|-----------|---------|
| Garrison Area | `reaperCrew_moduleGarrison` | Spawns AI defending buildings within the module area |
| Patrol Area | `reaperCrew_modulePatrol` | Spawns variable-sized groups patrolling the module area |
| Suppress Area | `reaperCrew_moduleSuppressPosition` | Synced static gunners suppress players entering the area |
| Convoy | `reaperCrew_moduleAwesomeConvoy` | AI convoy from synced vehicles with contact behaviour |
| Unlimited Ammo | `reaperCrew_moduleUnlimitedAmmo` | Gives synced vehicles infinite ammunition |
| Surrender Area | `reaperCrew_moduleSurrenderArea` | Synced AI surrender via ACE captives when players enter |

## Reaper Crew - Reinforcements

[System documentation](systems/reinforcements/reinforcements-system.md)

| Module | Classname | Purpose |
|--------|-----------|---------|
| Infantry Spawnpoint | `reaperCrew_moduleInfantrySpawn` | Foot mobile spawn location (2 km default zone) |
| Vehicle Spawnpoint | `reaperCrew_moduleVehicleSpawn` | Motorised/marauding vehicle spawn location (5 km default zone) |
| Aircraft Spawnpoint | `reaperCrew_moduleAircraftSpawn` | Helicopter/aircraft spawn location (25 km default zone) |
| Marine Spawnpoint | `reaperCrew_moduleMarineSpawn` | Boat spawn location (7.5 km default zone) |
| Marine LZ | `reaperCrew_moduleMarineLZ` | Beach landing point, synced to a Marine Spawnpoint |
| Path Waypoint | `reaperCrew_modulePathWaypoint` | Optional route waypoint for spawned vehicles/aircraft |
| Reinforcements (Infantry - Foot Mobile) | `reaperCrew_moduleReinforcementsHeadlessInfantry` | Foot mobile reinforcement waves |
| Reinforcements (Infantry - Motorised) | `reaperCrew_moduleReinforcementsHeadlessInfantryMotorised` | Vehicle-delivered reinforcement waves |
| Reinforcements (Infantry - Helicopter) | `reaperCrew_moduleReinforcementsHeadlessInfantryHelicopter` | Helicopter-delivered reinforcement waves (land/fastrope/random) |
| Reinforcements (Infantry - Marine) | `reaperCrew_moduleReinforcementsHeadlessInfantryMarine` | Boat-delivered reinforcement waves |
| Marauding Vehicles | `reaperCrew_moduleReinforcementsHeadlessMaraudingVehicles` | Persistent armour/technical pressure on an area |
| Marauding Aircraft | `reaperCrew_moduleReinforcementsHeadlessMaraudingAircrafts` | Persistent air pressure on an area |

All four spawnpoint types share the same attributes: Additional Condition, Inner Zone exclusion radius, Capturable (permanently disabled once a player reaches the inner zone) and Debug Markers. Marauding Vehicles and Aircraft also take an Additional Condition attribute.

## Reaper Crew - Ambience

[System documentation](systems/ambience/ambience-system.md)

| Module | Classname | Purpose |
|--------|-----------|---------|
| Ambient CAS | `reaperCrew_moduleAmbientCAS` | Background air strikes for atmosphere |

## Reaper Crew - Mission Mechanics

[System documentation](systems/mission-mechanics/mission-mechanics-system.md)

| Module | Classname | Purpose |
|--------|-----------|---------|
| Interaction Objective | `reaperCrew_moduleInteractionObjective` | Hold action on synced objects, publishes a completion variable |
| Timed Task | `reaperCrew_moduleTimedTask` | Configurable timer with start/in-progress/completed variables |

## Reaper Crew - Logistics

[System documentation](systems/logistics/logistics-system.md)

| Module | Classname | Purpose |
|--------|-----------|---------|
| Resupply Point | `reaperCrew_moduleResupplyPoint` | Crate requests at a synced object |
| Respawn Vehicle | `reaperCrew_moduleRespawnVehicle` | Marks a synced vehicle as a mobile respawn |
| Vehicle Resupply Spawn | `reaperCrew_moduleResupplyVehicleSpawnpoint` | Spawn location for delivered vehicles |

## Reaper Crew - Players

[System documentation](systems/player/player-management.md)

| Module | Classname | Purpose |
|--------|-----------|---------|
| Disarm all players | `reaperCrew_moduleDisarmPlayers` | Strips player loadouts at mission start |
| Save player loadout | `reaperCrew_moduleSavePlayerLoadout` | Saves player loadouts for respawn |
| Fix Fatigue | `reaperCrew_moduleFixFatigue` | Disables stamina/fatigue for players |

### Placeable Objects

| Object | Classname | Purpose |
|--------|-----------|---------|
| Loadout Laptop | `reaperCrew_loadoutLaptop` | Built-in Save Loadout and Self Heal ACE actions, no framework needed (Reaper Crew > Player) |
