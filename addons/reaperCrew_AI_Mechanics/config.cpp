class CfgPatches
{
	class ReaperCrew_AI_Mechanics
	{
		units[] = {""};
		weapons[]={};
		requiredVersion=1;
		requiredAddons[]=
		{"ReaperCrew_Common", "ReaperCrew_AI_Common"};
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
		};
	};
};