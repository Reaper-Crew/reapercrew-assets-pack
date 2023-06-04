class CfgPatches
{
	class reaperCrew_Sabre_Core
	{
		addonRootClass="A3_Props_F_Exp_A";
		requiredAddons[] = {"A3_Modules_F", "cba_settings", "ReaperCrew_Common"};
		requiredVersion=0.1;
		units[]=
		{
			""
		};
		weapons[]={};
	};
};
class Extended_PreInit_EventHandlers
{
	class reaperCrew_sabreCore_preInit
	{
		init="call compile preProcessFileLineNumbers 'RC_Assets_Pack\addons\reaperCrew_Sabre_Core\cba\XEH_preInit.sqf'";
	};
};
class CfgWeapons
{
	class Default;
	class ItemCore: Default {};
	class InventoryItem_Base_F {};
	class ToolKitItem: InventoryItem_Base_F {};
	class ToolKit: ItemCore {};
	class DataTabletItem: ToolKitItem {};

	class DataLinkTablet: ItemCore
	{
		author="$STR_A3_Bohemia_Interactive";
		_generalMacro="ToolKit";
		scope=2;
		displayName="SABRE Tablet";
		descriptionShort="Tablet allows you to retrieve information";
		picture="\A3\Drones_F\Weapons_F_Gamma\Items\data\UI\gear_UAV_controller_rgr_CA.paa";
		model="\a3\Drones_F\Weapons_F_Gamma\Items\UAV_controller_F";
		class ItemInfo: DataTabletItem
		{
			mass=20;
			uniformModel="\A3\Weapons_F\Items\GPS";
		};
	};
};
class CfgFunctions
{
	class reapercrew_sabre_main
	{
		tag="reapercrew_sabre_main";
		class functions
		{
			createShortcuts = 1;
			file = "rc_assets_pack\addons\reaperCrew_Sabre_Core\sabre_main";

			// Initialisation
			class initialiseSabreSystem{postInit = 1;};
			class initialiseScheduledTasks{postInit = 1;};
		};
	};
	class reapercrew_sabre_network
	{
		tag="reapercrew_sabre_network";
		class functions
		{
			createShortcuts = 1;
			file = "rc_assets_pack\addons\reaperCrew_Sabre_Core\sabre_network";
			
			// Network
			class validateSync{};
			class networkSync{};
		};
	};
};