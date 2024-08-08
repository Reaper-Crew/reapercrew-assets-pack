class CfgPatches
{
	class reaperCrew_AI_Reinforcements
	{
		units[] = {""};
		weapons[] = {""};
		vehicles[] = {""};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "cba_settings", "ReaperCrew_Common", "reaperCrew_AI_Common"};
	};
};
class Extended_PreInit_EventHandlers
{
	class reaperCrew_AI_Reinforcements_preInit
	{
		init="call compile preProcessFileLineNumbers 'rc_assets_pack\addons\reaperCrew_AI_Reinforcements\cba\XEH_preInit.sqf'";
	};
};
class cfgFactionClasses
{
	class NO_CATEGORY;
	class reaperCrew_ModulesReinforcements: NO_CATEGORY
	{
		displayName = "Reaper Crew - Reinforcements";
		scope = 2;
		scopeCurator = 2;
	};
};
class CfgEditorCategories
{
	class NO_CATEGORY;
	class reaperCrew_ModulesReinforcements: NO_CATEGORY
	{
		displayName = "Reaper Crew - Reinforcements";
		scope = 2;
		scopeCurator = 2;
	};
};
class CfgFunctions
{
	class reapercrew_reinforcements
	{
		class Effects
		{
			file = "rc_assets_pack\addons\reaperCrew_AI_Reinforcements\functions";

			class initReinforcementsSystem{postInit = 1;};

			// Spawnpoints
			class initInfantrySpawnpoint {};
			class initVehicleSpawnpoint {};
			class initAircraftSpawnpoint {};
			class initMarineSpawnpoint {};

			class initModuleInfantryFootMobile{};
			class initModuleInfantryAirbourne{};
			class initModuleInfantryMotorised{};
			class initModuleInfantryMarine{};

			class initModuleMaraudingVehicles{};
			class initModuleMaraudingAircraft{};
			class activateMaraudingVehicles{};
			class activateMaraudingAircraft{};

			class activateInfantryModuleFootMobile{};
			class activateInfantryModuleAirbourne{};
			class activateInfantryModuleMotorised{};
			class activateInfantryModuleMarine{};

			class spawnHeadlessInfantry{};
			class spawnHeadlessInfantryAirbourne{};
			class spawnHeadlessInfantryVehicle{};
			class spawnHeadlessVehicle{};

			class cleanupVehicle{};
			class getPathway{};
			class adjustGroupToVehicle{};
			class adjustGroupLeader{};
			
		};
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
			class Checkbox;				// Default checkbox (returned value is Boolean)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
		};
		// Description base classes, for more information see below
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
	class reaperCrew_moduleReinforcementsBase: Module_F
	{	
		icon = "RC_Assets_Pack\addons\reaperCrew_Common\data\insignia.paa";
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 1;
		is3DEN = 0;	
		curatorCanAttach = 1;
		scope = 1;
		scopeCurator = 1;
		functionPriority = 1;
		category = "reaperCrew_ModulesReinforcements";
	};
	class reaperCrew_moduleInfantrySpawn: reaperCrew_moduleReinforcementsBase
	{
		displayName = "Infantry Spawnpoint";
		scope = 2;
		scopeCurator = 0;
		function = "reapercrew_reinforcements_fnc_initInfantrySpawnpoint";
		class Attributes: AttributesBase {
			class additionalCondition: Edit {
				displayName = "Additional condition";
				property = "additionalCondition";
				typeName = "STRING";
				tooltip = "";
				control = "Edit";
				defaultValue = """true""";
			};
		};
	};
	class reaperCrew_modulePathWaypoint: reaperCrew_moduleReinforcementsBase
	{
		displayName = "Path Waypoint";
		scope = 2;
		scopeCurator = 0;
	};
    class reaperCrew_moduleVehicleSpawn: reaperCrew_moduleReinforcementsBase
	{
		displayName = "Vehicle Spawnpoint";
		scope = 2;
		scopeCurator = 0;
		function = "reapercrew_reinforcements_fnc_initVehicleSpawnpoint";
		class Attributes: AttributesBase {
			class additionalCondition: Edit {
				displayName = "Additional condition";
				property = "additionalCondition";
				typeName = "STRING";
				tooltip = "";
				control = "Edit";
				defaultValue = """true""";
			};
		};
	};
	class reaperCrew_moduleAircraftSpawn: reaperCrew_moduleReinforcementsBase
	{
		displayName = "Aircraft Spawnpoint";
		category = "reaperCrew_ModulesReinforcements";
		scope = 2;
		scopeCurator = 0;
		function = "reapercrew_reinforcements_fnc_initAircraftSpawnpoint";
		class Attributes: AttributesBase {
			class additionalCondition: Edit {
				displayName = "Additional condition";
				property = "additionalCondition";
				typeName = "STRING";
				tooltip = "";
				control = "Edit";
				defaultValue = """true""";
			};
		};
	};
	class reaperCrew_moduleMarineSpawn: reaperCrew_moduleReinforcementsBase
	{
		displayName = "Marine Spawnpoint";
		category = "reaperCrew_ModulesReinforcements";
		scope = 2;
		scopeCurator = 0;
		function = "reapercrew_reinforcements_fnc_initMarineSpawnpoint";
		class Attributes: AttributesBase {
			class additionalCondition: Edit {
				displayName = "Additional condition";
				property = "additionalCondition";
				typeName = "STRING";
				tooltip = "";
				control = "Edit";
				defaultValue = """true""";
			};
		};
	};
	class reaperCrew_moduleMarineLZ: reaperCrew_moduleReinforcementsBase
	{
		displayName = "Marine LZ";
		category = "reaperCrew_ModulesReinforcements";
		scope = 2;
		scopeCurator = 0;
	};


