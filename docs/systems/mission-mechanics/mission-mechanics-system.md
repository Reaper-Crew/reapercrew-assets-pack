# Mission Mechanics System

## Overview

The Mission Mechanics System provides mission makers with reusable, zero-scripting modules for common objective patterns. Rather than writing bespoke SQF for every "hold action to complete objective" or "wait X seconds for a task to finish" scenario, these modules handle the full lifecycle - from player interaction to global variable broadcasting - through Eden attributes alone.

The system currently provides two modules:

- **Interaction Objective** - adds a hold action to synchronised objects that sets a global variable on completion
- **Timed Task** - waits for a start signal, runs a timer, and sets completion variables when finished

Both modules communicate via global variables (`missionNamespace setVariable` with `publicVariable`), making them easy to chain together and integrate with triggers, tasks, and other framework systems.

## Quick Start

**Interaction Objective:**
1. Place an **Interaction Objective** module in Eden
2. Place the object(s) players will interact with (e.g. a laptop, radio, explosive charge)
3. Synchronise the object(s) to the module
4. Set the **Completion Variable** name and configure the action text/duration
5. Use the completion variable in triggers or scripts to advance the mission

**Timed Task:**
1. Place a **Timed Task** module in Eden
2. Set the **Start Variable**, **In-Progress Variable**, and **Completed Variable** names
3. Configure the duration and optional progress broadcasting
4. Set the start variable to `true` from a trigger, script, or another module's completion variable to begin the timer

---

## Interaction Objective Module

| Editor Name | Classname |
|-------------|-----------|
| Interaction Objective | `reaperCrew_moduleInteractionObjective` |

Adds a BIS hold action to all synchronised objects. When a player completes the hold action, a global variable is set to `true` and broadcast to all machines. This is the building block for objectives like "download intel", "plant explosives", "activate the radio", "search the body", etc.

### Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| Action Text | String | `"Interact"` | Text displayed to the player on the hold action prompt. |
| Duration (s) | Number | `5` | Time in seconds the player must hold the action to complete it. |
| Condition | String | `"true"` | SQF condition for showing the action. Available variables: `_target` (the object), `_this` (the player). Must return Boolean. |
| Completion Variable | String | *(empty)* | **Required.** Global variable name set to `true` and broadcast via `publicVariable` when the interaction completes. Must not clash with engine commands. |

### Behaviour

1. On mission start (server only), the module reads its attributes and validates:
   - At least one object must be synchronised to the module
   - The **Completion Variable** must not be empty
2. The completion variable is initialised to `false` on all machines via `missionNamespace setVariable [_var, false, true]`
3. A `BIS_fnc_holdActionAdd` call is `remoteExec`'d to all clients (including JIP) for each synchronised object:
   - The action uses the configured text, duration, and condition
   - An implicit proximity condition of 3m is applied (`_caller distance _target < 3`)
   - The action icon is `holdAction_connect_ca.paa` (the "connecting" icon)
4. When a player completes the hold action:
   - The completion variable is set to `true` on all machines
   - A log message is written to RPT with the variable name and player name
5. The hold action remains on the object after completion - if you need to remove it, use a condition that checks the completion variable (e.g. `!(missionNamespace getVariable ['myVar', false])`)

### Eden Setup - Step by Step

1. Place the object(s) players will interact with (e.g. `Land_Laptop_unfolded_F`, `Land_SatellitePhone_F`)
2. Press **F5** to open the Systems panel
3. Expand **Reaper Crew - Mission Mechanics**
4. Double-click **Interaction Objective** to place the module (position does not matter)
5. Select both the module and the target object(s), then press **F5** to synchronise them
6. Double-click the module to open attributes:
   - Set **Action Text** to something descriptive (e.g. `"Download Intel"`, `"Plant Explosives"`)
   - Set **Duration** to the desired hold time
   - Set **Completion Variable** to a unique variable name (e.g. `"obj1_intelDownloaded"`)
   - Optionally set a **Condition** to control when the action appears (e.g. `"_this getVariable ['hasKeycard', false]"`)

### Chaining with Triggers

Create a trigger with the condition:
```sqf
obj1_intelDownloaded
```

The trigger activates when the player completes the interaction, allowing you to chain objectives, spawn reinforcements, display notifications, etc.

### Chaining with Timed Task

A common pattern is: player interacts with an object to start a timed process (e.g. downloading data). Set the Interaction Objective's **Completion Variable** to the same value as the Timed Task's **Start Variable**:

- Interaction Objective → Completion Variable: `"obj1_downloadStarted"`
- Timed Task → Start Variable: `"obj1_downloadStarted"`

When the player completes the hold action, the timed task begins automatically.

### Removing the Action After Completion

The hold action persists after completion. To hide it once used, set the **Condition** to check the completion variable:

```
!(missionNamespace getVariable ['obj1_intelDownloaded', false])
```

This hides the action from all players once any player completes it.

---

## Timed Task Module

