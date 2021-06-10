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
