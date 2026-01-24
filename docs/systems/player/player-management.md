# Player Management System

## Overview

The Player Management system contains a mixture of features. Some are modules that can be placed and used in a mission or Zeus, others are automatic functions that run at the start of every mission, during respawn, or when reloading.

## Modules

All modules are found in Eden Editor under: `Systems (F5) > Modules > Reaper Crew - Player Management`

### Disarm All Players

| Editor Name | Classname |
|-------------|-----------|
| Disarm All Players | `reaperCrew_moduleDisarmPlayers` |

Strips all equipment from players and assigns parade/ceremonial uniforms based on role.

**Behavior:**
1. Removes all weapons, items, uniform, vest, backpack, headgear, goggles
2. Assigns base uniform: `U_BG_Guerilla2_1`
3. Assigns headgear: `RC_Beret_01`
4. Links: Map, Compass, Watch, GPS
5. Applies role-specific uniform upgrades
6. Fully heals player via ACE medical

**Role-Based Uniforms:**

| Role | Uniform |
|------|---------|
| Platoon Commander | `U_I_ParadeUniform_01_AAF_decorated_F` |
| Platoon Sergeant | `U_I_ParadeUniform_01_AAF_decorated_F` |
| Section Commander | `U_I_ParadeUniform_01_AAF_F` |
| Section 2IC | `U_I_ParadeUniform_01_AAF_F` |
| Section 3IC | `U_I_ParadeUniform_01_AAF_F` |
| All Others | `U_BG_Guerilla2_1` |

**Usage:** Place module and activate in Zeus/trigger. Executes on all players.

---

### Save Player Loadout

| Editor Name | Classname |
|-------------|-----------|
| Save Player Loadout | `reaperCrew_moduleSavePlayerLoadout` |

Captures and stores player loadouts for later restoration.

**Behavior:**
1. Uses ACRE API to filter loadout (excludes ACRE radios)
2. Stores loadout in player variable: `Saved_Loadout`
3. Also triggers insignia setup

**Usage:** Typically activated at mission start or after loadout selection phase.

**Restoring Loadout:**
```sqf
_savedLoadout = player getVariable ["Saved_Loadout", []];
if (count _savedLoadout > 0) then {
    player setUnitLoadout _savedLoadout;
};
```

---

### Fix Fatigue

| Editor Name | Classname |
|-------------|-----------|
| Fix Fatigue | `reaperCrew_moduleFixFatigue` |

Used to fix bugs that sometimes occur with player fatigue not being properly reset.

**Behavior:**
- Executes `player setFatigue 0` on all players

**Usage:** Place module and activate when needed.

---

## Automatic Systems

These systems run automatically when the addon loads (postInit):

### ACRE Radio Configuration

Automatically configures ACRE radio preset channels on mission start.

**Global Channel Names (PRC148, PRC152, PRC117F):**

| Channel | Name |
|---------|------|
| 1 | Command Net |
| 2 | Logistics Net |
| 3 | Fire Control Net |
| 4 | Operations Room |

**Personal Radio (PRC343) Channel Assignment:**

Group-based automatic channel selection:

| Group ID | Channel |
|----------|---------|
| Zero | 12 |
| Reaper-1-1 | 1 |
| Reaper-1-2 | 2 |
| Reaper-1-3 | 3 |
| Thunder | 4 |
| Hammer | 5 |
| Fury, Fury-1, Fury-2 | 6 |
| Foxhound-1, Foxhound-2, Foxhound-3 | 7 |
| Shadow | 8 |
| Viper | 9 |
| Phantom | 10 |
| Ugly-1, Ugly-2 | 11 |
| Sentinel | 13 |

**Multi-PTT Configuration:**

The system automatically configures Push-To-Talk based on available radios:

| Radio Setup | Multi-PTT Assignment |
|-------------|---------------------|
| Team radio only | [Personal, Team] |
| Team + Long-range | [Personal, Team, Long-range] |
| Long-range only (pilots) | [Personal, Long-range] |

---

### Unit Insignia System

Automatically applies unit insignia based on player's group and role.

**Insignia Classname Construction:**
```
reaperCrew_[GroupName]_[RoleDescription]
```

**Process:**
1. Extract role description and group ID
2. Clean invalid characters (replace `-` with `_`, remove spaces)
3. Build classname
4. Check if exists in config
5. Fallback to `reaperCrew_default_insignia` if not found

