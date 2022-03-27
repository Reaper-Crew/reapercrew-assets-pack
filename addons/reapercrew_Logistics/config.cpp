class CfgPatches
{
	class reaperCrew_Logistics
	{
		units[]=
		{
			"ReaperCrew_PlasticCase_Medical",
			"ReaperCrew_PlatoonAmmo_Base",
			"ReaperCrew_SupplyCrate",
			"ReaperCrew_Shells82",
			"ReaperCrew_PlasticCase_Base",
			"ReaperCrew_PlasticCase_Medical",
			"RC_CargoNet_01_barrels_F",
			"RC_VirtualReammoBox_F",
			"reaperCrew_moduleResupplyPoint",
			"ReaperCrew_Shells105CUP",
			"ReaperCrew_Shells122CUP"
		};
		weapons[] = {""};
		vehicles[] = {""};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "cba_settings", "ReaperCrew_Common"};
	};
};
class Extended_PreInit_EventHandlers
{
	class reaperCrew_logistics_preInit
	{
		init="call compile preProcessFileLineNumbers 'rc_assets_pack\addons\reaperCrew_Logistics\cba\XEH_preInit.sqf'";
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
class CfgFunctions
{
	class reapercrew_logistics
	{
		class Effects
		{
			file = "rc_assets_pack\addons\reaperCrew_Logistics\functions";
			class logisticsCreateSupplyCrate{};
			class logisticsPopulateSupplyCrate{};
			class logisticsCreateFuelSource{};
			class logisticsCreateAmmoSource{};
			class logisticsAddActions{};
			class logisticsModuleInit{};
		};
	};
};
class CfgVehicles
{
	class reaperCrew_module_base;
	class reaperCrew_moduleResupplyPoint: reaperCrew_module_base
	{
		displayName = "Resupply Point";
		function = "reapercrew_logistics_fnc_logisticsModuleInit";
		category = "reaperCrew_ModulesLogistics";
		scope = 2;
		scopeCurator = 2;
		isGlobal = 1;
		isTriggerActivated = 0;
		curatorCanAttach = 1;
	};
	class Items_base_F;
	class B_CargoNet_01_ammo_F;
	class CargoNet_01_barrels_F;
	class VirtualReammoBox_F;
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
            };
			class HE {
                name = ACE_1Rnd_82mm_Mo_HE;
                count = 50;
            };
			class Illum {
                name = ACE_1Rnd_82mm_Mo_Illum;
                count = 50;
            };
			class HELaserGuided {
                name = ACE_1Rnd_82mm_Mo_HE_LaserGuided;
                count = 50;
            };
			class Smoke {
                name = ACE_1Rnd_82mm_Mo_Smoke;
                count = 50;
            };
		};
	};
	class ReaperCrew_Shells105CUP: ReaperCrew_SupplyCrate {	
		displayName="Supply Crate (105mm Shells)";
		scope=2;
		scopeCurator=2;
		class TransportItems
		{
            class HE {
                name = CUP_compats_105mm_he;
                count = 50;
            };
			class WP {
                name = CUP_compats_105mm_wp;
                count = 50;
            };
			class Illum {
                name = CUP_compats_105mm_illum;
                count = 50;
            };
			class HELaserGuided {
                name = CUP_compats_105mm_laser;
                count = 50;
            };
			class Smoke {
                name = CUP_compats_105mm_smoke;
                count = 50;
            };
		};
	};
	class ReaperCrew_Shells122CUP: ReaperCrew_SupplyCrate {	
		displayName="Supply Crate (122mm Shells)";
		scope=2;
		scopeCurator=2;
		class TransportItems
		{
            class HE {
                name = CUP_compats_122mm_he;
                count = 50;
            };
			class Illum {
                name = CUP_compats_122mm_illum;
                count = 50;
            };
			class HELaserGuided {
                name = CUP_compats_122mm_laser;
                count = 50;
            };
			class Smoke {
                name = CUP_compats_122mm_smoke;
                count = 50;
            };
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
		// hiddenselectionsTextures[]=
		// {
		// 	"\reapercrew_Logistics\data\PlasticCase_01_CO_medical.paa"
		// };
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
            };
            class blood_500 {
                name = ACE_bloodIV_500;
                count = 50;
            };
            class blood_250 {
                name = ACE_bloodIV_250;
                count = 50;
            };
            class elasticbandage {
                name = ACE_elasticBandage;
                count = 50;
            };
            class quickclotbandage {
                name = ACE_quikclot;
                count = 50;
            };
            class packingbandage {
                name = ACE_packingBandage;
                count = 50;
            };
            class adenonsine {
                name = ACE_adenosine;
                count = 20;
            };
            class epinephrine {
                name = ACE_epinephrine;
                count = 20;
            };
            class morphine {
                name = ACE_morphine;
                count = 20;
            };
            class tourniquet {
                name = ACE_tourniquet;
                count = 8;
            };
            class splint {
                name = ACE_splint;
                count = 20;
            };
            class pak {
                name = ACE_personalAidKit;
                count = 2;
            };

		};
		class TransportMagazines {};
		class TransportWeapons {};
		hiddenselections[]=
		{
			"camo"
		};
		hiddenselectionsTextures[]=
		{
			"rc_assets_pack\addons\reaperCrew_Logistics\data\PlasticCase_01_CO_medical.paa"
		};
	};
	class RC_CargoNet_01_barrels_F: CargoNet_01_barrels_F {
		author="Reaper Crew";
		editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewStorageObjects";
		displayName="Supply Crate (Vehicle Fuel)";
		scope=2;
		scopeCurator=2;
		// Dragging
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 0};
        ace_dragging_dragDirection = 0;
		ace_maxWeightDrag = 9999;

        // Carrying
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1.2, 0};
        ace_dragging_carryDirection = 0;

		// Cargo
		ace_cargo_size = 8;
        ace_cargo_canLoad = 1;

		// Fuel
		init = "[(_this select 0)] call reapercrew_logistics_fnc_logisticsCreateFuelSource";
		ace_refuel_fuelCargo = 2000;

		class TransportItems{};
		class TransportMagazines{};
		class TransportWeapons{};
	};
	class RC_VirtualReammoBox_F: VirtualReammoBox_F {
		author="Reaper Crew";
		editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewStorageObjects";
		displayName="Supply Crate (Vehicle Ammo)";
		scope=2;
		scopeCurator=2;
		// Dragging
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 0};
        ace_dragging_dragDirection = 0;
		ace_maxWeightDrag = 9999;

        // Carrying
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1.2, 0};
        ace_dragging_carryDirection = 0;

		// Cargo
		ace_cargo_size = 8;
        ace_cargo_canLoad = 1;

		// Ammo
		ace_rearm_defaultSupply = 1000;

		// Fuel Resupply
		init = "[(_this select 0)] call reapercrew_logistics_fnc_logisticsCreateAmmoSource";

		class TransportItems{};
		class TransportMagazines{};
		class TransportWeapons{};
	};
};