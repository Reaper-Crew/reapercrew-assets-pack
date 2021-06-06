class CfgPatches
{
	class reaperCrew_Reinforcements
	{
		units[] = {""};
		weapons[] = {""};
		vehicles[] = {""};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "cba_settings", "ReaperCrew_Common"};
	};
};
class Extended_PreInit_EventHandlers
{
	class reaperCrew_reinforcements_preInit
	{
		init="call compile preProcessFileLineNumbers '\reaperCrew_Reinforcements\cba\XEH_preInit.sqf'";
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
			file = "\reaperCrew_Reinforcements\functions";
			class initReinforcements{
				postInit = 1;
			};
			class cleanupVehicle{};
			class spawnHeadlessInfantry{};
			class spawnHeadlessInfantryVehicle{};
			class spawnHeadlessInfantryHelicopter{};
			class spawnHeadlessVehicle{};
			class moduleSpawnHeadlessInfantry{};
			class moduleSpawnHeadlessInfantryVehicle{};
			class moduleSpawnHeadlessInfantryAircraft{};
			class moduleSpawnHeadlessMaraudingVehicles{};
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
	class reaperCrew_module_reinforcements_base: Module_F
	{	
		icon = "\reaperCrew_Common\data\insignia.paa";
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 1;
		is3DEN = 0;	
		curatorCanAttach = 1;
		scope = 1;
		scopeCurator = 1;
		functionPriority = 1;
	};
	class reaperCrew_moduleInfantrySpawn: reaperCrew_module_reinforcements_base
	{
		displayName = "Infantry Spawnpoint";
		category = "reaperCrew_ModulesReinforcements";
		scope = 2;
		scopeCurator = 0;
	};
    class reaperCrew_moduleVehicleSpawn: reaperCrew_module_reinforcements_base
	{
		displayName = "Vehicle Spawnpoint";
		category = "reaperCrew_ModulesReinforcements";
		scope = 2;
		scopeCurator = 0;
	};
	class reaperCrew_moduleAircraftSpawn: reaperCrew_module_reinforcements_base
	{
		displayName = "Aircraft Spawnpoint";
		category = "reaperCrew_ModulesReinforcements";
		scope = 2;
		scopeCurator = 0;
	};
	class reaperCrew_moduleReinforcementsBase: reaperCrew_module_reinforcements_base
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
            size3[] = {5, 5, -1};
        };
		class Attributes: AttributesBase {
			class reinforcementCount: Edit {
				displayName = "Reinforcement Count";
				property = "reinforcementCount";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "50";
			};
			class zoneThreshold: Edit {
				displayName = "Zone Threshold";
				property = "zoneThreshold";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "20";
			};
		};
	};
	class reaperCrew_moduleReinforcementsHeadlessInfantry: reaperCrew_moduleReinforcementsBase
	{
		displayName = "Reinforcements (Infantry - Foot Mobile)";
		function = "reapercrew_reinforcements_fnc_moduleSpawnHeadlessInfantry";
		scope = 2;
	};
	class reaperCrew_moduleReinforcementsHeadlessInfantryMotorised: reaperCrew_moduleReinforcementsBase
	{
		displayName = "Reinforcements (Infantry - Motorised)";
		function = "reapercrew_reinforcements_fnc_moduleSpawnHeadlessInfantryVehicle";
		scope = 2;
		class Attributes: AttributesBase {
			class reinforcementCount: Edit {
				displayName = "Reinforcement Count";
				property = "reinforcementCount";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "50";
			};
			class zoneThreshold: Edit {
				displayName = "Zone Threshold";
				property = "zoneThreshold";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "20";
			};
			class directionMin: Edit {
				displayName = "Direction Minimum";
				property = "directionMin";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "90";
			};
			class directionMax: Edit {
				displayName = "Direction Maximum";
				property = "directionMax";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "180";
			};
			class distanceMin: Edit {
				displayName = "Distance Minimum";
				property = "distanceMin";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "500";
			};
			class distanceMax: Edit {
				displayName = "Distance Maximum";
				property = "distanceMax";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "800";
			};
		};
	};
	class reaperCrew_moduleReinforcementsHeadlessInfantryHelicopter: reaperCrew_moduleReinforcementsBase
	{
		displayName = "Reinforcements (Infantry - Helicopter)";
		function = "reapercrew_reinforcements_fnc_moduleSpawnHeadlessInfantryAircraft";
		scope = 2;
		class Attributes: AttributesBase {
			class reinforcementCount: Edit {
				displayName = "Reinforcement Count";
				property = "reinforcementCount";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "50";
			};
			class zoneThreshold: Edit {
				displayName = "Zone Threshold";
				property = "zoneThreshold";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "20";
			};
			class directionMin: Edit {
				displayName = "Direction Minimum";
				property = "directionMin";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "90";
			};
			class directionMax {
				displayName = "Direction Maximum";
				property = "directionMax";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "180";
			};
			class distanceMin: Edit {
				displayName = "Distance Minimum";
				property = "distanceMin";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "500";
			};
			class distanceMax: Edit {
				displayName = "Distance Maximum";
				property = "distanceMax";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "800";
			};
		};
	};
	class reaperCrew_moduleReinforcementsHeadlessMaraudingVehicles: reaperCrew_moduleReinforcementsBase
	{
		displayName = "Marauding Vehicles";
		function = "reapercrew_reinforcements_fnc_moduleSpawnHeadlessMaraudingVehicles";
		scope = 2;
		class Attributes: AttributesBase {
			class vehicleCount: Edit {
				displayName = "Vehicle Count";
				property = "vehicleCount";
				typeName = "NUMBER";
				tooltip = "";
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
			class vehicleType: Edit {
				displayName = "Vehicle Types";
				property = "vehicleType";
				typeName = "NUMBER";
				tooltip = "";
				control = "Combo";
				defaultValue = "0";
				class Values
				{
					class randomSelection	{name = "Random Mix";	value = 0;}; // Listbox item
					class HeavyArmour	{name = "Heavy Armour"; value = 1; };
					class LightArmour	{name = "Light Armour"; value = 2; };
					class Technicals	{name = "Technicals"; value = 3; };
				};
			};
		};
	};
};