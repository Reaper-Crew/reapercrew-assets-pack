# Textures

## Billboards

### General

* rc_assets_pack\addons\reaperCrew_Common\data\general_bcrMusterPoint.paa
* rc_assets_pack\addons\reaperCrew_Common\data\general_briefingZone.paa
* rc_assets_pack\addons\reaperCrew_Common\data\general_standardLogo.paa
* rc_assets_pack\addons\reaperCrew_Common\data\insignia.paa
* rc_assets_pack\addons\reaperCrew_Common\data\reaperLogo.paa
* rc_assets_pack\addons\reaperCrew_Common\data\general_channels.paa
* rc_assets_pack\addons\reaperCrew_Common\data\general_communications.paa

### Callsigns

* rc_assets_pack\addons\reaperCrew_Common\data\billboard_zero.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_reaper11.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_reaper12.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_reaper13.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_reaper14.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_reaper15.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_reaper16.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_viper.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_ugly.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_shadow.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_phantom.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_hammer.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_fury.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_foxhound.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_thunder.paa
* rc_assets_pack\addons\reaperCrew_Common\data\billboard_sentinel.paa

# Marker Colours

`reaperCrew_Common` adds nine callsign marker colours, one visually distinct colour per element. They appear in the marker colour dropdown in Eden, Zeus and the in-game map alongside the vanilla palette (the vanilla colours remain available), and can be used from script with `setMarkerColor`.

| Classname | Display Name | RGB |
|-----------|--------------|-----|
| `reaperCrew_ColorZero` | Zero | 1.0, 0.75, 0.0 |
| `reaperCrew_ColorReaper1` | Reaper-1-1 | 0.15, 0.4, 0.9 |
| `reaperCrew_ColorReaper2` | Reaper-1-2 | 0.85, 0.1, 0.1 |
| `reaperCrew_ColorReaper3` | Reaper-1-3 | 0.1, 0.65, 0.15 |
| `reaperCrew_ColorReaper4` | Reaper-1-4 | 0.6, 0.2, 0.85 |
| `reaperCrew_ColorHammer` | Hammer | 1.0, 0.5, 0.0 |
| `reaperCrew_ColorThunder` | Thunder | 0.0, 0.75, 0.8 |
| `reaperCrew_ColorSentinel` | Sentinel | 1.0, 0.25, 0.6 |
| `reaperCrew_ColorFury` | Fury | 0.55, 0.8, 0.1 |

```sqf
"marker_reaper11" setMarkerColor "reaperCrew_ColorReaper1";
```
