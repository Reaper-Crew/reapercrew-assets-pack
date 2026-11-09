class CfgPatches
{
	class reaperCrew_Buildings
	{
		units[] = {"reaperCrew_Bunker01", "reaperCrew_Bunker02", "reaperCrew_Bunker03", "reaperCrew_Corridor25A", "reaperCrew_Corridor25B", "reaperCrew_Corridor25C", "reaperCrew_Corridor50A", "reaperCrew_Corridor50B", "reaperCrew_Corridor50C", "reaperCrew_Stairs01", "reaperCrew_HangarMid", "reaperCrew_HangarS", "reaperCrew_HangarN", "reaperCrew_HangarWDoorS", "reaperCrew_HangarWDoorN", "reaperCrew_HangarEDoorS", "reaperCrew_HangarEDoorN", "reaperCrew_HangarSW", "reaperCrew_HangarSE", "reaperCrew_HangarNW", "reaperCrew_HangarNE"};
		weapons[] = {};
		requiredVersion = 2.02;
		requiredAddons[] = {"A3_Structures_F", "A3_Sounds_F", "ReaperCrew_Common"};
	};
};
class CfgEditorSubcategories
{
	class reaperCrewBuildings
	{
		displayName = "Buildings";
	};
};
class CfgAnimationSourceSounds
{
	// Vanilla ramp motor once as a blast door starts moving, ramp slam at each end of travel.
	class reaperCrew_BlastDoorSound
	{
		class DoorMovement
		{
			loop = 0;
			terminate = 1;
			trigger = "(phase factor[0.01,0.02]) * (phase factor[0.99,0.98])";
			sound0[] = {"A3\Sounds_F\environment\structures\doors\ServoRamp\ServoRampSound_1.wss", 3.1622777, 1, 60};
			sound[] = {"sound0", 1};
		};
		class DoorMovementDone1
		{
			loop = 0;
			terminate = 0;
			trigger = "direction * (phase factor[0.98,0.995])";
			sound0[] = {"A3\Sounds_F\environment\structures\doors\ServoRamp\ServoRampSlam.wss", 3.1622777, 1, 60};
			sound[] = {"sound0", 1};
		};
		class DoorMovementDone2: DoorMovementDone1
		{
			trigger = "(1 - direction) * (phase factor[0.02,0.005])";
		};
	};
};
class CfgVehicles
{
	class House_F;
	class reaperCrew_Bunker01: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Bunker 01";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\Bunker01\Bunker01.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
		#include "data\Bunker01\Bunker01_doors.hpp"
	};
	class reaperCrew_Bunker02: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Bunker 02";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\Bunker02\Bunker02.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
		#include "data\Bunker02\Bunker02_doors.hpp"
	};
	class reaperCrew_Bunker03: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Bunker 03";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\Bunker03\Bunker03.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
		#include "data\Bunker03\Bunker03_doors.hpp"
	};
	class reaperCrew_Corridor25A: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Corridor 25 m (straight)";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\Corridor25A\Corridor25A.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_Corridor25B: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Corridor 25 m (bypass)";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\Corridor25B\Corridor25B.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_Corridor25C: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Corridor 25 m (pillar chamber)";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\Corridor25C\Corridor25C.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_Corridor50A: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Corridor 50 m (straight)";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\Corridor50A\Corridor50A.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_Corridor50B: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Corridor 50 m (S-bend)";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\Corridor50B\Corridor50B.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_Corridor50C: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Corridor 50 m (zig-zag)";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\Corridor50C\Corridor50C.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_Stairs01: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Stairs 50 m (switchback)";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\Stairs01\Stairs01.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_HangarMid: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Hangar block: interior";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\HangarMid\HangarMid.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_HangarS: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Hangar block: south wall";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\HangarS\HangarS.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_HangarN: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Hangar block: north wall";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\HangarN\HangarN.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_HangarWDoorS: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Hangar block: west doors, south half";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\HangarWDoorS\HangarWDoorS.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_HangarWDoorN: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Hangar block: west doors, north half";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\HangarWDoorN\HangarWDoorN.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_HangarEDoorS: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Hangar block: east doors, south half";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\HangarEDoorS\HangarEDoorS.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_HangarEDoorN: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Hangar block: east doors, north half";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\HangarEDoorN\HangarEDoorN.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_HangarSW: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Hangar block: south-west corner";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\HangarSW\HangarSW.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_HangarSE: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Hangar block: south-east corner";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\HangarSE\HangarSE.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_HangarNW: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Hangar block: north-west corner";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\HangarNW\HangarNW.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
	class reaperCrew_HangarNE: House_F
	{
		scope = 2;
		scopeCurator = 2;
		displayName = "Hangar block: north-east corner";
		model = "rc_assets_pack\addons\reaperCrew_Buildings\data\HangarNE\HangarNE.p3d";
		editorCategory = "reaperCrew";
		editorSubcategory = "reaperCrewBuildings";
		destrType = "DestructNo";
	};
};
// Eden compositions (Groups tab, side Empty), in the CfgGroups form CUP Terrains uses: positions in metres from the
// composition centre (x east, y north), dir in degrees.
class CfgGroups
{
	class Empty
	{
		class reaperCrew
		{
			name = "Reaper Crew";
			class Buildings
			{
				name = "Buildings";
				class reaperCrew_HoldingPen
				{
					name = "Holding Pen (200 x 200 m hangar)";
					icon = "\a3\ui_f\data\map\mapcontrol\bunker_ca.paa";
					side = 8;
				class Object1
					{
						side = 8;
						vehicle = "reaperCrew_HangarSW";
						rank = "";
						position[] = {-75, -75, 0};
						dir = 0;
					};
					class Object2
					{
						side = 8;
						vehicle = "reaperCrew_HangarS";
						rank = "";
						position[] = {-25, -75, 0};
						dir = 0;
					};
					class Object3
					{
						side = 8;
						vehicle = "reaperCrew_HangarS";
						rank = "";
						position[] = {25, -75, 0};
						dir = 0;
					};
					class Object4
					{
						side = 8;
						vehicle = "reaperCrew_HangarSE";
						rank = "";
						position[] = {75, -75, 0};
						dir = 0;
					};
					class Object5
					{
						side = 8;
						vehicle = "reaperCrew_HangarWDoorS";
						rank = "";
						position[] = {-75, -25, 0};
						dir = 0;
					};
					class Object6
					{
						side = 8;
						vehicle = "reaperCrew_HangarMid";
						rank = "";
						position[] = {-25, -25, 0};
						dir = 0;
					};
					class Object7
					{
						side = 8;
						vehicle = "reaperCrew_HangarMid";
						rank = "";
						position[] = {25, -25, 0};
						dir = 0;
					};
					class Object8
					{
						side = 8;
						vehicle = "reaperCrew_HangarEDoorS";
						rank = "";
						position[] = {75, -25, 0};
						dir = 0;
					};
					class Object9
					{
						side = 8;
						vehicle = "reaperCrew_HangarWDoorN";
						rank = "";
						position[] = {-75, 25, 0};
						dir = 0;
					};
					class Object10
					{
						side = 8;
						vehicle = "reaperCrew_HangarMid";
						rank = "";
						position[] = {-25, 25, 0};
						dir = 0;
					};
					class Object11
					{
						side = 8;
						vehicle = "reaperCrew_HangarMid";
						rank = "";
						position[] = {25, 25, 0};
						dir = 0;
					};
					class Object12
					{
						side = 8;
						vehicle = "reaperCrew_HangarEDoorN";
						rank = "";
						position[] = {75, 25, 0};
						dir = 0;
					};
					class Object13
					{
						side = 8;
						vehicle = "reaperCrew_HangarNW";
						rank = "";
						position[] = {-75, 75, 0};
						dir = 0;
					};
					class Object14
					{
						side = 8;
						vehicle = "reaperCrew_HangarN";
						rank = "";
						position[] = {-25, 75, 0};
						dir = 0;
					};
					class Object15
					{
						side = 8;
						vehicle = "reaperCrew_HangarN";
						rank = "";
						position[] = {25, 75, 0};
						dir = 0;
					};
					class Object16
					{
						side = 8;
						vehicle = "reaperCrew_HangarNE";
						rank = "";
						position[] = {75, 75, 0};
						dir = 0;
					};
				};
			};
		};
	};
};
