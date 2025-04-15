scriptname slso_mcm extends ski_configbase
sexlabframework property sexlab auto
spell property slso_spellanimsync auto
spell property slso_spellvoice auto
spell property slso_spellgame auto
event onconfiginit()
endevent
function refreshstrings()
endfunction
event onpagereset(string page)
endevent
function page_config()
endfunction
function page_widget()
endfunction 
function page_widget_colors()
endfunction 
function page_sound_system()
endfunction 
string function dectohex(int value)
endfunction 
state sl_estrusforcedenjoyment
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onhighlightst()
endevent
endstate
state sl_sla_orgasmexposureloss
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onhighlightst()
endevent
endstate
state sl_sla_orgasmexposuremodifier
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onhighlightst()
endevent
endstate
state sl_enjoymentrate_male
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state sl_enjoymentrate_female
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state condition_minimum_aggressor_orgasm
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onhighlightst()
endevent
endstate
state condition_maximum_aggressor_orgasm
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onhighlightst()
endevent
endstate
state condition_chance_minimum_aggressor_orgasm_increase
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onhighlightst()
endevent
endstate
state sl_hot_voice_strength
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onhighlightst()
endevent
endstate
state game_hybrid_progression_delay
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onhighlightst()
endevent
endstate
state sl_multiorgasmchance
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onhighlightst()
endevent
endstate
state sl_multiorgasmchance_curve
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onhighlightst()
endevent
endstate
state sl_default_always_orgasm
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state sl_npcscene_always_orgasm
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state game_no_sta_endanim
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state game_male_orgasm_endanim
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state game_hybrid_progression
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state sl_passive_enjoyment
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state sl_stage_enjoyment
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_consensual_orgasm
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_aggressor_orgasm
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_aggressor_change_animation
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_player_aggressor_orgasm
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state sl_agressor_bonus_enjoyment
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_female_orgasm_bonus
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_male_orgasm_penalty
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_female_orgasm
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_male_orgasm
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_futa_orgasm
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_leadin_orgasm
event onselectst()
endevent
endstate
state sl_sla_arousal
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state sl_sla_stage_arousal
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state sl_exhibitionist
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state slso_game
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state slso_game_npc
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state slso_game_edging
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state slso_game_scriptupdate_boost
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state game_player_autoplay
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state game_victim_autoplay
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state sl_masturbation
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state game_passive_enjoyment_reduction
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state game_enjoyment_reduction_chance
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state game_animation_speed_control
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state game_animation_speed_control_actorsync
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state game_animation_speed_control_min
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state game_animation_speed_control_max
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state game_pleasure_priority
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_player_orgasm
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_victim_orgasm
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_victim_arousal
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state condition_ddbelt_orgasm
event onselectst()
endevent
endstate
state widget_player_only
event onselectst()
endevent
endstate
state widget_show_enjoymentmodifier
event onselectst()
endevent
endstate
state hotkey_bonusenjoyment
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event onhighlightst()
endevent
endstate
state hotkey_edge
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event onhighlightst()
endevent
endstate
state hotkey_orgasm
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event onhighlightst()
endevent
endstate
state hotkey_utility
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event onhighlightst()
endevent
endstate
state hotkey_pausegame
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event onhighlightst()
endevent
endstate
state hotkey_widget
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event onhighlightst()
endevent
endstate
state widget1_0
event onselectst()
endevent
endstate
state widget1_1
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state widget1_2
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state widget1_3
event onselectst()
endevent
endstate
state widget2_0
event onselectst()
endevent
endstate
state widget2_1
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state widget2_2
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state widget2_3
event onselectst()
endevent
endstate
state widget3_0
event onselectst()
endevent
endstate
state widget3_1
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state widget3_2
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state widget3_3
event onselectst()
endevent
endstate
state widget4_0
event onselectst()
endevent
endstate
state widget4_1
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state widget4_2
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state widget4_3
event onselectst()
endevent
endstate
state widget5_0
event onselectst()
endevent
endstate
state widget5_1
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state widget5_2
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state widget5_3
event onselectst()
endevent
endstate
state labeltextsize
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state valuetextsize
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state borderalpha
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state backgroundalpha
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state meteralpha
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state meterscale
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state widgetcolors_0
event oncoloropenst()
endevent
event oncoloracceptst(int value)
endevent
endstate
state widgetcolors_1
event oncoloropenst()
endevent
event oncoloracceptst(int value)
endevent
endstate
state widgetcolors_2
event oncoloropenst()
endevent
event oncoloracceptst(int value)
endevent
endstate
state widgetcolors_3
event oncoloropenst()
endevent
event oncoloracceptst(int value)
endevent
endstate
state widgetcolors_4
event oncoloropenst()
endevent
event oncoloracceptst(int value)
endevent
endstate
state widgetcolors_5
event oncoloropenst()
endevent
event oncoloracceptst(int value)
endevent
endstate
state labelcolor
event oncoloropenst()
endevent
event oncoloracceptst(int value)
endevent
endstate
state selectedactorcolor
event oncoloropenst()
endevent
event oncoloracceptst(int value)
endevent
endstate
state sl_voice_enjoymentbased
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state sl_voice_playandwait
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state sl_voice_reset
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state sl_voice_painswitch
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onhighlightst()
endevent
endstate
state sl_voice_player
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onhighlightst()
endevent
endstate
state sl_voice_npc
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onhighlightst()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1