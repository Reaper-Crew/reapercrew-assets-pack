# Changelog

## Version 6.1

### Added
- **REINFORCEMENTS:** Added RANDOM delivery mode to airborne reinforcements module - each helicopter independently picks land or fastrope at random per wave

### Changed
- **REINFORCEMENTS:** Fastrope waypoint script now aborts gracefully if no units have left the vehicle after 30 seconds (handles ACE deployAIRecursive scheduling failures); helicopter is lowered to near-ground before forcing units out to prevent fall deaths, and ropes are cut manually on abort
- **REINFORCEMENTS:** Added 30-second timeout to ACE rope cleanup wait to prevent fastrope script hanging in edge cases
- **AMBIENCE:** Fixed CAS re-entry guard race condition - switched from boolean flag to script handle with `scriptDone` check; a boolean had a window where it was clear but the previous loop was still sleeping between strikes
- **AMBIENCE:** Refactored Ambient CAS dummy target creation out of a spawned thread; cleanup is now scheduled via `CBA_fnc_waitAndExecute` instead
- **PLAYER MANAGEMENT:** Fixed NVG colour effect not fully counteracting ACE3's green washout - desaturate value updated to full desaturate
- **PLAYER MANAGEMENT:** NVG effect now uses `ppEffectForceInNVG` to ensure correct rendering in all cases
- **PLAYER MANAGEMENT:** Fixed NVG effect not reapplying after closing Zeus while still in NVG mode
- **PLAYER MANAGEMENT:** NVG event handler now defers vision mode re-check to the next scheduled frame to absorb transient ACE3 mode changes

## Version 6.0

### Added
- **MISSION MECHANICS:** New addon - reaperCrew_Mission_Mechanics with Interaction Objective module (hold action on synced objects that publishes a global variable on completion)
- **MISSION MECHANICS:** Added Timed Task module - configurable timer with start/in-progress/completed variables and optional progress broadcasts via side chat
- **AMBIENCE:** New addon - reaperCrew_Ambience with Ambient CAS module
- **AMBIENCE:** Ambient CAS module supports configurable aircraft, strike type/direction, delay range, player proximity gating, and player-avoidance for strike positions
- **MECHANICS:** Added per-building min/max unit limits to Garrison module
- **MECHANICS:** Added minimum position distance attribute to Garrison module to prevent AI clustering
- **MECHANICS:** Added activation condition attribute to Garrison module for deferred spawning
- **MECHANICS:** Added Unlimited Ammo module, sync vehicles in Eden to give them infinite ammunition
- **MECHANICS:** Added Surrender Area module - sync AI units in Eden and they surrender via ACE captives when players enter the area, with configurable delay, stagger timing, weapon drop, and vehicle ejection options
- **PLAYER MANAGEMENT:** Added enhanced NVG colour effect (Modern Warfare preset), toggleable via CBA settings
- **PLAYER MANAGEMENT:** Added flashing on-screen notification when a player is being treated by another player via ACE medical
- **REINFORCEMENTS:** Added zone limit mode selector (Ceiling / Player Ratio with Ceiling) to all reinforcement modules, with separate ceiling and ratio attributes
- **REINFORCEMENTS:** Added shared zone ceiling calculation function; ratio mode is capped by the ceiling to prevent runaway AI counts
- **REINFORCEMENTS:** Added delivery mode selector (Land / Fastrope) to helicopter reinforcements module
- **REINFORCEMENTS:** Added custom fastrope waypoint script using ACE deployAI with helicopter position hold to prevent drift during deployment

