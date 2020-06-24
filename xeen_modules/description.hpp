// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
class ModuleDescription: ModuleDescription
{
	description = "Create dense urban AI presence"; // Short description, will be HQrmatted as structured text
	class LocationArea_F
	{
		description[] = { // Multi-line descriptions are supported
			"This module can be used to create dense urban contacts.",
			"By default it will spawn a selection of CSAT units unless specified otherwise in the HQ module"
		};
		position = 1; // Position is taken into effect
		direction = 0; // Direction is taken into effect
	};
};