| Editor Name | Classname |
|-------------|-----------|
| Timed Task | `reaperCrew_moduleTimedTask` |

Implements a server-side timer that waits for a start signal, runs for a configured duration, and sets variables at each stage. Optionally broadcasts progress percentages to all players via side chat. Useful for "defend this position for 5 minutes", "wait for the download to complete", "hold the area until extraction arrives", etc.

### Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| Start Variable | String | *(empty)* | **Required.** Global variable name that triggers the timer when set to `true`. The module polls for this variable every second. |
| In-Progress Variable | String | *(empty)* | **Required.** Global variable name set to `true` while the timer is running, and `false` when done. |
| Completed Variable | String | *(empty)* | **Required.** Global variable name set to `true` when the timer finishes. Must not clash with engine commands (e.g. use `"obj1_completed"` not `"taskCompleted"`). |
| Duration (s) | Number | `300` | How long the task runs for in seconds. |
| Broadcast Progress | Boolean | `true` | When enabled, announces progress percentage to all players via `systemChat` every 60 seconds. |
| Broadcast Message | String | `"Task progress"` | Prefix for the progress message. The format is: `"<message>: <percent>% complete"` (e.g. `"Download progress: 45% complete"`). |

### Behaviour

1. On mission start (server only), the module reads its attributes and validates:
   - All three variable names (start, in-progress, completed) must be non-empty
2. **In-Progress** and **Completed** variables are initialised to `false` on all machines
3. The **Start Variable** is NOT initialised - it must be created externally (e.g. by a trigger, interaction objective, or script)
4. The module polls every second, waiting for the start variable to exist and be `true`
5. When the start variable becomes `true`:
   - The in-progress variable is set to `true` on all machines
   - If broadcasting is enabled, `"<message>: Started"` is sent to all players via `systemChat`
   - A progress reporter thread starts, broadcasting percentage every 60 seconds
   - The main thread waits for the full duration to elapse (using `CBA_missionTime`)
6. When the duration completes:
   - The in-progress variable is set to `false` on all machines (this also terminates the progress reporter)
   - The completed variable is set to `true` on all machines
   - If broadcasting is enabled, `"<message>: Complete"` is sent to all players

### Variable Lifecycle

```
Time 0:     inProgress = false, completed = false    (initialised by module)
            start variable does not exist yet

Time X:     startVariable = true                      (set externally)
            inProgress = true                         (set by module)

Time X+60:  "Download progress: 20% complete"         (broadcast)
Time X+120: "Download progress: 40% complete"         (broadcast)
...

Time X+300: inProgress = false, completed = true      (set by module)
            "Download progress: Complete"              (broadcast)
```

### Eden Setup - Step by Step

1. Press **F5** to open the Systems panel
2. Expand **Reaper Crew - Mission Mechanics**
3. Double-click **Timed Task** to place the module (position does not matter)
4. Double-click the module to open attributes:
   - Set **Start Variable** to the variable that will trigger the timer (e.g. `"obj1_downloadStarted"`)
   - Set **In-Progress Variable** to a unique name (e.g. `"obj1_downloadInProgress"`)
   - Set **Completed Variable** to a unique name (e.g. `"obj1_downloadCompleted"`)
   - Set **Duration** to the desired time in seconds
   - Enable or disable **Broadcast Progress** as desired
   - Set **Broadcast Message** to a descriptive prefix (e.g. `"Download progress"`)

### Eden Setup - Chained Example (Interaction + Timed Task)

A complete "download intel from a laptop" objective:

1. Place a laptop object (`Land_Laptop_unfolded_F`)
2. Place an **Interaction Objective** module:
   - Action Text: `"Begin Download"`
   - Duration: `3`
   - Completion Variable: `"obj1_downloadStarted"`
3. Synchronise the laptop to the Interaction Objective module
4. Place a **Timed Task** module:
   - Start Variable: `"obj1_downloadStarted"`
   - In-Progress Variable: `"obj1_downloadInProgress"`
   - Completed Variable: `"obj1_downloadCompleted"`
   - Duration: `300`
   - Broadcast Message: `"Download progress"`
5. Create a trigger:
   - Condition: `obj1_downloadCompleted`
   - On Activation: your mission logic (e.g. `["obj1"] call BIS_fnc_taskSetState ["SUCCEEDED"];`)

Result: Player holds action on laptop for 3 seconds, a 5-minute timer starts with progress updates, and the trigger fires when complete.

### Eden Setup - Defend Until Extraction

A "hold the area" objective using the Timed Task on its own:

1. Place a **Timed Task** module:
   - Start Variable: `"lz_secured"`
   - In-Progress Variable: `"extraction_inbound"`
   - Completed Variable: `"extraction_arrived"`
   - Duration: `600`
   - Broadcast Message: `"Extraction ETA"`
2. Create a trigger over the landing zone (Anybody Present, your player side):
   - On Activation: `lz_secured = true; publicVariable "lz_secured";`
