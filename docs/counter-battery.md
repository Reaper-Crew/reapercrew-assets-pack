# Counter Battery System

## Overview

The purpose of the counter battery system is to provide a mechanism for players to organically detect the presence of enemy mortar, artillery, or other indirect fires - without the need to be given the information by a game master or mission designer. It's designed to be compatible with turrets and vehicles from a variety of mods. The idea is that over time the number of available counter battery systems will be expanded, each system having different capabilities and limitations.

## Variants

### TPQ-50

![TPQ-50](/docs/counter-battery/tpq-50-preview.jpg) ![TPQ-50](/docs/counter-battery/tpq-50-preview-2.jpg)

This model is based loosely on the real life [TPQ-50](https://www.srcinc.com/pdf/Radars-and-Sensors-ANTPQ50.pdf). This variant takes the form of a dedicated listening station, equipped with a tent and a detection range of around 30km². When packaged up, it takes the form of a shipping container that can be sling-loaded to an objective area, or packed into a truck.

## Mission Makers Guide

The system is designed to be mostly plug-and-play, but the minimal settings that do need configuring can be found under `Reaper Crew - Counter Battery`. From the menu you'll be able to configure whether or not the system is active, and the AI assets that should be detected - this is provided as a comma separated list of classnames.

![TPQ-50](/docs/counter-battery/counter-battery-config.jpg)

## Player Guide

### Basic Usage

As standard, listening posts will be deployed in the form of a shipping container. Once you ACE interact with this container, you should see the option to "Deploy Listening Post". This option will then unpack the container and deploy the listening post (more or less) on the position where the container once was. In the event that you'd like to pack up and leave, this process can be performed in reverse, interacting with the deployed listening post and repacking it into it's container.

Once deployed, you'll be able to get into the driver position of the listening post. When in the driver position of this listening post, you'll be able to see detection data on your map, but this information is only available to you for as long as you are present inside the post, and will disappear when you disembark.

You don't need to be embarked into the listening post in order to detect new firing positions, but you are required to keep the engine running. When disembarking, make sure to use the 'eject' option instead of 'Get out', as the latter of the two causes the vehicle engine to be automatically switched off.

It's worth noting that the listening post will behave similar to that of a vehicle, it will deplete fuel over time, and will also generate a thermal signature, making it an attractive target to aircraft, vehicles, and AT-equipped infantry.

## Known Issues

* When embarking in the listening post, it is meant to show the zone on the map in which the radar can detect enemy assets. This is currently broken in MP.
* The listening post gives you the option to get into cargo positions. This serves no functional purpose and isn't designed to be used. These positions will be removed in future updates.
* There is currently no sound to indicate that the engine is running.

## Roadmap

* Add new desert variant of the TPQ-50 listening post
* Setup proper hidden selection textures to allow people to retexture more easily.