**Rank Assignment:**
Certain roles automatically receive COLONEL rank:
- Platoon Commander
- Section Commander
- Vehicle Commander
- Battery Commander

**Clan Texture:**
All players receive clan insignia:
```
rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\ReaperCrewLogoPatch.paa
```

---

### ACE Actions

Automatically adds ACE self-actions on mission start.

**Group Info Action:**
- Location: ACE_SelfActions
- Name: "Group Info"
- Function: Displays group composition hint

---

## Group Information Display

### Viewing Group Info

1. ACE Self-Interact
2. Select "Group Info"
3. Hint displays all player groups with:
   - Group name (uppercase header)
   - Each player with role and weight
   - Leader indicator

### Display Format

```
REAPER-1-1
[Leader Icon] PlayerName     (32kg) [Rifleman]
              Player2        (45kg) [Medic]
              Player3        (38kg) [AT Specialist]

REAPER-1-2
[Leader Icon] Player4        (30kg) [Section Commander]
...
```

### Weight Color Coding

Player weight is color-coded to indicate load status:

| Weight | Color | Hex Code |
|--------|-------|----------|
| ≤ 30 kg | Green | #00FF00 |
| 31-35 kg | Orange | #FFA500 |
| 36-40 kg | Dark Orange | #FF5500 |
| 41-45 kg | Red | #FF2E2E |
| > 45 kg | Hot Pink | #FF69B4 |

---

## Code Examples

### Get Player Role

```sqf
// Get the role from player's role description
_roleDesc = roleDescription player;
_role = [player] call reapercrew_player_groups_fnc_getUnitRole;
hint format ["Your role: %1", _role];
```

### Get Player Weight

```sqf
// Get numeric weight using ACE
_weight = [player] call reapercrew_player_groups_fnc_getWeight;
hint format ["Your load: %1 kg", _weight];
```

### Force Insignia Update

```sqf
// Manually trigger insignia setup
[] call reapercrew_player_management_fnc_setUnitInsigniaLocal;
```

### Custom ACRE Channel

```sqf
// Set player's PRC343 to specific channel
_radio = ["ACRE_PRC343"] call acre_api_fnc_getRadioByType;
if (_radio != "") then {
    [_radio, 5] call acre_api_fnc_setRadioChannel;
};
```

### Save and Restore Loadout

```sqf
// Save current loadout
_loadout = [player] call acre_api_fnc_filterUnitLoadout;
player setVariable ["Saved_Loadout", _loadout, true];

// Restore loadout
_saved = player getVariable ["Saved_Loadout", []];
player setUnitLoadout _saved;
```

### Display Single Player Info

```sqf
// Get detailed player info display
_info = [player] call reapercrew_player_groups_fnc_getUnitInfoST;
hintSilent parseText _info;
```

---

## Function Reference

### Player Management Functions

| Function | Purpose |
|----------|---------|
| `setACRESettings` | Configure global ACRE channels |
| `setPersonalACRESettingsLocal` | Per-player radio configuration |
| `setUnitInsigniaLocal` | Apply unit insignia |
| `disarmModuleInit` | Module: Disarm all players |
| `savePlayerLoadoutGlobal` | Module: Save loadouts |
| `fixPlayerFatigueGlobal` | Module: Reset fatigue |
| `addACEActions` | Register ACE self-actions |

### Group Display Functions

| Function | Purpose |
|----------|---------|
| `listAllGroups` | Display all groups hint |
| `listPlayerInfo` | Display player + group info |
| `getGroupListST` | Build group structured text |
| `getUnitInfoST` | Build player info text |
| `getUnitRole` | Extract player role |
| `getWeight` | Get numeric weight (kg) |
| `getWeightColour` | Get hex color for weight |

---

## Troubleshooting

### ACRE Radios Not Configured

- Verify ACRE2 is loaded
- Check 15-second initialization delay has passed
- Confirm player has radios in inventory

### Insignia Not Appearing

- Verify insignia classnames exist in config
- Check group ID format matches expected pattern
- Fallback to default insignia if custom not found

### Group Info Not Showing

- ACE3 must be loaded
- Wait for postInit actions to complete
- Check ACE self-actions menu

### Wrong Radio Channel

- Verify group ID matches expected names
- Check for typos in group callsigns
- Manual override available via ACRE functions