3. Create a second trigger:
   - Condition: `extraction_arrived`
   - On Activation: spawn or unhide the extraction helicopter and update the task
4. Use `extraction_inbound` to drive pressure while the timer runs, for example as the Additional Condition on a [reinforcement module](../reinforcements/reinforcements-system.md) so enemy waves only flow while the players are holding the LZ

Result: When players reach the LZ the ten minute countdown starts with ETA updates every minute, enemy pressure builds while it runs, and the extraction arrives when the timer completes.

---

## Code Examples

### Starting a Timed Task from Script

If you need to trigger the timer from SQF rather than from an Interaction Objective:

```sqf
// Start the timer by setting the start variable
missionNamespace setVariable ["obj1_downloadStarted", true, true];
```

### Checking Task State in Script

```sqf
// Check if the task is currently running
if (missionNamespace getVariable ["obj1_downloadInProgress", false]) then {
    hint "Download in progress...";
};

// Check if the task has completed
if (missionNamespace getVariable ["obj1_downloadCompleted", false]) then {
    hint "Download complete!";
};
```

### Using Interaction Objective Condition

Show the action only when the player has a specific item:

```
"'ACE_key_master' in (items _this)"
```

Show the action only when no enemies are within 50m of the object:

```
"({side _x == east} count (_target nearEntities ['Man', 50])) == 0"
```

### Multiple Objects, One Objective

Synchronise multiple objects to a single Interaction Objective module. Any one of the objects can be interacted with to complete the objective - useful for "search any of these crates" scenarios.

```
Module ──sync──> Laptop_1
       ──sync──> Laptop_2
       ──sync──> Laptop_3
```

Any player completing the hold action on any of the three laptops sets the completion variable to `true`.

---

## Important Notes

- **Server only** - both modules run their logic exclusively on the server. Hold actions are added to clients via `remoteExec` with JIP.
- **Variable naming** - completion and state variable names **must not clash with engine commands or BIS functions**. For example, do not use `"taskCompleted"` or `"isPlayer"` as variable names. Use prefixed names like `"obj1_completed"` or `"mission_hackDone"`.
- **Variable scope** - all variables are set in `missionNamespace` with global broadcast (`publicVariable`). They are accessible from any machine at any time after being set.
- **Start variable ownership** - the Timed Task module does not create or initialise the start variable. It must be set externally. This is by design, allowing the start signal to come from any source (interaction objective, trigger, script, Zeus, etc.).
- **One-shot completion** - the Interaction Objective sets the variable to `true` once. There is no built-in mechanism to reset it. If you need a repeatable interaction, manage the variable reset in your own script.
- **Progress timing** - the Timed Task uses `CBA_missionTime` for elapsed time calculation, which pauses when the mission is paused. Progress broadcasts occur every 60 seconds regardless of task duration.
- **Hold action proximity** - the Interaction Objective enforces a 3m proximity check on the hold action's progress condition. Players must remain within 3m of the object for the entire hold duration.

---

## Troubleshooting

### Interaction Objective

#### Hold Action Not Appearing

- **Check synchronisation** - the module must be synchronised to at least one object. An error is logged to RPT if no objects are synchronised.
- **Check completion variable** - the variable name must not be empty. An error is logged to RPT if it is missing.
- **Check condition** - if you set a custom condition, verify it returns `true`. Test with the default (`"true"`) first.
- **Check distance** - the player must be within 3m of the object for the hold action to appear.
- **Check RPT** - look for `"Interaction Objective initialised"` to confirm the module started correctly.

#### Variable Not Being Set

- **Check RPT** - look for `"Interaction objective complete"` messages. If present, the variable is being set.
- **Check variable name** - ensure the variable name in your trigger/script matches exactly (case-sensitive) what is configured in the module.
- **Check for clashes** - if the variable name matches an engine command, `missionNamespace setVariable` may behave unexpectedly.

### Timed Task

#### Timer Not Starting

- **Check start variable** - the start variable must be set to `true` on the server. If it is set only locally, the server will not detect it.
- **Check variable names** - all three variable names (start, in-progress, completed) must be non-empty. An error is logged to RPT if any are missing.
- **Check RPT** - look for `"Timed Task initialised"` to confirm the module loaded, and `"Timed Task started"` to confirm the timer began.

#### Progress Not Broadcasting

- **Check Broadcast Progress** - ensure the checkbox is enabled in the module attributes.
- **Check duration vs interval** - progress broadcasts every 60 seconds. If the task duration is less than 60 seconds, only the "Started" and "Complete" messages will appear.

#### Timer Completing Instantly

- **Check duration** - ensure the Duration attribute is set to a positive number in seconds, not minutes.

### General

#### Variables Not Accessible on Clients

- Both modules use `missionNamespace setVariable [_var, _value, true]` which broadcasts via `publicVariable`. If a client cannot read the variable, check for JIP timing - the variable is set once and broadcast; JIP clients joining after the broadcast receive the current value because `missionNamespace` variables with `publicVariable` persist for JIP.
