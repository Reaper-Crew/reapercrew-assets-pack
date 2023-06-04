class CfgPatches
{
	class reaperCrew_Weapons
	{
		addonRootClass="A3_Props_F_Exp_A";
		requiredAddons[] = {"ReaperCrew_Common"};
		requiredVersion=0.1;
		units[]={};
		weapons[]={};
	};
};
class cfgWeapons {
	
	class Rifle;
	class Rifle_Base_F: Rifle {
		class WeaponSlotsInfo;
		class GunParticles;
		class Eventhandlers;
	};
	class mk20_base_F: Rifle_Base_F {
		class WeaponSlotsInfo: WeaponSlotsInfo {
			class MuzzleSlot;
		};
	};
	class arifle_SPAR_01_blk_F;

	// HK33
	class xeen_reaperCrew_HK33_base: arifle_SPAR_01_blk_F {
		selectionFireAnim = "muzzleFlash";
		cartridgePos="cartridgePos";
		cartridgeVel="cartridgeVel";
		author = "Xeenenta";
		descriptionshort = "Assault Rifle<br/>Calibre: 5.56x45mm STANAG<br/>by Xeenenta";
		// picture="\CAF2025\addons\xeen_weapons_core\data\HK33\HK33_Inventory.paa";
		// DLC = "xeen_reaperCrew_common";
		// class WeaponSlotsInfo: WeaponSlotsInfo {
		// 	class MuzzleSlot: MuzzleSlot{
		// 		// compatibleItems[] = {"L3A1_Bayonet"}; 	
		// 	};
		// };

		// reloadAction="HK33_GestureReload";
	};
	class xeen_reaperCrew_HK33_Standard: xeen_reaperCrew_HK33_base {
		scope = 2;
		scopeArsenal=2;
		scopeCurator=2;

		displayName = "HK33";
		model = "rc_assets_pack\addons\reaperCrew_Weapons\HK33\HK33.p3d";
		handAnim[] = {"OFP2_ManSkeleton","\A3\Weapons_F\Rifles\MX\data\Anim\MX_afg.rtm"};
		baseWeapon = "xeen_reaperCrew_HK33_Standard";
	};

	// L85A3
	class xeen_reaperCrew_L85A3_base: mk20_base_F {
		selectionFireAnim = "muzzleFlash";
		cartridgePos="cartridgePos";
		cartridgeVel="cartridgeVel";
		author = "Xeenenta";
		descriptionshort = "Assault Rifle<br/>Calibre: 5.56x45mm STANAG<br/>by Xeenenta";
		picture="\rc_assets_pack\addons\reaperCrew_Weapons\L85A3\L85A3_Inventory.paa";
		DLC = "xeen_reaperCrew_common";
		class WeaponSlotsInfo: WeaponSlotsInfo {
			class MuzzleSlot: MuzzleSlot{
				// compatibleItems[] = {"L3A1_Bayonet"}; 	
			};
		};

		reloadAction="L85A3_GestureReload";
	};
	class xeen_reaperCrew_L85A3_Standard: xeen_reaperCrew_L85A3_base {
		scope = 2;
		scopeArsenal=2;
		scopeCurator=2;

		displayName = "L85A3 Mk.1 - No Grip";
		model = "rc_assets_pack\addons\reaperCrew_Weapons\L85A3\L85A3.p3d";
		handAnim[] = {"OFP2_ManSkeleton","\A3\Weapons_F\Rifles\TRG20\Data\Anim\TRG_21.rtm"};

	};
	class xeen_reaperCrew_L85A3_ForeGrip: xeen_reaperCrew_L85A3_base {
		scope = 2;
		scopeArsenal=2;
		scopeCurator=2;

		displayName = "L85A3 Mk.1 - Foregrip";
		model = "rc_assets_pack\addons\reaperCrew_Weapons\L85A3\L85A3_FG.p3d";
		handAnim[]=
		{
			"OFP2_ManSkeleton",
			"rc_assets_pack\addons\reaperCrew_Weapons\L85A3\anims\handAnim.rtm"
		};

	};	
};
class CfgMovesBasic
{
    class DefaultDie;
    class ManActions
    {
        L85A3_GestureReload = "L85A3_GestureReload";    
    };

   class Actions {
       class NoActions : ManActions {
           L85A3_GestureReload[] = {"L85A3_GestureReload", "Gesture"};
       };
   };
};
class CfgGesturesMale
{
   class Default;
    class States
    {
        class L85A3_GestureReload: Default
        {
            file="\rc_assets_pack\addons\reaperCrew_Weapons\L85A3\anims\reloadAnim.rtm";
            looped=0;
            speed=0.200000;
            mask="handsWeapon";
            headBobStrength=0.400000;
            headBobMode=2;
            rightHandIKBeg=1;
            rightHandIKEnd=1;
            leftHandIKCurve[]={0,1,0.050000,0,0.950000,0,1,1};
        };
    };
};