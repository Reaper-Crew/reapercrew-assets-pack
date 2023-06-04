	class xeen_caf2025_L85A3_base: mk20_base_F {
		selectionFireAnim = "muzzleFlash";
		cartridgePos="cartridgePos";
		cartridgeVel="cartridgeVel";
		author = "Xeenenta";
		descriptionshort = "Assault Rifle<br/>Calibre: 5.56x45mm STANAG<br/>by Xeenenta";
		picture="\rc_assets_pack\addons\reaperCrew_Weapons\L85A3\L85A3_Inventory.paa";
		DLC = "xeen_caf2025_common";
		class WeaponSlotsInfo: WeaponSlotsInfo {
			class MuzzleSlot: MuzzleSlot{
				// compatibleItems[] = {"L3A1_Bayonet"}; 	
			};
		};

		reloadAction="L85A3_GestureReload";
	};
	class xeen_caf2025_L85A3_Standard: xeen_caf2025_L85A3_base {
		scope = 2;
		scopeArsenal=2;
		scopeCurator=2;

		displayName = "L85A3 Mk.1 - No Grip";
		model = "rc_assets_pack\addons\reaperCrew_Weapons\L85A3\L85A3.p3d";
		handAnim[] = {"OFP2_ManSkeleton","\A3\Weapons_F\Rifles\TRG20\Data\Anim\TRG_21.rtm"};

	};
	class xeen_caf2025_L85A3_ForeGrip: xeen_caf2025_L85A3_base {
		scope = 2;
		scopeArsenal=2;
		scopeCurator=2;

		displayName = "L85A3 Mk.1 - Foregrip";
		model = "\rc_assets_pack\addons\reaperCrew_Weapons\L85A3\L85A3_FG.p3d";
		handAnim[]=
		{
			"OFP2_ManSkeleton",
			"rc_assets_pack\addons\reaperCrew_Weapons\L85A3\anims\handAnim.rtm"
		};

	};

	class xeen_caf2025_L85A3_Standard_LDS: xeen_caf2025_L85A3_Standard {
		scope = 2;
		scopeArsenal=0;
		scopeCurator=0;
		class LinkedItems
		{
			class LinkedItemsOptic
			{
				slot = "CowsSlot";
				item = "optic_Arco_AK_blk_F";
			};
		};

	};


