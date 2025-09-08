scriptname sl_triggersAdapterSLS

_SLS_Api Function SLSAPI() global
    return Game.GetFormFromFile(0x0850D2, "SL Survival.esp") as _SLS_Api
EndFunction

;/
Use this event to stop the licence quartermasters selling licences to the player. 
The quartermasters will say something like "Sorry girl, but I've been instructed to not sell licences to you"

Parameters
Sender - A form from your mod. Any forms sent to Survival will be added to the global StorageUtil formlist "_SLS_LicenceBlockingForms". 
So if the form count on this key is greater than zero licence buying will be blocked. 
BlockLicence: 	True - Block licences with the associated sender
                False - Unblock licences and remove sender as a blocking form

Obviously, you must send the same form when blocking and unblocking licences otherwise they won't match and so won't be recognised. 
/;
function block_license_purchase(Form blocker, bool abBlock) global
    int handle = ModEvent.Create("_SLS_BlockLicenceBuy")
    if handle
        ModEvent.PushForm(handle, blocker)
        ModEvent.PushBool(handle, abBlock)
        ModEvent.Send(handle)
    endif
endfunction

; Revoke licences. Acceptable strArg parameters:
; "All" - Revoke all licences
; "Random" - Revoke a random licence type the player has.
; "Magic"
; "Weapon"
; "Armor"
; "Bikini"
; "Clothes"
; "Curfew"
; "Whore"
; "Freedom"
; "Property"
function revoke_license(string license) global
    int handle = ModEvent.Create("_SLS_RevokeLicence")
    if handle
        ModEvent.PushString(handle, "_SLS_RevokeLicence")
        ModEvent.PushString(handle, license)
        ModEvent.PushFloat(handle, 0.0)
        ModEvent.PushForm(handle, none)
        ModEvent.Send(handle)
    endif
endfunction

; Either directly specify a kennel via Hold or provide an actor. Player will be sent to the kennel with the corresponding CrimeFaction
; Holds: Whiterun, Solitude, Markarth, Windhelm or Riften
function send_to_kennel(Form crimeFactionMember = none, string hold = "") global
    int handle = ModEvent.Create("_SLS_SendToKennel")
    if handle
        ModEvent.PushForm(handle, crimeFactionMember)
        ModEvent.PushString(handle, hold)
        ModEvent.Send(handle)
    endif
endfunction

; HomeInt: 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
; EvictForm: A form identifying your mod to SLS. You need to use the same form to block and unblock.
; EvictReason: The reason for eviction. Hopefully I'll be able to add this to the note stuck on your door eventually. But for now it's more to
; give a user a more relatable/understandable reason for being barred than EvictForm
; Does not trigger a scene. Evicts/Unevicts immediately
; If the player isn't flagged as owning the house then nothing will happen
; To be flagged as having owned the house the home key must have entered the players inventory one time
; If the player later buys a home while you've still have them evicted then they will be evicted immediately when the key enters their inventory.
function evict_from_home(int aiHome, Form evictForm, string evictReason) global
    int handle = ModEvent.Create("_SLS_EvictFromHome")
    if handle
        ModEvent.PushInt(handle, aiHome)
        ModEvent.PushForm(handle, evictForm)
        ModEvent.PushString(handle, evictReason)
        ModEvent.Send(handle)
    endif
endfunction

; 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
; Does not trigger a scene. Evicts/Unevicts immediately
; If the player isn't flagged as owning the house then nothing will happen
; To be flagged as having owned the house the home key must have entered the players inventory one time
; If the player is already not evicted then nothing will happen
; Multiple mods may evict the player. All blocking forms must be removed for an eviction to be lifted
function unevict_from_home(int aiHome, Form evictForm) global
    int handle = ModEvent.Create("_SLS_UnEvictFromHome")
    if handle
        ModEvent.PushInt(handle, aiHome)
        ModEvent.PushForm(handle, evictForm)
        ModEvent.Send(handle)
    endif
endfunction

; akSpeaker - Uses this actors set CrimeFaction to determine which city to increase the ground time in. 
; If the actors crime faction isn't set or known then nothing will happen.
; Use LocInt if you don't have an actor to send
; LocInt: 0 - Whiterun, 1 - Solitude, 2 - Markarth, 3 - Windhelm, 4 - Riften
; Use LocInt if you don't want to use akSpeaker and want to hard set the city to ground in. 
; Days - how many days to ground for. 1 = 1 day. 7 = 1 week. 
; Ground time is rounded to midnight. So if ground time is sent with 1 on Monday then ground time will expire at midnight on Monday. If normal curfew is in effect at midnight then it will take over
function increase_ground_time(Form crimeFactionMember, int iLoc = -1, int days = 1) global
    int handle = ModEvent.Create("_SLS_IncreaseGroundTime")
    if handle
        ModEvent.PushForm(handle, crimeFactionMember)
        ModEvent.PushInt(handle, iLoc)
        ModEvent.PushInt(handle, days)
        ModEvent.Send(handle)
    endif
