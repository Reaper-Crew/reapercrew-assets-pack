class CfgPatches
{
	class ReaperCrew_Player_Management
	{
		units[] = {"reaperCrew_moduleDisarmPlayers", "reaperCrew_moduleSavePlayerLoadout"};
		weapons[]={};
		requiredVersion=1;
		requiredAddons[]=
		{"ReaperCrew_Common"};
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
class CfgFunctions
{
	class reapercrew_player_management
	{
		class Effects
		{
			file = "rc_assets_pack\addons\reaperCrew_Player_Management\functions";
			class setACRESettings{postInit = 1;};
			class setPersonalACRESettingsLocal{};
			class setPersonalACRESettingsServer{postInit = 1;};
			class setUnitInsigniaGlobal{postInit = 1;};
			class setUnitInsigniaLocal{};
            class disarmModuleInit{};
			class disarmModuleKitChange{};
			class savePlayerLoadoutGlobal{};
			class savePlayerLoadoutLocal{};
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
};