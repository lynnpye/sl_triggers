#include "engine.h"
#include "sl_triggers.h"
#include "caprunner.h"

namespace SLT {

void DelayedFunction(auto function, int delay) {
    std::thread t([=]() {
        std::this_thread::sleep_for(std::chrono::milliseconds(delay));
        function();
        });
    t.detach();
}

bool bPlayerInCombat = false;

void HandlePlayerCombatStatusChange() {
    auto* player = RE::PlayerCharacter::GetSingleton();

    if (!player) {
        logger::error("PlayerCharacter::GetSingleton return nullptr??");
        return;
    }

    bool nowInCombat = player->IsInCombat();
    if (nowInCombat != bPlayerInCombat) {
        bPlayerInCombat = nowInCombat;
        
        auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
        if (vm) {

            RE::Actor* target = nullptr;
            auto* combatGroup = player->GetCombatGroup();
            if (combatGroup) {
                if (combatGroup->targets.size() > 0) {
                    auto combatHandle = combatGroup->targets[0].targetHandle;
                    if (combatHandle) {
                        auto combatPtr = combatHandle.get();
                        if (combatPtr) {
                            target = combatPtr.get();
                        }
                    }
                }
            }
            auto* args = RE::MakeFunctionArguments(
                static_cast<RE::Actor*>(target),
                static_cast<bool>(bPlayerInCombat)
            );
            if (args) {
                RE::BSFixedString onPlayerCombatStateChanged("OnSLTRPlayerCombatStateChanged");
                vm->SendEventAll(onPlayerCombatStateChanged, args);
            }
        }
    }
}

RE::BSEventNotifyControl SLTREventSink::ProcessEvent(const RE::TESEquipEvent* event, RE::BSTEventSource<RE::TESEquipEvent>* source) {
    if (IsEnabledEquipEvent()) {
        if (event && event->actor) {
            auto* actor = event->actor->GetBaseObject();
            if (actor && actor->IsPlayer()) {
                auto* baseForm = RE::TESForm::LookupByID(event->baseObject);
                if (baseForm) {
                    auto* originalRef = RE::TESForm::LookupByID<RE::TESObjectREFR>(event->originalRefr);
                    // send event all
                    auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
                    if (vm) {
                        RE::BSFixedString onPlayerEquipEvent("OnSLTRPlayerEquipEvent");
                        auto* args = RE::MakeFunctionArguments(
                            static_cast<RE::TESForm*>(baseForm),
                            static_cast<TESObjectREFR*>(originalRef),
                            static_cast<bool>(event->equipped)
                        );
                        vm->SendEventAll(onPlayerEquipEvent, args);
                    }
                } else {
                    logger::error("EquipEvent: received but event->baseObject({}) could not be resolved to a Form", event->baseObject);
                }
            }
        }
    }

    return RE::BSEventNotifyControl::kContinue;
}

RE::BSEventNotifyControl SLTREventSink::ProcessEvent(const RE::TESHitEvent* event, 
                                    RE::BSTEventSource<RE::TESHitEvent>* source) {
    if (IsEnabledHitEvent()) {
        if (event && event->target && event->cause) {
            auto* target = event->target->GetBaseObject();
            auto* attacker = event->cause->GetBaseObject();

            if ((target && target->IsPlayer()) || (attacker && attacker->IsPlayer())) {
                auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
                if (vm) {
                    RE::BSFixedString onPlayerHitEvent("OnSLTRPlayerHit");
                    auto* args = RE::MakeFunctionArguments(
                        static_cast<RE::TESForm*>(attacker),
                        static_cast<RE::TESForm*>(target),
                        static_cast<RE::FormID>(event->source),
                        static_cast<RE::FormID>(event->projectile),
                        static_cast<bool>(attacker && attacker->IsPlayer()),
                        static_cast<bool>(event->flags.any(RE::TESHitEvent::Flag::kPowerAttack)),
                        static_cast<bool>(event->flags.any(RE::TESHitEvent::Flag::kSneakAttack)),
                        static_cast<bool>(event->flags.any(RE::TESHitEvent::Flag::kBashAttack)),
                        static_cast<bool>(event->flags.any(RE::TESHitEvent::Flag::kHitBlocked))
                    );
                    vm->SendEventAll(onPlayerHitEvent, args);
                }
            }
        }
    }

    return RE::BSEventNotifyControl::kContinue;
}

RE::BSEventNotifyControl SLTREventSink::ProcessEvent(const RE::TESCombatEvent* event, 
                                    RE::BSTEventSource<RE::TESCombatEvent>* source) {
    if (IsEnabledCombatEvent()) {
        DelayedFunction(&HandlePlayerCombatStatusChange, 1250);
    }

    return RE::BSEventNotifyControl::kContinue;
}

namespace {
using namespace std;
using namespace RE;
vector<TESObjectACTI*> harvestableActis;
vector<string> actiIDs = {
    "CritterMothBlue", "CritterMothLuna", "CritterBee", "CritterSalmon01", "CritterSalmon02", "CritterMothMonarch",
    "CritterFirefly", "CritterDragonfly01", "CritterDragonFly02", "CritterPondFish01", "CritterPondFish02",
    "CritterPondFish03", "CritterPondFish04", "CritterPondFish05", "TreeFloraNirnroot01", "TreeFloraNirnrootRed01"
};
OnDataLoaded([]{
    harvestableActis.clear();
    for(string aid : actiIDs) {
        TESForm* asForm = FormUtil::Parse::GetForm(aid);
        if (!asForm) {
            logger::debug("Unable to get Form from ID({})", aid);
        } else {
            auto* asACTI = asForm->As<TESObjectACTI>();
            if (!asACTI) {
                logger::debug("Unable to coerce Form to Activator for ID({}) FormID({}) FormType({})", aid, asForm->GetFormID(), FormTypeToString(asForm->GetSavedFormType()));
            }
            else {
                harvestableActis.push_back(asACTI);
            }
        }
    }
})
}

RE::BSEventNotifyControl SLTREventSink::ProcessEvent(const RE::TESActivateEvent* event,
                                    RE::BSTEventSource<RE::TESActivateEvent>* source) {
    enum { kFlag_Harvested = 0x2000 };
    RE::BSFixedString onHarvesting("OnSLTRHarvesting");

    if (IsEnabledActivateEvent()) {
        if (event && event->objectActivated && event->actionRef) {
            // player activating
            if (event->actionRef->IsPlayerRef()) {
                auto* baseObject = event->objectActivated->GetBaseObject();
                if (baseObject) {
                    // flora activated
                    auto* flora = baseObject->As<RE::TESFlora>();
                    if (flora) {
                        if (!(event->objectActivated->formFlags & kFlag_Harvested)) {
                            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
                            if (vm) {
                                auto* args = RE::MakeFunctionArguments(
                                    static_cast<RE::TESObjectREFR*>(event->objectActivated.get())
                                );
                                vm->SendEventAll(onHarvesting, args);
                            }
                        }
                    }
                    else {
                        auto* tree = baseObject->As<RE::TESObjectTREE>();
                        if (tree) {
                            if (!(event->objectActivated->formFlags & kFlag_Harvested)) {
                                auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
                                if (vm) {
                                    auto* args = RE::MakeFunctionArguments(
                                        static_cast<RE::TESObjectREFR*>(event->objectActivated.get())
                                    );
                                    vm->SendEventAll(onHarvesting, args);
                                }
                            }
                        }
                        else if (RE::FormType::Activator == baseObject->GetSavedFormType()) {
                            auto* asACTI = baseObject->As<RE::TESObjectACTI>();
                            auto it = find(harvestableActis.begin(), harvestableActis.end(), asACTI);

                            if (it != harvestableActis.end()) {
                                auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
                                if (vm) {
                                    auto* args = RE::MakeFunctionArguments(
                                        static_cast<RE::TESObjectREFR*>(event->objectActivated.get())
                                    );
                                    vm->SendEventAll(onHarvesting, args);
                                }
                            }
                            else {
                                logger::debug("base ACTI not found in harvestableActis, here's the info you requested: formID:{} name:'{}' editorID:'{}' formType:{}", baseObject->GetFormID(), baseObject->GetName(), baseObject->GetFormEditorID(), FormTypeToString(baseObject->GetSavedFormType()));
                            }
                        }
                    }
                }
            }
        }
    }
    
    return RE::BSEventNotifyControl::kContinue;
}

// Registration helper macro
#define REGISTER_PAPYRUS_PROVIDER(ProviderClass, ClassName) \
{ \
    ::SKSE::GetPapyrusInterface()->Register([](::RE::BSScript::Internal::VirtualMachine* vm) { \
        static ProviderClass provider; \
        provider.RegisterFunctions(vm, ClassName); \
        return true; \
    }); \
};

