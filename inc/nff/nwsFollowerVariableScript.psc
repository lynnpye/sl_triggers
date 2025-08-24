Scriptname nwsFollowerVariableScript extends Quest  

; Script for Storage of On-Load or Mutable Variables

; Game Properties
GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property PlayerFollowerCount Auto
GlobalVariable Property PlayerAnimalCount Auto

Quest Property DialogueFollower Auto
Quest Property BardSongs Auto
Quest Property DLC1NPCMentalModel Auto ; serana
Quest Property RelationshipMarriage Auto
Quest Property RelationshipMarriageFIN Auto
Keyword Property RelationshipMarriageFINKeyword Auto
Keyword Property LocTypeDwelling Auto
Keyword Property LocTypeDungeon Auto
Keyword Property LocTypeCity Auto
Keyword Property LocTypeTown Auto
Keyword Property LocTypePlayerHouse Auto
Keyword Property MagicSummonUndead Auto
LocationAlias Property spouseOrigHouse Auto
Potion Property FoodMarriageMeal Auto

Actor Property Serana Auto

Faction Property DismissedFac Auto
Faction Property CurrentHireling Auto
Faction Property PotentialHireling Auto ; this is papyrus bugged
Faction Property CurrFollowerFac Auto
Faction Property PlayerFollowerFac Auto
Faction Property CommentFaction Auto
Faction Property PlayerFaction Auto
Faction Property PotentialFollowerFaction Auto
Faction Property PotentialMarriageFaction Auto
Formlist Property VoicesMarriageAll Auto
Formlist Property VoicesFollowerAll Auto

Faction Property PlayerHousecarlFaction Auto
Faction Property PlayerMarriedFaction Auto
Faction Property JobBardFaction Auto
Faction Property BardSingerFaction Auto
Faction Property BardSingerNoAutostart Auto
Faction Property BardAudienceExclude Auto
Faction Property JobMiscFaction Auto
Faction Property JobMerchantFaction Auto

Keyword Property ActorTypeAnimal Auto
Keyword Property ActorTypeDwarven Auto
Keyword Property ActorTypeNPC Auto
Keyword Property ArmorLight Auto
Keyword Property ArmorHeavy Auto

Keyword Property VendorItemSpellTome Auto
Keyword Property MagicInfluenceFear Auto
Keyword Property wispellcolorful Auto

Message Property  FollowerDismissMessage Auto
Message Property  FollowerDismissMessageWedding Auto
Message Property  FollowerDismissMessageCompanions Auto
Message Property  FollowerDismissMessageCompanionsMale Auto
Message Property  FollowerDismissMessageCompanionsFemale Auto
Message Property  FollowerDismissMessageWait Auto

Weapon Property AkaviriKatana Auto
Armor Property ArmorBladesBoots Auto
Armor Property ArmorBladesCuirass Auto
Armor Property ArmorBladesGauntlets Auto
Armor Property ArmorBladesHelmet Auto
Armor Property ArmorBladesShield Auto
Armor Property MarriageBondofMatrimony Auto
Armor Property WolfSkinFXArmor Auto

Light Property Torch01 Auto
miscobject Property Gold  Auto  
miscobject Property Lockpick  Auto  
Weapon Property Unarmed Auto  

Idle Property BleedStop Auto
Idle Property DrunkStopIdle Auto
Idle Property GivePotion Auto
Idle Property CastLeft Auto
Idle Property DismountIdle Auto
Perk Property RestorationAdept50 Auto

; Framework Properties
Quest Property nwsFollowerGift Auto
Quest Property nwsFollowerMounts Auto
Quest Property nwsFollowerMinion Auto
Quest Property nwsFollowerMinions Auto

GlobalVariable Property nwsAllowGuard Auto
GlobalVariable Property nwsAllowHorses Auto
GlobalVariable Property nwsAllowSandbox Auto
GlobalVariable Property nwsAllowStealth Auto
GlobalVariable Property nwsAllowWarp Auto
GlobalVariable Property nwsDoProtect Auto
GlobalVariable Property nwsExpCostFull Auto
GlobalVariable Property nwsExpCostLow Auto
GlobalVariable Property nwsExpCostMid Auto
GlobalVariable Property nwsFollowerCount Auto
GlobalVariable Property nwsFollowerLastCount Auto
GlobalVariable Property nwsHistoryCount Auto
GlobalVariable Property nwsHistoryMax Auto
GlobalVariable Property nwsHorseSkinBase Auto
GlobalVariable Property nwsImportCount Auto ; number of imported allies
GlobalVariable Property nwsKeepHorse Auto
GlobalVariable Property nwsLearnSpells Auto
GlobalVariable Property nwsNoRecovery Auto
GlobalVariable Property nwsPayRate Auto
GlobalVariable Property nwsRealCount Auto
GlobalVariable Property nwsWeapDraw Auto
GlobalVariable Property nwsUsePotion Auto
GlobalVariable Property nwsAllowRevive Auto

