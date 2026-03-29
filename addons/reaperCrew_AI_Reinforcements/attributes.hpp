class reinforcementCount: Edit {
	displayName = "Reinforcement Count";
	property = "reinforcementCount";
	typeName = "NUMBER";
	tooltip = "";
	control = "Edit";
	defaultValue = "50";
};
class zoneThresholdMode: Combo {
	displayName = "Zone Threshold Mode";
	property = "zoneThresholdMode";
	typeName = "STRING";
	tooltip = "Threshold: fixed maximum enemy count. Ratio: enemy count scales with players in the zone.";
	defaultValue = """THRESHOLD""";
	class Values {
		class 0 { name = "Threshold"; value = "THRESHOLD"; };
		class 1 { name = "Player Ratio"; value = "RATIO"; };
	};
};
class zoneThreshold: Edit {
	displayName = "Zone Threshold / Ratio";
	property = "zoneThreshold";
	typeName = "NUMBER";
	tooltip = "In Threshold mode: maximum enemy count in the zone. In Ratio mode: number of enemy per player.";
	control = "Edit";
	defaultValue = "20";
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