    void GameEventHandler::onLoad() {
        // Register the provider
        REGISTER_PAPYRUS_PROVIDER(SLTPapyrusFunctionProvider, "sl_triggers");
        REGISTER_PAPYRUS_PROVIDER(SLTInternalPapyrusFunctionProvider, "sl_triggers_internal");
        REGISTER_PAPYRUS_PROVIDER(SLTCmdPapyrusFunctionProvider, "sl_triggersCmd");

        auto* eventSourceHolder = RE::ScriptEventSourceHolder::GetSingleton();
        if (eventSourceHolder) {
            eventSourceHolder->AddEventSink<TESEquipEvent>(SLTREventSink::GetSingleton());
            eventSourceHolder->AddEventSink<TESHitEvent>(SLTREventSink::GetSingleton());
            eventSourceHolder->AddEventSink<TESCombatEvent>(SLTREventSink::GetSingleton());
            eventSourceHolder->AddEventSink<TESActivateEvent>(SLTREventSink::GetSingleton());
            logger::info("CombatEvent sink initialized, enabled({})", SLTREventSink::GetSingleton()->IsEnabledCombatEvent());
            logger::info("EquipEvent sink initialized, enabled({})", SLTREventSink::GetSingleton()->IsEnabledEquipEvent());
            logger::info("HitEvent sink initialized, enabled({})", SLTREventSink::GetSingleton()->IsEnabledHitEvent());
            logger::info("ActivateEvent sink initialized, enabled({})", SLTREventSink::GetSingleton()->IsEnabledActivateEvent());
        } else {
            logger::error("Unable to register with ScriptEventSourceHolder");
        }

        // ad-hoc initters
        {
            auto& reg = SLT::RegistrationClass::GetSingleton();
            std::lock_guard<std::mutex> lock(reg._mutexInitters);
            for (auto& cb : reg._initters) {
                cb();
            }
        }

        // hook quitters
        RegistrationClass::QuitGameHook::install();
    }