GlobalVariable Property nwsRelaxStart Auto
GlobalVariable Property nwsRelaxRamp Auto
GlobalVariable Property nwsRelaxFlee Auto
GlobalVariable Property nwsBoxOnlyCity Auto
GlobalVariable Property nwsSandboxRange Auto ; hidden from UI but save
GlobalVariable Property nwsWarpRange Auto
GlobalVariable Property nwsWarpStart Auto
GlobalVariable Property nwsFleeDistance Auto
GlobalVariable Property nwsChatterStyle Auto
GlobalVariable Property nwsAllowCharge Auto
GlobalVariable Property nwsHealPlayerVal Auto
GlobalVariable Property nwsHealSelfVal Auto
GlobalVariable Property nwsHealOtherVal Auto
GlobalVariable Property nwsDlgEquip Auto
GlobalVariable Property nwsAllowExpel Auto
GlobalVariable Property nwsDlgDivorce Auto

GlobalVariable Property nwsFollowerMaxCount Auto ; 3rd party support

GlobalVariable Property nwsTimeWorkStart Auto
GlobalVariable Property nwsTimeWorkEnd Auto
GlobalVariable Property nwsTimeRelaxStart Auto
GlobalVariable Property nwsTimeRelaxEnd Auto
GlobalVariable Property nwsTimeSleepStart Auto
GlobalVariable Property nwsTimeSleepEnd Auto

Faction Property nwsFF_AggrFac Auto
Faction Property nwsFF_AmmoFac Auto
Faction Property nwsFF_AssistFac Auto
Faction Property nwsFF_BoxFaction Auto ; use sandbox package
Faction Property nwsFF_CSFac Auto
Faction Property nwsFF_ChatterFaction Auto
Faction Property nwsFF_ConfFac Auto
Faction Property nwsFF_CraftArrowFac  Auto  
Faction Property nwsFF_CraftPotionFac  Auto  
Faction Property nwsFF_CraftSharpFac  Auto 
Faction Property nwsFF_CraftTorchFac  Auto  
Faction Property nwsFF_DefaultFollow Auto
Faction Property nwsFF_EssFac Auto
Faction Property nwsFF_FollowerFac Auto
Faction Property nwsFF_GiftFac  Auto  
Faction Property nwsFF_GuardFaction Auto ; guard faction
Faction Property nwsFF_HelmFac Auto
Faction Property nwsFF_HomeFac Auto 
Faction Property nwsFF_HorseFXFac Auto
Faction Property nwsFF_HorseSkinFac Auto
Faction Property nwsFF_ImportFac Auto ; follower was imported
Faction Property nwsFF_ImportSetFac Auto ; applied safe settings
Faction Property nwsFF_MoralFac Auto
Faction Property nwsFF_NCRangeFac Auto ; non-combat range
Faction Property nwsFF_NoHorseFac Auto ; NEW
Faction Property nwsFF_NoRegardFac  Auto  ; opt-out
Faction Property nwsFF_PackHiFac Auto
Faction Property nwsFF_PayFac Auto
Faction Property nwsFF_RangeFac Auto ; combat range
Faction Property nwsFF_RegardFac  Auto  ; ranks
Faction Property nwsFF_RoleFac Auto ; healer or not
Faction Property nwsFF_ShieldFac Auto
Faction Property nwsFF_StealthFac Auto ; use stealth package
Faction Property nwsFF_StewardFac Auto
Faction Property nwsFF_TavernFac  Auto 
Faction Property nwsFF_VoiceFac Auto
Faction Property nwsFF_WaitFaction Auto ; permanent wait faction
Faction Property nwsFF_WeaponFac Auto
Faction Property nwsFF_hireCount Auto
Faction Property nwsFF_historyFac Auto
Faction Property nwsFF_iNPCFac Auto
Faction Property nwsFF_storedFac Auto
Faction Property sofiaPartyFac Auto Hidden
Faction Property nwsFF_TauntSndFac Auto
Faction Property nwsFF_AnimalInvFac Auto
Faction Property nwsFF_DefaultCombat Auto
Faction Property nwsFF_LightFac Auto
Faction Property nwsFF_NoInteract Auto
Faction Property nwsFF_NoImport Auto
Faction Property nwsFF_CostFac Auto
Faction Property nwsFF_DefenseFac Auto
Faction Property nwsFF_WerewolfFac Auto
Faction Property nwsFF_PassiveFac Auto
Faction Property nwsFF_ElopedFac Auto
Faction Property nwsFF_GatherFac Auto
Faction Property nwsFF_xStoreFac Auto
Faction Property nwsFF_AutoExport Auto
Faction Property nwsFF_AutoImport Auto
Faction Property nwsFF_MultIgnore Auto

