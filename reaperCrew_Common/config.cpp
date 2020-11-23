class CfgPatches
{
	class ReaperCrew_Insignia_Units
	{
		units[]={};
		weapons[]={};
		requiredVersion=1;
		requiredAddons[]=
		{};
	};
};
class UniformSlotInfo
{
	slotType=0;
	linkProxy="-";
};
class CfgUnitInsignia
{
	class reaperCrewInsignia
	{
		displayName="Reaper Crew Insignia";
		author="Xeenenta";
		texture="reaperCrew_Common\data\reaperLogo.paa";
		textureVehicle="";
	};
};
class cfgFactionClasses
{
    class reaperCrew //Faction Calling Name
    {
     displayName = "Reaper Crew"; //Faction name in-game
     icon = "reaperCrew_Common\data\reaperLogo.paa"; //Path to texture next to the faction name in editor "PBOname\filename.paa"
     priority = 1; //How far down it is on the menu
     side = 1; // 1 Blufor 2 opfor 3 independant i think.
     scope = 2;
	 scopeCurator = 2;
    };
};
class CfgEditorCategories
{
	class reaperCrew // Category class, you point to it in editorCategory property
	{
		displayName = "Reaper Crew"; // Name visible in the list
		scope = 2;
		scopeCurator = 2;
	};
};