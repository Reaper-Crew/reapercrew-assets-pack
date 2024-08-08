# Variables
$imageToPaa = 'G:\SteamLibrary\steamapps\common\Arma 3 Tools\ImageToPAA\ImageToPAA.exe'
$pboProject = 'C:\Program Files (x86)\Mikero\DePboTools\bin\pboProject.exe'
$modDirectory = 'P:\RC_Assets_Pack\addons'
$outputFolder = 'P:\@ASSETS_PACK'

# Build Textures First - You can add stuff to this array
$TextureFolders = "P:\RC_ASSETS_PACK\addons\reaperCrew_Common\data", "P:\RC_ASSETS_PACK\addons\reaperCrew_SimpleObjects\data"

Foreach ($directory in $TextureFolders)
{
    & $imageToPaa "$directory\*.tga"
    & $imageToPaa "$directory\*.jpg"
    Remove-Item $directory\* -Include *.tga
}

# Clean old PBOs
Remove-Item "P:\RC_Assets_Pack\addons" -Include *.pbo,*.bisign
# Remove-Item "P:\RC_Assets_Pack_2_CUP\addons" -Include *.pbo,*.bisign
# Remove-Item "P:\RC_Assets_Pack_2_CUP_TERRAINS\addons" -Include *.pbo,*.bisign
# Remove-Item "P:\RC_Assets_Pack_2_CWR3\addons" -Include *.pbo,*.bisign

# Build PBOs
& "$pboProject" -W -P "P:\RC_Assets_Pack\addons" -M="P:\@ASSETS_PACK"
# Leaving the below disabled until they are converted to Mikero
# & "$pboProject" -P "P:\RC_Assets_Pack_2_CUP\addons" -M="P:\@ASSETS_PACK_CUP"
# & "$pboProject" -P "P:\RC_Assets_Pack_2_CUP_TERRAINS\addons" -M="P:\@ASSETS_PACK_CUP_TERRAINS"
# & "$pboProject" -P "P:\RC_Assets_Pack_2_CWR3\addons" -M="P:\@ASSETS_PACK_CWR3"

Start-Sleep 10

#& "G:\SteamLibrary\steamapps\common\Arma 3\Arma3BattlEye.exe" 2 1 1 -exe Arma3_x64.exe -skipIntro -noSplash "E:\Documents\Arma 3 - Other Profiles\R%2e%20Xeenenta\missions\AddonTesting.Tanoa\mission.sqm" -cpuCount=16 -exThreads=7 -enableHT -malloc=cma_x64 -hugePages -maxmem=16384 -maxvram=4096 -noPause "-mod=G:\SteamLibrary\steamapps\common\Arma 3\!Workshop\@CBA_A3;G:\SteamLibrary\steamapps\common\Arma 3\!Workshop\@ace;G:\SteamLibrary\steamapps\common\Arma 3\!Workshop\@Zeus Enhanced;G:\SteamLibrary\steamapps\common\Arma 3\!Workshop\@LAMBS_Danger.fsm;G:\SteamLibrary\steamapps\common\Arma 3\!Workshop\@LAMBS_RPG;G:\SteamLibrary\steamapps\common\Arma 3\!Workshop\@LAMBS_Suppression;G:\SteamLibrary\steamapps\common\Arma 3\!Workshop\@LAMBS_Turrets;G:\SteamLibrary\steamapps\common\Arma 3\!Workshop\@Zeus Enhanced - ACE3 Compatibility;G:\SteamLibrary\steamapps\common\Arma 3\!Workshop\@MCC Sandbox 4 -  Mission Making The Easy Way;G:\SteamLibrary\steamapps\common\Arma 3\!Workshop\@3den Enhanced;G:\SteamLibrary\steamapps\common\Arma 3\!Workshop\@ACRE2;P:\@ASSETS_PACK"