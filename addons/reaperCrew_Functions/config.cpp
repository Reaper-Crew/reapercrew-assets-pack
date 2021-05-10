class CfgPatches
{
	class Xeenenta_Modules
	{
		units[] = {""};
		weapons[] = {""};
		vehicles[] = {""};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "cba_settings"};
	};
};
class CfgFunctions
{
	class reapercrew
	{
		class Effects
		{
			file = "\reaperCrew_Functions\functions";
			class setACRESettings{
				preInit = 1;
				postInit = 1;
				preStart = 1;
			};
			class setPersonalACRESettingsLocal{};
			class setPersonalACRESettingsServer{
				postInit = 1;
			};
			class logisticsCreateSupplyCrate{};
			class logisticsPopulateSupplyCrate{};
			class logisticsAddActions{};
			class logisticsModuleInit{};
            class disarmModuleInit{};
			class disarmModuleKitChange{};
            class garrisonModuleInit{};
			class garrisonModuleWaypoint{};
            class scanAreaModuleInit{};
			class initAirDefenceTurretTruck{};
			class initAirDefenceRadarTruck{};
			class CoverMap{};
			class setUnitInsigniaGlobal{
				postInit = 1;
			};
			class setUnitInsigniaLocal{};
			class primaryWeaponFix{};
		};
	};
};

class Extended_PreInit_EventHandlers
{
	class my_preInit
	{
		init="call compile preProcessFileLineNumbers '\reaperCrew_Functions\cba\XEH_preInit.sqf'";
	};
};