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
	class reaperCrewCamouflageNets // Category class, you point to it in editorSubcategory property
	{
		displayName = "Camouflage Nets"; // Name visible in the list
	};
	class reaperCrewTents // Category class, you point to it in editorSubcategory property
	{
		displayName = "Tents"; // Name visible in the list
	};
	class reaperCrewBuildingBlocks // Category class, you point to it in editorSubcategory property
	{
		displayName = "Building Blocks"; // Name visible in the list
	};
};
class CfgVehicles
{

	#include "desertFortifications.hpp"
	#include "woodlandFortifications.hpp"
	#include "genericFortifications.hpp"
	#include "camonets.hpp"
	#include "tents.hpp"
	class reaperCrew_BuildingBlock_Base: Land_ConcreteHedgehog_01_F {
		editorCategory = "reaperCrew";
    	editorSubcategory = "reaperCrewBuildingBlocks";
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
	class RC_ConcreteBlock50m: reaperCrew_BuildingBlock_Base {
		displayName="50x25x2m Concrete Block";
		model="rc_assets_pack\addons\reaperCrew_SimpleObjects\data\50x25x2Slab\50x25x2Slab.p3d";
	};
	#include "data\25mWall\25mWall.hpp"
	#include "data\4mWall\4mWall.hpp"
	class reaperCrew_BunkerTemplate1: reaperCrew_BuildingBlock_Base {
		displayName="Bunker Template 1";
		model="rc_assets_pack\addons\reaperCrew_SimpleObjects\data\UndergroundTemplate1\UnderGroundTemplate1.p3d";
	};
	#include "data\ServerRack\ServerRack.hpp"

};