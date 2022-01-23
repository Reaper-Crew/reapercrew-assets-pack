class CfgPatches
{
	class ReaperCrew_AI_Common
	{
		units[] = {""};
		weapons[]={};
		requiredVersion=1;
		requiredAddons[]=
		{"A3_Modules_F", "cba_settings", "ReaperCrew_Common"};
	};
};
class Extended_PreInit_EventHandlers
{
	class ReaperCrew_AI_Common_preInit
	{
		init="call compile preProcessFileLineNumbers 'rc_assets_pack\addons\reaperCrew_AI_Common\cba\XEH_preInit.sqf'";
	};
};