# Logistcal System

## Overview

The logistical system is our in-house system for spawning resupply crates and other resources during operations. Utilising this system to spawn crates only when required, reduces the number of objects on the map and allows us to avoid having a bunch of resupply crates in the spawn area.

## Quick Start

To get started, place an object that you'd like to use as your resupply point. It can be any object you'd like, but ideally we like to use a single cargo container, since it looks the part and doesn't take up much space.

Next, go to `Systems (F5) > Modules > Reaper Crew - Logistics > Resupply Point` and place the module next to the cargo container.

Then, syncronise the module to the cargo container.

![](https://imgur.com/eO3Wqxb.png)

The settings for this resupply module can be found in the addon settings under 'Reaper Crew - Logistics'. You can add a comma seperated list of classnames for each category, and simply leave a category blank if you don't have any magazines of that type you'd like to add.

*Note: A simple way to get these classnames is by using the Export function on the BI Virtual Arsenel.*

![](https://imgur.com/5GlZ3tx.png)

Make sure to save these settings under the 'mission' settings, rather than the server or client settings.

## Vehicle Deliveries

The Vehicle Delivery system is designed to allow players to replenish vehicles lost during operations. It is particularly necessary when dealing with assets that cannot be loaded into other vehicles, such as tanks, SPGs and some cars. 

Once requested, the vehicle will be driven by AI to the players location. During this time it will be immune from all damage, this is to prevent vehicles accidently becoming broken or damaged owing to the AI's love for smashing into trees and other objects. This immunity from damage is removed once the the waypoint is reached, and the AI driver will be automatically deleted. It is important to wait for the waypoint to complete fully to avoid any issues with vehicles being immunue to damage.

The settings for this system are defined under 'Reaper Crew - Logistics'.

* Deliverable Vehicles - A comma seperated list of vehicles that can be requested
* Permitted Groups - A comma seperated list of group callsigns that can request vehicles

Once configured, vehicles can be requested by ACE Self Interact > Equipment > Select vehicle

![Imgur](https://imgur.com/1Le3H6U.png)