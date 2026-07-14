# Ambience System

## Overview

The Ambience System provides mission makers with ambient environmental effects that run automatically during gameplay. Currently, the system offers **Ambient CAS** (Close Air Support) - a module that generates recurring AI air strikes within a defined area, creating the impression of an active battlefield without requiring manual scripting.

Strikes are driven by `BIS_fnc_moduleCAS` and execute entirely on the server. The module supports proximity gating (only fire strikes when players are nearby), player avoidance (place strikes away from players for near-miss atmospherics), and configurable timing.

## Quick Start

1. Open Eden Editor and navigate to `Systems (F5) > Modules > Reaper Crew - Ambience`
2. Place an **Ambient CAS** module in the area you want strikes to occur
3. Resize the module's area to cover the desired strike zone (default is 500m x 500m)
4. Configure attributes as needed (aircraft class, strike type, timing, etc.)
5. Preview or play the mission - strikes begin automatically when players enter the area

---

## Ambient CAS Module

| Editor Name | Classname |
|-------------|-----------|
| Ambient CAS | `reaperCrew_moduleAmbientCAS` |

The Ambient CAS module creates a repeating loop of AI-controlled air strikes within its area. A trigger is created at the module's position matching its area size and shape. When any player enters the trigger, the strike loop activates. When all players leave, the loop stops.

### Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| Aircraft Classname | String | `"B_Plane_CAS_01_F"` | Classname of the aircraft used for CAS strikes. Any aircraft class valid for `BIS_fnc_moduleCAS` can be used. |
| Strike Type | Number | `1` | CAS type passed to `BIS_fnc_moduleCAS`. `0` = gun run, `1` = bomb run, `2` = rockets. |
| Strike Direction | Number | `0` | Direction of the attack run in degrees (0-360). |
| Proximity Check | Boolean | `true` | When enabled, strikes only execute when at least one player is within the proximity range. Saves performance when no one is nearby. |
| Proximity Range (m) | Number | `2000` | Players must be within this 2D distance of the module for strikes to fire. Only used when Proximity Check is enabled. |
| Avoid Players | Boolean | `false` | When enabled, the system attempts to place strikes away from player positions, creating near-miss atmospherics rather than direct hits. |
| Avoid Radius (m) | Number | `500` | Minimum 2D distance from any player for a strike position. Only used when Avoid Players is enabled. |
| Delay Min (s) | Number | `30` | Minimum seconds between strikes. |
| Delay Max (s) | Number | `180` | Maximum seconds between strikes. |

### Area Configuration

The module supports Eden's built-in area tools:

- **Resizable area** - drag the area handles in Eden to define the strike zone
- **Shape selection** - choose between rectangle and ellipse
- Default size is 500m x 500m

Strike positions are randomly selected within this area using `BIS_fnc_randomPosTrigger`.

### Behaviour

1. On mission start, the server reads module attributes and creates an activation trigger matching the module's area
2. When any player enters the trigger area, the strike loop activates
3. Each iteration:
   - If **Proximity Check** is enabled, the system verifies at least one player is within the proximity range. If not, the strike is skipped and the system waits for the next delay interval
   - A random position within the trigger area is selected
   - If **Avoid Players** is enabled, the system attempts up to 5 times to find a position that is at least **Avoid Radius** metres from all players. If no safe position is found after 5 attempts, the last generated position is used as a fallback
   - A temporary invisible laser target is created at the strike position with the configured aircraft class and strike type
   - `BIS_fnc_moduleCAS` is called to execute the strike
   - The laser target is cleaned up after 10 seconds
4. The system waits a random duration between **Delay Min** and **Delay Max** before the next strike
5. When all players leave the trigger area, the loop exits and logs deactivation

### Eden Setup - Step by Step

1. Press **F5** to open the Systems panel
2. Expand **Reaper Crew - Ambience**
3. Double-click **Ambient CAS** to place the module
4. Drag the area handles to cover your desired strike zone
5. Double-click the module to open attributes:
   - Set the **Aircraft Classname** to an appropriate aircraft for your scenario faction (e.g. `"O_Plane_CAS_01_F"` for OPFOR)
   - Choose a **Strike Type** - `0` for gun runs (strafing), `1` for bomb runs, `2` for rockets
   - Set the **Strike Direction** to match the expected approach direction
   - Enable **Proximity Check** if the strike zone is far from player spawn (recommended for performance)
   - Enable **Avoid Players** and set an appropriate **Avoid Radius** if you want atmospheric near-misses without killing players
   - Adjust **Delay Min/Max** to control intensity - shorter delays = heavier bombardment

### Usage Scenarios

**Battlefield ambience (safe for players):**
- Enable **Avoid Players** with a 500m+ radius
- Set a large strike area (1000m+)
- Use moderate delays (60-180s)
- Creates the sound and visual of an active warzone without endangering players

