# Textures

## Billboards

### General

Informational boards, in the same placard style as the callsign signs.

* rc_assets_pack\addons\reaperCrew_Common\data\general_briefingZone.paa
* rc_assets_pack\addons\reaperCrew_Common\data\general_bcrMusterPoint.paa
* rc_assets_pack\addons\reaperCrew_Common\data\general_communications.paa
* rc_assets_pack\addons\reaperCrew_Common\data\general_channels.paa

`general_channels.paa` lists the whole callsign matrix on one board, so it needs remaking
whenever a channel changes.

Brand artwork, not signage.

* rc_assets_pack\addons\reaperCrew_Common\data\general_standardLogo.paa
* rc_assets_pack\addons\reaperCrew_Common\data\insignia.paa
* rc_assets_pack\addons\reaperCrew_Common\data\reaperLogo.paa

### Callsigns

Each sign states its callsign and the block and channel that callsign's PRR is tuned to.
There is one sign per callsign, including the bare name for an asset deploying alone, so
pick the sign matching the group name the element actually uses. Listed in channel order.

* rc_assets_pack\addons\reaperCrew_Common\data\billboard_reaper11.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_reaper12.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_reaper13.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_reaper14.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_thunder.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_hammer.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_fury.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_fury1.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_fury2.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_fury3.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_shadow.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_anvil.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_zero.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_sentinel.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_sentinel1.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_sentinel2.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_sentinel3.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_sentry.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_foxhound.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_foxhound1.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_foxhound2.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_foxhound3.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_viper.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_phantom.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_phantom1.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_phantom2.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_ugly.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_ugly1.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_ugly2.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_ugly3.paa

# Marker Colours

`reaperCrew_Common` adds a CC1 colour for markers that concern the whole platoon and eleven callsign colours, one visually distinct colour per element. They appear in the marker colour dropdown in Eden, Zeus and the in-game map alongside the vanilla palette (the vanilla colours remain available), and can be used from script with `setMarkerColor`. They are listed after the vanilla colours in the dropdown, which is an engine behaviour an addon cannot change: added colours are always appended to the base-game set.

| Classname | Display Name | RGB |
|-----------|--------------|-----|
| `reaperCrew_ColorCC1` | CC1 | 0.0, 0.8, 0.0 |
| `reaperCrew_ColorZero` | Zero | 1.0, 0.75, 0.0 |
| `reaperCrew_ColorReaper1` | Reaper-1-1 | 0.15, 0.4, 0.9 |
| `reaperCrew_ColorReaper2` | Reaper-1-2 | 0.85, 0.1, 0.1 |
| `reaperCrew_ColorReaper3` | Reaper-1-3 | 0.1, 0.65, 0.15 |
| `reaperCrew_ColorReaper4` | Reaper-1-4 | 0.6, 0.2, 0.85 |
| `reaperCrew_ColorHammer` | Hammer | 1.0, 0.5, 0.0 |
| `reaperCrew_ColorThunder` | Thunder | 0.0, 0.75, 0.8 |
| `reaperCrew_ColorSentinel` | Sentinel | 1.0, 0.25, 0.6 |
| `reaperCrew_ColorFury` | Fury | 0.55, 0.8, 0.1 |
| `reaperCrew_ColorAnvil` | Anvil | 0.0, 0.85, 0.5 |
| `reaperCrew_ColorSentry` | Sentry | 0.85, 0.1, 0.75 |

CC1 takes the same value as the vanilla `ColorGreen`, which is the colour already used across all callsigns for platoon-wide markers. The two entries look identical in the dropdown; pick `reaperCrew_ColorCC1` so the intent is readable.

The vanilla `colorCivilian` entry is the one used for aviation markers, so it is shown in the dropdown as **Aviation**. It has no fixed RGB: it inherits `ColorCIV`, which reads each player's own map colour settings, so the literal colour differs per player and its alpha is 0.8 rather than the 1 used by the entries above.

```sqf
"marker_reaper11" setMarkerColor "reaperCrew_ColorReaper1";
```
