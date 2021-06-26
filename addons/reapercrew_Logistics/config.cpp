class CfgPatches
{
	class reaperCrew_Logistics
	{
		units[] = {""};
		weapons[] = {""};
		vehicles[] = {""};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "cba_settings", "ReaperCrew_Common"};
	};
};
class CfgFunctions
{
	class reapercrew_logistics
	{
		class Effects
		{
			file = "\reapercrew_Logistics\functions";
			class logisticsCreateSupplyCrate{};
			class logisticsPopulateSupplyCrate{};
			class logisticsCreateFuelSource{};
			class logisticsCreateAmmoSource{};
			class logisticsAddActions{};
			class logisticsModuleInit{};
		};
	};
};
class CfgVehicles
{
	class reaperCrew_module_base;
	class reaperCrew_moduleResupplyPoint: reaperCrew_module_base
	{
		displayName = "Resupply Point";
		function = "reapercrew_logistics_fnc_logisticsModuleInit";
		category = "reaperCrew_ModulesLogistics";
		scope = 2;
		scopeCurator = 2;
		isGlobal = 1;
		isTriggerActivated = 0;
		curatorCanAttach = 1;
	};
};
class Extended_PreInit_EventHandlers
{
	class reaperCrew_logistics_preInit
	{
		init="call compile preProcessFileLineNumbers '\reapercrew_Logistics\cba\XEH_preInit.sqf'";
	};
};