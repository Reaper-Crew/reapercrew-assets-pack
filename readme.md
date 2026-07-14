# Reaper Crew Assets Pack - Documentation

## Overview

The Reaper Crew Assets Pack is a comprehensive collection of systems, modules, and assets designed to enhance Arma 3 mission making. This documentation provides mission makers with everything needed to implement and configure these systems effectively.

## Requirements

### Required Addons
- **CBA_A3** - Community Base Addons
- **ACE3** - Advanced Combat Environment
- **LAMBS Danger** - AI Enhancement Framework
- **ZEN** - Zeus Enhanced
- **ACRE2** - Advanced Combat Radio Environment

## Documentation

### Getting Started

- [Quick Reference](docs/quick-reference.md) - Mission maker cheat sheet
- [Module Index](docs/modules.md) - Every Eden module with classnames and links

### AI Systems

- [AI Common](docs/systems/ai/ai-common.md) - Faction, unit pools and skill configuration
- [AI Mechanics](docs/systems/ai/ai-mechanics.md) - Overview and shared concepts
  - [Garrison Area](docs/systems/ai/garrison.md) - Populate buildings with defenders
  - [Patrol Area](docs/systems/ai/patrol.md) - Roaming patrols in a zone
  - [Suppress Area](docs/systems/ai/suppress-position.md) - Suppressive fire positions
  - [Convoy](docs/systems/ai/convoy.md) - Vehicle convoys with contact behaviour
  - [Unlimited Ammo](docs/systems/ai/unlimited-ammo.md) - Infinite ammunition for synced vehicles
  - [Surrender Area](docs/systems/ai/surrender-area.md) - Scripted ACE surrenders

### Reinforcements

- [Reinforcements System](docs/systems/reinforcements/reinforcements-system.md) - Overview, CBA settings, zone ceiling and wave mechanics
  - [Spawnpoints](docs/systems/reinforcements/spawnpoints.md) - Spawn locations, zones, capturable objectives, pathing
  - [Infantry - Foot Mobile](docs/systems/reinforcements/foot-mobile.md) - Infantry that rush on foot
  - [Infantry - Motorised](docs/systems/reinforcements/motorised.md) - Vehicle-delivered infantry
  - [Infantry - Helicopter](docs/systems/reinforcements/helicopter.md) - Heli-delivered infantry (land or fastrope)
  - [Infantry - Marine](docs/systems/reinforcements/marine.md) - Boat-delivered infantry
  - [Marauding Vehicles & Aircraft](docs/systems/reinforcements/marauding.md) - Persistent vehicle and air pressure

### Mission Systems

- [Mission Mechanics](docs/systems/mission-mechanics/mission-mechanics-system.md) - Interaction Objectives and Timed Tasks
- [Ambience](docs/systems/ambience/ambience-system.md) - Ambient CAS strikes

### Support Systems

- [Logistics](docs/systems/logistics/logistics-system.md) - Resupply points, vehicle delivery and respawn vehicles
- [Player Management](docs/systems/player/player-management.md) - Loadouts, ACRE and player utilities

### Development

- [Developer Guide](docs/developer-guide.md) - For addon development
- [Common Files Reference](docs/common-files.md) - Shared utilities and functions
- [Functions Reference](docs/functions.md) - Public function documentation

## CBA Settings Categories

All systems are configured through CBA Settings (`Options > Addon Options`) under these categories:

- **Reaper Crew - AI Common** - Global AI configuration (faction, unit pools, skills)
- **Reaper Crew - AI Reinforcements** - Reinforcement system settings and debugging
- **Reaper Crew - Logistics** - Resupply crate contents and delivery settings

**Important:** Save CBA settings in the **Mission** tab to ensure they persist with your mission file.

## Module Categories in Eden Editor

Modules are found under `Systems (F5) > Modules`:

- **Reaper Crew - AI Mechanics** - AI behaviour modules (Garrison, Patrol, Suppress, Convoy, Unlimited Ammo, Surrender Area)
- **Reaper Crew - Reinforcements** - Spawnpoints and reinforcement modules
- **Reaper Crew - Ambience** - Ambient effects modules (CAS strikes)
- **Reaper Crew - Mission Mechanics** - Gameplay modules (Interaction Objective, Timed Task)
- **Reaper Crew - Logistics** - Resupply and vehicle management
- **Reaper Crew - Player Management** - Player utility modules

## Headless Client Support

All reinforcement and AI systems are designed for **Headless Client (HC) compatibility**. AI spawning and management is automatically distributed to available headless clients when present, reducing server load in multiplayer missions.
