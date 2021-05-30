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
            class disarmModuleInit{};
			class disarmModuleKitChange{};
            class garrisonModuleInit{};
			class garrisonModuleWaypoint{};
            class scanAreaModuleInit{};
			class initAirDefenceTurretTruck{};
			class initAirDefenceRadarTruck{};
			//class primaryWeaponFix{};
		};
	};
};

class Extended_PreInit_EventHandlers
{
	class reaperCrew_logistics_functions
	{
		init="call compile preProcessFileLineNumbers '\reaperCrew_Functions\cba\XEH_preInit.sqf'";
	};
};