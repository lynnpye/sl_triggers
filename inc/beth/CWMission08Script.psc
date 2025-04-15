scriptname cwmission08script extends cwmissionscript  conditional
faction property cwmission08enemytogiant auto
faction property cwmission08giantplayeralliesfaction auto
faction property cwmission08allgiantsplayerfriendfaction auto
scene property cwmission08scene1 auto
scene property cwmission08scene2 auto
locationalias property attackpoint auto
int property playeratattackpoint auto conditional hidden ;0 = unset, 1 = player arrived - used to control scene, making sure the player is present before the giant takes the herd and gaurds attack
cwalliesscript property cwalliess auto ;pointer to script on cwallies quest
event onupdate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1