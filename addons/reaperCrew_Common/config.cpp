class CfgPatches
{
	class ReaperCrew_Common
	{
		units[] = {};
		weapons[]={};
		requiredVersion=2.02;
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
class CfgHintCategories
{
	class CampaignInfo
	{
		displayName="Campaign Information";
		logicalOrder=0;
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
			class groupCleanupWatcher{postInit = 1;};
			class executeDistributed{};
			class randomGear{};
			class remoteLog{};
		};
	};
};
// Full redeclaration of the base-game CfgMarkerColors (from a3\ui_f\config.cpp),
// extended with Reaper Crew custom colours. Config classes merge across addons, so
// the vanilla entries below are identical overrides and the reaperCrew_* entries are
// additions - both the vanilla palette and ours are available on every mission.
class CfgMarkerColors
{
	class Default
	{
		name = "$STR_CFG_MARKERCOL_DEFAULT";
		color[] = {0,0,0,1};
		scope = 1;
	};
	class ColorBlack: Default
	{
		name = "$STR_CFG_MARKERCOL_BLACK";
		color[] = {0,0,0,1};
		scope = 2;
	};
	class ColorGrey: Default
	{
		name = "$STR_A3_CfgMarkerColors_ColorGrey_0";
		color[] = {0.5,0.5,0.5,1};
	};
	class ColorRed: Default
	{
		name = "$STR_CFG_MARKERCOL_RED";
		color[] = {0.89999998,0,0,1};
		scope = 2;
	};
	class ColorBrown: Default
	{
		name = "$STR_A3_CfgMarkerColors_ColorBrown_0";
		color[] = {0.5,0.25,0,1};
	};
	class ColorOrange: Default
	{
		name = "$STR_CFG_MARKERCOL_ORANGE";
		color[] = {0.85000002,0.40000001,0,1};
	};
	class ColorYellow: Default
	{
		name = "$STR_CFG_MARKERCOL_YELLOW";
		color[] = {0.85000002,0.85000002,0,1};
		scope = 2;
	};
	class ColorKhaki: Default
	{
		name = "$STR_A3_CfgMarkerColors_ColorKhaki_0";
		color[] = {0.5,0.60000002,0.40000001,1};
	};
	class ColorGreen: Default
	{
		name = "$STR_CFG_MARKERCOL_GREEN";
		color[] = {0,0.80000001,0,1};
		scope = 2;
	};
	class ColorBlue: Default
	{
		name = "$STR_CFG_MARKERCOL_BLUE";
		color[] = {0,0,1,1};
		scope = 2;
	};
	class ColorPink: Default
	{
		name = "$STR_A3_CfgMarkerColors_ColorPink_0";
		color[] = {1,0.30000001,0.40000001,1};
	};
	class ColorWhite: Default
	{
		name = "$STR_CFG_MARKERCOL_WHITE";
		color[] = {1,1,1,1};
		scope = 2;
	};
	class ColorWEST: Default
	{
		name = "$STR_WEST";
		color[] =
		{
			"(profilenamespace getvariable ['Map_BLUFOR_R',0])",
			"(profilenamespace getvariable ['Map_BLUFOR_G',1])",
			"(profilenamespace getvariable ['Map_BLUFOR_B',1])",
			"(profilenamespace getvariable ['Map_BLUFOR_A',0.8])"
		};
		scope = 2;
	};
	class ColorEAST: Default
	{
		name = "$STR_EAST";
		color[] =
		{
			"(profilenamespace getvariable ['Map_OPFOR_R',0])",
			"(profilenamespace getvariable ['Map_OPFOR_G',1])",
			"(profilenamespace getvariable ['Map_OPFOR_B',1])",
			"(profilenamespace getvariable ['Map_OPFOR_A',0.8])"
		};
		scope = 2;
	};
	class ColorGUER: Default
	{
		name = "$STR_GUERRILA";
		color[] =
		{
			"(profilenamespace getvariable ['Map_Independent_R',0])",
			"(profilenamespace getvariable ['Map_Independent_G',1])",
			"(profilenamespace getvariable ['Map_Independent_B',1])",
			"(profilenamespace getvariable ['Map_Independent_A',0.8])"
		};
		scope = 2;
	};
	class ColorCIV: Default
	{
		name = "$STR_CIVILIAN";
		color[] =
		{
			"(profilenamespace getvariable ['Map_Civilian_R',0])",
			"(profilenamespace getvariable ['Map_Civilian_G',1])",
			"(profilenamespace getvariable ['Map_Civilian_B',1])",
			"(profilenamespace getvariable ['Map_Civilian_A',0.8])"
		};
		scope = 2;
	};
	class ColorUNKNOWN: Default
	{
		name = "$STR_SIDE_UNKNOWN";
		color[] =
		{
			"(profilenamespace getvariable ['Map_Unknown_R',0])",
			"(profilenamespace getvariable ['Map_Unknown_G',1])",
			"(profilenamespace getvariable ['Map_Unknown_B',1])",
			"(profilenamespace getvariable ['Map_Unknown_A',0.8])"
		};
		scope = 2;
	};
	class colorBLUFOR: ColorWEST
	{
		scope = 0;
	};
	class colorOPFOR: ColorEAST
	{
		scope = 0;
	};
	class colorIndependent: ColorGUER
	{
		scope = 0;
	};
	class colorCivilian: ColorCIV
	{
		scope = 0;
	};
	// Reaper Crew callsign colours - one visually distinct colour per element.
	class reaperCrew_ColorZero: Default
	{
		name = "Zero";
		color[] = {1.0,0.75,0.0,1};
		scope = 2;
	};
	class reaperCrew_ColorReaper1: Default
	{
		name = "Reaper-1-1";
		color[] = {0.15,0.4,0.9,1};
		scope = 2;
	};
	class reaperCrew_ColorReaper2: Default
	{
		name = "Reaper-1-2";
		color[] = {0.85,0.1,0.1,1};
		scope = 2;
	};
	class reaperCrew_ColorReaper3: Default
	{
		name = "Reaper-1-3";
		color[] = {0.1,0.65,0.15,1};
		scope = 2;
	};
	class reaperCrew_ColorReaper4: Default
	{
		name = "Reaper-1-4";
		color[] = {0.6,0.2,0.85,1};
		scope = 2;
	};
	class reaperCrew_ColorHammer: Default
	{
		name = "Hammer";
		color[] = {1.0,0.5,0.0,1};
		scope = 2;
	};
	class reaperCrew_ColorThunder: Default
	{
		name = "Thunder";
		color[] = {0.0,0.75,0.8,1};
		scope = 2;
	};
	class reaperCrew_ColorSentinel: Default
	{
		name = "Sentinel";
		color[] = {1.0,0.25,0.6,1};
		scope = 2;
	};
	class reaperCrew_ColorFury: Default
	{
		name = "Fury";
		color[] = {0.55,0.8,0.1,1};
		scope = 2;
	};
};
