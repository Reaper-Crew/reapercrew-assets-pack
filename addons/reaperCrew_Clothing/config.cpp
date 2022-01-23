class CfgPatches
{
	class RC_Headgear
	{
		weapons[]={"RC_Beret_01", "RC_MTP_Uniform", "RC_MTP_Medic_Uniform"};
		requiredVersion=0.100000;
		requiredAddons[]={"ReaperCrew_Common", "A3_Data_F_Oldman_Loadorder"};
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
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\mtp_ReaperCrewUniform_01_co"
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
			"rc_assets_pack\addons\reaperCrew_Clothing\data\Uniforms\mtp_ReaperCrewMedicUniform_01_co.paa"
		};
	};
};
class CfgUnitInsignia
{	

	class ReaperCrew_PlatoonJTAC
	{
		displayName="[RC] Platoon JTAC";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\PLT_JTAC_1.paa";
		textureVehicle="";
	};
	class ReaperCrew_PlatoonCommander
	{
		displayName="[RC] Platoon Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\PLT_Command_1.paa";
		textureVehicle="";
	};
	class ReaperCrew_PlatoonSergeant
	{
		displayName="[RC] Platoon Sergeant";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\PLT_Sgt_1.paa";
		textureVehicle="";
	};
	class ReaperCrew_platoonMedic
	{
		displayName="[RC] Platoon Medic";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Zero_Medic.paa";
		textureVehicle="";
	};
	class ReaperCrew_platoonLogiCommand
	{
		displayName="[RC] Platoon Logistics Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Logi_Command.paa";
		textureVehicle="";
	};

				// Reaper 1-1 /  1-2 //

	class ReaperCrew_SectionCommander
	{
		displayName="[RC] Section Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\SquadLead_1.paa";
		textureVehicle="";
	};
	class ReaperCrew_2IC
	{
		displayName="[RC] Section 2IC";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\2IC_1.paa";
		textureVehicle="";
	};
	class ReaperCrew_Medic
	{
		displayName="[RC] Medic (White)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Medic_2.paa";
		textureVehicle="";
	};
	class ReaperCrew_Medic_2
	{
		displayName="[RC] Section Medic (Olive)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Medic_3.paa";
		textureVehicle="";
	};
	class ReaperCrew_Machinegunner
	{
		displayName="[RC] Section Machine Gunner";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\MG.paa";
		textureVehicle="";
	};
	class ReaperCrew_MG_ASSIST
	{
		displayName="[RC] Assist. Machine Gunner";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Assist_MG.paa";
		textureVehicle="";
	};
	class ReaperCrew_Engineer
	{
		displayName="[RC] Section Engineer";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Engineer.paa";
		textureVehicle="";
	};
	class ReaperCrew_EOD
	{
		displayName="[RC] Section EOD";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\EOD.paa";
		textureVehicle="";
	};
	class ReaperCrew_jtac
	{
		displayName="[RC] JTAC";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\JTAC_1.paa";
		textureVehicle="";
	};
	class ReaperCrew_Marksman
	{
		displayName="[RC] Section Marksman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Marksman.paa";
		textureVehicle="";
	};
	class ReaperCrew_Rifleman
	{
		displayName="[RC] Section Rifleman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Rifleman.paa";
		textureVehicle="";
	};
	class ReaperCrew_AA
	{
		displayName="[RC] Section AA";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\AA.paa";
		textureVehicle="";
	};
	class ReaperCrew_AT
	{
		displayName="[RC] Section AT";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\AT.paa";
		textureVehicle="";
	};

	class ReaperCrew_Thunder_SL
	{
		displayName="[RC] Thunder Commander";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Thunder_SL.paa";
		textureVehicle="";
	};
	class ReaperCrew_Thunder_2IC
	{
		displayName="[RC] Thunder 2IC";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Thunder_2ic.paa";
		textureVehicle="";
	};
	class ReaperCrew_Thunder_Grunt
	{
		displayName="[RC] Thunder Gunner";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Thunder_Grunt.paa";
		textureVehicle="";
	};
	class ReaperCrew_Thunder_Medic
	{
		displayName="[RC] Thunder Medic";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Thunder_Medic.paa";
		textureVehicle="";
	};

	class ReaperCrew_Artilleryman
	{
		displayName="[RC] Artilleryman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Arty.paa";
		textureVehicle="";
	};
	class ReaperCrew_Arty_2IC
	{
		displayName="[RC] Artilleryman (2IC)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Arty 2IC.paa";
		textureVehicle="";
	};
	class ReaperCrew_Arty_Commander
	{
		displayName="[RC] Artilleryman (Commander)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Arty SL.paa";
		textureVehicle="";
	};

	class ReaperCrew_Armoured_Medic
	{
		displayName="[RC] Armoured Crewman (Medic)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Armoured_Medic.paa";
		textureVehicle="";
	};
	class ReaperCrew_Armoured_Crew
	{
		displayName="[RC] Armoured Crewman";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Armoured_Crew.paa";
		textureVehicle="";
	};
	class ReaperCrew_Armoured_Commander
	{
		displayName="[RC] Armoured Crewman (Commander)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Armoured_Commander.paa";
		textureVehicle="";
	};

	class ReaperCrew_Pilot_Viper
	{
		displayName="[RC] Pilot (Viper)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Pilot_Viper.paa";
		textureVehicle="";
	};
	class ReaperCrew_Pilot_Ugly
	{
		displayName="[RC] Pilot (Ugly)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Pilot_Ugly.paa";
		textureVehicle="";
	};
	class ReaperCrew_Pilot_Phantom
	{
		displayName="[RC] Pilot (Phantom)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Pilot_Phantom.paa";
		textureVehicle="";
	};

	class ReaperCrew_Foxhound
	{
		displayName="[RC] Logistics";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Logi.paa";
		textureVehicle="";
	};
	
	class reaperCrewInsignia
	{
		displayName="[RC] Reaper Crew Logo";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\ReaperCrewLogoPatch.paa";
		textureVehicle="";
	};
};