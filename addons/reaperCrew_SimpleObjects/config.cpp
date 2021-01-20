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
};
class CfgVehicles
{

	#include "desertFortifications.hpp"
	#include "woodlandFortifications.hpp"
	#include "genericFortifications.hpp"
	#include "camonets.hpp"
	#include "tents.hpp"

};