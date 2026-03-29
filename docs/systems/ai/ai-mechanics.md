# AI Mechanics System

## Overview

The AI Mechanics system provides four specialised modules for creating dynamic AI behaviours in your missions:

- **Garrison Area** - Automatically populate buildings with AI units
- **Suppress Position** - Create coordinated suppressive fire positions
- **Convoy** - Create vehicle convoys that respond to contact for compelling scenarios
- **Unlimited Ammo** - Give synchronised vehicles infinite ammunition

## Modules

All modules are found in Eden Editor under: `Systems (F5) > Modules > Reaper Crew - AI`

---

## Garrison Area Module

| Editor Name | Classname |
|-------------|-----------|
| Garrison Area | `reaperCrew_moduleGarrison` |

### Overview

The Garrison Area module automatically spawns AI units and places them in nearby buildings. Units are distributed across buildings with one group per building, and skill levels are automatically applied based on the troop type selected (configured via CBA settings in AI Common).

### Quick Start

1. Place the **Garrison Area** module in Eden Editor
2. Resize the module's area to cover the buildings you want garrisoned
3. Configure the troop types and maximum unit count
4. (Optional) Set an activation condition to defer spawning until needed
5. Preview or start the mission

### Attributes

| Attribute | Property | Type | Default | Description |
|-----------|----------|------|---------|-------------|
| Activation Condition | `activationCondition` | String | `"true"` | Condition that must be true before units are spawned |
| Max Units | `MaxUnits` | Number | 50 | Maximum number of AI to spawn in the area |
| Regular Troops | `regularTroops` | Checkbox | true | Include regular troops from unit pool |
| Elite Troops | `eliteTroops` | Checkbox | false | Include elite troops from unit pool |
| Special Forces | `specialTroops` | Checkbox | false | Include special forces from unit pool |
| Min Units Per Building | `minUnitsPerBuilding` | Number | 4 | Buildings with fewer valid positions are skipped |
| Max Units Per Building | `maxUnitsPerBuilding` | Number | 10 | Caps the number of units placed in any single building |
| Min Position Distance | `minPositionDistance` | Number | 3 | Minimum distance (metres) between positions within a building |
| Code on Spawn | `codeOnSpawn` | String | `"true"` | Custom SQF code executed when each building group spawns |

### Area Configuration

- Default area: 5m x 5m
- Use the area tool to resize and reshape the garrison zone
- Buildings within the area will be considered for occupation

### How It Works

1. Module initialises on server and waits for activation condition
2. Finds all buildings in the configured area using LAMBS
3. Filters buildings with valid interior positions (ceiling check)
4. Groups positions by building
5. Filters positions within each building by minimum distance to prevent clustering
6. Applies per-building min/max limits (skips buildings below minimum, caps at maximum)
7. Respects the global max unit count across all buildings
8. Spawns one group per building, distributed across headless clients
9. Each unit is assigned a random stance (UP/MIDDLE) with pathfinding disabled
10. Skill is automatically set based on the troop type (Regular/Elite/SF) from CBA settings

### Code Examples

**Deferred Spawning:**
```sqf
// In the "Activation Condition" field:
garrisonActive

// Then in a trigger or script:
garrisonActive = true;
```

**Add Custom Equipment:**
```sqf
{
    _x addItem "ACE_CableTie";
    _x addMagazine "SmokeShell";
} forEach (units _thisGroup);
```

### Tips

- Place module centre in areas with dense buildings
- Keep Max Units reasonable (40-60) for performance
- Units use dynamic simulation for performance optimisation
- Each building spawns as a separate group, distributed across headless clients
- Use the activation condition to defer spawning and reduce mission startup load
- Garrison units will not trigger other dynamically simulated units to activate - only players can
- Skill levels are inherited from the CBA AI Common settings for each troop type

### Troubleshooting

**Units not spawning:**
- Verify buildings exist in the module area
- Check that selected troop pools have valid classnames
- Ensure at least one troop type checkbox is enabled
- Check the activation condition is returning true
- Buildings with fewer positions than Min Units Per Building will be skipped

---

## Suppress Position Module

| Editor Name | Classname |
|-------------|-----------|
| Suppress Area | `reaperCrew_moduleSuppressPosition` |

