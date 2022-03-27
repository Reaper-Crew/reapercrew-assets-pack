class CfgPatches
{
	class ReaperCrew_AI_Mechanics
	{
		units[] = {"reaperCrew_module_ai_mechanics_base", "reaperCrew_moduleGarrison"};
		weapons[]={""};
		requiredVersion=1;
		requiredAddons[] = {"A3_Modules_F", "cba_settings", "ReaperCrew_Common", "reaperCrew_AI_Common"};
	};
};
class CfgEditorCategories
{
	class NO_CATEGORY;
	class reaperCrew_ModulesReinforcements: NO_CATEGORY
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
			class activateGarrisonModule{};
			class remoteGarrisonSpawn{};
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
		category = "reaperCrew_ModulesReinforcements";
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
};