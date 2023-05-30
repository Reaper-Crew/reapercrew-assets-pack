class reinforcementCount: Edit {
	displayName = "Reinforcement Count";
	property = "reinforcementCount";
	typeName = "NUMBER";
	tooltip = "";
	control = "Edit";
	defaultValue = "50";
};
class zoneThreshold: Edit {
	displayName = "Zone Threshold";
	property = "zoneThreshold";
	typeName = "NUMBER";
	tooltip = "";
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