### Overview

The Suppress Position module creates a trigger area where synchronized gunners will provide suppressive fire on players who enter the zone.

### Quick Start

1. Place the **Suppress Area** module in Eden Editor
2. Place one or more static weapons or vehicles with gunners
3. Synchronize the gunners to the module (drag sync line)
4. Resize the trigger area as needed
5. Configure activation conditions if required

### Attributes

| Attribute | Property | Type | Default | Description |
|-----------|----------|------|---------|-------------|
| Activation Code | `ActivationCode` | String | `"true"` | Additional condition for trigger activation |

### Area Configuration

- Default area: 25m x 25m (with 20m height)
- Trigger activates when any player is present AND touching ground
- Gunners fire at random players within the trigger area

### How It Works

1. Module creates a trigger at its position
2. Synchronized objects (gunners) are stored
3. When players enter: trigger activates after 10-second delay
4. Each gunner targets random players in the zone
5. Uses ZEN's `zen_ai_fnc_suppressiveFire` for realistic suppression
6. Gunners continue firing while trigger is active

### Synchronization

**Important:** You must synchronize gunner units to the module:
1. Place static weapons (e.g., HMGs, GMGs) with AI crew
2. Select the static weapon or gunner unit
3. Hold Alt and drag to the module to create sync line
4. Multiple gunners can be synchronized to one module

### Custom Activation Conditions

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

### Tips

- Position gunners with good line of sight to the trigger area
- Use multiple gunners for overlapping fields of fire
- The 10-second delay helps prevent instant engagement
- Gunners will re-target every 1-10 seconds randomly

### Troubleshooting

**Gunners not firing:**
- Verify ZEN Enhanced is loaded
- Check gunners are properly synchronized to module
- Ensure activation code returns true
- Verify players are inside the trigger area AND on ground

---

## Convoy Module

| Editor Name | Classname |
|-------------|-----------|
| Convoy | `reaperCrew_moduleAwesomeConvoy` |

### Overview

The Convoy module creates a convoy system where vehicles maintain proper spacing and respond to contact. Vehicles will dismount crew when engaged and execute a task rush after contact.

### Quick Start

1. Place the **Convoy** module in Eden Editor
2. Place vehicles with crews (driver + passengers)
3. Synchronize vehicles to the module in order (first = lead vehicle)
4. Configure convoy behaviour and activation condition
5. Create a variable trigger or set activation code

### Attributes

| Attribute | Property | Type | Default | Description |
|-----------|----------|------|---------|-------------|
| Max Speed | `reaperCrew_moduleAwesomeConvoy_maxSpeed` | Number | 40 | Maximum convoy speed (km/h) |
| Convoy Separation | `reaperCrew_moduleAwesomeConvoy_convSeparation` | Number | 35 | Distance between vehicles (meters) |
| Stiffness Coefficient | `reaperCrew_moduleAwesomeConvoy_stiffnessCoeff` | Number | 0.2 | Lead vehicle braking for separation |
| Damping Coefficient | `reaperCrew_moduleAwesomeConvoy_dampingCoeff` | Number | 0.6 | Braking to minimize relative speed |
| Curvature Coefficient | `reaperCrew_moduleAwesomeConvoy_curvatureCoeff` | Number | 0.3 | Lead vehicle braking on curves |
| Link Stiffness | `reaperCrew_moduleAwesomeConvoy_stiffnessLinkCoeff` | Number | 0.1 | Follower acceleration/braking |
| Path Update Frequency | `reaperCrew_moduleAwesomeConvoy_pathFrequecy` | Number | 0.05 | How often path updates (seconds) |
| Speed Control Frequency | `reaperCrew_moduleAwesomeConvoy_speedFrequecy` | Number | 0.2 | How often speed adjusts (seconds) |
| Speed Mode | `reaperCrew_moduleAwesomeConvoy_speedMode` | Combo | NORMAL | Speed restriction mode |
| Behaviour | `reaperCrew_moduleAwesomeConvoy_behaviourConv` | Combo | pushThroughContact | Contact response behaviour |
| Debug Visualization | `reaperCrew_moduleAwesomeConvoy_debug` | Checkbox | false | Show path visualization |
| Activation Code | `ActivationCode` | String | `activateConvoy == true;` | Condition to start convoy |
| Contact Code | `ContactCode` | String | `"true"` | Code executed on contact |