	class reaperCrew_moduleReinforcementsSpawnerBase: reaperCrew_moduleReinforcementsBase
	{
		//displayName = "Reinforcements (Infantry - Foot Mobile)";
		category = "reaperCrew_ModulesReinforcements";
		scope = 0;
		scopeCurator = 0;
		//function = "reapercrew_reinforcements_fnc_moduleSpawnHeadlessInfantry";
		canSetArea = 1;
		canSetAreaShape = 1;
		//isTriggerActivated = 1;
		class AttributeValues {
            size3[] = {50, 50, -1};
        };
		class Attributes: AttributesBase {
			#include "attributes.hpp"
		};
	};
	class reaperCrew_moduleReinforcementsHeadlessInfantry: reaperCrew_moduleReinforcementsSpawnerBase
	{
		displayName = "Reinforcements (Infantry - Foot Mobile)";
		function = "reapercrew_reinforcements_fnc_initModuleInfantryFootMobile";
		scope = 2;
		class Attributes: AttributesBase {
			#include "attributes.hpp"
		};
	};
	class reaperCrew_moduleReinforcementsHeadlessInfantryMotorised: reaperCrew_moduleReinforcementsSpawnerBase
	{
		displayName = "Reinforcements (Infantry - Motorised)";
		function = "reapercrew_reinforcements_fnc_initModuleInfantryMotorised";
		scope = 2;
		class Attributes: AttributesBase {
			#include "attributes.hpp"
			#include "randomLZAttributes.hpp"
		};
	};
	class reaperCrew_moduleReinforcementsHeadlessInfantryHelicopter: reaperCrew_moduleReinforcementsSpawnerBase
	{
		displayName = "Reinforcements (Infantry - Helicopter)";
		function = "reapercrew_reinforcements_fnc_initModuleInfantryAirbourne";
		scope = 2;
		class Attributes: AttributesBase {
			#include "attributes.hpp"
			#include "randomLZAttributes.hpp"
		};
	};
	class reaperCrew_moduleReinforcementsHeadlessInfantryMarine: reaperCrew_moduleReinforcementsSpawnerBase
	{
		displayName = "Reinforcements (Infantry - Marine)";
		function = "reapercrew_reinforcements_fnc_initModuleInfantryMarine";
		scope = 2;
		class Attributes: AttributesBase {
			#include "attributes.hpp"
		};
	};
	class reaperCrew_moduleReinforcementsHeadlessMaraudingVehicles: reaperCrew_moduleReinforcementsSpawnerBase
	{
		displayName = "Marauding Vehicles";
		function = "reapercrew_reinforcements_fnc_initModuleMaraudingVehicles";
		scope = 2;
		class Attributes: AttributesBase {
			class vehicleCount: Edit {
				displayName = "Vehicle Count";
				property = "vehicleCount";
				typeName = "NUMBER";
				tooltip = "The total number of vehicles that this spawn point can produce";
				control = "Edit";
				defaultValue = "25";
			};
			class vehicleFrequencyMin: Edit {
				displayName = "Vehicle Frequency Min (seconds)";
				property = "vehicleFrequencyMin";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "180";
			};
			class vehicleFrequencyMax: Edit {
				displayName = "Vehicle Frequency Max(seconds)";
				property = "vehicleFrequencyMax";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "240";
			};
			class heavyArmour: Checkbox {
				displayName = "Heavy Armour";
				property = "HeavyArmour";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "true";
			};
			class lightArmour: Checkbox {
				displayName = "Light Armour";
				property = "LightArmour";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "true";
			};
			class technicals: Checkbox {
				displayName = "Tehnicals";
				property = "Technicals";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "true";
			};
		};
	};
	class reaperCrew_moduleReinforcementsHeadlessMaraudingAircrafts: reaperCrew_moduleReinforcementsSpawnerBase
	{
		displayName = "Marauding Aircraft";
		function = "reapercrew_reinforcements_fnc_initModuleMaraudingAircraft";
		scope = 2;
		class Attributes: AttributesBase {
			class AircraftCount: Edit {
				displayName = "Aircraft Count";
				property = "AircraftCount";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "25";
			};
			class AircraftFrequencyMin: Edit {
				displayName = "Aircraft Frequency Min (seconds)";
				property = "AircraftFrequencyMin";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "180";
			};
			class AircraftFrequencyMax: Edit {
				displayName = "Aircraft Frequency Max(seconds)";
				property = "AircraftFrequencyMax";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "240";
			};

			class fixedWingBombers: Checkbox {
				displayName = "Fixed Wing (Bombers)";
				property = "fixedWingBombers";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "true";
			};
			class fixedWingFighters: Checkbox {
				displayName = "Fixed Wing (Fighters)";
				property = "fixedWingFighters";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "true";
			};
			class rotaryCASHeavy: Checkbox {
				displayName = "Rotary CAS (Heavy)";
				property = "rotaryCASHeavy";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "true";
			};
			class rotaryCASLight: Checkbox {
				displayName = "Rotary CAS (Light)";
				property = "rotaryCASLight";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "true";
			};

		};
	};
};