**Active CAS threat:**
- Disable **Avoid Players**
- Use a smaller, focused area around an objective
- Use shorter delays (30-60s)
- Players must move through the area under fire

**Background bombardment:**
- Enable **Proximity Check** with a large range
- Place the module in a distant area visible from player positions
- Use bomb runs (type `1`) for dramatic explosions

---

## Worked Example: Shattered Frontline Approach

The players' route to the objective crosses an active frontline. Friendly and enemy air trade strikes in the distance while the players move through, without ever being hit themselves.

**Eden setup:**

1. Place an **Ambient CAS** module over the contested valley the players will skirt, and resize its area to roughly 1200m x 800m:
   - Aircraft Classname: `"O_Plane_CAS_02_F"` (match the enemy faction)
   - Strike Type: `1` (bomb runs read best at a distance)
   - Strike Direction: set to the bearing the enemy air would realistically approach from
   - Avoid Players: ticked, Avoid Radius: `600`
   - Proximity Check: ticked, Proximity Range: `2500`
   - Delay Min / Max: `90` / `240`
2. Optionally place a second module further along the route with a friendly aircraft classname and the opposite strike direction, so both sides appear to be trading blows

**Result:** As the players close to within 2.5 km, bombs begin falling in the valley every couple of minutes, always at least 600 m from any player. The battlefield feels alive for the whole transit, and the loop goes quiet automatically once the players move on. Attribute values not listed are left at their defaults.

---

## Code Examples

### Scripted Activation

The module is designed for Eden placement, but the underlying functions can be called from script if needed:

```sqf
// Create a logic and manually call the init function
private _logic = "reaperCrew_moduleAmbientCAS" createVehicle [5000, 5000, 0];
_logic setVariable ["aircraftClass", "O_Plane_CAS_01_F"];
_logic setVariable ["strikeType", 0];
_logic setVariable ["strikeDir", 90];
_logic setVariable ["avoidPlayers", true];
_logic setVariable ["avoidRadius", 300];
_logic setVariable ["delayMin", 45];
_logic setVariable ["delayMax", 120];
_logic setVariable ["objectarea", [800, 800, 0, false, -1]];
[_logic] call reapercrew_ambience_fnc_initAmbientCAS;
```

---

## Important Notes

- **Server only** - all strike logic runs on the server. The module exits immediately on clients.
- **BIS_fnc_moduleCAS** - strikes are executed via the vanilla CAS module function. The aircraft class must be compatible with this function. Most vanilla and modded fixed-wing aircraft work; helicopters may not produce expected results.
- **Trigger-based activation** - the module creates a real trigger in the mission. The strike loop runs only while the trigger is active (players inside the area). When players leave, strikes stop. When players re-enter, strikes resume.
- **Performance** - enable **Proximity Check** for modules placed in areas players may not visit immediately. This prevents unnecessary strike calculations when no one is nearby.
- **Avoid Players fallback** - the avoidance system makes at most 5 attempts to find a safe position. In small areas with many players, it may not be possible to avoid everyone. A log message is written to RPT when fallback is used.
- **Laser target cleanup** - each strike creates a temporary `LaserTargetCBase` object that is deleted after 10 seconds. In extreme cases with very short delays, multiple targets may exist simultaneously.

---

## Troubleshooting

### No Strikes Occurring

- **Check module area** - ensure the area is large enough and correctly positioned. Strikes are placed randomly within the area; a very small area may cause issues.
- **Check proximity** - if Proximity Check is enabled, verify players are within the configured proximity range.
- **Check player presence** - strikes only fire while players are inside the trigger area. Verify the trigger area covers the region where players are located.
- **Check RPT logs** - the system logs activation, deactivation, and each strike to RPT via `reapercrew_common_fnc_remoteLog`. Look for "Ambient CAS active" and "Executing air strike" messages.

### Strikes Hitting Players When Avoid Players Is Enabled

- **Increase avoid radius** - the default 500m may not be enough for fast-moving players. Consider 750m or more.
- **Increase area size** - if the strike area is small relative to the avoid radius, there may not be enough room to place strikes away from players. The system falls back after 5 failed attempts.
- **Check player spread** - if players are spread across the entire area, avoidance becomes impossible. Consider increasing the area or reducing player count in the zone.

### Aircraft Not Appearing

- **Verify classname** - ensure the aircraft classname is valid and the mod providing it is loaded. An invalid classname will cause `BIS_fnc_moduleCAS` to fail silently.
- **Check strike type** - not all aircraft support all strike types. Test with the vanilla `B_Plane_CAS_01_F` first to confirm the module works.

### Performance Issues

- Enable **Proximity Check** to prevent strikes when no players are nearby.
- Increase **Delay Min/Max** to reduce strike frequency.
- Avoid placing many Ambient CAS modules in overlapping areas.
