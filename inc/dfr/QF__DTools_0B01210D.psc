;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname QF__DTools_0B01210D Extends Quest Hidden

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Speaker4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Speaker4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Speaker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Speaker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Speaker5
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Speaker5 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Speaker2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Speaker2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Speaker3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Speaker3 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE _DFtools
Quest __temp = self as Quest
_DFtools kmyQuest = __temp as _DFtools
;END AUTOCAST
;BEGIN CODE
kmyquest.Rapetime()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef  Auto  
