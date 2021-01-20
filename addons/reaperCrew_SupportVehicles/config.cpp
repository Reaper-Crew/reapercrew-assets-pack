class CfgPatches
{
	class reaperCrew_SupportVehicles
	{
		units[] = {"RC_airDefenceTurret", "RC_airDefenceRadar"};
		weapons[] = {""};
		vehicles[] = {"RC_airDefenceTurret", "RC_airDefenceRadar"};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "cba_settings"};
	};
};
class CfgAddons 
{
	class PreloadAddons 
	{
		class reaperCrew_SupportVehicles
		{
			list[] = 
			{
				"reaperCrew_SupportVehicles"
			};
		};
	};
};
class CfgVehicles
{
    class B_Truck_01_flatbed_F;
    class B_Truck_01_mover_F;

    class RC_airDefenceTurret: B_Truck_01_flatbed_F {
        faction = "reaperCrew";
        editorSubcategory = "EdSubcat_AAs";
        displayName = "HEMTT (CIWS Turret)";
        scope = 2;
		scopeCurator = 2;
        editorPreview = "reaperCrew_SupportVehicles\data\hemtt_ciws.paa";
        class EventHandlers {
            init = "[(_this select 0)] call reapercrew_fnc_initAirDefenceTurretTruck";
        };
    };
    class RC_airDefenceRadar: B_Truck_01_mover_F {
        faction = "reaperCrew";
        editorSubcategory = "EdSubcat_AAs";
        displayName = "HEMTT (Radar System)";
        scope = 2;
		scopeCurator = 2;
        editorPreview = "reaperCrew_SupportVehicles\data\hemtt_radar.paa";
        class EventHandlers {
            init = "[(_this select 0)] call reapercrew_fnc_initAirDefenceRadarTruck";
        };
    };
};