### Changed
- **MECHANICS:** Refactored Garrison module to spawn one group per building instead of a single group for the entire area
- **MECHANICS:** Garrison units now use random stance (UP/MIDDLE), suppress voice, and disable radio protocol
- **MECHANICS:** Garrison module now applies skill levels from CBA AI Common settings per troop type
- **MECHANICS:** Refactored Convoy module to use correct parameter name (was referencing undefined variable)
- **MECHANICS:** Added null check for environmental damage in Convoy Hit event handler
- **MECHANICS:** Removed redundant simulation enable in Convoy dismount sequence
- **MECHANICS:** Added null check for empty player zone in Suppress Position activation
- **MECHANICS:** Cleaned up Convoy and Suppress Position code with improved inline comments
- **REINFORCEMENTS:** Fixed rushMode not being passed to airborne spawn script
- **REINFORCEMENTS:** Fixed rushMode not being passed to motorised spawn script
- **REINFORCEMENTS:** Fixed Marine module trigger using wrong condition variable (used raw condition instead of full trigger condition)
- **REINFORCEMENTS:** Fixed Marine LZ log message incorrectly saying "has no" when LZs were found
- **REINFORCEMENTS:** Fixed Motorised module header incorrectly describing it as helicopter reinforcements
- **REINFORCEMENTS:** Consolidated 4 identical debug logging loops into single efficient loop in reinforcements system init
- **REINFORCEMENTS:** Added function header comments to all spawnpoint init functions and activation functions
- **PLAYER MANAGEMENT:** Fixed fn_getRole to accept a unit parameter and return value instead of hardcoded player with hint
- **PLAYER MANAGEMENT:** Replaced hardcoded ACRE channel switch statement with HashMap lookup table
- **PLAYER MANAGEMENT:** Added alive check to treatment notification loop to prevent running after death
- **PLAYER MANAGEMENT:** Removed commented-out dead code from fn_addACEActions
- **PLAYER MANAGEMENT:** Cleaned up trailing whitespace in ACRE settings
- **LOGISTICS:** Removed duplicate switch statement with dead classname assignments in supply crate creation
- **LOGISTICS:** Fixed misleading comment in small arms crate init
- **REINFORCEMENTS:** Fixed airborne waypoint positions being set at sea level instead of terrain level (affected both helicopter and infantry waypoints)
- **REINFORCEMENTS:** Fixed fastrope waypoint using incorrect altitude calculation - now uses getTerrainHeightASL for correct hover position on hilly terrain
- **REINFORCEMENTS:** Added helicopter position hold during fastrope deployment to prevent drift causing ACE to detach units mid-rope
- **REINFORCEMENTS:** Added pilot MOVE AI suppression during deployment to prevent premature flyaway while last units are still descending
- **REINFORCEMENTS:** Fastrope script now gracefully exits with a logged warning if helicopter lacks ACE fastroping config
- **REINFORCEMENTS:** Airborne landing position search now rejects positions with trees or buildings within 25m to prevent helicopter collisions with canopy
- **REINFORCEMENTS:** Added sleep to airborne landing position search loop to prevent tight looping
- **REINFORCEMENTS:** Fixed airborne module debug log incorrectly saying "Vehicle triggers" instead of "Aircraft triggers"
- **MECHANICS:** Added sleep to Convoy contact detection waitUntil to prevent per-frame polling
- **AMBIENCE:** Added re-entry guard to prevent duplicate CAS loops when players leave and re-enter the trigger area
- **PLAYER MANAGEMENT:** Moved hasInterface check before ACRE init sleep to avoid needless delay on headless clients
- **PLAYER MANAGEMENT:** Fixed ACRE radio presence check using isNil instead of empty string comparison
- **ALL ADDONS:** Converted remaining active diag_log calls to remoteLog across AI Mechanics and Player Management addons; new addons (Ambience, Mission Mechanics) use remoteLog from the start

### Removed
- **REINFORCEMENTS:** Removed `fn_getZoneThreshold` function, replaced by `fn_getZoneCeiling` with separate ceiling and ratio parameters

---

## Version 5.6.5

### Added
- N/A

### Changed
- Bugfixed configuration of missing short range radios
- Added hotfix for replaced logi vehicle
- Adjusted pickup code for logistics

### Removed
- N/A

---

## Version 5.6.4

### Added
- Respawn Vehicle module for "magical resupply truck" with AI movement function

### Changed
- Bugfixed certain reinforcements modules not using the additional condition properly
- Bugfixes for incorrect detection behaviour in counter battery system

### Removed
- N/A

---

## Version 5.6.3

### Added
- Adjusted vehicle delivery system to use map-clicks for delivery position instead of player position
- Adjusted fn_setPersonalACRESettingsLocal to cope with players not having a short range at all
- Added support for reinforcements modules to use synchronised spawnpoints as well as global spawnpoints

