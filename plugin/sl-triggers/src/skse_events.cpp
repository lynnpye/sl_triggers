#include "engine.h"
#include "sl_triggers.h"

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
        logger::debug("\t HitSink enabled and processing");
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
    } else {
        logger::debug("\t HitSink event missed because not processing");
    }

    return RE::BSEventNotifyControl::kContinue;
}

RE::BSEventNotifyControl SLTREventSink::ProcessEvent(const RE::TESCombatEvent* event, 
                                    RE::BSTEventSource<RE::TESCombatEvent>* source) {
    if (IsEnabledCombatEvent()) {
        logger::debug("\t CombatSink enabled and processing");
        DelayedFunction(&HandlePlayerCombatStatusChange, 1250);
    } else {
        logger::debug("\t CombatSink event missed because not processing");
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

        auto* eventSourceHolder = RE::ScriptEventSourceHolder::GetSingleton();
        if (eventSourceHolder) {
            eventSourceHolder->AddEventSink<TESEquipEvent>(SLTREventSink::GetSingleton());
            eventSourceHolder->AddEventSink<TESHitEvent>(SLTREventSink::GetSingleton());
            eventSourceHolder->AddEventSink<TESCombatEvent>(SLTREventSink::GetSingleton());
            logger::info("CombatEvent sink initialized, enabled({})", SLTREventSink::GetSingleton()->IsEnabledCombatEvent());
            logger::info("EquipEvent sink initialized, enabled({})", SLTREventSink::GetSingleton()->IsEnabledEquipEvent());
            logger::info("HitEvent sink initialized, enabled({})", SLTREventSink::GetSingleton()->IsEnabledHitEvent());
        } else {
            logger::error("Unable to register with ScriptEventSourceHolder");
        }
    }

    void GameEventHandler::onPostLoad() {
        //logger::info("onPostLoad()");
    }

    void GameEventHandler::onPostPostLoad() {
        //logger::info("onPostPostLoad()");
    }

    void GameEventHandler::onInputLoaded() {
        //logger::info("onInputLoaded()");
    }

    void GameEventHandler::onDataLoaded() {
        FunctionLibrary::PrecacheLibraries();
        ScriptPoolManager::GetSingleton().InitializePool();
    }

    void GameEventHandler::onNewGame() {
        SLT::GenerateNewSessionId(true);
        logger::info("{} starting session {}", SystemUtil::File::GetPluginName(), SLT::GetSessionId());
    }

    void GameEventHandler::onPreLoadGame() {
        //logger::info("onPreLoadGame()");
    }

    void GameEventHandler::onPostLoadGame() {
        SLT::GenerateNewSessionId(true);
        logger::info("{} starting session {}", SystemUtil::File::GetPluginName(), SLT::GetSessionId());
    }

    void GameEventHandler::onSaveGame() {
        //logger::info("onSaveGame()");
    }

    void GameEventHandler::onDeleteGame() {
        //logger::info("onDeleteGame()");
    }
}  // namespace plugin


