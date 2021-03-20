class CfgPatches
{
	class reaperCrew_Modules
	{
		units[] = {"reaperCrew_moduleGarrison", "reaperCrew_moduleDisarmPlayers", "reaperCrew_moduleScanArea", "reaperCrew_moduleResupplyPoint"};
		weapons[] = {""};
		vehicles[] = {""};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "cba_settings"};
	};
};
class CfgAddons 
{
	class PreloadAddons 
	{
		class reaperCrew_Modules
		{
			list[] = 
			{
				"reaperCrew_Modules"
			};
		};
	};
};
class CfgFactionClasses
{
	class NO_CATEGORY;
	class reaperCrew_Modules: NO_CATEGORY
	{
		displayName = "Reaper Crew";
		scope = 2;
		scopeCurator = 2;
	};
};
class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit;					// Default edit box (i.e., text input field)
			class Combo;				// Default combo box (i.e., drop-down menu)
			class Checkbox;				// Default checkbox (returned value is Bool)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
		};
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
	class reaperCrew_module_base: Module_F
	{	
		icon = "\reaperCrew_Common\data\insignia.paa";
		category = "reaperCrew_Modules";
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 1;
		is3DEN = 0;	
		curatorCanAttach = 1;
		scope = 1;
		scopeCurator = 1;
		functionPriority = 1;
	};
	class reaperCrew_moduleDisarmPlayers: reaperCrew_module_base
	{
		displayName = "Disarm all players";
		function = "reaperCrew_fnc_disarmModuleInit";
		scope = 1;
		scopeCurator = 2;
		isGlobal = 0;
	};
	class reaperCrew_moduleScanArea: reaperCrew_module_base
	{
		displayName = "Scan area";
		function = "reaperCrew_fnc_scanAreaModuleInit";
		scope = 1;
		scopeCurator = 2;
		isGlobal = 1;
		isTriggerActivated = 0;
		curatorCanAttach = 1;
	};
	class reaperCrew_moduleGarrison: reaperCrew_module_base
	{
		displayName = "Garrison Area (5 per building, 50m radius)";
		function = "reaperCrew_fnc_garrisonModuleInit";
		scope = 1;
		scopeCurator = 2;
	};
	class reaperCrew_moduleResupplyPoint: reaperCrew_module_base
	{
		displayName = "Resupply Point";
		function = "reaperCrew_fnc_logisticsModuleInit";
		scope = 2;
		scopeCurator = 2;
		isGlobal = 1;
		isTriggerActivated = 0;
		curatorCanAttach = 1;
	};
};