class CfgPatches
{
	class RC_PMC_Gear
	{
		addonRootClass="A3_Structures_F_Mil";
		requiredAddons[]=
		{
			"A3_Characters_F",
			"A3_Data_F_Oldman_Loadorder",
			"ReaperCrew_Common"
		};
		requiredVersion=0.100000;
		units[]={};
		weapons[]=
		{
			"RC_PMC_TS_Vest_1",
			"RC_PMC_TS_Vest_2",
			"RC_PMC_TS_Cap_1",
			"RC_PMC_TS_Cap_2",
			"RC_PMC_TS_Helmet_Light_1",
			"RC_PMC_TS_Helmet_1",
			"RC_PMC_TS_Helmet_2"
		};
		author="Reaper Crew";
	};
};
class CfgWeapons
{
	class H_Cap_red;
	class H_Cap_oli_hs;
	class Camel_Helmet_light_N_Blk_2;
	class H_HelmetSpecB_blk;
	class H_HelmetB_black;
	class V_PlateCarrier1_rgr;
	class V_PlateCarrier2_rgr: V_PlateCarrier1_rgr
	{
		class Iteminfo;
	};
	class Vest_Camo_Base;
	class V_PlateCarrier1_blk: Vest_Camo_Base
	{
		class Iteminfo;
	};
	class RC_PMC_TS_Vest_1: V_PlateCarrier2_rgr
	{
		scope=2;
		displayName="Carrier Rig (Thanatos Security)";
		picture="\A3\Characters_F\data\ui\icon_V_plate_carrier_2_blk_CA.paa";
		hiddenSelections[]=
		{
			"camo"
		};
		hiddenSelectionsTextures[]=
		{
			"\reaperCrew_Clothing\data\Uniforms\PMC\data\RC_PMC_TS_Vest_0_co.paa"
		};
		class ItemInfo: Iteminfo
		{
			hiddenSelections[]=
			{
				"camo"
			};
		};
	};
	class RC_PMC_TS_Vest_2: V_PlateCarrier1_blk
	{
		scope=2;
		displayName="Carrier Lite (Thanatos Security)";
		picture="\A3\Characters_F\data\ui\icon_V_plate_carrier_2_blk_CA.paa";
		hiddenSelections[]=
		{
			"camo"
		};
		hiddenSelectionsTextures[]=
		{
			"\reaperCrew_Clothing\data\Uniforms\PMC\data\RC_PMC_TS_Vest_0_co.paa"
		};
		class ItemInfo: Iteminfo
		{
			hiddenSelections[]=
			{
				"camo"
			};
		};
	};
	class RC_PMC_TS_Cap_1: H_Cap_red
	{
		displayName="Cap (Thanatos Security)";
		picture="\A3\characters_f\Data\UI\icon_H_Cap_blk_CA.paa";
		hiddenSelectionsTextures[]=
		{
			"\reaperCrew_Clothing\data\Uniforms\PMC\data\RC_PMC_capb_black_co.paa"
		};
	};
	class RC_PMC_TS_Cap_2: H_Cap_oli_hs
	{
		displayName="Cap (Thanatos Security + Headset)";
		picture="\A3\characters_f\Data\UI\icon_H_Cap_blk_CA.paa";
		hiddenSelectionsTextures[]=
		{
			"\reaperCrew_Clothing\data\Uniforms\PMC\data\RC_PMC_capb_black_co.paa"
		};
	};
	class RC_PMC_TS_Helmet_Light_1: Camel_Helmet_light_N_Blk_2
	{
		displayName="Light Helmet (Thanatos Security + Headset)";
		picture="\A3\Characters_F\data\ui\icon_H_HelmetB_light_black_ca.paa";
		hiddenSelectionsTextures[]=
		{
			"\reaperCrew_Clothing\data\Uniforms\PMC\data\RC_PMC_TS_Helmet_Blk_co.paa"
		};
	};
	class RC_PMC_TS_Helmet_1: H_HelmetB_black
	{
		displayName="Combat Helmet (Thanatos Security)";
		picture="\A3\Characters_F\data\ui\icon_H_HelmetB_black_ca.paa";
		hiddenSelectionsTextures[]=
		{
			"\reaperCrew_Clothing\data\Uniforms\PMC\data\RC_PMC_TS_Helmet_Blk_co.paa"
		};
	};
	class RC_PMC_TS_Helmet_2: H_HelmetSpecB_blk
	{
		displayName="Enhanced Combat Helmet (Thanatos Security)";
		picture="\A3\Characters_F\data\ui\icon_H_HelmetSpecB_blk_ca.paa";
		hiddenSelectionsTextures[]=
		{
			"\reaperCrew_Clothing\data\Uniforms\PMC\data\RC_PMC_TS_Helmet_Blk_co.paa"
		};
	};
};
