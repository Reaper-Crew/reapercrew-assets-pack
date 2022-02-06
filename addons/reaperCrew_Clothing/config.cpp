class CfgPatches
{
	class RC_Headgear
	{
		author="Reaper Crew";
		weapons[]=
		{
			"RC_Beret_01", 
			"RC_MTP_Uniform", 
			"RC_MTP_Medic_Uniform"
		};
		units[]=
		{
			"MTP_Soldier_F", 
			"MTP_Soldier_F_Medic"
		};
		requiredVersion=0.100000;
		requiredAddons[]=
		{
			"ReaperCrew_Common", 
			"A3_Data_F_Oldman_Loadorder"
		};
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
		picture="rc_assets_pack\addons\reaperCrew_Common\data\reaperLogo.paa";
		hiddenSelections[]=
		{
			"Camo"
		};
		hiddenSelectionsTextures[]=
		{
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Beret\headgear_beret02_reapercrew_co.paa"
		};
	};
	class U_B_CombatUniform_mcam_vest;
	class U_B_CombatUniform_mcam;
	class U_I_CombatUniform_shortsleeve;
	class V_PlateCarrier1_rgr;
	class V_PlateCarrier1_blk;
	class V_PlateCarrier2_blk;
	class H_HelmetIA;
	class H_HelmetB;
	class H_HelmetSpecB;
	class B_Kitbag_tan;
	class H_Booniehat_khk;
	class Uniform_Base;
	class HeadgearItem;
	class UniformItem;
	class VestItem;
	class ItemCore;
	class B_Radiobag_01_base_F;
	class Vest_Camo_base: ItemCore
	{
		class ItemInfo;
	};
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
		picture="rc_assets_pack\addons\reaperCrew_Common\data\insignia.paa";
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
		scope=1;
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
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\mtp_ReaperCrewUniform_01_co"
		};
	};
	class MTP_Soldier_F_Medic: B_Soldier_base_F
	{
		_generalMacro="B_Soldier_F";
		scope=1;
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
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\mtp_ReaperCrewMedicUniform_01_co.paa"
		};
	};
};
class CfgUnitInsignia
{	

				// Zero / Platoon

	class reaperCrew_PlatoonJTAC
	{
		displayName="[RC] Platoon JTAC";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Zero1_JTAC.paa";
		textureVehicle="";
	};
	class reaperCrew_PlatoonCommander
	{
		displayName="[RC] Platoon Commander";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Zero1_CMD.paa";
		textureVehicle="";
	};
	class reaperCrew_PlatoonSergeant
	{
		displayName="[RC] Platoon Sergeant";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Zero1_SGT.paa";
		textureVehicle="";
	};
	class reaperCrew_platoonMedic
	{
		displayName="[RC] Platoon Medic";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Zero1_Medic.paa";
		textureVehicle="";
	};
	class reaperCrew_platoonLogiCommand
	{
		displayName="[RC] Platoon Logistics Commander";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Zero1_Logi_CMD.paa";
		textureVehicle="";
	};

				// Infantry / backup slots

