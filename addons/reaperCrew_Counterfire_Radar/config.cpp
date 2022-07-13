class CfgPatches
{
	class reaperCrew_lcmr
	{
		addonRootClass="A3_Props_F_Exp_A";
		requiredAddons[] = {"A3_Modules_F", "cba_settings", "ReaperCrew_Common"};
		requiredVersion=0.1;
		units[]=
		{
			"reaperCrew_counterBattery_base", "reaperCrew_TPQ_50_Static", "reaperCrew_TPQ_50_Static_Container"
		};
		weapons[]={};
	};
};
class CfgEditorSubcategories
{
	class reaperCrewMortarObjects // Category class, you point to it in editorSubcategory property
	{
		displayName = "Fire Support"; // Name visible in the list
		scope=2;
		scopeCurator=2;
	};
};

class CfgFunctions
{
	class reapercrew_counterBattery
	{
		class Effects
		{
			file = "rc_assets_pack\addons\reaperCrew_counterfire_radar\functions";

			// Container Management
			class containerDeploy{};
			class clientContainerDeploy{};

			// Initialisation
			class systemInit{postInit = 1;};
			class playerCBAEventHandlers {postInit = 1;};
			class radarInit{};

			// Events
			class eventFired{};
			class MarkerAdd {};
			class MarkerUpdate {};

			// Long Running Tasks
			class systemScheduledTasks{};

			// Validation
			class validateNotification{};
		};
	};
};
class Extended_PreInit_EventHandlers
{
	class reaperCrew_fireSupport_preInit
	{
		init="call compile preProcessFileLineNumbers 'RC_Assets_Pack\addons\reaperCrew_counterfire_radar\cba\XEH_preInit.sqf'";
	};
};
class CfgVehicles
{
	class B_MRAP_01_F {
		class ACE_Actions {
            class ACE_MainActions{};
        };
		class EventHandlers {};
	};
	class B_Slingload_01_Cargo_F {
		class ACE_Actions {
            class ACE_MainActions{};
        };
	};

	class reaperCrew_TPQ_50_Static_Container: B_Slingload_01_Cargo_F {
		editorCategory = "reaperCrew";
		editorSubcategory="reaperCrewMortarObjects";
		displayName="TPQ-50 Transport Container";
		ace_cargo_size = 8;
		ace_dragging_canDrag = 1;

		class ACE_Actions: ACE_Actions {
            class ACE_MainActions: ACE_MainActions {
                condition = "true";
				displayName = "Interactions";
				distance = 10;
				position = "[_target,  ace_interact_menu_cameraPosASL] call ace_interaction_fnc_getVehiclePosComplex";
				selection = "";
				class deployContainer {
					displayName = "Deploy Listening Post";
					condition = "true";
					exceptions[] = {};
					statement = "['reaperCrew_TPQ_50_Static', _target] call reapercrew_counterBattery_fnc_clientContainerDeploy";
				};
            };
        };
	};

	class reaperCrew_counterBattery_base: B_MRAP_01_F {
		editorCategory = "reaperCrew";
		editorSubcategory="reaperCrewMortarObjects";
		scope=0;
		scopeCurator=0;

		hasDriver = false;
		hasGunner = false;
		hasCommander =false;
		ace_cargo_hasCargo = 0;

		class EventHandlers : EventHandlers {
			init = "[(_this select 0)] call reapercrew_counterBattery_fnc_radarInit";
		};
		
		class counterBattery {
			detectionRadius = 6180; // 30km2 radius
			transmissionDistance = 250;
		};


		class TransportItems{};
		class TransportMagazines{};
		class TransportWeapons{};

		class ACE_Actions: ACE_Actions {
            class ACE_MainActions: ACE_MainActions {
                condition = "true";
				displayName = "Interactions";
				distance = 10;
				position = "[_target,  ace_interact_menu_cameraPosASL] call ace_interaction_fnc_getVehiclePosComplex";
				selection = "";
				class deployContainer {
					displayName = "Repack Listening Post";
					condition = "true";
					exceptions[] = {};
					statement = "['reaperCrew_TPQ_50_Static', _target] call reapercrew_counterBattery_fnc_clientContainerDeploy";
				};
            };
        };

	};
	class reaperCrew_TPQ_50_Static: reaperCrew_counterBattery_base {
		displayName="Listening Post (TPQ-50)";
		model="RC_Assets_Pack\addons\reaperCrew_counterfire_radar\data\TPQ_50_Static\TPQ_50_Static.p3d";
		scope=2;
		scopeCurator=2;

		class counterBattery: counterBattery {};
		class EventHandlers : EventHandlers {};
		class ACE_Actions: ACE_Actions {
			class ACE_MainActions: ACE_MainActions {
				class deployContainer: deployContainer {
					statement = "['reaperCrew_TPQ_50_Static_Container', _target] call reapercrew_counterBattery_fnc_clientContainerDeploy";
				};
			};
		};
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
		displayName="Data Link Tablet";
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