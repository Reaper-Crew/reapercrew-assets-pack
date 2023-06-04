class CfgPatches
{
	class reaperCrew_Sabre_Component_CounterBattery
	{
		requiredAddons[] = {"reaperCrew_Sabre_Core"};
		requiredVersion=0.1;
		units[]={"reaperCrew_Sentinel_west_dst","reaperCrew_Sentinel_west_wdl","reaperCrew_Sentinel_east_dst","reaperCrew_Sentinel_east_wdl","reaperCrew_Sentinel_independent_dst","reaperCrew_Sentinel_independent_wdl"};
		weapons[]={};
	};
};
class Extended_PreInit_EventHandlers
{
	class reaperCrew_Sabre_Component_CounterBattery_preInit
	{
		init="call compile preProcessFileLineNumbers 'RC_Assets_Pack\addons\reaperCrew_Sabre_Component_CounterBattery\cba\XEH_preInit.sqf'";
	};
};
class CfgEditorSubcategories
{
	class ReaperCrew_CounterBattery // Category class, you point to it in editorSubcategory property
	{
		displayName = "Counter Battery"; // Name visible in the list
	};
};
class CfgVehicles
{
	class B_MRAP_01_F {
		class ACE_Actions {
            class ACE_MainActions{};
        };
		class EventHandlers {};
		class Components;
	};
	class reaperCrew_counterBattery_base: B_MRAP_01_F {
		editorCategory = "reaperCrew";
		editorSubcategory="ReaperCrew_CounterBattery";
		scope=0;
		scopeCurator=0;

		hasDriver = true;
		hasGunner = false;
		hasCommander = false;
		ace_cargo_hasCargo = 0;
		radarTarget = 1;
		class EventHandlers : EventHandlers {
			init = "[(_this select 0)] spawn reapercrew_sabre_counterBattery_fnc_initialiseComponentLCMR;";
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
				class StartEngine {
					displayName = "Start Engine";
					condition = "isEngineOn _target == false";
					exceptions[] = {};
					statement = "_target engineOn true";
				};
				class StopEngine {
					displayName = "Stop Engine";
					condition = "isEngineOn _target == true";
					exceptions[] = {};
					statement = "_target engineOn false";
				};
				class CheckFuel {
					displayName = "Check Fuel";
					condition = "true";
					exceptions[] = {};
					statement = "hint format ['Fuel Level: %1%2', (fuel _target * 100), '%']";
				};
            };
        };
	};
	
	#include "radarUnits\SentinelRadar\Sentinel.hpp"
};
class CfgFunctions
{
	class reapercrew_sabre_counterBattery
	{
		tag="reapercrew_sabre_counterBattery";
		class functions
		{
			createShortcuts = 1;
			file = "rc_assets_pack\addons\reaperCrew_Sabre_Component_CounterBattery\sabre_counter_battery";

			// Initialisation
			class initialiseComponentLCMR{};
			class initialiseScheduledTasks{postInit = 1;}; 

			// Events
			class componentLCMREventFired{};
			class componentLCMRMarkerSearch{};
			class componentLCMRMarkerSetup{};

			// Actions
			class componentLCMRActionOpenUI{};
			class componentLCMRActionDeployLocal{};
			class componentLCMRActionDeployRemote{};

			// Scheduled Tasks
			class taskGarbageCollect{};
			class taskGatherFires{};
			class taskRemoveStaleMarkers{};

		};
	};
};