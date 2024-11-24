class CfgPatches
{
	class reaperCrew_CUP_SimpleObjects
	{
		units[] = {""};
		weapons[] = {""};
		vehicles[] = {""};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "cba_settings", "reaperCrew_SimpleObjects", "AiA_BaseConfig_F", "AiA_CA_Config"};
		skipWhenMissingDependencies = 1;
	};
};
class CfgAddons 
{
	class PreloadAddons 
	{
		class reaperCrew_CUP_SimpleObjects
		{
			list[] = {"reaperCrew_CUP_SimpleObjects"};
		};
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