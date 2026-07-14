# Spawnpoint Modules

Spawnpoints determine where reinforcement units can spawn. Every reinforcement and marauding module needs at least one compatible spawnpoint to function. All spawnpoints are found in Eden Editor under: `Systems (F5) > Modules > Reaper Crew - Reinforcements`

Part of the [Reinforcements System](reinforcements-system.md).

## Spawnpoint Types

| Module | Classname | Default Outer Zone | Default Inner Zone | Best Used For |
|--------|-----------|--------------------|--------------------|---------------|
| Infantry Spawnpoint | `reaperCrew_moduleInfantrySpawn` | 2km | 1km | [Foot mobile infantry](foot-mobile.md) |
| Vehicle Spawnpoint | `reaperCrew_moduleVehicleSpawn` | 5km | 2.5km | [Motorised infantry](motorised.md), [marauding vehicles](marauding.md) |
| Aircraft Spawnpoint | `reaperCrew_moduleAircraftSpawn` | 25km | 12.5km | [Airborne infantry](helicopter.md), [marauding aircraft](marauding.md) |
| Marine Spawnpoint | `reaperCrew_moduleMarineSpawn` | 7.5km | 3.75km | [Marine/amphibious infantry](marine.md) |

## Spawnpoint Zones

Each spawnpoint has two concentric zones:

- **Outer zone** - the activation radius. Players within it can trigger reinforcements. The outer zone is taken from the module's drawn area, so you can resize and reshape it in Eden; the values above are the default sizes used when the area is left untouched.
- **Inner zone** - an exclusion radius around the spawnpoint. The spawnpoint will not activate while a player is inside it, so AI never spawn on top of players.

## Activation Conditions

A spawnpoint becomes active when ALL conditions are met:

1. **Player proximity** - At least one player is within the outer zone
2. **Inner zone clear** - No player is inside the inner exclusion zone
3. **Line of sight** - Players cannot directly see the spawnpoint location
4. **Ground contact** - At least one player is touching the ground (not in aircraft)
5. **Not captured** - The spawnpoint has not been captured (see Capturable below)
6. **Additional condition** - Any custom condition specified returns true

## Capturable Spawnpoints

If the **Capturable** attribute is ticked, the spawnpoint is permanently disabled the first time a player reaches its inner zone. This is a one-way latch and lets you place spawnpoints inside objective areas so that taking the objective shuts off its reinforcements. The captured state is published to the `reaperCrew_spawnpointCaptured` variable on the module logic for mission scripting. Capturable is off by default.

## Attributes

All four spawnpoint types share the same attributes:

| Attribute | Property | Type | Default | Description |
|-----------|----------|------|---------|-------------|
| Additional Condition | `additionalCondition` | String | `"true"` | Custom SQF condition appended to the activation check |
| Inner Zone | `innerZone` | Number | 1000 | Inner exclusion radius (metres); the spawnpoint is disabled while a player is within it |
| Capturable | `capturable` | Checkbox | false | If ticked, the spawnpoint is permanently disabled once a player reaches the inner zone |
| Debug Markers | `debugMarkers` | Checkbox | false | If ticked, draws map markers for the centre, inner zone and outer zone of the spawnpoint |

> **Note:** The outer zone is set by resizing the module's area in Eden, not via an attribute. Vehicle, aircraft and marine spawnpoints default their inner zone to half the outer zone; the Inner Zone attribute lets you override it per spawnpoint.

## Placement Tips

- **Hide infantry spawnpoints inside large buildings.** Warehouses, hangars and large houses are ideal: they let you place reinforcements within an objective area while keeping the spawn location out of player view. Watching units appear out of thin air is game breaking, and the line of sight activation check only prevents spawning while a player can see the spawnpoint, so a concealed location keeps the flow of reinforcements moving even with players nearby
- Keep vehicle and aircraft spawnpoints behind terrain features (ridges, treelines) or well outside the expected engagement range
- Tick Debug Markers while testing to confirm the zones sit where you expect, and untick before the live mission

## Modes of Operation

There are two ways spawnpoints can be linked to reinforcement modules:

**Automatic Mode (Unsynchronized)**
- Leave spawnpoints unsynchronized from reinforcement modules
- The reinforcement module will automatically use the nearest active compatible spawnpoint
- Example: Foot Mobile module uses the nearest active Infantry Spawnpoint

**Manual Mode (Synchronized)**
- Synchronize specific spawnpoints to a reinforcement module
- The module will only use those specific synchronized spawnpoints
- Spawnpoints must still be active (meet activation conditions) to be usable
- Useful for controlling exact spawn locations per objective

**Important:** In both modes, spawnpoint activation conditions still apply. A synchronized spawnpoint that isn't active (players too far, line of sight blocked, custom condition false) will not be used.

## Supporting Modules

### Path Waypoint

**Path Waypoint** (`reaperCrew_modulePathWaypoint`)
- Used when you want vehicle-based reinforcements to follow a specific waypoint path to their destination
- Commonly used to navigate difficult terrain in a specific way
- Synchronize to spawnpoints in traversal order

### Marine LZ

**Marine LZ** (`reaperCrew_moduleMarineLZ`)
- Defines landing zones for marine reinforcements
- Required for marine spawnpoints to function
- Can be linked to multiple spawnpoints - all linked spawnpoints will be able to use that LZ
- Doesn't have to be 1:1

## Custom Pathing

### Path Waypoint Setup

1. Place Path Waypoint modules along desired route
2. Select all waypoints and the spawnpoint
3. Synchronize waypoints to spawnpoint in order (first synced = first waypoint)
4. The last waypoint becomes the final destination

**Important:** Synchronization order determines traversal order.

### Position Drift

A random drift of up to 50m is applied to final positions to prevent:
- Multiple vehicles/helicopters landing at exact same location
- Collisions and explosions
- "Arma space program" incidents

## Worked Example: Capturable Objective Spawnpoint

Players must capture a communications compound. The compound feeds itself reinforcements until it is taken.

**Eden setup:**

1. Place an **Infantry Spawnpoint** just behind the compound, out of sight of the main approach:
   - Capturable: ticked
   - Inner Zone: `200` (small enough that only entering the compound itself captures it)
   - Debug Markers: ticked while testing, unticked for the live mission
2. Resize the outer zone to around 1.5 km so the spawnpoint activates as players approach
3. Place a [Foot Mobile](foot-mobile.md) reinforcement module over the compound and synchronise the spawnpoint to it

**Result:** Reinforcements flow from behind the compound while players fight towards it. The moment a player pushes through to the spawnpoint's inner zone, the spawnpoint is captured and permanently stops. You can detect this in a trigger with:

```sqf
myspawnpointLogic getVariable ["reaperCrew_spawnpointCaptured", false]
```

(name the module logic `myspawnpointLogic` via its Variable Name field in Eden).

## Troubleshooting

**Spawnpoint never activates:**
- Tick Debug Markers to see the zones on the map and confirm players are inside the outer zone but outside the inner zone
- Check the spawnpoint isn't visible to any player (line of sight blocks activation)
- Check any Additional Condition returns true
- If Capturable is ticked, check it hasn't already been captured

**AI spawn too close to players:**
- Increase the Inner Zone radius
- Remember the inner zone default is half the outer zone for vehicle, aircraft and marine spawnpoints, but a fixed 1 km for infantry spawnpoints
