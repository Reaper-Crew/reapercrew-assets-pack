# Logistics System

## Overview

The Logistics System provides mission makers with a comprehensive suite of tools for managing resupply operations, vehicle delivery, and mobile respawn capabilities. By spawning resources only when required, the system reduces object count and avoids cluttering spawn areas with resupply crates.

## Quick Start

1. Place a Resupply Point module from Eden Editor
2. Synchronize the module to any object (cargo container recommended)
3. Configure crate contents in CBA Settings (`Options > Addon Options > Reaper Crew - Logistics`)
4. Save settings in the **Mission** tab

---

## Resupply Point Module

| Editor Name | Classname |
|-------------|-----------|
| Resupply Point | `reaperCrew_moduleResupplyPoint` |

The Resupply Point module enables players to spawn supply crates on demand.

### Setup

1. Place any object to serve as the resupply hub (cargo containers work well)
2. Place the **Resupply Point** module (`Systems (F5) > Modules > Reaper Crew - Logistics`)
3. Synchronize the module to your object (or attach in Zeus)

### Available Crate Types

Players interact with the synchronized object via ACE menu to spawn crates:

| Crate | Classname | Contents |
|-------|-----------|----------|
| Small Arms | `ReaperCrew_SupplyCrateSmallArms` | Rifle, MG, pistol magazines; grenades; launchers |
| Medical | `ReaperCrew_PlasticCase_Medical` | ACE medical supplies (blood, bandages, drugs) |
| IDF (Indirect Fires) | `ReaperCrew_SupplyCrateIDF` | Mortar rounds, illumination, utility items |
| Vehicle Fuel | `RC_CargoNet_01_barrels_F` | 2000L ACE refuel source |
| Vehicle Ammo | `RC_VirtualReammoBox_F` | 1000 units ACE rearm supply |
| Transport | `Land_WoodenCrate_01_F` | Empty crate for general use |

### ACE Interaction

On the resupply object:
```
ACE_MainActions
├── Spawn Section Crate (5-sec progress bar)
├── Spawn Medical Crate (5-sec progress bar)
├── Spawn IDF Crate (if enabled)
├── Spawn Vehicle Fuel Crate (if enabled)
├── Spawn Vehicle Ammo Crate (if enabled)
└── Spawn Transport Crate (if enabled)
```

### Troubleshooting

**Crates Not Spawning:**
- Verify module is synchronized → object
- Check module was placed in Eden Editor (not Zeus)
- Ensure CBA Settings are saved in the Mission tab

**Wrong Crate Contents:**
- Verify classnames in CBA Settings are correct
- Ensure no typos in comma-separated lists

---

## Supply Crate Contents

### Small Arms Crate

Configured via CBA Settings. Default quantities per item type:

| Category | Quantity | CBA Setting |
|----------|----------|-------------|
| Rifle Magazines | 64 | `reaperCrew_rifleMagazines` |
| Grenadier Ammo | 20 | `reaperCrew_grenadierAmmo` |
| Sidearm Magazines | 40 | `reaperCrew_sidearmMagazines` |
| MG Magazines | 20 | `reaperCrew_machinegunMagazines` |
| Marksman Magazines | 30 | `reaperCrew_MarksmanMagazines` |
| Launcher Ammo | 10 | `reaperCrew_LauncherAmmo` |
| Single-use Launchers | 10 | `reaperCrew_SingleUseLaunchers` |
| Lethal Grenades | 20 | `reaperCrew_lethalGrenades` |
| Non-Lethal Grenades | 20 | `reaperCrew_nonLethalGrenades` |
| Smoke Grenades | 20 | `reaperCrew_smokeGrenades` |
| Explosives | 10 | `reaperCrew_explosives` |

### Medical Crate

Fixed contents (ACE Medical):

| Item | Quantity |
|------|----------|
| ACE_bloodIV | 15 |
| ACE_bloodIV_500 | 12 |
| ACE_bloodIV_250 | 4 |
| ACE_elasticBandage | 100 |
| ACE_quikclot | 100 |
| ACE_packingBandage | 100 |
| ACE_adenosine | 20 |
| ACE_epinephrine | 50 |
| ACE_morphine | 20 |
| ACE_tourniquet | 20 |
| ACE_splint | 20 |
| ACE_personalAidKit | 2 |

### IDF Crate

Configured via CBA Settings:

| Category | Quantity | CBA Setting |
|----------|----------|-------------|
| Explosive Rounds | 50 | `reaperCrew_IDFExplosiveRounds` |
| Utility Rounds | 25 | `reaperCrew_IDFUtility` |
| Support Items | 10 | `reaperCrew_IDFItems` |

---

## Vehicle Delivery System

### Overview

The Vehicle Delivery system allows authorized players to request replacement vehicles that are driven to their location by AI. This is essential for assets that cannot be transported (tanks, SPGs, large vehicles).

