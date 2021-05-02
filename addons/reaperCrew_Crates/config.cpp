class CfgPatches
{
	class ReaperCrew_Crate
	{
		addonRootClass="A3_Structures_F_Heli";
		requiredAddons[]=
		{
			"A3_Structures_F_Heli"
		};
		requiredVersion=0.100000;
		units[]=
		{
			"ReaperCrew_PlasticCase_Medical",
			"ReaperCrew_PlatoonAmmo_Base"
		};
		weapons[]={};
	};
};
class CfgEditorSubcategories
{
	class reaperCrewStorageObjects // Category class, you point to it in editorSubcategory property
	{
		displayName = "Storage"; // Name visible in the list
		scope=2;
		scopeCurator=2;
	};
};
class CfgVehicles
{
	class Items_base_F;
	class B_CargoNet_01_ammo_F;
	class ReaperCrew_SupplyCrate: B_CargoNet_01_ammo_F {
		author="Reaper Crew";
		editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewStorageObjects";
		scope=0;
		scopeCurator=0;
		// Dragging
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 0};
        ace_dragging_dragDirection = 0;
		ace_maxWeightDrag = 9999;

        // Carrying
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1.2, 0};
        ace_dragging_carryDirection = 0;

		class TransportItems{};
		class TransportMagazines{};
		class TransportWeapons{};
	};
	class ReaperCrew_PlatoonAmmo_Base: ReaperCrew_SupplyCrate {	
		displayName="Supply Crate (Small Arms)";
		scope=2;
		scopeCurator=2;
	};
	class ReaperCrew_Shells82: ReaperCrew_SupplyCrate {	
		displayName="Supply Crate (82mm Mortar)";
		scope=2;
		scopeCurator=2;
		class TransportItems
		{
            class HEGuided {
                name = ACE_1Rnd_82mm_Mo_HE_Guided;
                count = 50;
            }
			class HE {
                name = ACE_1Rnd_82mm_Mo_HE;
                count = 50;
            }
			class Illum {
                name = ACE_1Rnd_82mm_Mo_Illum;
                count = 50;
            }
			class HELaserGuided {
                name = ACE_1Rnd_82mm_Mo_HE_LaserGuided;
                count = 50;
            }
			class Smoke {
                name = ACE_1Rnd_82mm_Mo_Smoke;
                count = 50;
            }
		};
	};
    class ReaperCrew_PlasticCase_Base: Items_base_F
	{
		author="Reaper Crew";
		mapSize=0.650000;
		_generalMacro="PlasticCase_01_base_F";
		scope=0;
		scopeCurator=0;
		displayName="Supply Crate (Reaper Crew)";
		model="\A3\Weapons_F\empty.p3d";
		icon="iconObject";
		editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewStorageObjects";
		vehicleClass="Container";
		waterLeakiness=100;
		maximumLoad=2000;
		transportMaxWeapons=24;
		transportMaxMagazines=128;
		transportMaxBackpacks=12;

        ace_cargo_size = 8;
        ace_cargo_canLoad = 1;

		// Dragging
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 0};
        ace_dragging_dragDirection = 0;
		ace_maxWeightDrag = 9999;

        // Carrying
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1.2, 0};
        ace_dragging_carryDirection = 0;
		class TransportItems
		{
		};
		class TransportMagazines
		{
		};
		class TransportWeapons
		{
		};
		hiddenselections[]=
		{
			"camo"
		};
		hiddenselectionsTextures[]=
		{
			"reaperCrew_Crates\data\plasticcase_01_co.paa"
		};
	};
	class ReaperCrew_PlasticCase_Medical: ReaperCrew_PlasticCase_Base
	{
		author="Reaper Crew";
		mapSize=1.250000;
		class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
		editorPreview="\A3\EditorPreviews_F\Data\CfgVehicles\Land_PlasticCase_01_large_F.jpg";
		_generalMacro="Land_PlasticCase_01_large_F";
		scope=2;
		scopeCurator=2;
		displayName="Supply Crate (Medical)";
		model="\A3\Structures_F_Heli\Items\Luggage\PlasticCase_01_large_F.p3d";
		icon="iconObject_1x2";
        class TransportItems
		{
            class blood_1000 {
                name = ACE_bloodIV;
                count = 50;
            }
            class blood_500 {
                name = ACE_bloodIV_500;
                count = 50;
            }
            class elasticbandage {
                name = ACE_elasticBandage;
                count = 50;
            }
            class quickclotbandage {
                name = ACE_quikclot;
                count = 50;
            }
            class packingbandage {
                name = ACE_packingBandage;
                count = 50;
            }
            class adenonsine {
                name = ACE_adenosine;
                count = 20;
            }
            class epinephrine {
                name = ACE_epinephrine;
                count = 20;
            }
            class morphine {
                name = ACE_morphine;
                count = 20;
            }
            class tourniquet {
                name = ACE_tourniquet;
                count = 8;
            }
            class splint {
                name = ACE_splint;
                count = 20;
            }
            class pak {
                name = ACE_personalAidKit;
                count = 2;
            }

		};
		class TransportMagazines {};
		class TransportWeapons {};
		hiddenselections[]=
		{
			"camo"
		};
		hiddenselectionsTextures[]=
		{
			"reaperCrew_Crates\data\plasticcase_01_co_medical.paa"
		};
	};
};