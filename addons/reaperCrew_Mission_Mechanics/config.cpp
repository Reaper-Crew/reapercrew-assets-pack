class CfgPatches
{
	class reaperCrew_Mission_Mechanics
	{
		units[] = {"reaperCrew_moduleMissionMechanicsBase", "reaperCrew_moduleInteractionObjective", "reaperCrew_moduleTimedTask"};
		weapons[] = {""};
		vehicles[] = {""};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "ReaperCrew_Common"};
	};
};
class cfgFactionClasses
{
	class NO_CATEGORY;
	class reaperCrew_ModulesMissionMechanics: NO_CATEGORY
	{
		displayName = "Reaper Crew - Mission Mechanics";
		scope = 2;
		scopeCurator = 2;
	};
};
class CfgEditorCategories
{
	class NO_CATEGORY;
	class reaperCrew_ModulesMissionMechanics: NO_CATEGORY
	{
		displayName = "Reaper Crew - Mission Mechanics";
		scope = 2;
		scopeCurator = 2;
	};
};
class CfgFunctions
{
	class reapercrew_mission_mechanics
	{
		class Effects
		{
			file = "rc_assets_pack\addons\reaperCrew_Mission_Mechanics\functions";
			class initInteractionObjective {}; // reapercrew_mission_mechanics_fnc_initInteractionObjective
			class initTimedTask {}; // reapercrew_mission_mechanics_fnc_initTimedTask
		};
	};
};
class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit;
			class Combo;
			class Checkbox;
			class CheckboxNumber;
			class ModuleDescription;
			class Units;
		};
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
	class reaperCrew_moduleMissionMechanicsBase: Module_F
	{
		icon = "RC_Assets_Pack\addons\reaperCrew_Common\data\insignia.paa";
		isGlobal = 0;
		isTriggerActivated = 0;
		isDisposable = 1;
		is3DEN = 0;
		curatorCanAttach = 1;
		scope = 1;
		scopeCurator = 1;
		functionPriority = 1;
		category = "reaperCrew_ModulesMissionMechanics";
	};
	class reaperCrew_moduleInteractionObjective: reaperCrew_moduleMissionMechanicsBase
	{
		displayName = "Interaction Objective";
		function = "reapercrew_mission_mechanics_fnc_initInteractionObjective";
		scope = 2;
		class Attributes: AttributesBase {
			class actionText: Edit {
				displayName = "Action Text";
				property = "actionText";
				typeName = "STRING";
				tooltip = "Text displayed to the player on the hold action.";
				control = "Edit";
				defaultValue = """Interact""";
			};
			class actionDuration: Edit {
				displayName = "Duration (s)";
				property = "actionDuration";
				typeName = "NUMBER";
				tooltip = "Time in seconds the player must hold the action to complete it.";
				control = "Edit";
				defaultValue = "5";
			};
			class actionCondition: Edit {
				displayName = "Condition";
				property = "actionCondition";
				typeName = "STRING";
				tooltip = "SQF condition for showing the action. Available variables: _target (the object), _this (the player). Must return Boolean.";
				control = "Edit";
				defaultValue = """true""";
			};
			class completionVariable: Edit {
				displayName = "Completion Variable";
				property = "completionVariable";
				typeName = "STRING";
				tooltip = "Global variable name that will be set to true and broadcast via publicVariable when the interaction is completed. Required. Must not clash with engine commands.";
				control = "Edit";
				defaultValue = "";
			};
		};
	};
	class reaperCrew_moduleTimedTask: reaperCrew_moduleMissionMechanicsBase
	{
		displayName = "Timed Task";
		function = "reapercrew_mission_mechanics_fnc_initTimedTask";
		scope = 2;
		class Attributes: AttributesBase {
			class startVariable: Edit {
				displayName = "Start Variable";
				property = "startVariable";
				typeName = "STRING";
				tooltip = "Global variable name that triggers the timer when set to true. Required.";
				control = "Edit";
				defaultValue = "";
			};
			class inProgressVariable: Edit {
				displayName = "In-Progress Variable";
				property = "inProgressVariable";
				typeName = "STRING";
				tooltip = "Global variable name set to true while the timer is running, false when done. Required.";
				control = "Edit";
				defaultValue = "";
			};
			class completedVariable: Edit {
				displayName = "Completed Variable";
				property = "completedVariable";
				typeName = "STRING";
				tooltip = "Global variable name set to true when the timer finishes. Required. Must not clash with engine commands (e.g. use 'obj1_completed' not 'taskCompleted').";
				control = "Edit";
				defaultValue = "";
			};
			class taskDuration: Edit {
				displayName = "Duration (s)";
				property = "taskDuration";
				typeName = "NUMBER";
				tooltip = "How long the task runs for in seconds.";
				control = "Edit";
				defaultValue = "300";
			};
			class broadcastProgress: Checkbox {
				displayName = "Broadcast Progress";
				property = "broadcastProgress";
				typeName = "BOOL";
				tooltip = "Announce progress percentage to all players via side chat every 60 seconds.";
				control = "Checkbox";
				defaultValue = "true";
			};
			class broadcastMessage: Edit {
				displayName = "Broadcast Message";
				property = "broadcastMessage";
				typeName = "STRING";
				tooltip = "Prefix for the side chat progress message (e.g. 'Download progress' becomes 'Download progress: 45% complete').";
				control = "Edit";
				defaultValue = """Task progress""";
			};
		};
	};
};
