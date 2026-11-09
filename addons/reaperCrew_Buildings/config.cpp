class CfgPatches
{
	class reaperCrew_Buildings
	{
		units[] = {"reaperCrew_HangarMid", "reaperCrew_HangarS", "reaperCrew_HangarN", "reaperCrew_HangarWDoorS", "reaperCrew_HangarWDoorN", "reaperCrew_HangarEDoorS", "reaperCrew_HangarEDoorN", "reaperCrew_HangarSW", "reaperCrew_HangarSE", "reaperCrew_HangarNW", "reaperCrew_HangarNE"};
		weapons[] = {};
		requiredVersion = 2.02;
		requiredAddons[] = {"A3_Structures_F", "ReaperCrew_Common"};
	};
};
class CfgEditorSubcategories
{
	class reaperCrewBuildings
	{
		displayName = "Buildings";
	};
};
class CfgVehicles
{
	class House_F;
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
