# Mission Maker Quick Reference

A condensed guide for rapidly setting up Reaper Crew Assets Pack systems.

---

## CBA Settings Checklist

Before starting, configure these in `Options > Addon Options`:

### Reaper Crew - AI Common
- [ ] Set Opposition Faction (EAST/WEST/INDEPENDENT)
- [ ] Configure unit pools (Regular, Elite, Special Forces)
- [ ] Set skill levels for each troop type
- [ ] Configure transport vehicles (ground, helicopter, boat)
- [ ] Configure fire support vehicles (armour, technicals, aircraft)

### Reaper Crew - AI Reinforcements
- [ ] Debug settings as needed for testing

### Reaper Crew - Logistics
- [ ] Configure crate contents (classnames for your mod setup)
- [ ] Set deliverable vehicles list
- [ ] Set permitted groups for vehicle delivery

**Important:** Save all settings in the **Mission** tab!

---

## Common Module Setups

### Dynamic AI Defence

**Goal:** Enemies reinforce an area as players approach.

1. Place **Infantry Spawnpoint** modules at spawn locations (2km from objective)
2. Place **Infantry - Foot Mobile** module at objective
3. (Optional) Synchronize spawnpoints to module for dedicated sources
4. Configure: Reinforcement Count, Zone Ceiling, Troop Types

### Motorised Reinforcements

**Goal:** Enemies arrive in vehicles from distant spawn points.

1. Place **Vehicle Spawnpoint** modules at spawn locations (5km from objective)
2. Place **Infantry - Motorised** module at objective
3. Configure dismount distance/direction
4. (Optional) Place **Path Waypoint** modules for specific routes

### Air Assault Defence

**Goal:** Helicopter-delivered reinforcements.

1. Place **Aircraft Spawnpoint** modules at airfield/FOB (25km range)
2. Place **Infantry - Airborne** module at objective
3. Configure landing distance/direction
4. (Optional) Place **Path Waypoint** modules for flight paths

### Amphibious Landing

**Goal:** Boat-delivered reinforcements.

1. Place **Marine Spawnpoint** at water spawn location
2. Place **Marine LZ** modules at beach landing points
3. Synchronize Marine LZ modules → Marine Spawnpoint
4. Place **Infantry - Marine** module at objective

### Persistent Vehicle Threat

**Goal:** Continuous armour pressure on an area.

1. Place **Vehicle Spawnpoint** modules
2. Place **Marauding Vehicles** module in threat area
3. Configure vehicle count and types (Heavy/Light Armour, Technicals)
4. Configure spawn frequency (min/max seconds)

### Building Garrison

**Goal:** AI defending buildings.

1. Place **Garrison Area** module
2. Resize area to cover target buildings
3. Configure Max Units, troop types, and per-building min/max limits
4. (Optional) Set an activation condition to defer spawning
5. (Optional) Add code on spawn for custom behaviour

### Ambush Setup (Suppress Position)

**Goal:** Static weapons suppress players entering an area.

1. Place static weapons with AI gunners
2. Place **Suppress Position** module
3. Synchronize gunners → module
4. Resize trigger area as needed

### Surrender Scenario

**Goal:** AI surrender when players enter an area.

1. Place AI units at the surrender location
2. Place **Surrender Area** module
3. Synchronise AI units to the module
4. Resize the trigger area as needed
5. (Optional) Set an activation condition to control when surrender becomes possible

### Ambient CAS

**Goal:** Background air strikes for atmosphere.

1. Place **Ambient CAS** module in the mission area
2. Configure aircraft type and strike parameters
3. Set player proximity gating and strike frequency

### Interaction Objective

**Goal:** Hold-action objective on a synced object.

1. Place the target object in Eden
2. Place **Interaction Objective** module
3. Synchronise the object to the module
4. Configure the completion variable name

### Timed Task

**Goal:** Configurable countdown timer with status variables.

1. Place **Timed Task** module
2. Configure timer duration and variable names
3. (Optional) Enable progress broadcasts via side chat

### Convoy Scenario

**Goal:** AI convoy that responds to contact.

1. Place vehicles with crews on road
2. Place **Convoy** module
3. Synchronize vehicles → module (order = convoy order)
4. Set activation condition variable
5. Configure speed, separation, contact behaviour

---

## Logistics Quick Setup

### Resupply Point

1. Place cargo container (any object)
2. Place **Resupply Point** module
3. Synchronize module → object
4. Configure crate contents in CBA Settings

### Vehicle Delivery

1. Place **Vehicle Spawnpoint** modules
2. Configure deliverable vehicles in CBA Settings
3. Configure permitted groups
4. Players request via ACE Self-Interact > Equipment

### Mobile Respawn

1. Place vehicle (truck, APC, etc.)
2. Place **Respawn Vehicle** module
3. Synchronize vehicle → module
4. Enable supply refresh if desired

---

## Key Module Classnames

