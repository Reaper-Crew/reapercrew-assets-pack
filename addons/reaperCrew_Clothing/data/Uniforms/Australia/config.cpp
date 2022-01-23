class CfgPatches
{
	class ReaperCrew_Pacific_Uniforms
	{
		units[]=
		{
			"AUSCAM_RC_Medic_Kitbag",
			"AUSCAM_RC_Kitbag",
			"AUSCAM_RC_Radio",
			"AUSCAM_Soldier_2_F",
			"AUSCAM_Soldier_2_Rolled_F"
		};
		weapons[]=
		{
			"RC_AUSCAM_Uniform_2",
			"RC_AUSCAM_Uniform_2_Rolled",
			"RC_AUSCAM_Vest_1",
			"RC_AUSCAM_Vest_2",
			"RC_AUSCAM_Helmet",
			"RC_AUSCAM_Enh_Helmet",
			"RC_A_Boonie"
		};
		requiredVersion=0.100000;
		requiredAddons[]=
		{
			"A3_Data_F_Oldman_Loadorder"
		};
	};
};
class CfgMods
{
	class Mod_Base;
	class ReaperCrew_Mods: Mod_Base
	{
		logo="rc_assets_pack\addons\reaperCrew_Common\data\reaperLogo.paa";
	};
	author="Ernst";
	timepacked="1607182564";
};
class CfgVehicles
{
	class B_RadioBag_01_base_F;
	class B_Kitbag_tan;
	class B_Soldier_base_F;
	class B_Soldier_F;
	class I_G_Soldier_universal_F;
	class AUSCAM_RC_Medic_Kitbag: B_Kitbag_tan
	{
		author="Reaper Crew";
		_generalMacro="SanRuckTrop23LLK";
		scope=2;
		picture="rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\UI\AUSCAM_Logo_co.paa";
		maximumLoad=280;
		displayName="[RC] Kitbag Australia (Medic)";
		hiddenSelectionsTextures[]=
		{
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\AUSCAM_RC_Medic_Kitbag_1_co.paa"
		};
	};
	class AUSCAM_RC_Kitbag: B_Kitbag_tan
	{
		author="Reaper Crew";
		_generalMacro="SanRuckTrop23LLK";
		scope=2;
		picture="rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\UI\AUSCAM_Logo_co.paa";
		maximumLoad=280;
		displayName="[RC] Kitbag Australia";
		hiddenSelectionsTextures[]=
		{
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\AUSCAM_RC_Kitbag_1_co.paa"
		};
	};
	class AUSCAM_RC_Radio: B_RadioBag_01_base_F
	{
		author="Reaper Crew";
		_generalMacro="SanRuckTrop23LLK";
		scope=2;
		picture="rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\UI\AUSCAM_Logo_co.paa";
		displayName="[RC] Radio Pack Australia";
		hiddenSelectionsTextures[]=
		{
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\AUSCAM_RC_Radio_co.paa"
		};
	};
	class AUSCAM_Soldier_2_F: I_G_Soldier_universal_F
	{
		_generalMacro="I_G_Soldier_universal_F";
		scope=1;
		displayName="Combat Uniform (Australia) 2";
		model="\A3\characters_f_beta\INDEP\ia_soldier_01.p3d";
		nakedUniform="U_BasicBody";
		uniformClass="RC_AUSCAM_Uniform_2";
		hiddenSelections[]=
		{
			"Camo",
			"Insignia"
		};
		hiddenSelectionsTextures[]=
		{
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\AUSCAM_RC_Uniform_2_co.paa"
		};
	};
	class AUSCAM_Soldier_2_Rolled_F: I_G_Soldier_universal_F
	{
		_generalMacro="I_G_Soldier_universal_F";
		scope=1;
		displayName="Combat Uniform (Australia) 2";
		model="\A3\characters_f_beta\INDEP\ia_soldier_02.p3d";
		nakedUniform="U_BasicBody";
		uniformClass="RC_AUSCAM_Uniform_2_Rolled";
		hiddenSelections[]=
		{
			"Camo",
			"Insignia"
		};
		hiddenSelectionsTextures[]=
		{
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\AUSCAM_RC_Uniform_2_co.paa"
		};
	};
};
class cfgWeapons
{
	class U_B_CombatUniform_mcam_vest;
	class U_B_CombatUniform_mcam;
	class U_I_CombatUniform_shortsleeve;
	class V_PlateCarrier1_rgr;
	class V_PlateCarrier1_blk;
	class V_PlateCarrier2_blk;
	class H_HelmetIA;
	class H_HelmetB;
	class H_HelmetSpecB;
	class H_Booniehat_khk;
	class Uniform_Base;
	class HeadgearItem;
	class UniformItem;
	class VestItem;
	class ItemCore;
	class Vest_Camo_base: ItemCore
	{
		class ItemInfo;
	};
	class RC_AUSCAM_Uniform_2: U_I_CombatUniform_shortsleeve
	{
		scope=2;
		displayName="[RC] Combat Fatigues (Australia)";
		picture="rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\UI\AUSCAM_Logo_co.paa";
		model="\A3\Characters_F\Common\Suitpacks\suitpack_original_F";
		class ItemInfo: UniformItem
		{
			uniformModel="-";
			uniformClass="AUSCAM_Soldier_2_F";
			containerClass="Supply40";
			mass=40;
		};
	};
	class RC_AUSCAM_Uniform_2_Rolled: U_I_CombatUniform_shortsleeve
	{
		scope=2;
		displayName="[RC] Combat Fatigues (Australia) (Rolled-up)";
		picture="rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\UI\AUSCAM_Logo_co.paa";
		model="\A3\Characters_F\Common\Suitpacks\suitpack_original_F";
		class ItemInfo: UniformItem
		{
			uniformModel="-";
			uniformClass="AUSCAM_Soldier_2_Rolled_F";
			containerClass="Supply40";
			mass=40;
		};
	};
	class RC_AUSCAM_Vest_1: V_PlateCarrier1_blk
	{
		author="ReaperCrew";
		scope=2;
		displayName="[RC] Carrier Lite (Australia)";
		picture="rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\UI\AUSCAM_Logo_co.paa";
		hiddenSelectionsTextures[]=
		{
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\AUSCAM_RC_Vest_1_co"
		};
	};
	class RC_AUSCAM_Vest_2: V_PlateCarrier2_blk
	{
		author="ReaperCrew";
		scope=2;
		displayName="[RC] Carrier Rig (Australia)";
		picture="rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\UI\AUSCAM_Logo_co.paa";
		hiddenSelectionsTextures[]=
		{
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\AUSCAM_RC_Vest_1_co"
		};
	};
	class RC_AUSCAM_Helmet: H_HelmetB
	{
		scope=2;
		author="Reaper Crew";
		weaponPoolAvailable=1;
		displayName="[RC] Combat Helmet (Australia)";
		picture="rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\UI\AUSCAM_Logo_co.paa";
		hiddenSelectionsTextures[]=
		{
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\AUSCAM_RC_Helmet_1_co"
		};
	};
	class RC_AUSCAM_Enh_Helmet: H_HelmetSpecB
	{
		scope=2;
		author="Reaper Crew";
		weaponPoolAvailable=1;
		displayName="[RC] Enhanced Combat Helmet (Australia)";
		picture="rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\UI\AUSCAM_Logo_co.paa";
		hiddenSelectionsTextures[]=
		{
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\AUSCAM_RC_Helmet_1_co"
		};
	};
	class RC_A_Boonie: H_Booniehat_khk
	{
		scope=2;
		displayName="[RC] Booniehat (Australia)";
		picture="rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\UI\AUSCAM_Logo_co.paa";
		hiddenSelectionsTextures[]=
		{
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\Australia\data\AUSCAM_RC_Boonie_1_co"
		};
	};
};
