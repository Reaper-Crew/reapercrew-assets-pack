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
		init="call compile preProcessFileLineNumbers '\reaperCrew_AI_Reinforcements\cba\XEH_preInit.sqf'";
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
			file = "\reaperCrew_AI_Reinforcements\functions";

			class initReinforcementsSystem{postInit = 1;};

			class initInfantrySpawnpoint {};
			class initVehicleSpawnpoint {};
			class initAircraftSpawnpoint {};

			class initModuleInfantryFootMobile{};
			class initModuleInfantryAirbourne{};
			class initModuleInfantryMotorised{};

			class initModuleMaraudingVehicles{};
			class initModuleMaraudingAircraft{};
			class activateMaraudingVehicles{};
			class activateMaraudingAircraft{};

			class activateInfantryModuleFootMobile{};
			class activateInfantryModuleAirbourne{};
			class activateInfantryModuleMotorised{};

			class spawnHeadlessInfantry{};
			class spawnHeadlessInfantryAirbourne{};
			class spawnHeadlessInfantryVehicle{};
			class spawnHeadlessVehicle{};

			class cleanupVehicle{};
			
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
		category = "reaperCrew_ModulesReinforcements";
	};
	class reaperCrew_moduleInfantrySpawn: reaperCrew_module_reinforcements_base
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
    class reaperCrew_moduleVehicleSpawn: reaperCrew_module_reinforcements_base
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

	
	class reaperCrew_moduleAircraftSpawn: reaperCrew_module_reinforcements_base
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
	};
	class reaperCrew_moduleReinforcementsHeadlessInfantry: reaperCrew_moduleReinforcementsBase
	{
		displayName = "Reinforcements (Infantry - Foot Mobile)";
		function = "reapercrew_reinforcements_fnc_initModuleInfantryFootMobile";
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
			class regularTroops: Checkbox {
				displayName = "Regular Troops";
				property = "regularTroops";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "true";
			};
			class eliteTroops: Checkbox {
				displayName = "Elite Troops";
				property = "eliteTroops";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "false";
			};
			class specialTroops: Checkbox {
				displayName = "Special Forces";
				property = "specialTroops";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "false";
			};
			class rushMode: Checkbox {
				displayName = "Enable Rush Mode";
				property = "rushMode";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "false";
			};
		};
	};
	class reaperCrew_moduleReinforcementsHeadlessInfantryMotorised: reaperCrew_moduleReinforcementsBase
	{
		displayName = "Reinforcements (Infantry - Motorised)";
		function = "reapercrew_reinforcements_fnc_initModuleInfantryMotorised";
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
			class regularTroops: Checkbox {
				displayName = "Regular Troops";
				property = "regularTroops";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "true";
			};
			class eliteTroops: Checkbox {
				displayName = "Elite Troops";
				property = "eliteTroops";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "false";
			};
			class specialTroops: Checkbox {
				displayName = "Special Forces";
				property = "specialTroops";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "false";
			};
			class rushMode: Checkbox {
				displayName = "Enable Rush Mode";
				property = "rushMode";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "false";
			};
		};
	};
	class reaperCrew_moduleReinforcementsHeadlessInfantryHelicopter: reaperCrew_moduleReinforcementsBase
	{
		displayName = "Reinforcements (Infantry - Helicopter)";
		function = "reapercrew_reinforcements_fnc_initModuleInfantryAirbourne";
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
			class regularTroops: Checkbox {
				displayName = "Regular Troops";
				property = "regularTroops";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "true";
			};
			class eliteTroops: Checkbox {
				displayName = "Elite Troops";
				property = "eliteTroops";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "false";
			};
			class specialTroops: Checkbox {
				displayName = "Special Forces";
				property = "specialTroops";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "false";
			};
			class rushMode: Checkbox {
				displayName = "Enable Rush Mode";
				property = "rushMode";
				typeName = "BOOL";
				tooltip = "";
				control = "Checkbox";
				defaultValue = "false";
			};
		};
	};
	class reaperCrew_moduleReinforcementsHeadlessMaraudingVehicles: reaperCrew_moduleReinforcementsBase
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
	class reaperCrew_moduleReinforcementsHeadlessMaraudingAircrafts: reaperCrew_moduleReinforcementsBase
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