### Changed
- Adapted reinforcements functions to use RemoteLog function instead of direct diag_log
- Bugfix for RemoteLog function to better determine server vs player
- Hotfix for ACE carrying not working properly on spawned crates

### Removed
- N/A

---

## Version 5.6.2

### Added
- Added CUP Terrains Assets pack files with soft dependency

### Changed
- N/A

### Removed
- N/A

---

## Version 5.6.1

### Added
- MVP Vehicle Delivery system

### Changed
- Updated convoy EventHandler to mitigate weird convoy self-activation bug
- Modified RemoteLog function to just take log message as input
- Fixed bug with being unable to pickup logi crates by adding "pick up" interaction option

### Removed
- N/A

---

## Version 5.6

### Added
- MVP for M4 Benelli Shotgun

### Changed
- Updated fn_activateMaraudingVehicles to navigate to nearest player instead of module location

### Removed
- N/A

---

## Version 5.5

### Added
- Added "Convoy" module that combines Better Convoy with other custom behaviour

### Changed
- Added function to update Radar unit detection marker position
- Adjusted fn_logisticsConsolidateSupplies to include new crate types
- Added support for items in IDF crate, defaults to range tables and map tools
- Updated number of supplies in the medical crate
- Bugfix for fn_setUnitInsigniaLocal to more reliably set unit insignia

### Removed
- N/A

---

## Version 5.4.3

### Added
- New ReaperCrew Logo for 2024

### Changed
- reapercrew_player_management_fnc_setUnitInsigniaLocal now also applies "clan" insignia consistently

### Removed
- N/A

---

## Version 5.4.2

### Added
- Adding new building blocks: 25x50m, 12x5m, 6x50m and 3x50m tunnels; Tunnel Connectors and Tunnel Splitters

### Changed
- Fixed FireGeo for 25m + 4m walls + Bunker Template 1 + 50m Slab
- Fixed L85A3 Handguard textures

### Removed
- N/A

---

## Version 5.4.1

### Added
- N/A

### Changed
- **MECHANICS:** Adjusted suppression module to be repeatable
- **MECHANICS:** Moved Garrison and suppression module to their own editor category
- **REINFORCEMENTS:** Automatically mounted AI into vehicles on spawn
- **REINFORCEMENTS:** Added workaround script to mitigate AI standing in place issue with LAMBS Rush module

### Removed
- N/A

---

## Version 5.4

### Added
- **MECHANICS:** Added "Suppress Position" AI mechanic

### Changed
- **REINFORCEMENTS:** Added Failsafe function to reinforcements spawners to adjust group size automatically to the size of the available vehicle (prevents situations where not all AI can fit in the vehicle)

### Removed
- N/A

---

## Version 5.3

### Added
- **SIMPLE OBJECTS:** Server Rack simple object
- **REINFORCEMENTS:** Added mechanics for custom reinforcements pathing
- **COUNTER BATTERY:** Added MVP for Counter Battery rewrite
- **PLAYER MANAGEMENT:** Added GroupLists function
- **CLOTHING:** Added Range Master belt with extended capacity for training map

### Changed
- **BUGFIX:** Fixed broken texture path and missing animation on L85A3
- **BUGFIX:** Fixed aiming memory point on HK33
- **COMMON:** Updated remoteLog to output to SystemChat in singleplayer for easier debugging

### Removed
- N/A

---

## Version 5.2

### Added
- N/A

### Changed
- Hotfix for Disarm module

### Removed
- N/A

---

## Version 5.1

### Added
- **CLOTHING:** Basic Ranger Green clothing to reaperCrew_Clothing
- **WEAPONS:** Added reaperCrew_Weapons containing HK33 and L85A3
- **SIMPLE OBJECTS:** Added the following editor structures; Bunker Template 1, 25x4m Wall and 4x4m Wall
- **COUNTER BATTERY:** Added Sentinel Radar unit

### Changed
- N/A

### Removed
- **CLOTHING:** Removed branded medic/MTP uniform
- **CLOTHING:** Removed ROK, Philippines, AUSCAM and Thanatos Security Retextures

---

## Version 5.0.4

### Added
- **SIMPLE OBJECTS:** Added generic 50mx25mx2m concrete blocks for use with deformer

### Changed
- **PLAYER MANAGEMENT:** Bugfix for Disarm module not showing the dialog box