| Editor Name | Classname |
|-------------|-----------|
| Vehicle Spawnpoint | `reaperCrew_moduleResupplyVehicleSpawnpoint` |

Place this module to mark where delivery vehicles will spawn.

### Setup

1. Place **Vehicle Spawnpoint** modules at suitable spawn locations
2. Configure deliverable vehicles in CBA Settings
3. Configure permitted groups in CBA Settings

### Requesting a Vehicle

1. ACE Self-Interact > Equipment > Select vehicle type
2. Map opens - click to select delivery destination
3. Progress bar indicates spawn in progress
4. AI driver delivers vehicle to location
5. Upon arrival, driver is deleted and damage protection removed

### Delivery Mechanics

- **Damage Immunity:** Vehicle is invulnerable during transit (prevents AI collision damage)
- **Driver:** Civilian AI with careless behaviour, deleted on arrival
- **Important:** Wait for full waypoint completion before taking vehicle

### CBA Settings

| Setting | Variable | Description |
|---------|----------|-------------|
| Deliverable Vehicles | `reaperCrew_vehicleResupplyDeliveryClasses` | Comma-separated vehicle classnames |
| Permitted Groups | `reaperCrew_vehicleResupplyDeliveryGroups` | Comma-separated group callsigns |

**Default Vehicles:**
```
B_Truck_01_mover_F,B_MRAP_01_F,B_LSV_01_unarmed_F,B_Quadbike_01_F
```

### Script Overrides

Mission makers can define custom code to run against spawned vehicles and drivers by setting global variables. These are evaluated on each spawn, so they can be updated mid-mission.

| Variable | Arguments | Description |
|----------|-----------|-------------|
| `reaperCrew_vehicleDelivery_onVehicleCreated` | `[_vehicle, _spawnPosition, _deliveryPoint]` | Code to run on the vehicle after creation |
| `reaperCrew_vehicleDelivery_onDriverCreated` | `[_unit, _vehicle, _spawnPosition, _deliveryPoint]` | Code to run on each driver unit after loadout |

Both default to `{}` (no-op) if not set. The code only runs where the vehicle/unit is local. If effects need to be broadcast (e.g. `setObjectTextureGlobal`), that is the responsibility of the override code.

**Examples:**

```sqf
// Randomise vehicle colour in init.sqf
reaperCrew_vehicleDelivery_onVehicleCreated = {
    params ["_vehicle", "_spawnPos", "_deliveryPos"];
    _vehicle setObjectTextureGlobal [0, selectRandom ["texture1.paa", "texture2.paa"]];
};

// Give driver a sidearm
reaperCrew_vehicleDelivery_onDriverCreated = {
    params ["_unit", "_vehicle", "_spawnPos", "_deliveryPos"];
    _unit addWeapon "hgun_Pistol_heavy_01_F";
};

// Clear override mid-mission
reaperCrew_vehicleDelivery_onVehicleCreated = {};
```

### Troubleshooting

- Check player's group is in permitted groups list
- Verify Vehicle Spawnpoint modules are placed
- Confirm vehicle classnames are valid

---

## Respawn Vehicle Module

### Overview

The Respawn Vehicle system provides a mobile FOB capability where players respawn directly into a designated vehicle. The vehicle can also be recalled to a specified location.

| Editor Name | Classname |
|-------------|-----------|
| Respawn Vehicle | `reaperCrew_moduleRespawnVehicle` |

### Setup

1. Place a vehicle to serve as the respawn point
2. Place the **Respawn Vehicle** module
3. Synchronize the vehicle to the module
4. (Optional) Enable supply refresh in CBA Settings

### Features

**Player Respawn:**
- Players automatically moved into respawn vehicle on death
- 2-second delay after respawn before teleport

**Supply Refresh:**
- Vehicle cargo can be automatically replenished
- Configurable refresh frequency (default: 30 minutes)
- Refills both small arms and medical supplies

**Vehicle Recall:**
- Players can request the respawn vehicle come to them
- ACE Self-Interact > Call HQ Vehicle
- AI driver delivers vehicle to selected map location

### CBA Settings

| Setting | Variable | Type | Default | Description |
|---------|----------|------|---------|-------------|
| Refresh Supplies | `reaperCrew_respawnVehicleRefreshSupplies` | Checkbox | true | Auto-refill vehicle cargo |
| Refresh Frequency | `reaperCrew_respawnVehicleRefreshSuppliesFrequency` | Slider | 30 | Minutes between refreshes (30-120) |

### Troubleshooting

- Ensure vehicle is synchronized → module
- Check supply refresh is enabled if expected
- Verify only one vehicle is synchronized (uses first in list)

---

## FOB Crate

