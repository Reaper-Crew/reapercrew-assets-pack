class CfgPatches
{
	class Training_Missions
	{
		units[] = {""};
		weapons[] = {""};
		vehicles[] = {""};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F", "cba_settings"};
	};
};
class CfgFunctions
{
	class reapercrew_training
	{
		class Effects
		{
            file = "\reaperCrew_Training\functions";
			class startTraining{};
            class createPickupTroops{};
            class createLZSmoke{};
		};
	};
};
class CfgMissions
{
	class Missions
	{
		class TrainingMissions
		{
			briefingName = "Reaper Crew - Training Missions";
			author = "Xeenenta";
			overviewPicture = "reaperCrew_Training\training_overview.jpg";
			overviewText = "A series of repeatable scenarios that you can use to enhance your skills.";

			class TransportFlightTrainingLivonia
			{
				directory = "reaperCrew_Training\missions\TransportFlightTrainingLivonia.Enoch";
			};
		};
	};
};
