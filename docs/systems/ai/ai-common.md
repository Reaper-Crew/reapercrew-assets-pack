# AI Common Configuration

## Overview

The AI Common system provides global configuration settings for all AI-related systems in the Reaper Crew Assets Pack. These settings define the opposition faction, unit pools for different troop types, skill levels, and vehicle classes used by the reinforcements and other AI systems.

## Quick Start

1. Open CBA Settings (`Options > Addon Options`)
2. Navigate to **Reaper Crew - AI Common**
3. Configure the opposition faction and unit classnames
4. Save settings in the **Mission** tab

## CBA Settings Reference

All settings are configured via `Options > Addon Options > Reaper Crew - AI Common`.

### 1. Global AI Settings

| Setting | Variable Name | Type | Default | Description |
|---------|--------------|------|---------|-------------|
| Opposition Faction | `reaperCrew_reinforcements_side` | List | WEST | The side that AI will spawn as (EAST, WEST, INDEPENDENT) |

**Faction Options:**
- `EAST` - OPFOR (Index 0)
- `WEST` - BLUFOR (Index 1) - Default
- `INDEPENDENT` - Independent (Index 2)

### 2. Infantry Settings

#### Unit Pools

| Setting | Variable Name | Default |
|---------|--------------|---------|
| Regular Troops | `reaperCrew_reinforcements_regularTroops` | `O_Soldier_F,O_Soldier_AR_F,...` |
| Elite Troops | `reaperCrew_reinforcements_eliteTroops` | `O_Soldier_F,O_Soldier_AR_F,...` |
| Special Forces | `reaperCrew_reinforcements_specialForces` | `O_Soldier_F,O_Soldier_AR_F,...` |

**Format:** Comma-separated list of unit classnames (no spaces).

#### Skill Settings

| Setting | Variable Name | Range | Default |
|---------|--------------|-------|---------|
| Regular Troops Skill | `reaperCrew_reinforcements_regularTroopsDifficulty` | 20-100 | 50 |
| Elite Troops Skill | `reaperCrew_reinforcements_eliteTroopsDifficulty` | 20-100 | 80 |
| Special Forces Skill | `reaperCrew_reinforcements_specialForcesDifficulty` | 20-100 | 100 |

### 3. Transport Settings

| Setting | Variable Name | Default |
|---------|--------------|---------|
| Transport Vehicles | `reaperCrew_reinforcements_transportGround` | `O_G_Offroad_01_F` |
| Transport Helicopters | `reaperCrew_reinforcements_transportHelicopter` | `O_Heli_Light_02_unarmed_F` |
| Transport Boats | `reaperCrew_reinforcements_transportBoat` | `I_C_Boat_Transport_02_F` |

### 4. Fire Support (Ground)

| Setting | Variable Name | Default |
|---------|--------------|---------|
| Heavy Armour | `reaperCrew_reinforcements_fireSupportHeavyArmour` | `O_MBT_02_cannon_F` |
| Light Armour | `reaperCrew_reinforcements_fireSupportLightArmour` | `O_APC_Tracked_02_cannon_F` |
| Technicals | `reaperCrew_reinforcements_fireSupportTechnicals` | `O_G_Offroad_01_armed_F` |

### 5. Fire Support (Air)

| Setting | Variable Name | Default |
|---------|--------------|---------|
| Light Rotary | `reaperCrew_reinforcements_fireSupportLightRotary` | `O_Heli_Light_02_dynamicLoadout_F` |
| Heavy Rotary | `reaperCrew_reinforcements_fireSupportHeavyRotary` | `O_Heli_Attack_02_F` |
| Fixed Wing (Fighters) | `reaperCrew_reinforcements_fireSupportFixedWingFighters` | `O_Plane_CAS_02_F` |
| Fixed Wing (Bombers) | `reaperCrew_reinforcements_fireSupportFixedWingBombers` | `O_Plane_CAS_02_F` |

## Code Examples

### Reading AI Settings in Scripts

```sqf
// Get the opposition faction side
_oppositionSide = reaperCrew_reinforcements_side;

// Get regular troops array
_regularTroops = reaperCrew_reinforcements_regularTroops splitString ",";

// Get skill level for elite troops
_eliteSkill = reaperCrew_reinforcements_eliteTroopsDifficulty / 100;
```

### Custom Unit Pool Configuration

To configure custom unit pools for a specific mod (e.g., RHS):

**Regular Troops (RHS Russian):**
```
rhs_msv_rifleman,rhs_msv_at,rhs_msv_grenadier,rhs_msv_machinegunner,rhs_msv_marksman,rhs_msv_medic
```

**Elite Troops (RHS VDV):**
```
rhs_vdv_rifleman,rhs_vdv_at,rhs_vdv_grenadier,rhs_vdv_machinegunner,rhs_vdv_marksman,rhs_vdv_medic
```

**Heavy Armour (RHS):**
```
rhs_t80um,rhs_t90_tv,rhs_t72bc_tv
```

### Overriding Settings at Runtime

```sqf
// Change opposition faction mid-mission
["reaperCrew_reinforcements_side", east] call CBA_settings_fnc_set;

// Update vehicle pool
["reaperCrew_reinforcements_fireSupportHeavyArmour", "rhs_t90_tv,rhs_t80um"] call CBA_settings_fnc_set;
```

## Integration with Other Systems

The AI Common settings are used by:

- **Reinforcements System** - For spawning infantry and vehicles
- **Garrison Module** - Uses unit pools for building occupation
- **Marauding Modules** - Uses fire support vehicle pools

## Troubleshooting

### Units spawning as wrong faction
- Verify `reaperCrew_reinforcements_side` matches your mission's enemy faction

### Units not spawning
- Check that classnames are valid (no typos)
- Verify the addon providing the units is loaded
- Use Arsenal's export function to get correct classnames

### Performance Issues
- Avoid using overly complex units with many attachments
