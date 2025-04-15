scriptname ccbgssse001_miscquestscript extends quest  
quest[] property miscquests auto
book[] property bountyletters auto
referencealias property activebountyletter auto
actor property playerref auto
int property askobjective auto
int property donestage auto
book function giveplayerbountyletterforquest(quest akquest)
endfunction
function setbountyletterwasread(quest akquest)
endfunction
function setquestcomplete(quest akquest, bool abaskagain = true)
endfunction
int function getmiscquestreadletterobjective(int aiquestindex)
endfunction
int function getmiscquestletterwasreadstage(int aiquestindex)
endfunction
int function getmiscquestcompletestage(int aiquestindex)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1