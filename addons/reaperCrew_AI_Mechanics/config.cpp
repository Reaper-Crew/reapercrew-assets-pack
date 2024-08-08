class CfgPatches
{
	class ReaperCrew_AI_Mechanics
	{
		units[] = {"reaperCrew_module_ai_mechanics_base", "reaperCrew_moduleGarrison", "reaperCrew_moduleSuppressPosition", "reaperCrew_moduleAwesomeConvoy"};
		weapons[]={""};
		requiredVersion=1;
		requiredAddons[] = {"A3_Modules_F", "cba_settings", "ReaperCrew_Common", "reaperCrew_AI_Common", "myTag_addonName"};
	};
};
class cfgFactionClasses
{
	class NO_CATEGORY;
	class reaperCrew_ModulesAIMechanics: NO_CATEGORY
	{
		displayName = "Reaper Crew - AI Mechanics";
		scope = 2;
		scopeCurator = 2;
	};
};
class CfgEditorCategories
{
	class NO_CATEGORY;
	class reaperCrew_ModulesAIMechanics: NO_CATEGORY
	{
		displayName = "Reaper Crew - AI Mechanics";
		scope = 2;
		scopeCurator = 2;
	};
};
class CfgFunctions
{
	class reapercrew_ai_mechanics
	{
		class Effects
		{
			file = "rc_assets_pack\addons\reaperCrew_AI_Mechanics\functions";
			class initGarrisonModule{};
			class initSuppressPosition{};
			class activateSuppressPosition{};
			class activateGarrisonModule{};
			class remoteGarrisonSpawn{};
			class initConvoySetup{};
			class activateConvoySetup{};
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
	class reaperCrew_module_ai_mechanics_base: Module_F
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
		category = "reaperCrew_ModulesAIMechanics";
	};
	class reaperCrew_moduleGarrison: reaperCrew_module_ai_mechanics_base
	{
		displayName = "Garrison Area";
		function = "reapercrew_ai_mechanics_fnc_initGarrisonModule";
		scope = 2;
		canSetArea = 1;
		canSetAreaShape = 1;
		class AttributeValues {
            size3[] = {5, 5, -1};
        };
		class Attributes: AttributesBase {
			class maxCount: Edit {
				displayName = "Max Units";
				property = "MaxUnits";
				typeName = "NUMBER";
				tooltip = "";
				control = "Edit";
				defaultValue = "50";
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
			class codeOnSpawnGroup: Edit {
				displayName = "Code on spawn";
				property = "codeOnSpawn";
				typeName = "STRING";
				tooltip = "";
				control = "EditCodeMulti5";
				defaultValue = """true""";
			};
		};
	};
	class reaperCrew_moduleSuppressPosition: reaperCrew_module_ai_mechanics_base
	{
		displayName = "Suppress Area";
		function = "reapercrew_ai_mechanics_fnc_initSuppressPosition";
		scope = 2;
		canSetArea = 1;
		canSetAreaShape = 1;
		class AttributeValues {
            size3[] = {25, 25, 20};
        };
		class Attributes: AttributesBase {
			class ActivationCode: Edit {
				displayName = "Activation Code";
				property = "ActivationCode";
				typeName = "STRING";
				tooltip = "";
				control = "Edit";
				defaultValue = """true""";
			};
		};
	};
	class reaperCrew_moduleAwesomeConvoy: reaperCrew_module_ai_mechanics_base
	{
		scope = 2;
		function = "reapercrew_ai_mechanics_fnc_initConvoySetup";
		displayName = "Convoy";
		class Attributes: AttributesBase {
			class Units: Units
			{
				//property = "blake_moduleAudio_Units";
			};
			// Module specific arguments
			class maxSpeed: Edit
			{
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "reaperCrew_moduleAwesomeConvoy_maxSpeed";
				displayName = "Max Speed"; // Argument label
				tooltip = "Maximum speed of the convoy, in km/h."; // Tooltip description
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "40"; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
			};
			class convSeparation: Edit
			{
				displayName = "Convoy Separation";
				property = "reaperCrew_moduleAwesomeConvoy_convSeparation";
				tooltip = "Convoy separation distance, in meters.";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "35";
			};
			class stiffnessCoeff: Edit
			{
				displayName = "Convoy Stiffness";
				property = "reaperCrew_moduleAwesomeConvoy_stiffnessCoeff";
				tooltip = "How much should the lead vehicle brake, in order to establish the desired convoy separation.";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0.2";
			};
			class dampingCoeff: Edit
			{
				displayName = "Convoy Damping";
				property = "reaperCrew_moduleAwesomeConvoy_dampingCoeff";
				tooltip = "How much should the lead vehicle brake, in order to minimize the relative speeds between the vehicles.";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0.6";
			};
			class curvatureCoeff: Edit
			{
				displayName = "Curvature Coefficient";
				property = "reaperCrew_moduleAwesomeConvoy_curvatureCoeff";
				tooltip = "How much should the lead vehicle brake, when traversing winding roads.";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0.3";
			};
			class stiffnessLinkCoeff: Edit
			{
				displayName = "Link Stiffness";
				property = "reaperCrew_moduleAwesomeConvoy_stiffnessLinkCoeff";
				tooltip = "How much should a follower vehicle accelerate and break, in order to establish the desired convoy separation with the vehicle in front.";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0.1";
			};
			class pathFrequecy: Edit
			{
				displayName = "Path Frequency";
				property = "reaperCrew_moduleAwesomeConvoy_pathFrequecy";
				tooltip = "Path update frequency, in seconds (adjust for performance).";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0.05";
			};
			class speedFrequecy: Edit
			{
				displayName = "Speed Control Frequency";
				property = "reaperCrew_moduleAwesomeConvoy_speedFrequecy";
				tooltip = "Speed control update frequency, in seconds (adjust for performance).";
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "0.2";
			};
			class speedModeConv: Combo
			{
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "reaperCrew_moduleAwesomeConvoy_speedMode";
				displayName = "Convoy Speed Mode"; // Argument label
				tooltip = "Change the Speed Mode for all the convoy's groups."; // Tooltip description
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = """Normal"""; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
				class Values
				{
					class 0	{name = "Unchanged";	value = "UNCHANGED";}; // Listbox item
					class 1	{name = "Limited"; 		value = "LIMITED";};
					class 2	{name = "Normal"; 		value = "NORMAL";};
					class 3	{name = "Full"; 		value = "FULL";};
				};
			};	
			class behaviourConv: Combo
			{
				// Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
				property = "reaperCrew_moduleAwesomeConvoy_behaviourConv";
				displayName = "Behaviour"; // Argument label
				tooltip = "Forces convoy vehicles to push through enemy contact."; // Tooltip description
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = """pushThroughContact"""; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
				class Values
				{
					class 0	{name = "Aware";				value = "AWARE";}; // Listbox item
					class 1	{name = "Push Through Contact"; value = "pushThroughContact";};
				};
			};
			class debug: Checkbox
			{
				displayName = "Debug";
				property = "reaperCrew_moduleAwesomeConvoy_debug";
				tooltip = "Draw paths.";
				typeName = "BOOL"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				defaultValue = "false";
			};
			class ActivationCode: Edit {
				displayName = "Activation Condition";
				property = "ActivationCode";
				typeName = "STRING";
				tooltip = "";
				control = "Edit";
				defaultValue = """activateConvoy == true;""";
			};
			class ContactCode: Edit {
				displayName = "Contact Condition";
				property = "ContactCode";
				typeName = "STRING";
				tooltip = "Code executed when the convoy is hit";
				control = "Edit";
				defaultValue = """true""";
			};
		};
	};

};