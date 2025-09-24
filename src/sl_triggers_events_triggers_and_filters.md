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
    - [Chance](#chance)
    - [Key](#key)
    - [Modifier Key](#modifier-key)
    - [Use DAK](#use-dak)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
  - Top of the Hour
    - Runs each in-game hour, at the top of the hour (e.g. 1 o'clock, 2 o'clock); May skip time due to travel and sleep
    - [Chance](#chance)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - New Session
    - Runs once when a game is created or a save is loaded
    - [Chance](#chance)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - Player Cell Change
    - Runs when the Player changes cells, which happens fairly frequently
    - [Chance](#chance)
    - [Daytime](#daytime)
    - [Location](#location)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - Player Opened Container
    - Runs when the Player opens a container
    - [Chance](#chance)
    - [Common Containers](#common-containers)
    - [Location](#location)
    - [Corpses](#corpses)
    - [Empty Containers](#empty-containers)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - Player Location Change
    - Runs when the Player changes locations
    - [Chance](#chance)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
    - [Daytime](#daytime)
    - [Leaving Location](#location)
    - [Leaving Location Cleared](#cleared)
    - [Entering Location](#location)
    - [Entering Location Cleared](#cleared)
  - Player Equipment Change
    - Runs when the Player's equipped items have changed, i.e. putting on or taking off armor
    - [Chance](#chance)
    - [Equipping/Unequipping](#equippingunequipping)
    - [Has Enchants](#has-enchants)
    - [Type of Item](#type-of-item)
    - [Armor Slot](#armor-slot)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
    - [Unique/World Item](#uniqueworld-items)
  - Player Combat State Changed
    - Runs when the Player's combat state changes, i.e. when entering or leaving combat
    - [Chance](#chance)
    - [Combat State](#combat-state)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - Player Hit Or Is Hit
    - Runs any time the Player hits something or is it by something
    - [Chance](#chance)
    - [Player Attacking](#player-attacking)
    - [Attack Blocked](#attack-blocked)
    - [Power Attacking](#power-attacking)
    - [Sneak Attacking](#sneak-attacking)
    - [Bash Attacking](#bash-attacking)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - Timer
    - Runs on an interval between 1 and 60 minutes inclusive (e.g. once every 1 minute, or once every 2 minutes)
    - [Chance](#chance)
    - [Timer Delay](#timer-delay)
    - [Location](#location)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - Harvesting
    - Runs when the Player harvests things e.g. plants, fish, bugs
    - [Chance](#chance)
    - [Location](#location)
    - [Daytime](#daytime)
  - Fast Travel Arrival
    - Runs when the Player arrives due to fast travel
    - [Chance](#chance)
  - Vampirism Transition
    - Runs when the Player's contracts vampirism (not just the initial disease) and when cured, and when the Vampire Lord form is entered or left
    - [Chance](#chance)
    - [Vampirism Transition](#vampirism-transition)
    - [Location](#location)
    - [Daytime](#daytime)
  - Werewolf Transition
    - Runs when the Player contracts lycanthropy and when cured, and when the Werewolf form is entered or left
    - [Chance](#chance)
    - [Lycanthropy Transition](#lycanthropy-transition)
    - [Location](#location)
    - [Daytime](#daytime)
  - Vampire Feeding
    - Runs when the Player feeds in vampire state
    - [Chance](#chance)
    - [Location](#location)
    - [Daytime](#daytime)
  - Swim Start/Stop
    - Runs when the Player starts or stops the "Swimming" state
    - [Chance](#chance)
    - [Swimming Start/Stop](#swimming-startstop)
  - Water Enter/Exit
    - Runs when the Player enters or leaves water
    - [Chance](#chance)
    - [Entering/Leaving Water](#enteringleaving-water)
  - Soul Trapped
    - Runs any time a soul is trapped
    - [Chance](#chance)
    - [Is Player](#is-player)
    - [Location](#location)
    - [Daytime](#daytime)
- SexLab/SexLab P+ Triggers
  - Start
    - Runs for all Actors starting the SexLab scene
    - [Chance](#chance)
    - [Race](#race)
    - [Player Relationship](#player-relationship)
    - [Sex](#sex)
    - [Partner Race](#partner-race)
    - [Partner Role](#partner-role)
    - [Partner Sex](#partner-sex)
    - [Position](#position)
    - [Tag](#tag)
    - [Daytime](#daytime)
    - [Location](#location)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - Stop
    - Runs for all Actors ending the SexLab scene
    - [Chance](#chance)
    - [Race](#race)
    - [Player Relationship](#player-relationship)
    - [Sex](#sex)
    - [Partner Race](#partner-race)
    - [Partner Role](#partner-role)
    - [Partner Sex](#partner-sex)
    - [Position](#position)
    - [Tag](#tag)
    - [Daytime](#daytime)
    - [Location](#location)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - Orgasm
    - Runs for all Actors when an SexLab orgasm occurs
    - [Chance](#chance)
    - [Race](#race)
    - [Player Relationship](#player-relationship)
    - [Sex](#sex)
    - [Partner Race](#partner-race)
    - [Partner Role](#partner-role)
    - [Partner Sex](#partner-sex)
    - [Position](#position)
    - [Tag](#tag)
    - [Daytime](#daytime)
    - [Location](#location)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - Orgasm, Separate
    - Runs for the Actor that had an SexLab orgasm
    - [Chance](#chance)
    - [Race](#race)
    - [Player Relationship](#player-relationship)
    - [Sex](#sex)
    - [Partner Race](#partner-race)
    - [Partner Role](#partner-role)
    - [Partner Sex](#partner-sex)
    - [Position](#position)
    - [Tag](#tag)
    - [Daytime](#daytime)
    - [Location](#location)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - Stage Start
    - Runs for all Actors when a SexLab stage starts
    - [Chance](#chance)
    - [Race](#race)
    - [Player Relationship](#player-relationship)
    - [Sex](#sex)
    - [Partner Race](#partner-race)
    - [Partner Role](#partner-role)
    - [Partner Sex](#partner-sex)
    - [Position](#position)
    - [Tag](#tag)
    - [Daytime](#daytime)
    - [Location](#location)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - Stage End
    - Runs for all Actors when a SexLab stage ends
    - [Chance](#chance)
    - [Race](#race)
    - [Player Relationship](#player-relationship)
    - [Sex](#sex)
    - [Partner Race](#partner-race)
    - [Partner Role](#partner-role)
    - [Partner Sex](#partner-sex)
    - [Position](#position)
    - [Tag](#tag)
    - [Daytime](#daytime)
    - [Location](#location)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
- OStim Triggers
  - Start
    - Runs for all Actors starting the OStim scene
    - [Chance](#chance)
    - [Race](#race)
    - [Player Relationship](#player-relationship)
    - [Sex](#sex)
    - [Partner Race](#partner-race)
    - [Partner Role](#partner-role)
    - [Partner Sex](#partner-sex)
    - [Position](#position)
    - [Tag](#tag)
    - [Daytime](#daytime)
    - [Location](#location)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - Stop
    - Runs for all Actors ending the OStim scene
    - [Chance](#chance)
    - [Race](#race)
    - [Player Relationship](#player-relationship)
    - [Sex](#sex)
    - [Partner Race](#partner-race)
    - [Partner Role](#partner-role)
    - [Partner Sex](#partner-sex)
    - [Position](#position)
    - [Tag](#tag)
    - [Daytime](#daytime)
    - [Location](#location)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - Orgasm
    - Runs for the Actor that had an OStim orgasm
    - [Chance](#chance)
    - [Race](#race)
    - [Player Relationship](#player-relationship)
    - [Sex](#sex)
    - [Partner Race](#partner-race)
    - [Partner Role](#partner-role)
    - [Partner Sex](#partner-sex)
    - [Position](#position)
    - [Tag](#tag)
    - [Daytime](#daytime)
    - [Location](#location)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)
  - SceneChange
    - Runs for all Actors when an OStim scene changes
    - [Chance](#chance)
    - [Race](#race)
    - [Player Relationship](#player-relationship)
    - [Sex](#sex)
    - [Partner Race](#partner-race)
    - [Partner Role](#partner-role)
    - [Partner Sex](#partner-sex)
    - [Position](#position)
    - [Tag](#tag)
    - [Daytime](#daytime)
    - [Location](#location)
    - [Is Weapon/Spell Drawn](#is-weaponspell-drawn)
    - [Is Armor/Clothing Equipped](#is-armorclothing-equipped)
    - [Is Weapon/Spell Equipped](#is-weaponspell-equipped)

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

### Location
The type of the location being considered.

Options:
- Any
- Interior
- Exterior
- Safe Area (Home/Jail/Inn)
- City (City/Town/Habitation/Dwelling)
- Wilderness (No Location/Hold/Fort/Bandit Camp)
- Dungeon (Cave/Dungeon/Dwemer Dungeon/etc.)
- Player Home
- Jail
- Dungeon
- Cave
- Dwelling
- City
- Town
- Habitation
- Draugr Crypt
- Dragon Priest Lair
- Bandit Camp
- Falmer Hive
- Vampire Lair
- Dwemer Ruin
- Military Fort
- Mine
- Inn
- Hold

### Equipping/Unequipping
Whether equipment is being put on or taken off.

Options:
- Any
- Equipping Item
- Unequipping Item

### Is Weapon/Spell Equipped
Whether the actor has a weapon or spell equipped.

Options:
- Any
- Equipped In Either Hand
- Not Equipped In Either Hand
- Not Equipped In Main/Right Hand

### Is Armor/Clothing Equipped
Whether the actor has armor or clothing equipped.

Options:
- Any
- Equipped in Body Slot(32)
- Not Equipped In Body Slot (32)
- Not Equipped or Devious Item Equipped In Body Slot (32)
  - That is, either nothing is equipped, or what is equipped is a devious item

### Is Weapon/Spell Drawn
Whether the actor has a weapon or spell drawn.

Options:
- Any
- Weapon/Spell Is Drawn
- Weapon/Spell Is Not Drawn

### Has Enchants
Whether an item has enchantments or not.

Options:
- Any
- Must Have Enchantments
- Cannot Have Enchantments

### Unique/World Items
Whether an item is a unique item (e.g. Dawnbreaker) or a standard item (e.g. Iron Sword). (specifically, do the equip/unequip events provide an ObjectReference or just the base Form?)

Options:
- Any
- Standard Items Only
- Unique/World Items Only

### Type of Item
What type of item is being considered.

Options:
- Any
- Armor Item
- Weapon Item
- Spell Item
- Potion/Food Item
- Ammo Item

### Armor Slot
Which armor slot armor belongs to.

Options:
- Any
- Body/Head/Hands/Feet
  - i.e. any of these 4 main slots
- Ring/Amulet/Circlet
  - i.e. any of these 3 common secondary slots
- 30 - Head
- 31 - Hair
- 32 - Body
- 33 - Hands
- 34 - Forearms
- 35 - Amulet
- 36 - Ring
- 37 - Feet
- 38 - Calves
- 39 - Shield
- 40 - Tail
- 41 - LongHair
- 42 - Circlet
- 43 - Ears
- 44 - Unnamed
- 45 - Unnamed
- 46 - Unnamed
- 47 - Unnamed
- 48 - Unnamed
- 49 - Unnamed
- 50 - DecapitatedHead
- 51 - Decapitate
- 52 - Unnamed
- 53 - Unnamed
- 54 - Unnamed
- 55 - Unnamed
- 56 - Unnamed
- 57 - Unnamed
- 58 - Unnamed
- 59 - Unnamed
- 60 - Unnamed
- 61 - FX01

### Daytime
Whether the event took place during daytime or nighttime.

Options:
- Any
- Day
  - between 7am and 7pm
- Night
  - between 7pm and 7am

### Common Containers
Whether to ignore or require a container be 'common'. 'common' is defined through the containers.json file.

Options:
- Any
- Ignore Common Containers
- Only Common Containers

### Corpses
Whether to ignore or require a container be a corpse.

Options:
- Any
- Ignore Corpses
- Only Corpses

### Empty Containers
Whether to ignore or require a container be empty.

Options:
- Any
- Ignore Empty Containers
- Only Empty Containers

### Combat State
Whether the player is entering or leaving combat.

Options:
- Any
- Entering Combat
- Leaving Combat

### Player Attacking
Whether the player is the one attacking or being attacked.

Options:
- Any
- Player Attacking
- Player Being Attacked

### Power Attacking
Whether an attack was a 'power attack'.

Options:
- Any
- Is Power Attacking
- Is Not Power Attacking

### Sneak Attacking
Whether an attack was a 'sneak attack'.

Options:
- Any
- Is Sneak Attacking
- Is Not Sneak Attacking

### Bash Attacking
Whether an attack was a 'bash attack'.

Options:
- Any
- Is Bash Attacking
- Is Not Bash Attacking

### Attack Blocked
Whether an attack was blocked.

Options:
- Any
- Was Attack Blocked
- Was Attack Left Unblocked

### Vampirism Transition
Which vampirism transition is occurring.

Options:
- Any
- Cured
- Contracted
  - Note: this is when the disease finally turns you into a vampire, not when you contract the disease initially.
- Enter Vampire Lord Form
- Leave Vampire Lord Form

### Lycanthropy Transition
Which lycanthropy transition is occurring.

Options:
- Any
- Cured
- Contracted
- Enter Werewolf Form
- Leave Werewolf Form

### Swimming Start/Stop
Whether the event was caused by the player starting or stopping the swim action.

Options:
- Either
- Start
- Stop

### Entering/Leaving Water
Whether the event was caused by the player entering or leaving the water.

Options:
- Either
- Entering
- Leaving

### Is Player
Whether the actor is the Player.

Options:
- Either
- Is Player
- Is Not Player

### Race
The type of race of the actor.

Options:
- Any
- Humanoid
  - Player is always treated as a Humanoid
- Creature
- Undead

### Role
(OStim/SexLab/SexLab P+) The role of the actor in the scene.

Options:
- Any
- Aggressor
- Victim
- Not part of aggressive scene

### Player Relationship
(OStim/SexLab/SexLab P+) The relationship of the actor to the Player.

Options:
- Any
- Player
  - i.e. the actor is the Player
- Not Player
  - i.e. any actor other than the Player (possibly not even in a scene with the Player)
- Partner Player
  - i.e. the actor is in the scene with the Player but is not the Player
- Partner Not Player
  - i.e. the actor is not in the scene with the Player

### Sex
(OStim/SexLab/SexLab P+) The sex of the actor in the scene.

Options:
- Any
- Male
- Female
- Futa (SexLab P+ only)
- Creature - Male (SexLab/SexLab P+ only)
- Creature - Female (SexLab/SexLab P+ only)

### Tag
(OStim/SexLab/SexLab P+) The tag (or action for OStim) for the scene. Other tags may exist; these are primary/basic. Note: OStim users may customize the actions that qualify as 'vaginal', 'anal', or 'oral' in the `ostim-configuration.json` file.

Options:
- Any
- Vaginal
- Anal
- Oral

### Position
(OStim/SexLab/SexLab P+) The indexed position in the actor list for the given scene.

Options:
- Any
- 1
- 2
- 3
- 4
- 5

### Partner Race
(OStim/SexLab/SexLab P+) Whether, for a given actor in a scene, there are any other actors in the same scene with the specified race type.

Options:
- Any
- Humanoid
  - The Player qualifies as Humanoid
- Creature
- Undead

### Partner Role
(OStim/SexLab/SexLab P+) Whether, for a given actor in a scene, there are any other actors in the same scene with the specified role.

Options:
- Any
- Aggressor
- Victim
- Not part of aggressive scene

### Partner Sex
(OStim/SexLab/SexLab P+) Whether, for a given actor in a scene, there are any other actors in the same scene with the specified sex.

Options:
- Any
- Male
- Female
- Futa (SexLab P+ only)
- Creature - Male (SexLab/SexLab P+ only)
- Creature - Female (SexLab/SexLab P+ only)