### Removed
- N/A

---

## Version 5.0.3

### Added
- **COMMON:** Added RemoteLog function to push client logging data to server

### Changed
- **LOGISTICS:** Hotfix for section crates not having contents

### Removed
- N/A

---

## Version 5.0.2

### Added
- N/A

### Changed
- **COUNTER BATTERY:** Disabled counter battery functions

### Removed
- N/A

---

## Version 5.0.1

### Added
- N/A

### Changed
- Hotfix for small arms crates not spawning

### Removed
- N/A

---

## Version 5.0

### Added
- **PLAYER MANAGEMENT:** Add Zeus module to fix stamina bug
- **LOGISTICS:** Added new system for IDF ammunition crates (Breaking change)
- **REINFORCEMENTS:** Added new modules for marine-based reinforcements

### Changed
- **PLAYER MANAGEMENT:** Updated loadout save module to delete placed logic
- **LOGISTICS:** Modified Small Arms and Indirect Fires crates to use EventHandler init calls
- **PLAYER MANAGEMENT:** Added confirmation box to disarm module to prevent accidental usage
- **PLAYER MANAGEMENT:** Updated Insignia assignment function to use group-specific insignia

### Removed
- **LOGISTICS:** Removed specific IDF crates

---

## Version 4.5.2

### Added
- N/A

### Changed
- **REINFORCEMENTS:** Changed spawnpoint evaluation interval from 0.5 seconds to 30 seconds (Hotfix)
- **REINFORCEMENTS:** Changed reinforcement module init from 0.5 seconds to 5 seconds (Hotfix)
- **REINFORCEMENTS:** Changed spawnpoint createTrigger calls from global to local (Hotfix)

### Removed
- N/A

---

## Version 4.5.1

### Added
- N/A

### Changed
- **HOTFIX:** Backed out ACRE Tetra beeps for troubleshooting

### Removed
- N/A

---

## Version 4.5

### Added
- N/A

### Changed
- N/A

### Removed
- N/A

---

## Version 4.4

### Added
- Added RandomGear script to support BAF2025 and CAF2025 projects
- Added logistics consolidation crate and construction supplies
- Added logisticsConsolidateSupplies function to move all items into a single crate
- Added UK Police Tetra beeps to ACRE radios
- Added Data Link Tablet items

### Changed
- **COUNTER BATTERY:** Changing notifications to use Data Link tablets
- **COUNTER BATTERY:** Updated backend notification system to use CBA event listeners
- **COUNTER BATTERY:** Adjusted shipping container to 8 spaces (ACE CARGO)
- **REINFORCEMENTS:** Adjusted dynamic simulation for garrison units

### Removed
- N/A

---

## Version 4.3

### Added
- Added 'code on group' field to reinforcements modules to allow custom code execution against group spawned with AI reinforcements module
- Added 'wave delay' field to reinforcements module to allow custom delay between AI reinforcement waves
- Added 105mm and 122mm ACE Artillery ammo crates (requires CUP)
- Reimplemented Garrison Module

### Changed
- Updated medical crate to include 250ml blood bags
- Updated reapercrew_common_fnc_executeDistributed to wait for headless client data to be available

### Removed
- N/A

---

## Version 4.2

### Added
- Added re-engineered counter battery system
- Added module to save player loadout
- Additional unit-specific insignia textures

### Changed
- Fixed: Unit Insignias not being applied due to renamed function

### Removed
- N/A

---

## Version 4.1

### Added
- Added 2035 Uniforms for Philippines, South Korea, Australia and Thanatos Security

### Changed
- N/A

### Removed
- N/A

---

## Version 4.0

### Added
- Added Insignia support for Vehicle crews and Battery teams
- Created reaperCrew_Player_Management pbo for disarm module and ACRE auto-configuration
- Added reaperCrew_AI_Common for centralised configuration of mission AI settings
- Added support for regular, elite and SF troops in reinforcements settings
- Added fn_executeDistributed to execute code on a random headless client
- Added fn_monitorHeadlessClients as a new postinit function to check for headless clients
- Added fn_sideChatMP to broadcast sideChat messages in an MP compatible way

