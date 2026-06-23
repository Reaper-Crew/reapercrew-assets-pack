class reinforcementCount: Edit {
	displayName = "Reinforcement Count";
	property = "reinforcementCount";
	typeName = "NUMBER";
	tooltip = "";
	control = "Edit";
	defaultValue = "50";
};
class zoneLimitMode: Combo {
	displayName = "Zone Limit Mode";
	property = "zoneLimitMode";
	typeName = "STRING";
	tooltip = "Ceiling: fixed maximum enemy count. Player Ratio / Ceiling: enemy count scales with players in the zone, capped at the ceiling.";
	defaultValue = """CEILING""";
	class Values {
		class 0 { name = "Ceiling"; value = "CEILING"; };
		class 1 { name = "Player Ratio / Ceiling"; value = "RATIO_CEILING"; };
	};
};
class zoneCeiling: Edit {
	displayName = "Zone Ceiling";
	property = "zoneCeiling";
	typeName = "NUMBER";
	tooltip = "Hard maximum number of enemy AI allowed in the zone.";
	control = "Edit";
	defaultValue = "80";
};
class zoneRatio: Edit {
	displayName = "Zone Ratio";
	property = "zoneRatio";
	typeName = "NUMBER";
	tooltip = "Number of AI per player in the zone. Only used in Player Ratio / Ceiling mode.";
	control = "Edit";
	defaultValue = "3";
};
class regularTroops: Checkbox {
	displayName = "Regular Troops";
	property = "regularTroops";
	typeName = "BOOL";
	tooltip = "";
	control = "Checkbox";
	defaultValue = "true";
};
class eliteTroops: Checkbox {
	displayName = "Elite Troops";
	property = "eliteTroops";
	typeName = "BOOL";
	tooltip = "";
	control = "Checkbox";
	defaultValue = "false";
};
class specialTroops: Checkbox {
	displayName = "Special Forces";
	property = "specialTroops";
	typeName = "BOOL";
	tooltip = "";
	control = "Checkbox";
	defaultValue = "false";
};
class rushMode: Checkbox {
	displayName = "Enable Rush Mode";
	property = "rushMode";
	typeName = "BOOL";
	tooltip = "";
	control = "Checkbox";
	defaultValue = "false";
};
class waveDelay: Edit {
	displayName = "Wave Delay (seconds)";
	property = "waveDelay";
	typeName = "STRING";
	tooltip = "";
	control = "SliderTimeRespawn";
	defaultValue = 60;
};
class additionalCondition: Edit {
	displayName = "Additional condition";
	property = "additionalCondition";
	typeName = "STRING";
	tooltip = "";
	control = "Edit";
	defaultValue = """true""";
};
class codeOnSpawnGroup: Edit {
	displayName = "Code on spawn";
	property = "codeOnSpawn";
	typeName = "STRING";
	tooltip = "";
	control = "EditCodeMulti5";
	defaultValue = """true""";
};