	class reaperCrew_SectionCommander
	{
		displayName="[RC] Section Commander (Infantry)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Infantry_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_2IC
	{
		displayName="[RC] Section 2IC (Infantry) ";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Infantry_2IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Medic
	{
		displayName="[RC] Section Medic (Infantry)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Infantry_Medic.paa";
		textureVehicle="";
	};
	class reaperCrew_Machinegunner
	{
		displayName="[RC] Section Machine Gunner (Infantry)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Infantry_mg.paa";
		textureVehicle="";
	};
	class reaperCrew_MG_ASSIST
	{
		displayName="[RC] Section Asst. Machine Gunner (Infantry)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Infantry_mgAssist.paa";
		textureVehicle="";
	};
	class reaperCrew_Engineer
	{
		displayName="[RC] Section Engineer (Infantry)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Infantry_Engineer.paa";
		textureVehicle="";
	};
	class reaperCrew_jtac
	{
		displayName="[RC] JTAC (WIP)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Infantry_Rifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Marksman
	{
		displayName="[RC] Section Marksman (Infantry)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Infantry_Marksman.paa";
		textureVehicle="";
	};
	class reaperCrew_Rifleman
	{
		displayName="[RC] Section Rifleman (Infantry)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Infantry_Rifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_AA
	{
		displayName="[RC] Section AA (Infantry)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Infantry_AA.paa";
		textureVehicle="";
	};
	class reaperCrew_AT
	{
		displayName="[RC] Section AT (Infantry)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Infantry_AT.paa";
		textureVehicle="";
	};

				// Reaper 1-1

	class reaperCrew_section_11_1IC
	{
		displayName="[RC] Section Commander (1-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper1_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_section_11_2IC
	{
		displayName="[RC] Section 2IC (1-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper1_2IC.paa";
		textureVehicle="";
	};
	class reaperCrew_section_11_AA
	{
		displayName="[RC] Section AA (1-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper1_AA.paa";
		textureVehicle="";
	};
	class reaperCrew_section_11_AT
	{
		displayName="[RC] Section AT (1-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper1_AT.paa";
		textureVehicle="";
	};
	class reaperCrew_section_11_Engineer
	{
		displayName="[RC] Section Engineer (1-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper1_Engineer.paa";
		textureVehicle="";
	};
	class reaperCrew_section_11_Marksman
	{
		displayName="[RC] Section Marksman (1-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper1_Marksman.paa";
		textureVehicle="";
	};
	class reaperCrew_section_11_Medic
	{
		displayName="[RC] Section Medic (1-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper1_Medic.paa";
		textureVehicle="";
	};
	class reaperCrew_section_11_mg
	{
		displayName="[RC] Section Machine Gunner (1-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper1_MG.paa";
		textureVehicle="";
	};
	class reaperCrew_section_11_mgAssist
	{
		displayName="[RC] Section Asst. Machine Gunner (1-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper1_MG.paa";
		textureVehicle="";
	};
	class reaperCrew_section_11_rifleman
	{
		displayName="[RC] Section Rifleman (1-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper1_Rifleman.paa";
		textureVehicle="";
	};

				// Reaper 1-2

	class reaperCrew_section_12_1IC
	{
		displayName="[RC] Section Commander (1-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper2_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_section_12_2IC
	{
		displayName="[RC] Section 2IC (1-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper2_2IC.paa";
		textureVehicle="";
	};
	class reaperCrew_section_12_AA
	{
		displayName="[RC] Section AA (1-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper2_AA.paa";
		textureVehicle="";
	};
	class reaperCrew_section_12_AT
	{
		displayName="[RC] Section AT (1-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper2_AT.paa";
		textureVehicle="";
	};
	class reaperCrew_section_12_Engineer
	{
		displayName="[RC] Section Engineer (1-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper1_Engineer.paa";
		textureVehicle="";
	};
	class reaperCrew_section_12_Marksman
	{
		displayName="[RC] Section Marksman (1-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper2_Marksman.paa";
		textureVehicle="";
	};
	class reaperCrew_section_12_Medic
	{
		displayName="[RC] Section Medic (1-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper2_Medic.paa";
		textureVehicle="";
	};
	class reaperCrew_section_12_mg
	{
		displayName="[RC] Section Machine Gunner (1-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper2_MG.paa";
		textureVehicle="";
	};
	class reaperCrew_section_12_mgAssist
	{
		displayName="[RC] Section Asst. Machine Gunner (1-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper2_MG.paa";
		textureVehicle="";
	};
	class reaperCrew_section_12_rifleman
	{
		displayName="[RC] Section Rifleman (1-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper2_Rifleman.paa";
		textureVehicle="";
	};

				// Reaper 1-3

	class reaperCrew_section_13_1IC
	{
		displayName="[RC] Section Commander (1-3)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper3_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_section_13_2IC
	{
		displayName="[RC] Section 2IC (1-3)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper3_2IC.paa";
		textureVehicle="";
	};
	class reaperCrew_section_13_AA
	{
		displayName="[RC] Section AA (1-3)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper3_AA.paa";
		textureVehicle="";
	};
	class reaperCrew_section_13_AT
	{
		displayName="[RC] Section AT (1-3)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper3_AT.paa";
		textureVehicle="";
	};
	class reaperCrew_section_13_Engineer
	{
		displayName="[RC] Section Engineer (1-3)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper3_Engineer.paa";
		textureVehicle="";
	};
	class reaperCrew_section_13_Marksman
	{
		displayName="[RC] Section Marksman (1-3)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper3_Marksman.paa";
		textureVehicle="";
	};
	class reaperCrew_section_13_Medic
	{
		displayName="[RC] Section Medic (1-3)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper1_Medic.paa";
		textureVehicle="";
	};
	class reaperCrew_section_13_mg
	{
		displayName="[RC] Section Machine Gunner (1-3)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper3_MG.paa";
		textureVehicle="";
	};
	class reaperCrew_section_13_mgAssist
	{
		displayName="[RC] Section Asst. Machine Gunner (1-3)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper1_MG.paa";
		textureVehicle="";
	};
	class reaperCrew_section_13_rifleman
	{
		displayName="[RC] Section Rifleman (1-3)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper3_Rifleman.paa";
		textureVehicle="";
	};

				// Thunder-1

	class reaperCrew_Thunder_SL
	{
		displayName="[RC] Thunder Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Thunder1_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Thunder_2IC
	{
		displayName="[RC] Thunder 2IC";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Thunder1_2IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Thunder_Grunt
	{
		displayName="[RC] Thunder Gunner";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Thunder1_Rifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Thunder_Medic
	{
		displayName="[RC] Thunder Medic";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Thunder1_Medic.paa";
		textureVehicle="";
	};

				// Hammer-1

	class reaperCrew_Artilleryman
	{
		displayName="[RC] Hammer-1 Artilleryman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Hammer1_Rifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Arty_2IC
	{
		displayName="[RC] Hammer-1 2IC";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Hammer1_2IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Arty_Commander
	{
		displayName="[RC] Hammer-1 (Commander)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Hammer1_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Arty_Medic
	{
		displayName="[RC] Hammer-1 Artilleryman (Medic)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Hammer1_1IC.paa";
		textureVehicle="";
	};

				// Shadow-1

	class reaperCrew_Shadow_1_1IC
	{
		displayName="[RC] Shadow-1 Commander";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow1_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_1_2IC
	{
		displayName="[RC] Shadow-1 2IC";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow1_2IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_1_Rifleman
	{
		displayName="[RC] Shadow-1 Rifleman";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow1_Rifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_1_Medic
	{
		displayName="[RC] Shadow-1 Medic";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow1_Medic.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_1_MG
	{
		displayName="[RC] Shadow-1 Machine Gunner";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow1_MG.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_1_MG_Assist
	{
		displayName="[RC] Shadow-1 Assistant Machine Gunner";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow1_mgAssist.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_1_Sniper
	{
		displayName="[RC] Shadow-1 Sniper";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow1_Sniper.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_1_Spotter
	{
		displayName="[RC] Shadow-1 Spotter";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow1_Spotter.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_1_JTAC
	{
		displayName="[RC] Shadow-1 JTAC";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow1_JTAC.paa";
		textureVehicle="";
	};

				// Shadow-2

	class reaperCrew_Shadow_2_1IC
	{
		displayName="[RC] Shadow-2 Commander";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow2_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_2_2IC
	{
		displayName="[RC] Shadow-2 2IC";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow2_2IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_2_Rifleman
	{
		displayName="[RC] Shadow-2 Rifleman";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow2_Rifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_2_Medic
	{
		displayName="[RC] Shadow-2 Medic";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow2_Medic.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_2_MG
	{
		displayName="[RC] Shadow-2 Machine Gunner";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow2_MG.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_2_MG_Assist
	{
		displayName="[RC] Shadow-2 Assistant Machine Gunner";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow2_mgAssist.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_2_Sniper
	{
		displayName="[RC] Shadow-2 Sniper";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow2_Sniper.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_2_Spotter
	{
		displayName="[RC] Shadow-2 Spotter";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow2_Spotter.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_2_JTAC
	{
		displayName="[RC] Shadow-2 JTAC";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow2_JTAC.paa";
		textureVehicle="";
	};

				// Armoured / misc

	class reaperCrew_Armoured_Commander
	{
		displayName="[RC] Armoured Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Armoured_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Armoured_Crew
	{
		displayName="[RC] Armoured Crewman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Armoured_Crew.paa";
		textureVehicle="";
	};
	class reaperCrew_Armoured_Medic
	{
		displayName="[RC] Armoured Crewman (Medic)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Armoured_Medic.paa";
		textureVehicle="";
	};

				// Fury-1

	class reaperCrew_Fury_1_CMD
	{
		displayName="[RC] Fury-1 Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Fury1_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Fury_1_Crew
	{
		displayName="[RC] Fury-1 Crewman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Fury1_Crew.paa";
		textureVehicle="";
	};
	class reaperCrew_Fury_1_Medic
	{
		displayName="[RC] Fury-1 Crewman (Medic)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Fury1_Medic.paa";
		textureVehicle="";
	};

				// Fury-2

	class reaperCrew_Fury_2_CMD
	{
		displayName="[RC] Fury-2 Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Fury2_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Fury_2_Crew
	{
		displayName="[RC] Fury-2 Crewman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Fury2_Crew.paa";
		textureVehicle="";
	};
	class reaperCrew_Fury_2_Medic
	{
		displayName="[RC] Fury-2 Crewman (Medic)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Fury2_Medic.paa";
		textureVehicle="";
	};

				// Fury-3

	class reaperCrew_Fury_3_CMD
	{
		displayName="[RC] Fury-3 Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Fury3_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Fury_3_Crew
	{
		displayName="[RC] Fury-3 Crewman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Fury3_Crew.paa";
		textureVehicle="";
	};
	class reaperCrew_Fury_3_Medic
	{
		displayName="[RC] Fury-3 Crewman (Medic)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Fury3_Medic.paa";
		textureVehicle="";
	};

				// Guardian-1

	class reaperCrew_Guardian_1_CMD
	{
		displayName="[RC] Guardian-1 Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Guardian1_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Guardian_1_Crew
	{
		displayName="[RC] Guardian-1 Crewman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Guardian1_Crew.paa";
		textureVehicle="";
	};
	class reaperCrew_Guardian_1_Medic
	{
		displayName="[RC] Guardian-1 Crewman (Medic)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Guardian1_Medic.paa";
		textureVehicle="";
	};

				// Guardian-2

	class reaperCrew_Guardian_2_CMD
	{
		displayName="[RC] Guardian-2 Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Guardian2_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Guardian_2_Crew
	{
		displayName="[RC] Guardian-2 Crewman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Guardian2_Crew.paa";
		textureVehicle="";
	};
	class reaperCrew_Guardian_2_Medic
	{
		displayName="[RC] Guardian-2 Crewman (Medic)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Guardian2_Medic.paa";
		textureVehicle="";
	};

				// Guardian-3

	class reaperCrew_Guardian_3_CMD
	{
		displayName="[RC] Guardian-3 Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Guardian3_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Guardian_3_Crew
	{
		displayName="[RC] Guardian-3 Crewman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Guardian3_Crew.paa";
		textureVehicle="";
	};
	class reaperCrew_Guardian_3_Medic
	{
		displayName="[RC] Guardian-3 Crewman (Medic)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Guardian3_Medic.paa";
		textureVehicle="";
	};
		
				// Sentinel-1

	class reaperCrew_Sentinel_1_CMD
	{
		displayName="[RC] Sentinel-1 Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Sentinel1_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Sentinel_1_Crew
	{
		displayName="[RC] Sentinel-1 Crewman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Sentinel1_Crew.paa";
		textureVehicle="";
	};
	class reaperCrew_Sentinel_1_Medic
	{
		displayName="[RC] Sentinel-1 Crewman (Medic)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Sentinel1_Medic.paa";
		textureVehicle="";
	};
		
				// Sentinel-2

	class reaperCrew_Sentinel_2_CMD
	{
		displayName="[RC] Sentinel-2 Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Sentinel2_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Sentinel_2_Crew
	{
		displayName="[RC] Sentinel-2 Crewman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Sentinel2_Crew.paa";
		textureVehicle="";
	};
	class reaperCrew_Sentinel_2_Medic
	{
		displayName="[RC] Sentinel-2 Crewman (Medic)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Sentinel2_Medic.paa";
		textureVehicle="";
	};
		
				// Sentinel-3

	class reaperCrew_Sentinel_3_CMD
	{
		displayName="[RC] Sentinel-3 Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Sentinel3_1IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Sentinel_3_Crew
	{
		displayName="[RC] Sentinel-3 Crewman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Sentinel3_Crew.paa";
		textureVehicle="";
	};
	class reaperCrew_Sentinel_3_Medic
	{
		displayName="[RC] Sentinel-3 Crewman (Medic)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Sentinel3_Medic.paa";
		textureVehicle="";
	};

				// Viper-1 / Viper-2

	class reaperCrew_Pilot_Viper
	{
		displayName="[RC] Pilot Viper-1";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Viper1_Pilot.paa";
		textureVehicle="";
	};
	class reaperCrew_Pilot_Viper2
	{
		displayName="[RC] Pilot Viper-2";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Viper2_Pilot.paa";
		textureVehicle="";
	};

				// Ugly-1 / Ugly-2 / Ugly-3

	class reaperCrew_Pilot_Ugly
	{
		displayName="[RC] Pilot Ugly-1";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Ugly1_Pilot.paa";
		textureVehicle="";
	};
	class reaperCrew_Pilot_Ugly2
	{
		displayName="[RC] Pilot Ugly-2";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Ugly2_Pilot.paa";
		textureVehicle="";
	};
	class reaperCrew_Pilot_Ugly3
	{
		displayName="[RC] Pilot Ugly-3";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Ugly3_Pilot.paa";
		textureVehicle="";
	};

				// Phantom-1 / Phantom-2

	class reaperCrew_Pilot_Phantom
	{
		displayName="[RC] Pilot Phantom-1";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Phantom1_Pilot.paa";
		textureVehicle="";
	};
	class reaperCrew_Pilot_Phantom2
	{
		displayName="[RC] Pilot Phantom-2";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Phantom2_Pilot.paa";
		textureVehicle="";
	};

				// Foxhound-1 / Foxhound-2

	class reaperCrew_Foxhound
	{
		displayName="[RC] Logistics Foxhound-1";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Foxhound1_Driver.paa";
		textureVehicle="";
	};
	class reaperCrew_Foxhound2
	{
		displayName="[RC] Logistics Foxhound-2";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Foxhound2_Driver.paa";
		textureVehicle="";
	};

				// MISC

	class reaperCrewInsignia
	{
		displayName="[RC] Reaper Crew Logo";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\ReaperCrewLogoPatch.paa";
		textureVehicle="";
	};
};