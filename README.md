# SL Triggers Redux (SLTR)

# What Does It Do:
SLTR lets you run simple scripts without the need to compile and without worrying about Papyrus script dependencies or whether your script will build. SLTR comes with some scripts for you, thinks like giving yourself a little gold, healing yourself, giving yourself a drink. You can also write your own custom SLTScripts. And finally, you can set up triggers, ways to make SLTScripts run in response to game events, like on game load, on changing location, or even tied to custom keymappings of your choice. All of this is configurable via MCM or text files if you prefer.

It is ESL flagged to minimize impact on your load order and most dependencies are loaded dynamically, so aside from the requirements of SKSE and PapyrusUtils, everything else is optional depending on what functionality you want.

# Requirements
- [SKSE](https://skse.silverlock.org/) - SLTR comes with a plugin that provides core functionality; it is also required for PapyrusUtil
- [Address Library for SKSE Plugins](https://www.nexusmods.com/skyrimspecialedition/mods/32444) - the SLTR plugin needs this as does PapyrusUtil
- [PapyrusUtil](https://www.nexusmods.com/skyrimspecialedition/mods/13048) - provides core functionality

## Optional
These mods provide additional functionality, mostly in the form of integration, i.e. bindings in SLTScript to run functions in the mod, or, as in SexLab's case, full on extensions to provide trigger support and a broad set of additional functions for SLTScript. Not having them simply means your SLTScripts will not have access to functions provided for that mod.
- [SexLab Framework](https://www.loverslab.com/files/file/20058-sexlab-se-sex-animation-framework-v166b-01182024/) (if you want SexLab events and commands)
- [SexLab P+ Framework](https://www.loverslab.com/files/file/25318-sexlab-p/) (this version works as well)
- [OStim Standalone](https://www.nexusmods.com/skyrimspecialedition/mods/98163)
- [Console Util Extended](https://www.nexusmods.com/skyrimspecialedition/mods/133569) (if you want to execute Skyrim console commands in your scripts) (or another ConsoleUtil variant)
- [MfgFix](https://www.nexusmods.com/skyrimspecialedition/mods/11669) (if you want facial expression related commands in your scripts)
- [Devious Followers Continued](https://www.loverslab.com/files/file/11732-devious-followers-continued-se/)
- [OSLAroused](https://www.loverslab.com/files/file/20867-osl-aroused-arousal-reborn-sse-ae/)
- [Devious Devices NG](https://www.loverslab.com/files/file/29779-devious-devices-ng/)/[Devious Devices SE](https://www.loverslab.com/files/file/5878-devious-devices-se/)
- [Pet Collar](https://www.loverslab.com/files/file/1423-petcollar/) - the PetCollar Game is centered on this mod
- [Nether's Follower Framework](https://www.nexusmods.com/skyrimspecialedition/mods/55653)

# More Details Please!
SL Triggers Redux (SLTR, though you may still see references to SLT) is two things: first, it is a scripting engine for the SLTScript scripting language and second, it is an extensible set of triggers that let you set up SLTScripts to be run in response to in-game events. The original focus of SLTR was purely on the four basic SexLab events (Sex Start, Orgasm, Sex End, Separate Orgasm via SLSO), but the framework has been expanded to not be tied solely to SexLab events. In addition, out of the box, you can also set up hotkeys to run scripts on demand, set scripts up to run on the (in-game) hour, and even run scripts directly via console command.

These scripts are simple text files with the .sltscript extension, with an easy to understand syntax and a number of examples available to work from. Scripts are comprised of commands. Commands can be functions like "av_set" (to set an Actor Value) or syntactic commands like "goto" (to script execution to a different line). 

SLTR comes with a base [library of functions available for scripting](https://github.com/lynnpye/sl_triggers/wiki/Function-Libraries) that is growing. That said, it features an extension architecture through which mod authors can implement additional functions that would be available to other users of SLT that also install the extension. This allows the ability to expand the function library without needing it to be added to the core library.

You don't have to program the scripts to use them. A selection is available for you to work with from the get-go, plus any you want to copy and modify, and of course you can also share scripts with other SLTR users. (I hold no copyright over any SLTScripts anyone creates, just so you know.)

Visit the [SLT wiki](https://github.com/lynnpye/sl_triggers/wiki) for complete details, including script examples and SLT API documentation for your SLTScripts, as well as integration features.

# Supported Events
Events that occur in game (SexLab orgasm, Key press, Fast Travel) can be configured to fire triggers, which in turn can result in running scripts if the filters match. Currently, you can run SLTScripts in response to the following events:
- Core
  - Keymapping (triggers in response to your choice of hotkey mapping, with optional modifier and DAK support)
  - Top of the Hour (triggers on the in-game hour (or on the next such hour after sleep or travel))
  - New Session (triggers on each new game load)
  - Player Cell Change (triggers on each Cell change; this happens more frequently than you might think, so be careful about heavy scripts with this, and protect against spamming i.e. player running back and forth across cell boundaries could generate spammed script executions)
  - Player Opened Container (triggers after a Player opens a container; depending on timing of the backing ActiveMagicEffect landing, might not run until after the container is closed)
  - Player Location Change (triggers on each Location change; typically much less frequent than Cell change)
  - Player Equipment Change (triggers when the player swaps equipment)
  - Player Combat State Changed (triggers when the Player's combat status changes)
  - Player Hit Or Is Hit (triggers when the Player is hit; this can result in a lot of executions so be careful with filter selection and heavy scripts)
  - Timer (triggers on a per-minute timer, delayed anywhere from 1 to 60 minutes)
  - Harvesting (triggers when harvesting typical harvestables; e.g. plants, mushrooms, butterflies)
  - Fast Travel Arrival (triggers when you arrive after fast travel)
  - Vampirism Transitions (triggers when: you become a Vampire, you are cured, you transform to a Vampire Lord, and you end the Vampire Lord transformation)
  - Werewolf Transitions (triggers when: you are cursed, you are cured, you transform into a Werewolf, and you end the Werewolf transofmration)
  - Vampire Feeding (triggers when you begin vampiric feeding)
- SexLab (optional)
  - Start
  - Stop
  - Orgasm
  - Orgasm, Separate
  - Stage Start
  - Stage End
- OStim (optional)
  - Start
  - Stop
  - Orgasm
  - SceneChange

# Scripts Provided
These are some of the SLTScripts provided out of the box with just the Core install. That means you can run any of them from the console, or in response to any trigger, with no additional configuration. Making more SLTScripts available is simple; add them to your 'Data/SKSE/Plugins/sl_triggers/commands/' folder and on your next game launch you will see them. The 'target' of a script might be someone other than the player i.e. if you target them when using the console commands or if an event fires that targets them, like SexLab Separate Orgasm.
- Example Scripts part of Core:
  - Add Perk Point - adds 1 perk point
  - Alcohol - feeds the player 1 random alcoholic drink
  - Cast Calm - casts Apprentice level Calm spell on target
  - Cast Light - casts Light spell on target
  - Change stats (bad) - randomly modifies the Health, Magicka, and Stamina of the target by up to -10 (i.e. negative modifier to max)
  - Change stats (good) - randomly modifies the Health, Magicka, and Stamina of the target by up to 10 (i.e. positive modifier to max)
  - CureDisease - casts "Cure Disease" on the target
  - Harm/Heal (-100/+100) - performs damage or healing as indicated on the target
  - Show Limited RaceMenu - shows the "limited" racemenu, allowing modifying of RaceMenu settings besides Race and Sex (similar to Vanity Mirror)

# Add-Ons/Mini-Games Available
These are add-on packs or mini-games implemented through SLTR. These may alter gameplay or introduce new mechanics. Typically these involve combinations of SLTScripts, pre-built triggers, and sometimes configuration files.
- PetCollar Game - (Requires: SexLab, PetCollar; Contents: SLTScript, trigger, JSON) At the start of SexLab scenes, your followers will (somewhat) randomly choose to equip and unequip the "Keyless Pet Collar" from the PetCollar mod. This is the one which cannot be picked or removed by the wearer.
- Consumption Lifestyle - (Requires: Transformative Elixirs; contents: SLTScript, trigger) When the non-stealth varieties of Transformative Elixirs appear in containers the player interacts with, they will automatically pull them into their inventory and consume them. Additionally, a periodic timer will run which will look for these items and consume them.

# Installation
## If You Are Updating From An Older Version
If you are moving from Fotogen's original SL Triggers, you will need a new save.

If you are updating from one version of SLTR (this mod) to a newer version, check the CHANGELOG, but I'll likely still recommend a new save. Regardless, especially for small version jumps, it doesn't hurt to try first without a new save.

That said, I have often found that both Fotogen's and mine seem to be able to survive the following:
- Save your game and quit Skyrim
- Remove the old version
- Run Skyrim, load your save, click through the warning, save, and quit again
- Perform any necessary cleanup (e.g. some versions no longer understand old script formats like JSON)
- Install the new version
- Run Skyrim and enjoy your new version

However, in case of support, if a problem persists beyond that, the next logical step would be to test on a new save if possible.

## If You Are Installing For The First Time
### Using MO2 Is Recommended
I personally use (ModOrganizer2/MO2)[https://www.modorganizer.org/] and even then, often just through whichever modlist I'm using via (wabbajack)[https://www.wabbajack.org/]. If using MO2, dragging an SLTR install .zip into the downloads tab should be sufficient to make it available to install into your list. Similarly dragging it into your active load order should be sufficient to have it installed and running when you next play. It doesn't (at this time) have any particular load order requirements so feel free to move it about as you need.

### If, However, You Are Doing A Manual Install
SLTR itself is a typical mod install with a SKSE plugin. It installs into Data\ as you would expect

## Mod and Plugin Logging Output
Mod logging output will appear in whichever folder SKSE is configured to output to. On a typical Windows 10 Steam install, for example, I think this ends up in your 'Documents\My Games\Skyrim Special Edition\SKSE\sl-triggers.log' folder. Generally I also send log output from Papyrus script through the plugin, so all log output should be located in that one file.

## Once It Is Installed
Once installed, you should now find in your 'mods' folder a new sub-folder, 'sl_triggers' (or whatever you named it during install).

The mod folder structure at install should look something like:

- `interfaces\` - containing e.g. translation files
- `scripts\` - containing compiled .pex files
- `SKSE\`
  - `CustomConsole\` - config file for ConsoleUtil-Extended to provide improved console commands
  - `Plugins\`
    - `sl_triggers\`
      - `commands\` - pre-made SLTScripts you can link to triggers without having to do any coding
      - `commandstore\` - folder available for SLTScript usage as well as shared persisted files (other locations are not excluded)
      - `extensions\`
        - `sl_triggersExtensionCore\` - trigger definitions (JSON) for events handled by the 'Core' extension
          - new triggers for the 'Core' extension will be created here (but may end up in your overwrite or other folder specified for output files)
          - you can place your own JSON files (as long as the filename can be a valid string in the Skyrim Papyrus VM) here without needing to use the MCM
          - this also allows you to share triggers created by others
        - `sl_triggersExtensionSexLab\` - trigger definitions (JSON) for events handled by the 'SexLab' extension
          - new triggers for the 'SexLab' extension will be created here (but may end up in your overwrite or other folder specified for output files)
          - similarly, this works for any extension; for now there are only 'Core' and 'SexLab' offered by the mod
        - `sl_triggersExtensionCore-attributes.json` - DO NOT EDIT; JSON-based definitions for the SLTR MCM to handle Core triggers
        - `sl_triggersExtensionCore-libraries.json` - DO NOT EDIT; JSON configuration for Core function libraries
        - `sl_triggersExtensionSexLab-attributes.json` - DO NOT EDIT; JSON-based definitions for the SLTR MCM to handle SexLab triggers
        - `sl_triggersExtensionSexLab-libraries.json` - DO NOT EDIT; JSON configuration for SexLab function libraries
      - `containers.json` - JSON configuration for Containers (provides support for the Core trigger: On Player Activate Container)
        - you can modify this file to add containers from other mods that will be detected; it includes some examples
        - you can also define which containers will be considered "Common" for filtering purposes; some defaults are included
      - `settings.json` - created at first launch to avoid being overwritten during updates
    - `sl-triggers.dll` - SKSE plugin; CommonLibNG-SSE based; uses Address Library; should support most used versions
- `source\`
  - `scripts\` - containing source .psc files for the .pex files
- `sl_triggers.esp`
- `sl_triggers_CHANGELOG.txt`
- `sl_triggers_function_library.md` - Markdown documentation for available SLTScript functions provided by SLTR (other functions may be provided by third party extensions and function libraries)
- `sl_triggers_function_library.txt` - Text documentation for available SLTScript functions provided by SLTR (other functions may be provided by third party extensions and function libraries)
- `sl_triggers_sltscripts.txt` - Basic information about SLTScript; for the best documentation visit the [wiki](https://github.com/lynnpye/sl_triggers/wiki).

## In-Game Configuration
If you have SkyUI installed, you should have an MCM available as 'SL Triggers Redux'. Any extensions registering themselves with SLTR will be listed on the left.

The main SLTR MCM screen has an 'Enabled' option (on by default), a 'Debug' option, and a number of Granular Debug options, all of which are off by default. This will cause very little logging output. Even with all 'Debug' options off, during SLTScript parsing, if errors or important warnings or info need to be reported, they will be sent to that log. If your SLTScript isn't behaving as expected, check the log first.

All of the 'Debug' options will output to the log file and will absolutely impact performance, both of your SLTScript and likely the game itself. This can be useful when troubleshooting your scripts, but don't leave it on for general play.

Selecting an extension displays it's triggers if it has any defined, and gives you the option to create more. Each trigger has filter options on it's card for you to customize when the scripts should be applied.

In game, if you are using the MCM to create new triggers, or as any new files are generated by SLTR (like new .json files if you create SLTScript that does so), they will be generated in the 'overwrite\' folder as for any mod; if you want to manage those files, you will need to manually copy them into whatever new location you want them in.

You can also "soft delete" a trigger, marking it inactive until either you restore it or go in and physically remove the trigger file. Until restored it will remain inactive.

# About Performance:

Effort has been made to avoid scripts from stressing the system more than necessary, but there are still limitations. Each script will be run on an Actor in game (the Player or an NPC) as an ActiveMagicEffect i.e. as from a Spell. Any one Actor can have no more than 30 scripts running on them at one time. Scripts can be long-running if you make them so, so be careful not to let things run away.

# Okay, But How Do I Run A Script!
## Running Scripts Manually
You can use the console to list available scripts and run them. From the console, use:

    slt list

To list the available scripts. To run a given script, use:

    slt run "scriptname"

The quotes are only necessary if the script name has spaces. So, to give yourself a free 10 septims, try:

    slt run "Give Gold(10)"

## Setting Up a Keymapping
If you have a script you want to be able to run at the press of a button, set up a Keymapping trigger. This is most easily done through the MCM.

Go to the "SL Triggers Redux" MCM and choose the "SLTR Core" extension. Then click "Add New Item" on the right. Choose "Keymapping" as the event type, then select the key you wish to map it to. Finally, click the "Do 1" drop down and select a script to run. Exit the MCM and you should be able to run that script on demand just by pressing your mapped key!

# What Is Different From the Original?

Fotogen's original sl_triggers effort is great and still works well. Plus I had already added some of these features (like the Keymapping and Top of the Hour event handling) to it. So what else is new in this updated version?

- Extensible - It is very easy to expand functionality to add more operations to be available in your scripts with the new command libraries; Papyrus script developers can create their own .psc file with global functions to add new operations that will be available to any script run on the system
- New script format - The original format used JSON which is conveniently supported in the Skyrim environment but not convenient for development; the new .sltscript format is easier to read and works conveniently with syntax highlighting for some of the features
- More than SexLab - I know, SexLab is the SL in SLT; but the framework supports any event to fire a script and the scripts can interact with a lot more than just SexLab
- ModEvent support for Script Execution - Mod authors can send mod events with a script name and SLT will run the script on the targeted Actor (or the Player if no target is available)
- API support - You can also access the same features through an API if you prefer
- Console command support - Some features available from the console
- Additional SLTScript language features - subroutines; script-to-script execution with call arguments; named variables; multiple variable scopes including target(i.e. persistent by Actor) and global(i.e. persistent for lifetime of save)

# Build Instructions
If you are looking to build anything here, here are a few things to keep in mind:

- The root for sl-triggers development on my machine happens to be `D:\src\sksemods\sl_triggers`
- I use VSCode (Visual Studio Code) for development
- I have Visual Studio 2022 for the build tools
- Prior to launch, I open a Visual Studio Developer Prompt
  - To start developing for Papyrus: `code <sl_triggers root>`
    - So in my case, `code D:\src\sksemods\sl_triggers`
  - To start developing for the C++ Plugin: `code <sl_triggers root>\plugin\sl-triggers`
    - Yes, that is a hyphen, not an underscore, unlike the root folder
    - So in my case, `code D:\src\sksemods\sl_triggers\plugin\sl-triggers`
  - Use of the Developer Prompt is required to make sure the appropriate tools are in the path
- There are VScode tasks for builds and packaging
- Uses `jump` for task execution
- I do *not* reuse the Papyrus VSCode instance to do C++ development, but YMMV

# Speaking of Copyright and Licensing / Attribution
See LICENSE for all license, copyright, and attribution details.

All SLTScripts created by anyone else are subject to their copyright and I hold none over them.