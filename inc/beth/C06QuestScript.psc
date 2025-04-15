scriptname c06questscript extends companionsstoryquest conditional
quest property beforepreviousquest auto
quest property waybackquest auto
referencealias property skjor auto  ; on c03
referencealias property kodlak auto ; on c04
miscobject property glenmorilhead auto
quest property c06postquest auto
referencealias property skyforge auto
referencealias property eorlund auto
referencealias property aela auto
referencealias property farkas auto
referencealias property vilkas auto
referencealias property essentialkodlak auto ; on c00
referencealias property essentialskjor auto ; on c00
referencealias property essentialeorlund auto ; on c00
referencealias property essentialaela auto ; on c00
referencealias property essentialvilkas auto ; on c00
referencealias property essentialfarkas auto ; on c00
objectreference property funeralpoint1 auto
objectreference property funeralpoint2 auto
objectreference property funeralpoint3 auto
objectreference property funeralpoint4 auto
bool property eorlundfgatfuneralend auto conditional
bool property farkasfgbeforespiders auto conditional
bool property farkasleft auto conditional
bool property wolfspiritchill auto conditional
bool property kodlakout auto conditional
referencealias property ghostkodlak auto
effectshader property ghostshader auto
armor property vilkashelmet auto
referencealias property head1 auto ; on c00
referencealias property head2 auto ; on c00
referencealias property head3 auto ; on c00
referencealias property head4 auto ; on c00
referencealias property head5 auto ; on c00
referencealias property deadthing1 auto ; on c00
referencealias property deadthing2 auto ; on c00
referencealias property deadthing3 auto ; on c00
referencealias property deadthing4 auto ; on c00
referencealias property deadthing5 auto ; on c00
referencealias property deadthing6 auto ; on c00
referencealias property deadthing7 auto ; on c00
referencealias property kodlaksfragment auto
referencealias property kodlaksjournal auto
objectreference property funeralenabler auto
objectreference property kodlakbody auto
bool property playerpresentatfuneral auto conditional
bool property aelaforcegreetattomb auto conditional
bool property eorlundforcegreetinchamber auto conditional
scene property kodlaksfuneral auto
quest property funeralobservers auto
faction property safecorpse auto
faction property companions auto
function setup()
endfunction
function init()
endfunction
function startfuneral()
endfunction
function teardown()
endfunction
event onupdate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1