### Classname: `reaperCrew_FOB_Crate`

A sling-loadable cargo crate with special consolidation ability.

### Special Action

**Consolidate Supplies** (ACE interaction):
- Collects all supply crates within 50m radius
- Transfers contents into FOB crate
- Deletes consolidated crates
- Collects from: Medical, Small Arms, and IDF crates

---

## CBA Settings Reference

Configure under `Options > Addon Options > Reaper Crew - Logistics`:

### Small Arms Category

| Setting | Variable | Default |
|---------|----------|---------|
| Rifle Magazines | `reaperCrew_rifleMagazines` | `ACE_30Rnd_556x45_Stanag_Tracer_Dim` |
| Grenadier Ammo | `reaperCrew_grenadierAmmo` | `1Rnd_HE_Grenade_shell` |
| Sidearm Magazines | `reaperCrew_sidearmMagazines` | `9Rnd_45ACP_Mag` |
| MG Magazines | `reaperCrew_machinegunMagazines` | `200Rnd_556x45_Box_Tracer_F` |
| Marksman Magazines | `reaperCrew_MarksmanMagazines` | `10Rnd_338_Mag` |
| Launcher Ammo | `reaperCrew_LauncherAmmo` | `Titan_AT` |
| Single-use Launchers | `reaperCrew_SingleUseLaunchers` | `launch_NLAW_F` |
| Lethal Grenades | `reaperCrew_lethalGrenades` | `HandGrenade` |
| Non-Lethal Grenades | `reaperCrew_nonLethalGrenades` | `ACE_CTS9` |
| Smoke Grenades | `reaperCrew_smokeGrenades` | `SmokeShellPurple,SmokeShell` |
| Explosives | `reaperCrew_explosives` | `DemoCharge_Remote_Mag` |

### Indirect Fires Category

| Setting | Variable | Default |
|---------|----------|---------|
| Enable IDF Crate | `reaperCrew_IDFCrate` | false |
| Explosive Rounds | `reaperCrew_IDFExplosiveRounds` | `ACE_1Rnd_82mm_Mo_HE,ACE_1Rnd_82mm_Mo_HE_Guided,ACE_1Rnd_82mm_Mo_HE_LaserGuided` |
| Utility Rounds | `reaperCrew_IDFUtility` | `ACE_1Rnd_82mm_Mo_Smoke,ACE_1Rnd_82mm_Mo_Illum` |
| IDF Items | `reaperCrew_IDFItems` | `ACE_UAVBattery,ACE_MapTools,ACE_RangeTable_82mm,ACE_artilleryTable` |

### Vehicle Armaments Category

| Setting | Variable | Default |
|---------|----------|---------|
| Enable Fuel Crate | `reaperCrew_VehicleFuelCheckbox` | false |
| Enable Ammo Crate | `reaperCrew_VehicleAmmoCheckbox` | false |

### Misc Category

| Setting | Variable | Default |
|---------|----------|---------|
| Enable Transport Crate | `reaperCrew_transportCheckbox` | false |

---

## Code Examples

### Custom Crate Contents

```sqf
// In init.sqf or mission script - customise small arms crate
// Format: comma-separated classnames
reaperCrew_rifleMagazines = "rhs_mag_30Rnd_556x45_M855A1_Stanag,rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
reaperCrew_machinegunMagazines = "rhs_200rnd_556x45_M_SAW";
```

### Spawn Crate Programmatically

```sqf
// Spawn a small arms crate at position
_pos = getPos player;
_crate = createVehicle ["ReaperCrew_SupplyCrateSmallArms", _pos, [], 0, "NONE"];
[_crate] call reapercrew_logistics_fnc_logisticsInitCrateSmallArms;
```

### Check Vehicle Delivery Permissions

```sqf
// Check if player's group can request vehicles
_groupID = groupId (group player);
_permitted = reaperCrew_vehicleResupplyDeliveryGroups splitString ",";

if (_groupID in _permitted) then {
    hint "You can request vehicle delivery";
};
```

### Manually Trigger Supply Refresh

```sqf
// Server-side: Refresh respawn vehicle supplies
_vehicle = missionNamespace getVariable ["reaperCrew_respawn_vehicle", objNull];
if (!isNull _vehicle) then {
    [_vehicle] call reapercrew_logistics_fnc_logisticsInitCrateSmallArms;
    // Add medical supplies...
};
```

---

## ACE Integration

The Logistics system integrates with several ACE modules:

| ACE Module | Integration |
|------------|-------------|
| ACE Dragging | All crates can be carried/dragged |
| ACE Refuel | Fuel crate provides 2000L refuel source |
| ACE Rearm | Ammo crate provides 1000 units rearm supply |
| ACE Medical | Medical crate contents match ACE medical items |
| ACE Interact Menu | All player actions via ACE interaction |