endfunction

function remove_magic_curse(Form akTarget) global
    int handle = ModEvent.Create("_SLS_RemoveMagicCurse")
    if handle
        ModEvent.PushForm(handle, akTarget)
        ModEvent.Send(handle)
    endif
endfunction

function add_magic_curse(Form akTarget) global
    int handle = ModEvent.Create("_SLS_AddMagicCurse")
    if handle
        ModEvent.PushForm(handle, akTarget)
        ModEvent.Send(handle)
    endif
endfunction

; Specify either an actor to use as a source for cum or directly specify an amount to swallow.
; DidSwallow = Player tries her best to swallow everything. !DidSwallow = Player still swallows a fraction of load
; AddCumToFace - Add cum to player's face and set cum type data so it can be collected. 0 - No cum, 1 - 1 layer of cum, 2 - 2 layers of cum
function swallow_cum(Form cum_source = none, float amount = -1.0, bool did_swallow = true, int add_to_face = 0) global
    int handle = ModEvent.Create("_SLS_SwallowCum")
    if handle
        ModEvent.PushForm(handle, cum_source)
        ModEvent.PushFloat(handle, amount)
        ModEvent.PushBool(handle, did_swallow)
        ModEvent.PushInt(handle, add_to_face)
        ModEvent.Send(handle)
    endif
endfunction

float function get_creature_corruption() global
    return StorageUtil.GetFloatValue(none, "_SLS_CreatureCorruption")
endfunction

bool function is_enjoying_cum() global
    return SLSAPI().util.IsEnjoyingCum()
endfunction

; 0 - tiny - Skeever/Hare
; 1 - small - Dog/Wolf
; 2 - average - Most playable races
; 3 - Above Average - Orcs/Nords
; 4 - Big - Troll/Horse/Bear/Sabrecat
; 5 - Huge - Mammoth
; 6 - Massive - Dragon
int function get_load_tier(Actor cum_source) global
    return SLSAPI().util.GetLoadTier(cum_source)
endfunction

float function get_load_size(Actor cum_source, int load_tier = -1) global
    return SLSAPI().util.GetLoadSize(cum_source, load_tier)
endfunction

float function get_load_size_actual(Actor cum_source, float base_load_size) global
    return SLSAPI().util.GetLoadSizeActual(cum_source, base_load_size)
endfunction

; 0.0 - 1.0
float function get_load_fullness(Actor akTarget) global
    return SLSAPI().util.GetLoadFullnessMod(akTarget)
endfunction

bool function is_drugged(Actor akTarget, bool check_skooma, bool check_sw, bool check_lactacid) global
    return SLSAPI().util.IsDrugged(akTarget, check_skooma, check_sw, check_lactacid)
endfunction

bool function is_high_on_skooma(Actor akTarget) global
    return SLSAPI().util.IsHighOnSkooma(akTarget)
endfunction

bool function is_high_on_skooma_whore_drugs(Actor akTarget) global
    return SLSAPI().util.IsHighOnSkoomaWhoreDrugs(akTarget)
endfunction

bool function is_high_on_lactacid(Actor akTarget) global
    return SLSAPI().util.IsHighOnLactacid(akTarget)
endfunction

; IsWithdrawing: true - Withdrawal effect must be active. False - Don't care
; Addiction Levels
; 0 - Not addicted
; 1 - Experimentation
; 2 - Regular Use
; 3 - Risky Use
; 4 - Dependence
; 5 - Addiction
int function get_skooma_junkie_level(Actor akTarget, bool is_withdrawing) global
    return SLSAPI().util.GetSkoomaJunkieLevel(akTarget, is_withdrawing)
endfunction

function do_female_pain_sound(Actor akTarget, float volume) global
    SLSAPI().util.DoFemalePainSound(akTarget, volume)
endfunction

function do_hit_sound(Actor akActor, float volume) global
    SLSAPI().util.DoHitSound(akActor, volume)
endfunction

function do_trauma_hit_sound(Actor akActor, bool playerSqueaks) global
    SLSAPI().util.DoTraumaHitSound(akActor, playerSqueaks)
endfunction

; 0.0 - 1.0; both vag and onal
float function get_cum_stuffed_factor(Actor akTarget) global
    return SLSAPI().util.GetCumStuffedFactor(akTarget)
endfunction