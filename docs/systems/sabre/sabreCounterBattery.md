# SABRE - Counter Battery

## Overview

The purpose of this Counter Battery component is to provide a mechanism for players and AI to organically detect the presence of opposing indirect fires assets - without the need to be given that information by the game master or mission designer. It's designed to be implmeneted in such a way that it will work with any modded content.

Over time the number of radar units available will increase, each brining their own unique capabilities and limitations.

## Radar Systems

### Using the Radar

The Radar will share information using the SABRE system, therefore in order to make use of this platform you must have the "SABRE tablet" on you your character.

In order for a radar unit to detect enemy assets, the following conditions must be met:

* It must be within range of the radar (see the area marked on the map)
* The radar must have the engine switched on
* The radar unit must be alive and manned by an AI

### Managing the radar

Your radar unit functions as a vehicle, and therefore you must consider some of the usual limitations that you would associate with any vehicle.

Firstly is that of fuel. The engine sits in idle and therefore fuel consumption is low, but not zero. As such, you will need to make sure that you keep your radar topped up with fuel.

The second is that of thermal signature. The engine functions in the same way as other vehicles in ArmA - It will getting hotter and hotter over time, and will produce a significant thermal signature when it has been running for some time. As such, this system can be targetted by ATGMs, aircraft, tanks etc - and from considerable distance. Take care to site the radar in a safe or protected area.

You can view both the fuel and the start/stop the engine from the ACE interact menu.

## Mission Makers Guide

The system is designed to be mostly plug-and-play, but the minimal settings that do need configuring can be found under `Reaper Crew - SABRE (Counter Battery)`. From the menu you'll be able to configure whether or not the system is active, and the AI assets that should be detected - this is provided as a comma separated list of classnames.

## Known Issues

* The system initialises a number of server-only functions, as such this does not behave properly in SP and must be tested in MP.
* Markers will sometimes dissappear, this is an issue with how ArmA handles locality and I'm currently thinking about workarounds.

