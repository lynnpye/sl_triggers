scriptname ccbgssse001_critterspawn extends critterspawn
actor property playerref auto
bool property aaa_config_islargeshallowspawner = true auto
bool property aaa_config_spawnalways = true auto
bool property aaa_config_spawnwhenclearorsnowweather = false auto
bool property aaa_config_spawnwhenrainweather = false auto
formlist property aaa_config_crittertypes auto
int property aaa_config_maxcrittercount = 3 auto
float property update_interval = 2.0 autoreadonly
float property max_player_distance = 4000.0 autoreadonly
float property leash_length_small_deep = 128.0 autoreadonly
float property leash_height_small_deep = 128.0 autoreadonly
float property leash_depth_small_deep = 128.0 autoreadonly
float property leash_length_large_shallow = 256.0 autoreadonly
float property leash_height_large_shallow = 256.0 autoreadonly
float property leash_depth_large_shallow = 64.0 autoreadonly
event oninit()
endevent
event onload()
endevent
event onupdate()
endevent
event onunload()
endevent
event oncelldetach()
endevent
function spawncritters()
endfunction
event oncritterdied()
endevent
function spawncritteratref(objectreference arspawnref)
endfunction
bool function shouldspawnwithindistanceandweather(float afdistancetoplayer)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1