### Changed
- Compacted reaperCrew_Beret, reaperCrew_Uniform, reaperCrew_Insignia into reaperCrew_Clothing
- Compacted reaperCrew_Crates into reaperCrew_Logistics
- Changed vehicle fuel barrels from 100 litres to 2000 litres capacity
- Modified resupply module to use ACE interaction system rather than hold actions
- Updated fn_setUnitInsigniaLocal to account for 10 man sections
- Improved spawnpoint activation logic: players must be within an acceptable range; players must not be able to see the spawn position; only activate the spawnpoint if at least one of the units within range is infantry; the module now allows the specification of an additional condition
- Marauding vehicles and aircraft will attempt to move towards the player nearest to the logic object, rather than just always to the logic itself
- Temporarily removed LCMR until improved

### Removed
- Removed reaperCrew_SupportVehicles since it was redundant
- Removed reapercrew_Functions pbo in favour of more specific modules

---

## Version 3.2

### Added
- N/A

### Changed
- Hotfix: Improved helicopter landing area behaviour to fix helicopters getting stuck in hovering state

### Removed
- N/A

---

## Version 3.1

### Added
- Counter Battery system Alpha
- Automatic team colour assignment based on role

### Changed
- Bugfix: Updated ACRE function to fix channels not being set
- Bugfix: End the spawning of reinforcements once players have left a zone
- Bugfix: Fixed broken spawnpoint activation
- Updated reapercrew_common_fnc_setUnitInsigniaLocal to include 'Assist. Machine Gunner'

### Removed
- N/A

---

## Version 3.0

### Added
- Added reinforcement system
- Added marauding vehicle/aircraft system
- Added Vehicle Ammo and Vehicle Fuel crates

### Changed
- Separated logistics data into separate pbo
- Trimmed CBA Settings for logistics
- Moved generic functions into reaperCrew_Common
- Fixed setUnitInsigniaLocal to use RemoteExec
- Disarm Module now heals all players
- reapercrew_logistics_fnc_logisticsPopulateSupplyCrate now returns the created supply crate for integration with other scripts

### Removed
- Removed reaperCrew_Modules.pbo

---

## Version 2.5

### Added
- 82mm Mortar crate (ACE Ammo Handling)
- Settings option for 82mm Mortar crate
- Settings option for empty wooden crates
- Automatic assignment of ACRE Radio channels
- Automatic assignment of ACRE PTT keys
- Automatic configuration of unit insignia based on role name
- Automatic configuration of unit rank based on role name

### Changed
- Bugfix: Fixed crate simulation on spawn

### Removed
- N/A

---

## Version 2.4

### Added
- Added signs for Reaper-1-5 and Reaper-1-6
- Added general signs for special assets
- Added cfgMods entry for reaperCrew_Common

### Changed
- Fixed Disarm Module to only run once per client instead of for each connected client
- Modified Garrison module to 50m radius and 5 per building
- Reworked callsigns board to new callsigns list
- Changed resupply module to add dragging and carrying functionality to both crates

### Removed
- Removed many of the old callsigns images

---

## Version 2.3

### Added
- Added Livonia helicopter training mission and associated functions
- Added support for explosives in resupply crate
- Added modified cover map function
- Added old style czech hedgehog as simple object

### Changed
- Separated resupply functions into Create and Populate functions so that it can be used by a Support Provider: Supply Drop module

### Removed
- N/A

---

## Version 2.2

### Added
- Added Camonets, tents and additional H-barriers as simple objects

### Changed
- Modified disarm module to add beret to unit

### Removed
- N/A

---

## Version 2.1

### Added
- Added additional fortifications as simple objects

### Changed
- N/A

### Removed
- N/A

---

## Version 2.0

### Added
- Added ACRE2 auto-configuration global script
- Added logisticsAddActions, logisticsCreateMedicalCrate, logisticsCreateSupplyCrate functions
- Added Resupply Point Module to Eden and Zeus
- Added reaperCrew_SimpleObjects.pbo that adds a copy of fortifications with the Simple Object parameter available
- Added initAirDefenceTurretTruck and initAirDefenceRadarTruck functions
- Added ReaperCrew air defence vehicles
- Added Unit role insignias

### Changed
- Rebranded xeen_modules to reaperCrew_Functions and reaperCrew_Modules

### Removed
- N/A
