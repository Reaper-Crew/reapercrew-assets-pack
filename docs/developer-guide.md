# Developer Guide

## Preface

This guide will show you how to build a local copy of the Reaper Crew Assets pack to allow for local development. We'll be making the following assumptions:

* You have Git & Mikero's tools installed
* You're happy to use the command line
* You have your P: drive configured
* You may need to create some stub files to account for missing model files in order to get the PBOs to actually build.

Start by opening a `Command Prompt` window and navigate to your P: drive and create a directory to download the assets pack

```powershell
P:
mkdir P:\RC_Assets_Pack P:\RC_Assets_Pack_CUP P:\RC_Assets_Pack_CUP_TERRAINS P:\RC_Assets_Pack_CWR3
mkdir P:\@ASSETS_PACK P:\@ASSETS_PACK_CUP P:\@ASSETS_PACK_CUP_TERRAINS P:\@ASSETS_PACK_CWR3
```

Then clone the repository into that directory:

```powershell
git clone https://github.com/Reaper-Crew/reapercrew-assets-pack.git P:\RC_Assets_Pack
git clone https://github.com/Reaper-Crew/reapercrew-assets-pack-cup.git P:\RC_Assets_Pack_CUP
git clone https://github.com/Reaper-Crew/reapercrew-assets-pack-cup-terrains.git P:\RC_Assets_Pack_CUP_TERRAINS
git clone https://github.com/Reaper-Crew/reapercrew-assets-pack-cwr3.git P:\RC_Assets_Pack_CWR3
```

In the root of the directory you'll find a file called `build_all.ps1`, use of this file is optional but it'll allow you to convert texture files from `.tga` to `.paa` and build all of the PBOs with a single command (it currently just builds the main assets pack by default, but that can be changed using the variables).

If you open the file in your text editor of choice and modify the following variables to point to the EXE of the imageToPAA tool (part of the A3 Tools set) & to PBOProject which will be wherever you've installed Mikero's tools

```powershell
$imageToPaa = '<imagetoPAA EXE>'
$pboProject = '<PBOProject EXE>'
```

Once you've updated the variables, you can either run the script from the command line with:

```powershell
.\build_all.ps1
```

or by double clicking on the script in the explorer window.

## Code Conventions

To keep configuration consistent, we should subscribe to a few basic rules:

* Use `reaperCrew` to start classnames instead of `RC` or anything else
* All folders need to have a `$PBOPREFIX$.txt` file.
* Only inherit from or reference assets from base game, or from any one of the approved dependencies (see below)

## Approved Dependencies

* CBA
* ACE3
* LAMBS AI