    void GameEventHandler::onPostLoad() {
        RegistrationClass::HandleSKSEMessage(SKSE::MessagingInterface::kPostLoad);
    }

    void GameEventHandler::onPostPostLoad() {
        RegistrationClass::HandleSKSEMessage(SKSE::MessagingInterface::kPostPostLoad);
    }

    void GameEventHandler::onInputLoaded() {
        RegistrationClass::HandleSKSEMessage(SKSE::MessagingInterface::kInputLoaded);
    }

    void GameEventHandler::onDataLoaded() {
        FunctionLibrary::PrecacheLibraries();
        ScriptPoolManager::GetSingleton().InitializePool();

        //RunCapricaForScripts();
        RegistrationClass::HandleSKSEMessage(SKSE::MessagingInterface::kDataLoaded);
    }

    void GameEventHandler::onNewGame() {
        SLT::GenerateNewSessionId(true);
        logger::info("{} starting session {}", SystemUtil::File::GetPluginName(), SLT::GetSessionId());

        RegistrationClass::HandleSKSEMessage(SKSE::MessagingInterface::kNewGame);
    }

    void GameEventHandler::onPreLoadGame() {
        RegistrationClass::HandleSKSEMessage(SKSE::MessagingInterface::kPreLoadGame);
    }

    void GameEventHandler::onPostLoadGame() {
        SLT::GenerateNewSessionId(true);
        logger::info("{} starting session {}", SystemUtil::File::GetPluginName(), SLT::GetSessionId());
        RegistrationClass::HandleSKSEMessage(SKSE::MessagingInterface::kPostLoadGame);
    }

    void GameEventHandler::onSaveGame() {
        RegistrationClass::HandleSKSEMessage(SKSE::MessagingInterface::kSaveGame);
    }

    void GameEventHandler::onDeleteGame() {
        RegistrationClass::HandleSKSEMessage(SKSE::MessagingInterface::kDeleteGame);
    }
}  // namespace plugin

void SLT::RegistrationClass::QuitGameHook::hook() {
    {
        auto& reg = SLT::RegistrationClass::GetSingleton();
        std::lock_guard<std::mutex> lock(reg._mutexQuitters);
        for (auto& cb : reg._quitters) {
            cb();
        }
    }
    orig();
}

void SLT::RegistrationClass::QuitGameHook::install() {
    HookUtil::Hooking::writeCall<SLT::RegistrationClass::QuitGameHook>();
}

std::string SLT::RegistrationClass::QuitGameHook::logName = "QuitGame";
REL::Relocation<decltype(SLT::RegistrationClass::QuitGameHook::hook)> SLT::RegistrationClass::QuitGameHook::orig;
REL::RelocationID SLT::RegistrationClass::QuitGameHook::srcFunc = REL::RelocationID{35545, 36544};
uint64_t SLT::RegistrationClass::QuitGameHook::srcFuncOffset = REL::Relocate(0x35, 0x1AE);

SLT::RegistrationClass& SLT::RegistrationClass::GetSingleton() {
    static SLT::RegistrationClass instance;
    return instance;
}

void SLT::RegistrationClass::RegisterMessageListener(SKSEMessageType skseMessageType, std::function<void()> cb) {
    std::lock_guard<std::mutex> lock(_mutex);
    _callbacks[skseMessageType].push_back(std::move(cb));
}

SLT::RegistrationClass::AutoRegister::AutoRegister(SKSEMessageType skseMsg, std::function<void()> cb) {
    SLT::RegistrationClass::GetSingleton().RegisterMessageListener(skseMsg, cb);
}

void SLT::RegistrationClass::RegisterInitter(std::function<void()> cb) {
    std::lock_guard<std::mutex> lock(_mutexInitters);
    _initters.push_back(std::move(cb));
}

SLT::RegistrationClass::AutoInitter::AutoInitter(std::function<void()> cb) {
    SLT::RegistrationClass::GetSingleton().RegisterInitter(cb);
}

void SLT::RegistrationClass::RegisterQuitter(std::function<void()> cb) {
    std::lock_guard<std::mutex> lock(_mutexQuitters);
    _quitters.push_back(std::move(cb));
}

SLT::RegistrationClass::AutoQuitter::AutoQuitter(std::function<void()> cb) {
    SLT::RegistrationClass::GetSingleton().RegisterQuitter(cb);
}
