class CfgPatches
{
	class reaperCrew_lcmr
	{
		addonRootClass="A3_Props_F_Exp_A";
		requiredAddons[] = {"A3_Modules_F", "cba_settings", "ReaperCrew_Common"};
		requiredVersion=0.1;
		units[]=
		{
			"RC_LCMR"
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
	class reapercrew_fireSupport
	{
		class Effects
		{
			file = "\reaperCrew_lcmr\functions";
            class checkAttachGenerator{};
			class checkAttachControlUnit{};
			class attachGenerator{};
			class attachControlUnit{};
			class triggerFired{};
			class alertUnit{};
			class addMapMarker{};
			class removeMapMarker{};
			class updateMapMarker{};
			class systemInit{
				postInit = 1;
			};
		};
	};
};
class Extended_PreInit_EventHandlers
{
	class reaperCrew_fireSupport_preInit
	{
		init="call compile preProcessFileLineNumbers '\reaperCrew_lcmr\cba\XEH_preInit.sqf'";
	};
};
class CfgVehicles
{
	class Items_base_F;
	class Land_PowerGenerator_F;
	class Land_Laptop_03_black_F;
	class reaperCrew_TPQ_49_base_no_colour: Items_base_F {
		class ACE_Actions {
            class ACE_MainActions;
        };
	};


    class reaperCrew_TPQ_49_base: reaperCrew_TPQ_49_base_no_colour
	{
		author="Xeenenta";
		mapSize=0.01;
		editorPreview="reaperCrew_lcmr\data\AN_TPQ_49\icon.paa";
		scope=0;
		scopeCurator=0;

		icon="iconObject_5x4";
		editorCategory = "reaperCrew";
		editorSubcategory="reaperCrewMortarObjects";

		// Dragging
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 0, 1};
        ace_dragging_dragDirection = 0;

		// Loading
		ace_cargo_size = 4;
		ace_cargo_canLoad = 1;

		class ACE_Actions: ACE_Actions {
            class ACE_MainActions: ACE_MainActions {
                condition = "true";
				displayName = "Interactions";
				distance = 10;
				position = "[_target,  ace_interact_menu_cameraPosASL] call ace_interaction_fnc_getVehiclePosComplex";
				selection = "";

				class testButton {
					displayName = "Attach Generator";
					condition = "[_target] call reaperCrew_fireSupport_fnc_checkAttachGenerator";
					statement = "[_target] call reaperCrew_fireSupport_fnc_attachGenerator";
					icon = "\reaperCrew_Common\data\dot_ca.paa";
					distance = 20;
				};
				class testButton2 {
					displayName = "Attach Controller";
					condition = "[_target] call reaperCrew_fireSupport_fnc_checkAttachControlUnit";
					statement = "[_target] call reaperCrew_fireSupport_fnc_attachControlUnit";
					icon = "\reaperCrew_Common\data\dot_ca.paa";
					distance = 20;
				}
            };
        };
	};
	class reaperCrew_TPQ_49_woodland: reaperCrew_TPQ_49_base {
		displayName="AN/TPQ-49 (Woodland)";
		model="reaperCrew_lcmr\data\AN_TPQ_49\an_tpq_49_woodland.p3d";
		scope=2;
		scopeCurator=2;
	};
	class reaperCrew_TPQ_49_desert: reaperCrew_TPQ_49_base {
		displayName="AN/TPQ-49 (Desert)";
		model="reaperCrew_lcmr\data\AN_TPQ_49\an_tpq_49_desert.p3d";
		scope=2;
		scopeCurator=2;
	};
	class reaperCrew_TPQ_49_PowerUnit_base: Land_PowerGenerator_F {
		class ACE_Actions {
            class ACE_MainActions;
        };
	};
	class reaperCrew_TPQ_49_PowerUnit: reaperCrew_TPQ_49_PowerUnit_base {
		author="Xeenenta";
		displayName="AN/TPQ-49 Generator";
		editorCategory = "reaperCrew";
		editorSubcategory="reaperCrewMortarObjects";

		// Dragging
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 0};
        ace_dragging_dragDirection = 0;
		ACE_maxWeightDrag = 999999;

		// Loading
		ace_cargo_size = 4;
		ace_cargo_canLoad = 1;

		class ACE_Actions: ACE_Actions {
            class ACE_MainActions: ACE_MainActions {
                condition = "true";
				displayName = "Interactions";
				distance = 10;
				position = "[_target,  ace_interact_menu_cameraPosASL] call ace_interaction_fnc_getVehiclePosComplex";
				selection = "";
            };
        };
	};
	class reaperCrew_TPQ_49_ControlUnit_base: Land_Laptop_03_black_F {
		class ACE_Actions {
            class ACE_MainActions;
        };
	};
	class reaperCrew_TPQ_49_ControlUnit: reaperCrew_TPQ_49_ControlUnit_base {
		author="Xeenenta";
		displayName="AN/TPQ-49 Control unit";
		editorCategory = "reaperCrew";
		editorSubcategory="reaperCrewMortarObjects";

        // Carrying
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1.2, 0};
        ace_dragging_carryDirection = 0;
		ace_maxWeightCarry = 9999;

		// Loading
		ace_cargo_size = 4;
		ace_cargo_canLoad = 1;

		class ACE_Actions: ACE_Actions {
            class ACE_MainActions: ACE_MainActions {
                condition = "true";
				displayName = "Interactions";
				distance = 10;
				position = "[_target,  ace_interact_menu_cameraPosASL] call ace_interaction_fnc_getVehiclePosComplex";
				selection = "";
            };
        };
	};
};