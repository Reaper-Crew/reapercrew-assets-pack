class CfgPatches
{
	class RC_Headgear
	{
		weapons[]=
		{
			"RC_Beret_01"
		};
		requiredVersion=0.100000;
		requiredAddons[]={};
		units[]={};
	};
};
class CfgWeapons
{
	class H_Beret_Colonel;
	class RC_Beret_01: H_Beret_Colonel
	{
		author="Reaper Crew";
		scope=2;
		displayName="Beret (Reaper Crew)";
		picture="\reaperCrew_Beret\data\UI\ReaperCrew_Beret02_Icon.paa";
		hiddenSelections[]=
		{
			"Camo"
		};
		hiddenSelectionsTextures[]=
		{
			"\reaperCrew_Beret\data\headgear_beret02_reapercrew_co"
		};
	};
};