### Speed Modes

- **UNCHANGED** - No speed restrictions
- **LIMITED** - Restricted speed
- **NORMAL** - Standard convoy speed
- **FULL** - Maximum configured speed

### Behaviour Modes

- **AWARE** - Standard aware behaviour
- **pushThroughContact** - Attempt to push through when engaged

### How It Works

**Setup Phase:**
1. Vehicles and crews have simulation disabled initially
2. Hit event handlers are added to detect contact
3. Convoy waits for activation condition

**Activation Phase:**
1. Simulation enabled on vehicles and drivers
2. Convoy begins movement along route

**Contact Phase:**
1. When hit (damage > 0.25 from enemy), contact is triggered
2. All vehicles stop (fuel depleted)
3. Non-gunner crew dismount and move to cover
4. Gunners remain in vehicles

**Post-Contact Phase:**
1. Custom contact code executes
2. After 2 minutes, all groups execute LAMBS task rush
3. After 30 minutes, vehicles added to garbage collection

### Code Examples

**Simple Activation Variable:**
```sqf
// In init.sqf or trigger:
activateConvoy = true;
```

**Custom Contact Response:**
```sqf
// In the "Contact Code" field:
hint "Convoy under attack!";
["ConvoyAmbushed", []] call CBA_fnc_globalEvent;
```

**Trigger-Based Activation:**
```sqf
// In the "Activation Code" field:
triggerActivated convoyStartTrigger
```

### Setting Up a Convoy Ambush Scenario

1. Place convoy vehicles along a road
2. Place and configure the Convoy module
3. Sync vehicles to module (order matters - first synced = lead)
4. Set activation to a variable: `convoyStart`
5. Place a trigger near ambush point that sets: `convoyStart = true;`
6. Configure contact code for mission-specific responses

### Tips

- Sync vehicles in convoy order (lead vehicle first)
- Give the travel waypoint to just the lead vehicle and nothing else
- Place vehicles on roads with clear paths
- Dismounted infantry should be in separate groups from the vehicle crews
- Gunners stay in vehicles to provide fire support
- Infantry dismounts will rush ambushing players after 30 seconds to simulate the enemy retaking the initiative
- Adjust separation based on vehicle size (trucks need more space) - vehicles too close together can have unintended effects

### Troubleshooting

**Convoy not starting:**
- Check activation condition syntax
- Verify the activation variable is being set
- Ensure vehicles have crews assigned
- Give the convoy a decent lead time - AI can misbehave and take a while to get into position

**Vehicles not following properly:**
- Move problematic vehicles ahead using Zeus
- **NEVER** remote control convoy units - changing locality breaks the script entirely

**Vehicles colliding:**
- Increase convoy separation value
- Reduce max speed for tight roads

**Crew not dismounting:**
- Contact detection requires damage > 0.25
- Enemy must be the damage source
- Gunners intentionally stay mounted

---

## Unlimited Ammo Module

| Editor Name | Classname |
|-------------|-----------|
| Unlimited Ammo | `reaperCrew_moduleUnlimitedAmmo` |

### Overview

The Unlimited Ammo module gives synchronised vehicles infinite ammunition. Ammo is replenished instantly after each shot via a Fired event handler.

### Quick Start

1. Place the **Unlimited Ammo** module in Eden Editor
2. Place the vehicle(s) you want to have unlimited ammo
3. Synchronise the vehicle(s) to the module
4. Preview or start the mission

### How It Works

1. Module initialises on server
2. Iterates all synchronised vehicles
3. Adds a `Fired` event handler to each vehicle on all machines (JIP-safe)
4. The event handler resets vehicle ammo to full after every shot
5. Handles locality transfers automatically - the EH fires wherever the vehicle is local

### Tips

- Sync any vehicle type - works with static weapons, armour, aircraft, etc.
- Multiple vehicles can be synced to a single module
- The EH persists through locality changes (e.g. headless client transfers)

### Troubleshooting

**Vehicle runs out of ammo:**
- Verify the vehicle is synchronised to the module (check sync line in Eden)
- Ensure the vehicle is not a `Man` unit - only vehicles are processed
