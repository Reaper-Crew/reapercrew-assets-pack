# Convoy Module

| Editor Name | Classname |
|-------------|-----------|
| Convoy | `reaperCrew_moduleAwesomeConvoy` |

Part of the [AI Mechanics System](ai-mechanics.md). Found in Eden under `Systems (F5) > Modules > Reaper Crew - AI Mechanics`.

## Overview

The Convoy module creates a convoy system where vehicles maintain proper spacing and respond to contact. Vehicles will dismount crew when engaged and execute a task rush after contact.

## Quick Start

1. Place the **Convoy** module in Eden Editor
2. Place vehicles with crews (driver + passengers)
3. Synchronize vehicles to the module in order (first = lead vehicle)
4. Configure convoy behaviour and activation condition
5. Create a variable trigger or set activation code

## Attributes

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

## Speed Modes

- **UNCHANGED** - No speed restrictions
- **LIMITED** - Restricted speed
- **NORMAL** - Standard convoy speed
- **FULL** - Maximum configured speed

## Behaviour Modes

- **AWARE** - Standard aware behaviour
- **pushThroughContact** - Attempt to push through when engaged

## How It Works

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

## Code Examples

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

## Worked Example: Convoy Ambush Scenario

1. Place convoy vehicles along a road
2. Place and configure the Convoy module
3. Sync vehicles to module (order matters - first synced = lead)
4. Set activation to a variable: `convoyStart`
5. Place a trigger near ambush point that sets: `convoyStart = true;`
6. Configure contact code for mission-specific responses

## Tips

- Sync vehicles in convoy order (lead vehicle first)
- Give the travel waypoint to just the lead vehicle and nothing else
- Place vehicles on roads with clear paths
- Dismounted infantry should be in separate groups from the vehicle crews
- Gunners stay in vehicles to provide fire support
- Infantry dismounts will rush ambushing players after 30 seconds to simulate the enemy retaking the initiative
- Adjust separation based on vehicle size (trucks need more space) - vehicles too close together can have unintended effects

## Troubleshooting

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
