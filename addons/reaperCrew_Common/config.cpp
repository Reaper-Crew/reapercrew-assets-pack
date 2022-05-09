class CfgPatches
{
	class ReaperCrew_Common
	{
		units[] = {};
		weapons[]={};
		requiredVersion=1;
		requiredAddons[] = {"A3_Modules_F", "cba_settings"};
	};
};
class CfgMods
{
	class Mod_Base;
	class ReaperCrew_Common: Mod_Base
	{
		logo="rc_assets_pack\addons\reaperCrew_Common\data\reaperLogo.paa";
	};
	author="Reaper Crew";
	timepacked="1618105293";
};
class UniformSlotInfo
{
	slotType=0;
	linkProxy="-";
};
class Extended_PreInit_EventHandlers
{
	class reaperCrew_Common_preInit
	{
		init="call compile preProcessFileLineNumbers 'rc_assets_pack\addons\reaperCrew_Common\cba\XEH_preInit.sqf'";
	};
};
class cfgFactionClasses
{
	class NO_CATEGORY;
    class reaperCrew //Faction Calling Name
    {
     displayName = "Reaper Crew"; //Faction name in-game
     icon = "rc_assets_pack\addons\reaperCrew_Common\data\reaperLogo.paa"; //Path to texture next to the faction name in editor "PBOname\filename.paa"
     priority = 1; //How far down it is on the menu
     side = 1; // 1 Blufor 2 opfor 3 independant i think.
     scope = 2;
	 scopeCurator = 2;
    };
	class reaperCrew_ModulesLogistics: NO_CATEGORY
	{
		displayName = "Reaper Crew - Logistics";
		scope = 2;
		scopeCurator = 2;
	};
	class reaperCrew_ModulesAI: NO_CATEGORY
	{
		displayName = "Reaper Crew - AI";
		scope = 2;
		scopeCurator = 2;
	};
	class reaperCrew_ModulesPlayers: NO_CATEGORY
	{
		displayName = "Reaper Crew - Players";
		scope = 2;
		scopeCurator = 2;
	};
};
class CfgEditorCategories
{
	class NO_CATEGORY;
	class reaperCrew // Category class, you point to it in editorCategory property
	{
		displayName = "Reaper Crew"; // Name visible in the list
		scope = 2;
		scopeCurator = 2;
	};
	class reaperCrew_ModulesLogistics: NO_CATEGORY
	{
		displayName = "Reaper Crew - Logistics";
		scope = 2;
		scopeCurator = 2;
	};
	class reaperCrew_ModulesAI: NO_CATEGORY
	{
		displayName = "Reaper Crew - AI";
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
		icon = "rc_assets_pack\addons\reaperCrew_Common\data\insignia.paa";
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 1;
		is3DEN = 0;	
		curatorCanAttach = 1;
		scope = 1;
		scopeCurator = 1;
		functionPriority = 1;
	};
};
class CfgFunctions
{
	class reapercrew_common
	{
		class Effects
		{
			file = "rc_assets_pack\addons\reaperCrew_Common\functions";
			class CoverMap{};
			class sideChatMP{};
			class monitorHeadlessClients{postInit = 1;};
			class executeDistributed{};
			class randomGear{};
		};
	};
};