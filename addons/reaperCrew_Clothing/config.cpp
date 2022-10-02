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

	class reaperCrew_default_insignia
	{
		displayName="[RC] Reaper Crew Logo";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\ReaperCrewLogoPatch.paa";
		textureVehicle="";
	};

	// Zero
	class reaperCrew_Zero_PlatoonCommander
	{
		displayName="[RC] Platoon Commander";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Zero\platoonCommander.paa";
		textureVehicle="";
	};
	class reaperCrew_Zero_PlatoonSergeant
	{
		displayName="[RC] Platoon Sergeant";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Zero\platoonSergeant.paa";
		textureVehicle="";
	};
	class reaperCrew_Zero_LogisticsCommander
	{
		displayName="[RC] Platoon Logistics Commander";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Zero\logisticsCommander.paa";
		textureVehicle="";
	};
	class reaperCrew_Zero_PlatoonJTAC
	{
		displayName="[RC] Platoon JTAC";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Zero\platoonJTAC.paa";
		textureVehicle="";
	};
	class reaperCrew_Zero_PlatoonMedic
	{
		displayName="[RC] Platoon Medic";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Zero\platoonMedic.paa";
		textureVehicle="";
	};

	// Reaper-1-1
	class reaperCrew_Reaper_1_1_SectionCommander
	{
		displayName="[RC] Section Commander (Reaper-1-1)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-1\sectionCommander.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_1_Section2IC
	{
		displayName="[RC] Section 2IC (Reaper-1-1)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-1\section2IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_1_Sharpshooter
	{
		displayName="[RC] Sharpshooter (Reaper-1-1)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-1\Sharpshooter.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_1_Rifleman
	{
		displayName="[RC] Rifleman (Reaper-1-1)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-1\Rifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_1_Medic
	{
		displayName="[RC] Medic (Reaper-1-1)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-1\Medic.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_1_Engineer
	{
		displayName="[RC] Engineer (Reaper-1-1)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-1\Engineer.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_1_Autorifleman
	{
		displayName="[RC] Autorifleman (Reaper-1-1)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-1\Autorifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_1_AssistAutorifleman
	{
		displayName="[RC] Assist Autorifleman (Reaper-1-1)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-1\AssistAutorifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_1_ATSpecialist
	{
		displayName="[RC] AT Specialist (Reaper-1-1)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-1\AT.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_1_AASpecialist
	{
		displayName="[RC] AA Specialist (Reaper-1-1)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-1\AA.paa";
		textureVehicle="";
	};

	// Reaper-1-2
	class reaperCrew_Reaper_1_2_SectionCommander
	{
		displayName="[RC] Section Commander (Reaper-1-2)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-2\sectionCommander.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_2_Section2IC
	{
		displayName="[RC] Section 2IC (Reaper-1-2)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-2\section2IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_2_Sharpshooter
	{
		displayName="[RC] Sharpshooter (Reaper-1-2)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-2\Sharpshooter.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_2_Rifleman
	{
		displayName="[RC] Rifleman (Reaper-1-2)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-2\Rifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_2_Medic
	{
		displayName="[RC] Medic (Reaper-1-2)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-2\Medic.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_2_Engineer
	{
		displayName="[RC] Engineer (Reaper-1-2)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-2\Engineer.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_2_Autorifleman
	{
		displayName="[RC] Autorifleman (Reaper-1-2)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-2\Autorifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_2_AssistAutorifleman
	{
		displayName="[RC] Assist Autorifleman (Reaper-1-2)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-2\AssistAutorifleman.paa";
		textureVehicle="";
	};1_1
	class reaperCrew_Reaper_1_2_ATSpecialist
	{
		displayName="[RC] AT Specialist (Reaper-1-2)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-2\AT.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_2_AASpecialist
	{
		displayName="[RC] AA Specialist (Reaper-1-2)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-2\AA.paa";
		textureVehicle="";
	};
	
	// Reaper-1-3
	class reaperCrew_Reaper_1_3_SectionCommander
	{
		displayName="[RC] Section Commander (Reaper-1-3)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-3\sectionCommander.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_3_Section2IC
	{
		displayName="[RC] Section 2IC (Reaper-1-3)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-3\section2IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_3_Sharpshooter
	{
		displayName="[RC] Sharpshooter (Reaper-1-3)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-3\Sharpshooter.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_3_Rifleman
	{
		displayName="[RC] Rifleman (Reaper-1-3)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-3\Rifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_3_Medic
	{
		displayName="[RC] Medic (Reaper-1-3)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-3\Medic.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_3_Engineer
	{
		displayName="[RC] Engineer (Reaper-1-3)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-3\Engineer.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_3_Autorifleman
	{
		displayName="[RC] Autorifleman (Reaper-1-3)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-3\Autorifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_3_AssistAutorifleman
	{
		displayName="[RC] Assist Autorifleman (Reaper-1-3)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-3\AssistAutorifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_3_ATSpecialist
	{
		displayName="[RC] AT Specialist (Reaper-1-3)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-3\AT.paa";
		textureVehicle="";
	};
	class reaperCrew_Reaper_1_3_AASpecialist
	{
		displayName="[RC] AA Specialist (Reaper-1-3)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Reaper-1-3\AA.paa";
		textureVehicle="";
	};
	
	// Thunder
	class reaperCrew_Thunder_SectionCommander
	{
		displayName="[RC] Section Commander (Thunder)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Thunder\sectionCommander.paa";
		textureVehicle="";
	};
	class reaperCrew_Thunder_Section2IC
	{
		displayName="[RC] Section 2IC (Thunder)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Thunder\section2IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Thunder_Sniper
	{
		displayName="[RC] Sniper (Thunder)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Thunder\sharpshooter.paa";
		textureVehicle="";
	};
	class reaperCrew_Thunder_HeavyGunner
	{
		displayName="[RC] Heavy Gunner (Thunder)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Thunder\Gunner.paa";
		textureVehicle="";
	};

	// Hammer
	class reaperCrew_Hammer_BatteryCommander
	{
		displayName="[RC] Battery Commander (Hammer)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Hammer\batteryCommander.paa";
		textureVehicle="";
	};
	class reaperCrew_Hammer_BatteryMedic
	{
		displayName="[RC] Battery Medic (Hammer)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Hammer\batteryMedic.paa";
		textureVehicle="";
	};
	class reaperCrew_Hammer_BatteryGunner
	{
		displayName="[RC] Battery Gunner (Hammer)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Hammer\batteryGunner.paa";
		textureVehicle="";
	};

	// Fury-1
	class reaperCrew_Fury_1_VehicleCommander
	{
		displayName="[RC] Vehicle Commander (Fury)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Fury-1\vehicleCommander.paa";
		textureVehicle="";
	};
	class reaperCrew_Fury_1_VehicleCrew
	{
		displayName="[RC] Vehicle Crew (Fury)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Fury-1\vehicleCrew.paa";
		textureVehicle="";
	};

	// Fury-2
	class reaperCrew_Fury_2_VehicleCommander
	{
		displayName="[RC] Vehicle Commander (Fury)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Fury-2\vehicleCommander.paa";
		textureVehicle="";
	};
	class reaperCrew_Fury_2_VehicleCrew
	{
		displayName="[RC] Vehicle Crew (Fury)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Fury-2\vehicleCrew.paa";
		textureVehicle="";
	};
	
	// Shadow
	class reaperCrew_Shadow_SectionCommander
	{
		displayName="[RC] Section Commander (Shadow)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow-1\sectionCommander.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_Section2IC
	{
		displayName="[RC] Section 2IC (Shadow)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow-1\section2IC.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_Rifleman
	{
		displayName="[RC] Rifleman (Shadow)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow-1\Rifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_Medic
	{
		displayName="[RC] Medic (Shadow)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow-1\Medic.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_Autorifleman
	{
		displayName="[RC] Autorifleman (Shadow)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow-1\Autorifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_AssistAutorifleman
	{
		displayName="[RC] Assist Autorifleman (Shadow)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow-1\assistAutorifleman.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_Sniper
	{
		displayName="[RC] Sniper (Shadow)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow-1\Sniper.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_Spotter
	{
		displayName="[RC] Spotter (Shadow)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow-1\Spotter.paa";
		textureVehicle="";
	};
	class reaperCrew_Shadow_JTAC
	{
		displayName="[RC] JTAC (Shadow)";
		author="Reaper Crew";
		texture="\rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Shadow-1\JTAC.paa";
		textureVehicle="";
	};

	// Sentinel-1
	class reaperCrew_Sentinel_1_VehicleCommander
	{
		displayName="[RC] Vehicle Commander (Sentinel)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Sentinel-1\vehicleCommander.paa";
		textureVehicle="";
	};
	class reaperCrew_Sentinel_1_VehicleCrew
	{
		displayName="[RC] Vehicle Crew (Sentinel)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Sentinel-1\vehicleCrew.paa";
		textureVehicle="";
	};

	// Sentinel-2
	class reaperCrew_Sentinel_2_VehicleCommander
	{
		displayName="[RC] Vehicle Commander (Sentinel)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Sentinel-2\vehicleCommander.paa";
		textureVehicle="";
	};
	class reaperCrew_Sentinel_2_VehicleCrew
	{
		displayName="[RC] Vehicle Crew (Sentinel)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Sentinel-2\vehicleCrew.paa";
		textureVehicle="";
	};

	// Viper-1
	class reaperCrew_Viper_1_Pilot
	{
		displayName="[RC] Pilot (Viper-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Viper-1\Pilot.paa";
		textureVehicle="";
	};
	// Viper-2
	class reaperCrew_Viper_2_Pilot
	{
		displayName="[RC] Pilot (Viper-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Viper-2\Pilot.paa";
		textureVehicle="";
	};

	// Ugly-1
	class reaperCrew_Ugly_1_Pilot
	{
		displayName="[RC] Pilot (Ugly-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Ugly-1\Pilot.paa";
		textureVehicle="";
	};
	// Ugly-2
	class reaperCrew_Ugly_2_Pilot
	{
		displayName="[RC] Pilot (Ugly-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Ugly-2\Pilot.paa";
		textureVehicle="";
	};

	// Phantom-1
	class reaperCrew_Phantom_1_Pilot
	{
		displayName="[RC] Pilot (Phantom-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Phantom-1\Pilot.paa";
		textureVehicle="";
	};
	// Phantom-2
	class reaperCrew_Phantom_2_Pilot
	{
		displayName="[RC] Pilot (Phantom-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Phantom-2\Pilot.paa";
		textureVehicle="";
	};


	// Foxhound-1
	class reaperCrew_Foxhound_1_LogisticsOfficer
	{
		displayName="[RC] Logistics Officer (Foxhound-1)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Foxhound-1\LogisticsOfficer.paa";
		textureVehicle="";
	};
	// Foxhound-2
	class reaperCrew_Foxhound_2_LogisticsOfficer
	{
		displayName="[RC] Logistics Officer (Foxhound-2)";
		author="Reaper Crew";
		texture="rc_assets_pack\addons\reaperCrew_Clothing\data\Insignias\Foxhound-2\LogisticsOfficer.paa";
		textureVehicle="";
	};

};