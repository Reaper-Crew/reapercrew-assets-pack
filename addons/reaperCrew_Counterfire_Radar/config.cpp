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

			class containerDeploy{};
			class clientContainerDeploy{};

			class radarInit{};

			class eventFired{};
			class eventGetIn{};
			class eventGetOut{};

			class systemInit{
				postInit = 1;
			};
			class systemScheduledTasks{};
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
	class Land_Cargo20_military_green_F {
		class ACE_Actions {
            class ACE_MainActions{};
        };
	};

	class reaperCrew_TPQ_50_Static_Container: Land_Cargo20_military_green_F {
		editorCategory = "reaperCrew";
		editorSubcategory="reaperCrewMortarObjects";
		displayName="TPQ-50 Transport Container";
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

		hasGunner = false;
		hasCommander =false;

		class EventHandlers : EventHandlers {
			init = "[(_this select 0)] call reapercrew_counterBattery_fnc_radarInit";
			getIn = "diag_log _this; [(_this select 0)] remoteExec ['reapercrew_counterBattery_fnc_eventGetIn', (_this select 2)];";
			getOut = "diag_log _this; [(_this select 0)] remoteExec ['reapercrew_counterBattery_fnc_eventGetOut', (_this select 2)];";
		};
		
		class counterBattery {
			detectionRadius = 6180; // 30km2 radius
		};

		driverAction = "gunner_offroad01";

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