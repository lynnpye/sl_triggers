scriptname dunlabyrinthianwoodenmaskscript extends activemagiceffect  
objectreference property areamarker auto
float property maskrange = 512.0 auto
objectreference property sanctuarymarker auto
location property dragonpriestsanctuarylocation auto
imagespacemodifier property azurafadetoblack auto
imagespacemodifier property fadetoblackbackimod auto
sound property transitionsfx  auto 
objectreference property maskactual auto
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1