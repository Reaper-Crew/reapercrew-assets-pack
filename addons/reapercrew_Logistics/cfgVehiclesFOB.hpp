	class reaperCrew_FOB_Crate: B_Slingload_01_Cargo_F {
		displayName="FOB Builder (Reaper Crew)";
		editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewStorageObjects";
		class TransportMagazines {};
		class TransportWeapons{};
		class TransportItems{};
		class ACE_Actions {
            class ACE_MainActions {
                condition = "true";
				displayName = "Interactions";
				distance = 10;
				position = "[_target,  ace_interact_menu_cameraPosASL] call ace_interaction_fnc_getVehiclePosComplex";
				selection = "";
				class consolidateSupplies {
					displayName = "Consolidate Supplies";
					condition = "true";
					exceptions[] = {};
					statement = "[_target] call reapercrew_logistics_fnc_logisticsConsolidateSupplies;";
				};
            };
        };
	};
	class reaperCrew_ConstructionSupplies500: Items_base_F {
		scope=2;
		scopeCurator=2;
		displayName="Construction Supplies (Reaper Crew)";
		editorCategory = "reaperCrew";
        editorSubcategory = "reaperCrewStorageObjects";
		model = "\A3\Structures_F\Civ\Constructions\Bricks_V1_F.p3d";
		ace_cargo_size = 8;
        ace_cargo_canLoad = 1;

		// Dragging
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 0};
        ace_dragging_dragDirection = 0;
		ace_maxWeightDrag = 9999;

        // Carrying
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1.2, 0};
        ace_dragging_carryDirection = 0;
		class ACE_Actions {
            class ACE_MainActions {
                condition = "true";
				displayName = "Interactions";
				distance = 10;
				position = "[_target,  ace_interact_menu_cameraPosASL] call ace_interaction_fnc_getVehiclePosComplex";
				selection = "";
            };
        };
	};