| System | Module | Classname |
|--------|--------|-----------|
| Reinforcements | Infantry Spawnpoint | `reaperCrew_moduleInfantrySpawn` |
| Reinforcements | Vehicle Spawnpoint | `reaperCrew_moduleVehicleSpawn` |
| Reinforcements | Aircraft Spawnpoint | `reaperCrew_moduleAircraftSpawn` |
| Reinforcements | Marine Spawnpoint | `reaperCrew_moduleMarineSpawn` |
| Reinforcements | Marine LZ | `reaperCrew_moduleMarineLZ` |
| Reinforcements | Path Waypoint | `reaperCrew_modulePathWaypoint` |
| Reinforcements | Infantry Foot | `reaperCrew_moduleReinforcementsHeadlessInfantry` |
| Reinforcements | Infantry Motor | `reaperCrew_moduleReinforcementsHeadlessInfantryMotorised` |
| Reinforcements | Infantry Airborne | `reaperCrew_moduleReinforcementsHeadlessInfantryHelicopter` |
| Reinforcements | Infantry Marine | `reaperCrew_moduleReinforcementsHeadlessInfantryMarine` |
| Reinforcements | Marauding Vehicles | `reaperCrew_moduleReinforcementsHeadlessMaraudingVehicles` |
| Reinforcements | Marauding Aircraft | `reaperCrew_moduleReinforcementsHeadlessMaraudingAircrafts` |
| AI Mechanics | Garrison Area | `reaperCrew_moduleGarrison` |
| AI Mechanics | Suppress Position | `reaperCrew_moduleSuppressPosition` |
| AI Mechanics | Convoy | `reaperCrew_moduleAwesomeConvoy` |
| AI Mechanics | Unlimited Ammo | `reaperCrew_moduleUnlimitedAmmo` |
| AI Mechanics | Surrender Area | `reaperCrew_moduleSurrenderArea` |
| Ambience | Ambient CAS | `reaperCrew_moduleAmbientCAS` |
| Mission Mechanics | Interaction Objective | `reaperCrew_moduleInteractionObjective` |
| Mission Mechanics | Timed Task | `reaperCrew_moduleTimedTask` |
| Logistics | Resupply Point | `reaperCrew_moduleResupplyPoint` |
| Logistics | Vehicle Spawnpoint | `reaperCrew_moduleResupplyVehicleSpawnpoint` |
| Logistics | Respawn Vehicle | `reaperCrew_moduleRespawnVehicle` |
| Player | Disarm All | `reaperCrew_moduleDisarmPlayers` |
| Player | Save Loadout | `reaperCrew_moduleSavePlayerLoadout` |
| Player | Fix Fatigue | `reaperCrew_moduleFixFatigue` |

---

## Activation Distances

| Spawnpoint Type | Activation Distance |
|-----------------|---------------------|
| Infantry | 2 km |
| Vehicle | 5 km |
| Marine | 7.5 km |
| Aircraft | 25 km |

---

## Default Values Reference

### Reinforcements
- Reinforcement Count: 50
- Zone Ceiling: 80
- Zone Ratio: 3 (AI per player, in Ratio mode)
- Wave Delay: 60 seconds
- Spawnpoint Cooldown: Wave Delay + 2 seconds

### Convoy
- Max Speed: 40 km/h
- Separation: 35 meters

---

## Troubleshooting Quick Checks

### Units Not Spawning
1. Check CBA faction setting matches unit classnames
2. Verify spawnpoint is within activation distance
3. Confirm zone ceiling not exceeded (the count includes all humanoids in the zone - players and civilians too - plus the module's own reinforcements still inbound)
4. Check pause settings are OFF
5. Verify spawnpoint conditions are met

### Convoy Not Moving
1. Check activation condition returns true
2. Verify vehicles have crews assigned
3. Ensure vehicles are synchronized to module

### Vehicle Delivery Fails
1. Verify group is in permitted list
2. Check Vehicle Spawnpoint modules exist
3. Confirm vehicle classnames are valid

---

## Code Snippets

### Pause Reinforcements Mid-Mission
```sqf
reaperCrew_pauseInfantryReinforcements = true;  // Pause
reaperCrew_pauseInfantryReinforcements = false; // Resume
```

### Check Active Spawnpoints
```sqf
diag_log format ["Infantry: %1", activeInfantryTriggers];
diag_log format ["Vehicle: %1", activeVehicleTriggers];
```

### Custom Spawn Code (codeOnSpawn)
```sqf
// Skill is set automatically from CBA settings, but can be overridden:
_thisGroup allowFleeing 0;
```

### Trigger-Based Condition
```sqf
triggerActivated myTrigger
```

### Variable-Based Condition
```sqf
myMissionVariable
```

---

## Mission Type Workflows

### Assault Mission
1. Set up Garrison modules at objective
2. Configure Reinforcements with Infantry + Motorised
3. Place Resupply Point at player start
4. (Optional) Add Marauding Vehicles for flanking threat

### Defence Mission
1. Place player defensive positions
2. Configure Infantry Foot Mobile reinforcements
3. Add Marauding Vehicles/Aircraft for pressure
4. Set up Suppress Position at key approaches

### Convoy Ambush
1. Set up Convoy module with vehicles
2. Place player ambush positions
3. Configure activation trigger
4. Add Reinforcements to respond to contact

### Supply Operation
1. Place Resupply Point at main base
2. Configure Vehicle Delivery for logistics
3. Set up Respawn Vehicle as mobile FOB
4. Add light enemy presence with Marauding modules

---

## Documentation Links

- [AI Common](systems/ai/ai-common.md) - Faction and unit pool configuration
- [AI Mechanics](systems/ai/ai-mechanics.md) - Garrison, Suppress, Convoy, Unlimited Ammo, Surrender Area
- [Ambience](systems/ambience/ambience-system.md) - Ambient CAS strikes
- [Mission Mechanics](systems/mission-mechanics/mission-mechanics-system.md) - Interaction Objectives, Timed Tasks
- [Reinforcements](systems/reinforcements/reinforcements-system.md) - Dynamic AI spawning
- [Logistics](systems/logistics/logistics-system.md) - Resupply and delivery
- [Player Management](systems/player/player-management.md) - Loadouts and ACRE
