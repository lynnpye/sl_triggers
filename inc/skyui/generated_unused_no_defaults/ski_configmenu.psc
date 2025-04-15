scriptname ski_configmenu extends ski_configbase
ski_activeeffectswidget property ski_activeeffectswidgetinstance auto
ski_favoritesmanager property ski_favoritesmanagerinstance auto
ski_main property ski_maininstance auto
ski_settingsmanager property ski_settingsmanagerinstance auto
int function getversion()
endfunction
function onconfiginit()
endfunction
function ongamereload()
endfunction
function onversionupdate(int a_version)
endfunction
function onpagereset(string a_page)
endfunction
string function getcustomcontrol(int a_keycode)
endfunction
function applysettings()
endfunction
function applyitemlistfontsize()
endfunction
function apply3ditemxoffset()
endfunction
function apply3ditemyoffset()
endfunction
function apply3ditemscale()
endfunction
bool function validatekey(int a_keycode, bool a_gamepad)
endfunction
function swapitemlistkey(int a_newkey, int a_curkey)
endfunction
function setcurrentfavoritegroup(int a_index)
endfunction
function setfavoritesgrouphotkey(int a_groupindex, int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
function refreshfavoritehotkeys()
endfunction
state check_barter_menu
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state check_container_menu
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state check_crafting_menu
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state check_favorites_menu
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state check_gift_menu
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state check_inventory_menu
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state check_magic_menu
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state check_map_menu
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state effect_widget_enabled
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state effect_widget_group_count
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onslideracceptst(float a_value)
endfunction
function onslideropenst()
endfunction
endstate
state effect_widget_horizontal_anchor
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state effect_widget_icon_size
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state effect_widget_min_time_left
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onslideracceptst(float a_value)
endfunction
function onslideropenst()
endfunction
endstate
state effect_widget_orientation
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state effect_widget_vertical_anchor
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state effect_widget_xoffset
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onslideracceptst(float a_value)
endfunction
function onslideropenst()
endfunction
endstate
state effect_widget_yoffset
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onslideracceptst(float a_value)
endfunction
function onslideropenst()
endfunction
endstate
state equip_mode_key
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state fav_equip_state_key
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state fav_group_add_key
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state fav_group_select
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onmenuacceptst(int a_index)
endfunction
function onmenuopenst()
endfunction
endstate
state fav_group_unequip_armor
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state fav_group_unequip_hands
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state fav_group_use_hotkey1
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state fav_group_use_hotkey2
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state fav_group_use_hotkey3
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state fav_group_use_hotkey4
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state fav_group_use_hotkey5
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state fav_group_use_hotkey6
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state fav_group_use_hotkey7
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state fav_group_use_hotkey8
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state fav_group_use_key
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state fav_menu_help_enabled
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state fav_set_icon_key
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state fav_toggle_focus
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state itemcard_align
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state itemcard_xoffset
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onslideracceptst(float a_value)
endfunction
function onslideropenst()
endfunction
endstate
state itemcard_yoffset
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onslideracceptst(float a_value)
endfunction
function onslideropenst()
endfunction
endstate
state itemlist_category_icon_theme
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onmenuacceptst(int a_index)
endfunction
function onmenuopenst()
endfunction
endstate
state itemlist_font_size
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state itemlist_no_icon_colors
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state itemlist_quantity_min_count
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onslideracceptst(float a_value)
endfunction
function onslideropenst()
endfunction
endstate
state next_column_button
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state prev_column_button
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state search_key
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state sort_order_button
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state switch_tab_button
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state switch_tab_key
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
endstate
state xd_item_positioning
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onselectst()
endfunction
endstate
state xd_item_scale
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onslideracceptst(float a_value)
endfunction
function onslideropenst()
endfunction
endstate
state xd_item_xoffset
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onslideracceptst(float a_value)
endfunction
function onslideropenst()
endfunction
endstate
state xd_item_yoffset
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function onslideracceptst(float a_value)
endfunction
function onslideropenst()
endfunction
endstate
;This file was cleaned with PapyrusSourceHeadliner 1