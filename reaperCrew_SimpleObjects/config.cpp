class CfgPatches
{
	class reaperCrew_SimpleObjects
	{
		units[] = {""};
		weapons[] = {""};
		vehicles[] = {""};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "cba_settings"};
	};
};
class CfgAddons 
{
	class PreloadAddons 
	{
		class reaperCrew_SimpleObjects
		{
			list[] = {"reaperCrew_SimpleObjects"};
		};
	};
};
class CfgEditorSubcategories
{
	class reaperCrewFortificationsWoodland // Category class, you point to it in editorSubcategory property
	{
		displayName = "Fortifications (Woodland)"; // Name visible in the list
	};
    class reaperCrewFortificationsDesert // Category class, you point to it in editorSubcategory property
	{
		displayName = "Fortifications (Desert)"; // Name visible in the list
	};
    class reaperCrewFortificationsGeneric // Category class, you point to it in editorSubcategory property
	{
		displayName = "Fortifications (Generic)"; // Name visible in the list
	};
};
class CfgVehicles
{
    class Land_HBarrier_01_line_3_green_F;
    class Land_HBarrier_01_line_5_green_F;
    class Land_HBarrier_01_big_4_green_F;
    class Land_HBarrier_01_wall_6_green_F;
    class Land_HBarrier_01_big_tower_green_F;
    class Land_BagBunker_01_large_green_F;
    class Land_BagBunker_01_small_green_F;
    class Land_HBarrier_01_tower_green_F;

    class Land_HBarrier_3_F;
    class Land_HBarrier_5_F;
    class Land_HBarrier_Big_F;
    class Land_HBarrierWall6_F;
    class Land_HBarrierTower_F;
    class Land_BagBunker_Large_F;
    class Land_BagBunker_Small_F;
    class Land_BagBunker_Tower_F;

    class Land_ConcreteHedgehog_01_F;
    class Land_Mil_ConcreteWall_F;
    class Land_CncBarrier_F;
    class Land_CncBarrierMedium_F;
    class Land_CncBarrierMedium4_F;
    class Land_CncBarrier_stripes_F;
    class Land_CncWall1_F;
    class Land_CncWall4_F;
    class Land_Razorwire_F;

	class Land_BagFence_Corner_F;
	class Land_BagFence_End_F;
	class Land_BagFence_Long_F;
	class Land_BagFence_Round_F;
	class Land_BagFence_Short_F;

	class Land_BagFence_01_corner_green_F;
	class Land_BagFence_01_end_green_F;
	class Land_BagFence_01_long_green_F;
	class Land_BagFence_01_round_green_F;
	class Land_BagFence_01_short_green_F;

    class RC_Land_HBarrier_01_line_3_green_F: Land_HBarrier_01_line_3_green_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_HBarrier_01_line_5_green_F: Land_HBarrier_01_line_5_green_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_HBarrier_01_big_4_green_F: Land_HBarrier_01_big_4_green_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_HBarrier_01_wall_6_green_F: Land_HBarrier_01_wall_6_green_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_HBarrier_01_big_tower_green_F: Land_HBarrier_01_big_tower_green_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagBunker_01_large_green_F: Land_BagBunker_01_large_green_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagBunker_01_small_green_F: Land_BagBunker_01_small_green_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_HBarrier_01_tower_green_F: Land_HBarrier_01_tower_green_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagFence_01_corner_green_F: Land_BagFence_01_corner_green_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagFence_01_end_green_F: Land_BagFence_01_end_green_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagFence_01_long_green_F: Land_BagFence_01_long_green_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagFence_01_round_green_F: Land_BagFence_01_round_green_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagFence_01_short_green_F: Land_BagFence_01_short_green_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };

    class RC_Land_HBarrier_3_F: Land_HBarrier_3_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsDesert";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_HBarrier_5_F: Land_HBarrier_5_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsDesert";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_HBarrier_Big_F: Land_HBarrier_Big_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsWoodland";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_HBarrierWall6_F: Land_HBarrierWall6_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsDesert";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_HBarrierTower_F: Land_HBarrierTower_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsDesert";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagBunker_Large_F: Land_BagBunker_Large_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsDesert";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagBunker_Small_F: Land_BagBunker_Small_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsDesert";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagBunker_Tower_F: Land_BagBunker_Tower_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsDesert";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagFence_Corner_F: Land_BagFence_Corner_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsDesert";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagFence_End_F: Land_BagFence_End_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsDesert";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagFence_Long_F: Land_BagFence_Long_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsDesert";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagFence_Round_F: Land_BagFence_Round_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsDesert";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_BagFence_Short_F: Land_BagFence_Short_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsDesert";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };

    class RC_Land_ConcreteHedgehog_01_F: Land_ConcreteHedgehog_01_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsGeneric";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_Mil_ConcreteWall_F: Land_Mil_ConcreteWall_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsGeneric";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_CncBarrier_F: Land_CncBarrier_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsGeneric";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_CncBarrierMedium_F: Land_CncBarrierMedium_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsGeneric";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_CncBarrierMedium4_F: Land_CncBarrierMedium4_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsGeneric";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_CncBarrier_stripes_F: Land_CncBarrier_stripes_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsGeneric";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_CncWall1_F: Land_CncWall1_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsGeneric";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_CncWall4_F: Land_CncWall4_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsGeneric";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
    class RC_Land_Razorwire_F: Land_Razorwire_F {
        editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewFortificationsGeneric";
        class SimpleObject
		{
			eden=1;
			animate[]={};
			hide[]={};
			verticalOffset=0.382000;
			verticalOffsetWorld=0;
			init="''";
		};
    };
};