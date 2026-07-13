class CfgPatches
{
	class ReaperCrew_Player_Management
	{
		units[] = {"reaperCrew_moduleDisarmPlayers", "reaperCrew_moduleSavePlayerLoadout", "reaperCrew_moduleFixFatigue", "reaperCrew_loadoutLaptop"};
		weapons[]={};
		requiredVersion=2.02;
		requiredAddons[]=
		{"ReaperCrew_Common", "acre_sys_sounds", "cba_settings"};
	};
};
class Extended_PreInit_EventHandlers
{
	class reaperCrew_Player_Management_preInit
	{
		init="call compile preProcessFileLineNumbers 'rc_assets_pack\addons\reaperCrew_Player_Management\cba\XEH_preInit.sqf'";
	};
};
class CfgEditorCategories
{
	class NO_CATEGORY;
    class reaperCrew_ModulesPlayers: NO_CATEGORY
	{
		displayName = "Reaper Crew - Player Management";
		scope = 2;
		scopeCurator = 2;
	};
};
class CfgEditorSubcategories
{
	class reaperCrewPlayerObjects // Category class, you point to it in editorSubcategory property
	{
		displayName = "Player"; // Name visible in the list
		scope = 2;
		scopeCurator = 2;
	};
};
class CfgFunctions
{
	class reapercrew_player_management
	{
		class Effects
		{
			file = "rc_assets_pack\addons\reaperCrew_Player_Management\functions";
			class setACRESettings{postInit = 1;};
			class addACEActions{postInit = 1;};
			class initNvgEffect{postInit = 1;};
			class initTreatmentNotification{postInit = 1;};
			class showTreatmentNotification{};
			class setPersonalACRESettingsLocal{};
			class setPersonalACRESettingsServer{postInit = 1;};
			class setUnitInsigniaGlobal{postInit = 1;};
			class setUnitInsigniaLocal{};
            class disarmModuleInit{};
			class disarmModuleKitChange{};
			class savePlayerLoadoutGlobal{};
			class savePlayerLoadoutLocal{};
			class fixPlayerFatigueGlobal{};
			class fixPlayerFatigueLocal{};
		};
	};
	class reapercrew_player_groups
	{
		class Effects
		{
			file = "rc_assets_pack\addons\reaperCrew_Player_Management\listAllGroups";
			class getGroupListST{};
			class getRole{};
			class getUnitInfoST{};
			class getUnitRole{};
			class getUnitWeightST{};
            class getWeight{};
			class getWeightColour{};
			class listAllGroups{};
			class listPlayerInfo{};
		};
	};
};
class CfgVehicles
{
	class Logic;
	class Module_F: Logic {};
    class reaperCrew_module_base: Module_F {};
    class reaperCrew_moduleDisarmPlayers: reaperCrew_module_base
	{
		displayName = "Disarm all players";
		function = "reapercrew_player_management_fnc_disarmModuleInit";
		category = "reaperCrew_ModulesPlayers";
		scope = 1;
		scopeCurator = 2;
		isGlobal = 0;
	};
	class reaperCrew_moduleSavePlayerLoadout: reaperCrew_module_base
	{
		displayName = "Save player loadout";
		function = "reapercrew_player_management_fnc_savePlayerLoadoutGlobal";
		category = "reaperCrew_ModulesPlayers";
		scope = 1;
		scopeCurator = 2;
		isGlobal = 0;
	};
	class reaperCrew_moduleFixFatigue: reaperCrew_module_base
	{
		displayName = "Fix Fatigue";
		function = "reapercrew_player_management_fnc_fixPlayerFatigueGlobal";
		category = "reaperCrew_ModulesPlayers";
		scope = 1;
		scopeCurator = 2;
		isGlobal = 0;
	};
	class Land_Laptop_03_black_F;
	class reaperCrew_loadoutLaptop: Land_Laptop_03_black_F
	{
		author = "Reaper Crew";
		displayName = "Loadout Laptop";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewPlayerObjects";
		scope = 2;
		scopeCurator = 2;
		class ACE_Actions
		{
			class ACE_MainActions
			{
				displayName = "Interactions";
				condition = "true";
				selection = "";
				class reaperCrew_saveLoadout
				{
					displayName = "Save Loadout";
					condition = "true";
					exceptions[] = {};
					statement = "['Saving loadout...', 2, {true}, { [] call reapercrew_player_management_fnc_savePlayerLoadoutLocal; }, {}, []] call CBA_fnc_progressBar;";
				};
				class reaperCrew_selfHeal
				{
					displayName = "Self Heal";
					condition = "true";
					exceptions[] = {};
					statement = "['Healing...', 2, {true}, { [player] call ace_medical_treatment_fnc_fullHealLocal; }, {}, []] call CBA_fnc_progressBar;";
				};
			};
		};
	};
};
class CfgAcreSounds {
    class Acre_TetraOn {
        sound = "rc_assets_pack\addons\reaperCrew_Player_Management\sounds\TetraSquawkOn.b64";
    };

    class Acre_TetraOff {
        sound = "rc_assets_pack\addons\reaperCrew_Player_Management\sounds\TetraSquawkOff.b64";
    };
};
