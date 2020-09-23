class garrisonModuleDialog
{
	idd = 99;
	access = 0;
	movingEnable = false;
	enableSimulation = false;
	class ControlsBackground
	{
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0;
			y = 0.4;
			w = 1;
			h = 0.6;
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;
			text = "AI per building:"; //--- ToDo: Localize;
			x = 0.025;
			y = 0.68;
			w = 0.17;
			h = 0.05;
		};
		class RscStructuredText_1101: RscStructuredText
		{
			idc = 1101;
			text = "Garrison Radius:"; //--- ToDo: Localize;
			x = 0.025;
			y = 0.44;
			w = 0.17;
			h = 0.05;
		};
		class RscStructuredText_1102: RscStructuredText
		{
			idc = 1102;
			text = "0"; //--- ToDo: Localize;
			x = 0.1625;
			y = 0.68;
			w = 0.06;
			h = 0.05;
		};
		class RscStructuredText_1103: RscStructuredText
		{
			idc = 1103;
			text = "0m"; //--- ToDo: Localize;
			x = 0.2;
			y = 0.44;
			w = 0.06;
			h = 0.05;
		};
	};
	class Controls
	{
		class RscButtonMenuOK_2600: RscButtonMenuOK
		{
			idc = 1234;
			x = 0.875;
			y = 0.88;
			w = 0.1;
			h = 0.1;
			onButtonClick = "[(findDisplay 99) getVariable ['_logicLocation', objNull], sliderPosition 1901, sliderPosition 1900] call xeen_fnc_garrisonModuleInit; (findDisplay 99) closeDisplay 1;";
		};
		class RscButtonMenuCancel_2700: RscButtonMenuCancel
		{
			x = 0.75;
			y = 0.88;
			w = 0.1;
			h = 0.1;
		};
		class RscSlider_1900: RscSlider
		{
			idc = 1900;
			x = 0.025;
			y = 0.74;
			w = 0.95;
			h = 0.1;
			type = 43;
			arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
			border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
			thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
			color[] = {1,1,1,0.5};
            coloractive[] = {1,1,1,1};
            sliderPosition = 0;
            sliderRange[] = {0,10};
            sliderStep = 1;
            lineSize = 1;
			onSliderPosChanged="((findDisplay 99) displayCtrl 1102) ctrlSetStructuredText parseText str(sliderPosition 1900)";
		};

		class RscSlider_1901: RscSlider
		{
			idc = 1901;
			x = 0.025;
			y = 0.5;
			w = 0.95;
			h = 0.1;
			type = 43;
			arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
			border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
			thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
			color[] = {1,1,1,0.5};
            coloractive[] = {1,1,1,1};
            sliderPosition = 5;
            sliderRange[] = {0,100};
            sliderStep = 10;
            lineSize = 1;
			onSliderPosChanged="((findDisplay 99) displayCtrl 1103) ctrlSetStructuredText parseText str(sliderPosition 1901)";
		};

	};
	class Objects
	{

	};
};