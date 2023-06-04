class RC_4mWall: reaperCrew_BuildingBlock_Base {
	displayName="4x4m Wall Block";
	model="rc_assets_pack\addons\reaperCrew_SimpleObjects\data\4mWall\4mWall.p3d";
	hiddenSelections[] = {"camo"};
	hiddenSelectionsTextures[]=
	{
		"rc_assets_pack\addons\reaperCrew_SimpleObjects\data\4mWall\textures\Concrete\4mWall_CO.paa"
	};
};
class RC_4mWall_RedBrick: RC_4mWall {
	hiddenSelectionsTextures[]=
	{
		"rc_assets_pack\addons\reaperCrew_SimpleObjects\data\4mWall\textures\RedBrick\4mWall_CO.paa"
	};
};
class RC_4mWall_BreezeBlocks: RC_4mWall {
	hiddenSelectionsTextures[]=
	{
		"rc_assets_pack\addons\reaperCrew_SimpleObjects\data\4mWall\textures\BreezeBlock\4mWall_CO.paa"
	};
};