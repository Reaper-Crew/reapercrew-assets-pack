#include "BIS_AddonInfo.hpp"
class CfgPatches
{
	class Xeenenta_Modules
	{
		units[] = {"xeen_moduleGarrison", "xeen_moduleForwardObserver"};
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
		class Xeenenta_Modules
		{
			list[] = 
			{
				"Xeenenta_Modules"
			};
		};
	};
};
class CfgFactionClasses
{
	class NO_CATEGORY;
	class xeen_modules: NO_CATEGORY
	{
		displayName = "Xeenenta's Modules";
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
	class xeen_module_base: Module_F
	{	
		icon = "\xeen_modules\insignia.paa";
		category = "xeen_modules";
		isGlobal = 0;
		isTriggerActivated = 1;
		isDisposable = 1;
		is3DEN = 0;	
		curatorCanAttach = 1;
		scope = 1;
		scopeCurator = 1;
	};

	class xeen_moduleGarrison: xeen_module_base
	{
		displayName = "Garrison Area";
		function = "xeen_fnc_garrisonModuleDialog";
		functionPriority = 10;
		scope = 2;
		scopeCurator = 2;	
		class Attributes: AttributesBase
		{
			class GarrisonSpread: Edit
			{
				property = "xeen_moduleGarrison_GarrisonSpread";
				displayName = "Unit Spread (m)";
				tooltip = "The distance of buildings to be garrisoned";
				typeName = "NUMBER";
				defaultValue = "50";
			};
			class MaxPerBuilding: Edit
			{
				property = "xeen_moduleGarrison_MaxPerBuilding";
				displayName = "Max units per building";
				tooltip = "Max units per building";
				typeName = "NUMBER";
				defaultValue = "5";
			};
			//class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};
		#include "description.hpp"
	};
	class xeen_moduleForwardObserver: xeen_module_base
	{
		displayName = "Forward Observer";
		function = "xeen_fnc_observerModuleInit";
		functionPriority = 10;
		curatorInfoType = "testView";
		scope = 2;
		scopeCurator = 2;
		isGlobal = 1;
		class Attributes: AttributesBase
		{
			class Units: Units
			{
				property = "xeen_modulefo_Units";
			};
			class SupportType: Combo
			{
				property = "xeen_modulefo_Ordinance";
				displayName = "Ordinance";
				tooltip = "What ordinance should be used";
				typeName = "STRING";
				defaultValue = "82mm";
				class Values
				{
					class 82mm	{
						name = "82mm Mortar";
						value = "82mm";
					};
					class 105mm	{
						name = "155mm Mortar";
						value = "155mm";
					};
					class plane_Gun {
						name = "Plane (Gun Run)";
						value = "planeGunRun";
					};
					class plane_Missiles {
						name = "Plane (Missiles)";
						value = "planeMissiles";
					};
					class plane_GunMissiles {
						name = "Plane (Gun + Missiles)";
						value = "planeGunMissiles";
					};
					class plane_BombStrike {
						name = "Plane (Bomb Strike)";
						value = "planeBombStrike";
					};
					class plane_random {
						name = "Plane (Random)";
						value = "planeRandom";
					};
				};
			};
			class retryTime: Edit
			{
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "xeen_modulefo_retryTime";
				displayName = "Retry Time"; // Argument label
				tooltip = "How often the observers should attempt to perform a strike"; // Tooltip description
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "240"; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
			};
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};
	};
};
class CfgFunctions
{
	class xeen
	{
		class Effects
		{
			file = "\xeen_modules\functions";
			class garrisonModuleInit{};
			class garrisonModuleWaypoint{};
			class garrisonModuleDialog{};
			class observerModuleCAS{};
			class observerModuleIDF{};
			class observerModuleBehavior{};
			class observerModuleInit{};
		};
	};
};

class Extended_PreInit_EventHandlers
{
	class my_preInit
	{
		init="call compile preProcessFileLineNumbers '\xeen_modules\cba\XEH_preInit.sqf'";
	};
};

#include "ui\moduleUIMain.hpp"
#include "ui\garrisonModuleDialog.hpp"

