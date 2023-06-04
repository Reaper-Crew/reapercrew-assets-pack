class reaperCrew_Sentinel_base: reaperCrew_counterBattery_base {
	displayName="Sentinel Radar";
	model="rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\Sentinel.p3d";
	class counterBattery: counterBattery {};
	class EventHandlers : EventHandlers {};
	class ACE_Actions: ACE_Actions {
		class ACE_MainActions: ACE_MainActions {};
	};
	slingLoadCargoMemoryPoints[] = {
		"SlingLoadCargo1",
		"SlingLoadCargo2",
		"SlingLoadCargo3",
		"SlingLoadCargo4"
	};
	class AnimationSources {
		class RadarRotate {
			AnimPeriod = 1;				// mandatory. in seconds.
			source = "user";			// optional. default = user
			InitPhase = 1;				// optional. default = 0
			// weapon = WeaponClassName;	// only for source = reload;
		};
	};
	hiddenSelections[] = {"Sentinel_Chasis", "Sentinel_Radar", "Sentinel_Accessories", "Sentinel_Unit"};
	hiddenSelectionsTextures[]= {
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Chasis_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Radar_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Accessories_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Unit_CO.paa"
	};
};

class reaperCrew_Sentinel_west: reaperCrew_Sentinel_base {
	side = 1;
	typicalCargo[] = {"B_UAV_AI"};

};
class reaperCrew_Sentinel_west_wdl: reaperCrew_Sentinel_west {
	scope=2;
	scopeCurator=2;
	hiddenSelectionsTextures[]= {
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Chasis_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Radar_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Accessories_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Unit_CO.paa"
	};
};
class reaperCrew_Sentinel_west_dst: reaperCrew_Sentinel_west {
	scope=2;
	scopeCurator=2;
	hiddenSelectionsTextures[]= {
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Desert\Sentinel_Chasis_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Desert\Sentinel_Radar_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Desert\Sentinel_Accessories_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Desert\Sentinel_Unit_CO.paa"
	};
};

class reaperCrew_Sentinel_east: reaperCrew_Sentinel_base {
	side = 0;
	typicalCargo[] = {"O_UAV_AI"};	
};
class reaperCrew_Sentinel_east_wdl: reaperCrew_Sentinel_east {
	scope=2;
	scopeCurator=2;
	hiddenSelectionsTextures[]= {
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Chasis_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Radar_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Accessories_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Unit_CO.paa"
	};
};
class reaperCrew_Sentinel_east_dst: reaperCrew_Sentinel_east {
	scope=2;
	scopeCurator=2;
	hiddenSelectionsTextures[]= {
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Desert\Sentinel_Chasis_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Desert\Sentinel_Radar_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Desert\Sentinel_Accessories_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Desert\Sentinel_Unit_CO.paa"
	};
};

class reaperCrew_Sentinel_independent: reaperCrew_Sentinel_base {
	side = 2;
	typicalCargo[] = {"I_UAV_AI"};	
};
class reaperCrew_Sentinel_independent_wdl: reaperCrew_Sentinel_independent {
	scope=2;
	scopeCurator=2;
	hiddenSelectionsTextures[]= {
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Chasis_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Radar_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Accessories_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Woodland\Sentinel_Unit_CO.paa"
	};
};
class reaperCrew_Sentinel_independent_dst: reaperCrew_Sentinel_independent {
	scope=2;
	scopeCurator=2;
	hiddenSelectionsTextures[]= {
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Desert\Sentinel_Chasis_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Desert\Sentinel_Radar_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Desert\Sentinel_Accessories_CO.paa",
		"rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\radarUnits\SentinelRadar\textureSets\Desert\Sentinel_Unit_CO.paa"
	};
};