FormList Property nwsFFammoList Auto
FormList Property nwsFFhorseSkins Auto
FormList Property nwsFFpotionList Auto
FormList Property nwsFFrestoreList Auto
FormList Property nwsFFequipMove Auto ; carrier form actor 1
FormList Property nwsFFhorseFX Auto
FormList Property nwsFFgiftsMetals Auto
FormList Property nwsFFgiftsGems Auto
FormList Property nwsSandboxList Auto
FormList Property nwsFFarrowCraft Auto
FormList Property nwsFFsaleMarkers Auto ; town center first part, store center second part
FormList Property nwsFFsaleKeys Auto
FormList Property nwsFFsaleLocations Auto
FormList Property nwsFFgemsList Auto
FormList Property nwsFFnakedKeys Auto
FormList Property nwsFFlootList Auto
FormList Property nwsFFlootIncludes Auto
FormList Property nwsFFcombatStyles Auto

Sound Property nwsCraftArrowSnd Auto
Sound Property nwsCraftTorchSnd Auto
Sound Property nwsCraftPotionSnd Auto
Sound Property nwsCraftSharpSnd Auto

ReferenceAlias Property bladesREF Auto
ReferenceAlias Property bladesLink Auto

ObjectReference Property nwsFFEquipBoxREF Auto

Armor Property nwsFF_specialArmor Auto
Armor Property SeranaHoodie Auto
Armor Property nwsFF_silverRing Auto
Armor Property nwsFF_nakedHelmet Auto

Keyword Property nwsFF_boxKey Auto
Keyword Property nwsFF_lightKey Auto

Spell Property nwsHealSelf Auto
Spell Property nwsJiltedCD Auto
Spell Property nwsSneakSpell Auto
Spell Property nwsImpStealthSpell Auto
Spell Property nwsSharpenSpell Auto
Spell Property nwsTauntBuff Auto
Spell Property nwsRechargeSpell Auto
Spell Property nwsCalmAllies Auto
Spell Property nwsHealOther Auto

Spell Property nwsCommandAllSpell Auto
Spell Property nwsRegardInspired Auto ; buff ability
Spell Property nwsRaiseMorale Auto
Spell Property nwsStaggerAlly Auto
Spell Property nwsStaggerAll Auto
Spell Property nwsDispelLight Auto

Spell Property nwsDispelFear Auto ; remove?

Spell Property nwsSetBehindSpell Auto
Spell Property nwsRetreatAllies Auto
Spell Property nwsRetreatCancel Auto
Spell Property nwsFindTargetSpell Auto
Spell Property nwsAttackTargetSpell Auto
Spell Property nwsWerewolfChangeFX Auto

Spell Property nwsCombatSenseAgg Auto

MagicEffect Property nwsSneakEnhFX Auto
MagicEffect Property nwsStealthAggDownFX Auto
MagicEffect Property nwsSharpenWeapons Auto
MagicEffect Property nwsFortifyHealthFX Auto
MagicEffect Property nwsTauntCDFX Auto
MagicEffect Property LightFFSelf Auto
MagicEffect Property nwsDispelFearFX Auto
MagicEffect Property nwsRetreatAlliesFX Auto

Sound Property nwsHorseCallSnd Auto
Package Property nwsFollowerStealthPKG Auto
Package Property nwsFollowerCombatTemplate Auto
Package Property nwsFollowerGoMount Auto
Package Property nwsFollowerLootPKG Auto
Package Property nwsFollowerLootIntPKG Auto

Message Property nwsImport_MSG Auto
Message Property nwsExport_MSG Auto
Message Property nwsImportSet_MSG Auto
Message Property nwsImportSetCraft_MSG Auto
Message Property nwsImportSetGear_MSG Auto
Message Property nwsImportSetBehavior_MSG Auto
Message Property nwsCmdAll_MSG Auto
Message Property nwsCmdOne_MSG Auto
Message Property nwsCmdRange_MSG Auto
Message Property nwsCmdDist_MSG Auto
Message Property nwsCmdWait_MSG Auto
Message Property nwsCmdSpell_MSG Auto
Message Property nwsTut_countMSG  Auto  
Message Property nwsStoreGear_MSG Auto
Message Property nwsClearGear_MSG Auto
Message Property nwsCmdSpellDlg_MSG Auto
Message Property nwsAutoExport_MSG Auto
Message Property nwsAutoImport_MSG Auto

; External Mod /DLC Support
bool Property HFactive Auto Hidden
bool Property iNPCactive Auto Hidden
bool Property CHactive Auto Hidden
bool Property jpnVoiceActive Auto Hidden
bool Property sassyActive Auto Hidden
bool Property RDOactive Auto Hidden

Quest Property nwsFollowerEnemies  Auto  
