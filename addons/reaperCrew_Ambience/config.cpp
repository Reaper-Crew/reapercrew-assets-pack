class CfgPatches
{
	class reaperCrew_Ambience
	{
		units[] = {"reaperCrew_moduleAmbienceBase", "reaperCrew_moduleAmbientCAS"};
		weapons[] = {""};
		vehicles[] = {""};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "ReaperCrew_Common"};
	};
};
class cfgFactionClasses
{
	class NO_CATEGORY;
	class reaperCrew_ModulesAmbience: NO_CATEGORY
	{
		displayName = "Reaper Crew - Ambience";
		scope = 2;
		scopeCurator = 2;
	};
};
class CfgEditorCategories
{
	class NO_CATEGORY;
	class reaperCrew_ModulesAmbience: NO_CATEGORY
	{
		displayName = "Reaper Crew - Ambience";
		scope = 2;
		scopeCurator = 2;
	};
};
class CfgFunctions
{
	class reapercrew_ambience
	{
		class Effects
		{
			file = "rc_assets_pack\addons\reaperCrew_Ambience\functions";
			class initAmbientCAS {}; // reapercrew_ambience_fnc_initAmbientCAS
			class activateAmbientCAS {}; // reapercrew_ambience_fnc_activateAmbientCAS
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
	class reaperCrew_moduleAmbienceBase: Module_F
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
		category = "reaperCrew_ModulesAmbience";
	};
	class reaperCrew_moduleAmbientCAS: reaperCrew_moduleAmbienceBase
	{
		displayName = "Ambient CAS";
		function = "reapercrew_ambience_fnc_initAmbientCAS";
		scope = 2;
		canSetArea = 1;
		canSetAreaShape = 1;
		class AttributeValues {
			size3[] = {500, 500, -1};
		};
		class Attributes: AttributesBase {
			class aircraftClass: Edit {
				displayName = "Aircraft Classname";
				property = "aircraftClass";
				typeName = "STRING";
				tooltip = "Classname of the aircraft used for CAS strikes.";
				control = "Edit";
				defaultValue = """B_Plane_CAS_01_F""";
			};
			class strikeType: Edit {
				displayName = "Strike Type";
				property = "strikeType";
				typeName = "NUMBER";
				tooltip = "CAS type passed to BIS_fnc_moduleCAS. 0 = gun run, 1 = bomb run, 2 = rockets.";
				control = "Edit";
				defaultValue = "1";
			};
			class strikeDir: Edit {
				displayName = "Strike Direction";
				property = "strikeDir";
				typeName = "NUMBER";
				tooltip = "Direction of the attack run in degrees.";
				control = "Edit";
				defaultValue = "0";
			};
			class proximityEnabled: Checkbox {
				displayName = "Proximity Check";
				property = "proximityEnabled";
				typeName = "BOOL";
				tooltip = "Only execute strikes when players are within the proximity range. Saves performance when no one is nearby.";
				control = "Checkbox";
				defaultValue = "true";
			};
			class proximityRange: Edit {
				displayName = "Proximity Range (m)";
				property = "proximityRange";
				typeName = "NUMBER";
				tooltip = "Players must be within this 2D distance of the module for strikes to fire.";
				control = "Edit";
				defaultValue = "2000";
			};
			class avoidPlayers: Checkbox {
				displayName = "Avoid Players";
				property = "avoidPlayers";
				typeName = "BOOL";
				tooltip = "Attempt to place strikes away from player positions. Creates near-misses rather than direct hits.";
				control = "Checkbox";
				defaultValue = "false";
			};
			class avoidRadius: Edit {
				displayName = "Avoid Radius (m)";
				property = "avoidRadius";
				typeName = "NUMBER";
				tooltip = "Minimum 2D distance from any player for a strike position. Only used when Avoid Players is enabled.";
				control = "Edit";
				defaultValue = "500";
			};
			class delayMin: Edit {
				displayName = "Delay Min (s)";
				property = "delayMin";
				typeName = "NUMBER";
				tooltip = "Minimum seconds between strikes.";
				control = "Edit";
				defaultValue = "30";
			};
			class delayMax: Edit {
				displayName = "Delay Max (s)";
				property = "delayMax";
				typeName = "NUMBER";
				tooltip = "Maximum seconds between strikes.";
				control = "Edit";
				defaultValue = "180";
			};
		};
	};
};
