This is a simple "addon" pack for SL Triggers Redux, "The Pet Collar Game", based on (the Pet Collar mod)[https://www.loverslab.com/files/file/1423-petcollar/].

Requirements:
	- SL Triggers Redux
		- to run the scripts
	- SexLab Framework
		- to detect if in a scene
	- Pet Collar Mod
		- for the device

What it contains:

SKSE/Plugins/sl_triggers/commandstore/pet_collar_game.json
	- the settings for the game. It comes with some defaults. It has comments to make it easy to understand what is going on.
	
SKSE/Plugins/sl_triggers/extensions/sl_triggersExtensionSexLab/PetCollarGame.json
	- Trigger, enabled by default, set to run "On SexLab Start" (i.e. at the start of a SexLab scene) with a 100% chance
	- It is set to require "Player" (i.e. set to run "on" or "targeting" the Player; this is also the default state of scripts run via e.g. Hotkey)
	
SKSE/Plugins/sl_triggers/commands/PetCollarGame.ini
	- it is currently written to require:
		- being run during a SexLab scene
		- run "on"/"targeting" the player
		- with at least one scene partner who is a follower (FACT: CurrentFollowerFaction, 0x0005C84E, Skyrim.esm)
		- THEN a random number low to high is generated
		- if it's higher than the current "petCollarTime" ($global.petCollarGame.petCollarTime), increment it by 'add' (from settings)
			- END
		
		- else
			- if player is already wearing the pet collar
				- set petCollarTime to mercybase
				- remove the pet collar
				- END
			- if player is wearing a zad_DeviousCollar
				- END
			- tell PetCollar to apply itself
			- set petCollarTime to base
				- END
				
				
		- END

How to apply this:
If you have installed Pet Collar and SL Triggers Redux, and all of their dependencies, to the extent that, individually you know both mods are working, then you can apply this like any other mod e.g. as with MO2.
It does not overwrite any existing files, only adds files in an expected file structure.

Once you're sure both are installed and working, then you can apply this like any other mod/addon-on. It's data only, not even Papyrus scripts, nor .esp, nor .dll. Just some .ini and .json files for SLTR.

Basically each time the script is run is another tick on a counter and another roll of the dice as to whether the counter is still low enough. Too high and it's time to switch collar states!

In SL Triggers Redux, the "PetCollarGame" trigger should already be configured and enabled to run on SexLab ccene start. Contextually, remember that it requires being in a SexLab scene and run from perspective of the player.
This means that, for example, you could, instead of running this with "On SexLab Start", instead use the Core On Cell Change, with a much lower percentage chance, and perhaps with changes to the settings in the pet_collar_game.json to account for a possibly higher frequency of executions.

