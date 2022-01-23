# Variables
$imageToPaa = 'G:\SteamLibrary\steamapps\common\Arma 3 Tools\ImageToPAA\ImageToPAA.exe'
$pboProject = 'C:\Program Files (x86)\Mikero\DePboTools\bin\pboProject.exe'
$modDirectory = 'P:\RC_Assets_Pack\addons'
$outputFolder = 'P:\@ASSETS_PACK'

# Build Textures First - You can add stuff to this array
$TextureFolders = "P:\RC_Assets_Pack\addons\reaperCrew_counterfire_radar\data\TPQ_50_Static"

Foreach ($directory in $TextureFolders)
{
    & $imageToPaa "$directory\*.tga"
    Remove-Item $directory\* -Include *.tga
}

# Clean old PBOs
Remove-Item "P:\RC_Assets_Pack\addons" -Include *.pbo,*.bisign
Remove-Item "P:\RC_Assets_Pack_CUP\addons" -Include *.pbo,*.bisign
Remove-Item "P:\RC_Assets_Pack_CUP_TERRAINS\addons" -Include *.pbo,*.bisign
Remove-Item "P:\RC_Assets_Pack_CWR3\addons" -Include *.pbo,*.bisign

# Build PBOs
& "$pboProject" -P "P:\RC_Assets_Pack\addons" -M="P:\@ASSETS_PACK"
# Leaving the below disabled until they are converted to Mikero
# & "$pboProject" -P "P:\RC_Assets_Pack_CUP\addons" -M="P:\@ASSETS_PACK_CUP"
# & "$pboProject" -P "P:\RC_Assets_Pack_CUP_TERRAINS\addons" -M="P:\@ASSETS_PACK_CUP_TERRAINS"
# & "$pboProject" -P "P:\RC_Assets_Pack_CWR3\addons" -M="P:\@ASSETS_PACK_CWR3"
