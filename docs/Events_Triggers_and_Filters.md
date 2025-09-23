# Events, Triggers, and Filters

## The Event/Trigger/Filter Process
Each trigger you create is tied to a particular event, things like timers (the event runs on your schedule), keystrokes (when using Keymapping), changing location (Player Location Change) are all tied to events.

Triggers have filters, conditions which must be met for a trigger to run scripts defined for it. Many filters default to the equivalent of "Any", meaning the filter is generally ignored. For a filter to pass, it must either be set to such an "Any" value, or the condition matching it's value must be true. For example, if a filter requires the sky to be blue, the filter will fail if the sky is any color other than blue; but if that same filter is set to "Any", it will be ignored.

When you create triggers, SLTR groups them by event type and stores them in a list. When you open a save, the lists are refreshed. When you update the triggers, the lists are updated.

When an event fires, the associated list of triggers is iterated and for each, the trigger's filters are checked. If all filters pass, all scripts associated with the trigger are run.

## Events and Actors
SLTScripts are always run in the context of an Actor. This Actor is called the "targeted actor" and is what will resolve when using `$system.self`.

While most events have only a single Actor to consider, and many are explicitly stated, some might have multiple Actors in consideration. An example would be "SexLab Start", where the one event includes a reference to all Actors in the scene. In these cases, the filters are still applied to all Actors to determine which Actors, if any, will be targeted with the SLTScripts for the trigger.

## Available Triggers and Their Filters
The following shows available triggers and their filters.

- Core Triggers
  - Keymapping
    - Runs in response to key mappings you choose
  - Top of the Hour
    - Runs each in-game hour, at the top of the hour (e.g. 1 o'clock, 2 o'clock); May skip time due to travel and sleep
  - New Session
    - Runs once when a game is created or a save is loaded
  - Player Cell Change
    - Runs when the Player changes cells, which happens fairly frequently
  - Player Opened Container
    - Runs when the Player opens a container
  - Player Location Change
    - Runs when the Player changes locations
  - Player Equipment Change
    - Runs when the Player's equipped items have changed, i.e. putting on or taking off armor
  - Player Combat State Changed
    - Runs when the Player's combat state changes, i.e. when entering or leaving combat
  - Player Hit Or Is Hit
    - Runs any time the Player hits something or is it by something
  - Timer
    - Runs on an interval between 1 and 60 minutes inclusive (e.g. once every 1 minute, or once every 2 minutes)
  - Harvesting
    - Runs when the Player harvests things e.g. plants, fish, bugs
  - Fast Travel Arrival
    - Runs when the Player arrives due to fast travel
  - Vampirism Transition
    - Runs when the Player's contracts vampirism (not just the initial disease) and when cured, and when the Vampire Lord form is entered or left
  - Werewolf Transition
    - Runs when the Player contracts lycanthropy and when cured, and when the Werewolf form is entered or left
  - Vampire Feeding
    - Runs when the Player feeds in vampire state
  - Swim Start/Stop
    - Runs when the Player starts or stops the "Swimming" state
  - Water Enter/Exit
    - Runs when the Player enters or leaves water
  - Soul Trapped
    - Runs any time a soul is trapped
- SexLab/SexLab P+ Triggers
  - Start
    - Runs for all Actors starting the SexLab scene
  - Stop
    - Runs for all Actors ending the SexLab scene
  - Orgasm
    - Runs for all Actors when an SexLab orgasm occurs
  - Orgasm, Separate
    - Runs for the Actor that had an SexLab orgasm
  - Stage Start
    - Runs for all Actors when a SexLab stage starts
  - Stage End
    - Runs for all Actors when a SexLab stage ends
- OStim Triggers
  - Start
    - Runs for all Actors starting the OStim scene
  - Stop
    - Runs for all Actors ending the OStim scene
  - Orgasm
    - Runs for the Actor that had an OStim orgasm
  - SceneChange
    - Runs for all Actors when an OStim scene changes

## Filter Definitions
### Chance
The percentage (%) chance the trigger will run. Defaults to 100 (i.e. always pass).
To Pass: The chance value is compared to a random number from 0 to 100; if chance is equal to or greater than the random value, the filter passes.

### Key
The key to check the pressed state for.
To Pass: The indicated key must be pressed.

### Timer Delay
Defines the interval for the timer; from 1 to 60, inclusive.
To Pass: Used in timer setup; auto-pass.

### Modifier Key
The modifier key to check the pressed state for. Only matters if the main Key is also pressed.
To Pass: The indicated modifier key must be pressed.

### Use DAK
Whether to use the Dynamic Activation Key mod's DAK key instead of a Modifier Key.
To Pass: If checked, the DAK key must currently be activated.

### Cleared
Whether the location is considered cleared or not.
Options:
- Any
- Cleared
- Not Cleared