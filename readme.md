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

## Systems Overview

### AI Systems

| System | Description |
|--------|-------------|
| [**AI Common**](docs/systems/ai/ai-common.md) | Global AI configuration including faction selection, unit pools, and skill settings |
| [**AI Mechanics**](docs/systems/ai/ai-mechanics.md) | Garrison, Suppress Position, and Convoy modules |
| [**AI Reinforcements**](docs/systems/reinforcements/reinforcements-system.md) | Dynamic reinforcement spawning with multiple delivery methods |

### SABRE Network

| System | Description |
|--------|-------------|
| [**SABRE Core**](docs/systems/sabre/sabreCore.md) | Information sharing network framework |
| [**Counter-Battery**](docs/systems/sabre/sabreCounterBattery.md) | Radar-based indirect fire detection system |

### Support Systems

| System | Description |
|--------|-------------|
| [**Logistics**](docs/systems/logistics/logistics-system.md) | Resupply points, vehicle delivery, and respawn vehicles |
| [**Player Management**](docs/systems/player/player-management.md) | Loadout saving, ACRE configuration, and group management |

## Quick Start

For mission makers who want to get started quickly, see the [Quick Reference Guide](docs/quick-reference.md).

## CBA Settings Categories

All systems are configured through CBA Settings (`Options > Addon Options`) under these categories:

- **Reaper Crew - AI Common** - Global AI configuration (faction, unit pools, skills)
- **Reaper Crew - AI Reinforcements** - Reinforcement system settings and debugging
- **Reaper Crew - Logistics** - Resupply crate contents and delivery settings
- **Reaper Crew - SABRE** - Network activation settings
- **Reaper Crew - SABRE (Counter Battery)** - Radar detection and artillery classnames

**Important:** Save CBA settings in the **Mission** tab to ensure they persist with your mission file.

## Module Categories in Eden Editor

Modules are found under `Systems (F5) > Modules`:

- **Reaper Crew - AI** - AI behaviour modules (Garrison, Suppress, Convoy)
- **Reaper Crew - Reinforcements** - Spawnpoints and reinforcement modules
- **Reaper Crew - Logistics** - Resupply and vehicle management
- **Reaper Crew - Player Management** - Player utility modules

## Headless Client Support

All reinforcement and AI systems are designed for **Headless Client (HC) compatibility**. AI spawning and management is automatically distributed to available headless clients when present, reducing server load in multiplayer missions.

## Documentation Structure

```
docs/
├── quick-reference.md        # Mission maker cheat sheet
└── systems/
    ├── ai/
    │   ├── ai-common.md      # Faction & unit pool configuration
    │   └── ai-mechanics.md   # Garrison, Suppress, Convoy
    ├── reinforcements/
    │   └── reinforcements-system.md
    ├── sabre/
    │   ├── sabreCore.md
    │   └── sabreCounterBattery.md
    ├── logistics/
    │   └── logistics-system.md
    └── player/
        └── player-management.md
```

## Additional Resources

- [Developer Guide](docs/developer-guide.md) - For addon development
- [Common Files Reference](docs/common-files.md) - Shared utilities and functions
- [Functions Reference](docs/functions.md) - Public function documentation
