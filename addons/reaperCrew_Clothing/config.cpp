class CfgPatches
{
	class RC_Headgear
	{
		weapons[]={"RC_Beret_01", "RC_MTP_Uniform", "RC_MTP_Medic_Uniform"};
		requiredVersion=0.100000;
		requiredAddons[]={"ReaperCrew_Common"};
		units[]={"MTP_Soldier_F", "MTP_Soldier_F_Medic"};
	};
};
class CfgWeapons
{
	class H_Beret_Colonel;
	class RC_Beret_01: H_Beret_Colonel
	{
		author="Reaper Crew";
		scope=2;
		displayName="Beret (Reaper Crew)";
		picture="\reaperCrew_Common\data\reaperLogo.paa";
		hiddenSelections[]=
		{
			"Camo"
		};
		hiddenSelectionsTextures[]=
		{
			"\reaperCrew_Clothing\data\Beret\headgear_beret02_reapercrew_co.paa"
		};
	};
	class U_B_CombatUniform_mcam_vest;
	class U_B_CombatUniform_mcam;
	class Uniform_Base;
	class UniformItem;
	class RC_MTP_Uniform: U_B_CombatUniform_mcam
	{
		scope=2;
		displayName="RC MTP Uniform";
		picture="\A3\characters_f\data\ui\icon_U_B_CombatUniform_mcam_ca.paa";
		model="\A3\Characters_F\Common\Suitpacks\suitpack_blufor_soldier";
		class ItemInfo: UniformItem
		{
			uniformModel="-";
			uniformClass="MTP_Soldier_F";
			containerClass="Supply40";
			mass=40;
		};
	};
	class RC_MTP_Medic_Uniform: U_B_CombatUniform_mcam_vest
	{
		scope=2;
		displayName="RC MTP Uniform (Medic)";
		picture="reaperCrew_Common\data\insignia.paa";
		model="\A3\Characters_F\Common\Suitpacks\suitpack_blufor_soldier";
		class ItemInfo: UniformItem
		{
			uniformModel="-";
			uniformClass="MTP_Soldier_F_Medic";
			containerClass="Supply40";
			mass=40;
		};
	};
};
class CfgVehicles
{
	class B_Soldier_base_F;
	class MTP_Soldier_F: B_Soldier_base_F
	{
		_generalMacro="B_Soldier_F";
		scope=2;
		displayName="RC MTP Uniform";
		model="\A3\characters_F\BLUFOR\b_soldier_01.p3d";
		nakedUniform="U_BasicBody";
		uniformClass="RC_MTP_Uniform";
		hiddenSelections[]=
		{
			"Camo",
			"Insignia"
		};
		hiddenSelectionsTextures[]=
		{
			"\reaperCrew_Clothing\data\Uniforms\mtp_ReaperCrewUniform_01_co"
		};
	};
	class MTP_Soldier_F_Medic: B_Soldier_base_F
	{
		_generalMacro="B_Soldier_F";
		scope=2;
		displayName="RC MTP Uniform (Medic)";
		model="\A3\characters_F\BLUFOR\b_soldier_03.p3d";
		nakedUniform="U_BasicBody";
		uniformClass="U_B_CombatUniform_mcam_vest";
		hiddenSelections[]=
		{
			"Camo",
			"Insignia"
		};
		hiddenSelectionsTextures[]=
		{
			"\reaperCrew_Clothing\data\Uniforms\mtp_ReaperCrewMedicUniform_01_co.paa"
		};
	};
};