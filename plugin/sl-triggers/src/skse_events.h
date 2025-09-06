#pragma once


/*
MIT License

Copyright (c) 2023 Emerson Pinter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */

template <class T>
class SkseMessagingListener {
    protected:
        SkseMessagingListener() = default;

    private:
        SkseMessagingListener(SkseMessagingListener&) = delete;
        SkseMessagingListener& operator=(SkseMessagingListener&&) = delete;
        void operator=(SkseMessagingListener&) = delete;

    public:
        ~SkseMessagingListener() = default;

        // This plugin is finishing load.
        virtual void onLoad(){};

        // All plugins have finished running SKSEPlugin_Load.
        virtual void onPostLoad(){};

        // All kPostLoad message handlers have run.
        virtual void onPostPostLoad(){};

        // All game data has been found.
        virtual void onInputLoaded(){};

        // All ESM/ESL/ESP plugins have loaded, main menu is now active.
        virtual void onDataLoaded(){};

        // Player starts a new game from main menu.
        virtual void onNewGame(){};

        // Player selected a game to load, but it hasn't loaded yet.
        virtual void onPreLoadGame(){};

        // Player selected save game has finished loading.
        virtual void onPostLoadGame(){};

        // Player has saved a game.
        virtual void onSaveGame(){};

        // Player deleted a saved game from within the load menu.
        virtual void onDeleteGame(){};

        auto registerListener() {
            if (!SKSE::GetMessagingInterface()->RegisterListener([](SKSE::MessagingInterface::Message* message) {
                    switch (message->type) {
                        case SKSE::MessagingInterface::kPostLoad:
                            T::getInstance().onPostLoad();
                            break;
                        case SKSE::MessagingInterface::kPostPostLoad:
                            T::getInstance().onPostPostLoad();
                            break;
                        case SKSE::MessagingInterface::kInputLoaded:
                            T::getInstance().onInputLoaded();
                            break;
                        case SKSE::MessagingInterface::kDataLoaded:
                            T::getInstance().onDataLoaded();
                            break;
                        case SKSE::MessagingInterface::kNewGame:
                            T::getInstance().onNewGame();
                            break;
                        case SKSE::MessagingInterface::kPreLoadGame:
                            T::getInstance().onPreLoadGame();
                            break;
                        case SKSE::MessagingInterface::kPostLoadGame:
                            T::getInstance().onPostLoadGame();
                            break;
                        case SKSE::MessagingInterface::kSaveGame:
                            T::getInstance().onSaveGame();
                            break;
                        case SKSE::MessagingInterface::kDeleteGame:
                            T::getInstance().onDeleteGame();
                            break;
                    }
                })) {
                SKSE::stl::report_and_fail("Unable to register message listener.");
            }
        }
};

namespace SLT {
    class GameEventHandler : public SkseMessagingListener<GameEventHandler> {
        private:
            GameEventHandler() {
                registerListener();
            };
            GameEventHandler(GameEventHandler&) = delete;
            GameEventHandler& operator=(GameEventHandler&&) = delete;
            void operator=(GameEventHandler&) = delete;
        public:
            [[nodiscard]] static GameEventHandler& getInstance() {
                static GameEventHandler instance;
                return instance;
            }

            void onLoad() override;
            void onPostLoad() override;
            void onPostPostLoad() override;
            void onInputLoaded() override;
            void onDataLoaded() override;
            void onNewGame() override;
            void onPreLoadGame() override;
            void onPostLoadGame() override;
            void onSaveGame() override;
            void onDeleteGame() override;
    };
    

    class SLTREventSink :
        public RE::BSTEventSink<RE::TESCombatEvent>,
        public RE::BSTEventSink<RE::TESEquipEvent>,
        public RE::BSTEventSink<RE::TESHitEvent>,
        //public RE::BSTEventSink<RE::TESActivateEvent>,
        public RE::BSTEventSink<RE::TESHarvestedEvent::ItemHarvested>
    {
    private:
        bool isEnabled_CombatEvent;
        bool isEnabled_EquipEvent;
        bool isEnabled_HitEvent;
        //bool isEnabled_ActivateEvent;
        bool isEnabled_HarvestedEvent;
        bool isEnabled_SwimHooks;

        SLTREventSink() : isEnabled_CombatEvent(false), isEnabled_EquipEvent(false), isEnabled_HitEvent(false), 
            //isEnabled_ActivateEvent(false),
            isEnabled_SwimHooks(false), isEnabled_HarvestedEvent(false)
        {}

    public:
        static SLTREventSink* GetSingleton()
        {
            static SLTREventSink singleton;
            return &singleton;
        }

        bool IsEnabledEquipEvent() { return isEnabled_EquipEvent; }
        bool IsEnabledHitEvent() { return isEnabled_HitEvent; }
        bool IsEnabledCombatEvent() { return isEnabled_CombatEvent; }
        //bool IsEnabledActivateEvent() { return isEnabled_ActivateEvent; }
        bool IsEnabledHarvestedEvent() { return isEnabled_HarvestedEvent; }
        bool IsEnabledSwimHooks() { return isEnabled_SwimHooks; }

        void SetEnabledEquipEvent(bool b) { isEnabled_EquipEvent = b; }
        void SetEnabledHitEvent(bool b) { isEnabled_HitEvent = b; }
        void SetEnabledCombatEvent(bool b) { isEnabled_CombatEvent = b; }
        //void SetEnabledActivateEvent(bool b) { isEnabled_ActivateEvent = b; }
        void SetEnabledHarvestedEvent(bool b) { isEnabled_HarvestedEvent = b; }
        void SetEnabledSwimHooks(bool b) { isEnabled_SwimHooks = b; }

        RE::BSEventNotifyControl ProcessEvent(const RE::TESEquipEvent* event, RE::BSTEventSource<RE::TESEquipEvent>* source) override;

        RE::BSEventNotifyControl ProcessEvent(const RE::TESHitEvent* event, 
                                        RE::BSTEventSource<RE::TESHitEvent>* source) override;

        RE::BSEventNotifyControl ProcessEvent(const RE::TESCombatEvent* event, 
                                        RE::BSTEventSource<RE::TESCombatEvent>* source) override;

        /*
        RE::BSEventNotifyControl ProcessEvent(const RE::TESActivateEvent* event,
                                        RE::BSTEventSource<RE::TESActivateEvent>* source) override;
        */

        RE::BSEventNotifyControl ProcessEvent(const RE::TESHarvestedEvent::ItemHarvested* event,
                                        RE::BSTEventSource<RE::TESHarvestedEvent::ItemHarvested>* source) override;
    };
}


namespace SLT {
class RegistrationClass {
    friend class GameEventHandler;

public:
    //static bool Init(const SKSE::LoadInterface *skse, std::function<void(SKSE::MessagingInterface::Message*)> msgHandler = nullptr);
    static RegistrationClass& GetSingleton();

    void RegisterMessageListener(SKSEMessageType skseMessageType, std::function<void()> cb);
    void RegisterInitter(std::function<void()> cb);
    void RegisterQuitter(std::function<void()> cb);

public:
    class AutoRegister {
    public:
        AutoRegister(SKSEMessageType skseMsgType, std::function<void()> cb);
    };

    class AutoInitter {
    public:
        AutoInitter(std::function<void()> cb);
    };

    class AutoQuitter {
    public:
        AutoQuitter(std::function<void()> cb);
    };

private:
    RegistrationClass() = default;

    std::unordered_map<SKSEMessageType, std::vector<std::function<void()>>> _callbacks;
    mutable std::mutex _mutex;
    static std::function<void(SKSE::MessagingInterface::Message*)> _msgHandler;

    std::vector<std::function<void()>> _initters;
    mutable std::mutex _mutexInitters;

    std::vector<std::function<void()>> _quitters;
    mutable std::mutex _mutexQuitters;

    static void HandleSKSEMessage(SKSEMessageType msgOfType) {
        auto& reg = SLT::RegistrationClass::GetSingleton();
        std::vector<std::function<void()>> toCall;
        {
            std::lock_guard<std::mutex> lock(reg._mutex);
            auto it = reg._callbacks.find(msgOfType);
            if (it != reg._callbacks.end())
                toCall = it->second; // Safe copy
        }
        for (auto& cb : toCall)
            cb();
    }

private:
    struct QuitGameHook {
        static void hook();
        static void install();

        static std::string logName;
        static REL::Relocation<decltype(hook)> orig;
        static REL::RelocationID srcFunc;
        static uint64_t srcFuncOffset;
    };
    
};
}

using SKSEReg = SLT::RegistrationClass;
 
#define REGISTRATION_CONCATENATE_DETAIL(x, y) x##y
#define REGISTRATION_CONCATENATE(x, y) REGISTRATION_CONCATENATE_DETAIL(x, y)
#define REGISTRATION_UNIQUE_NAME(prefix) REGISTRATION_CONCATENATE(prefix, __LINE__)

#define OnAfterSKSEInit(lambda) \
namespace { \
    static SLT::RegistrationClass::AutoInitter REGISTRATION_UNIQUE_NAME(_OnAfterSKSEInit_)(lambda); \
}

#define OnQuit(lambda) \
namespace { \
    static SLT::RegistrationClass::AutoQuitter REGISTRATION_UNIQUE_NAME(_OnQuit_)(lambda); \
}

#define OnPostLoad(lambda) \
namespace { \
    static SLT::RegistrationClass::AutoRegister REGISTRATION_UNIQUE_NAME(_OnPostLoad_)(::SKSE::MessagingInterface::kPostLoad, lambda); \
}

#define OnPostPostLoad(lambda) \
namespace { \
    static SLT::RegistrationClass::AutoRegister REGISTRATION_UNIQUE_NAME(_OnPostPostLoad_)(::SKSE::MessagingInterface::kPostPostLoad, lambda); \
}

#define OnPreLoadGame(lambda) \
namespace { \
    static SLT::RegistrationClass::AutoRegister REGISTRATION_UNIQUE_NAME(_OnPreLoadGame_)(::SKSE::MessagingInterface::kPreLoadGame, lambda); \
}

#define OnPostLoadGame(lambda) \
namespace { \
    static SLT::RegistrationClass::AutoRegister REGISTRATION_UNIQUE_NAME(_OnPostLoadGame_)(::SKSE::MessagingInterface::kPostLoadGame, lambda); \
}

#define OnSaveGame(lambda) \
namespace { \
    static SLT::RegistrationClass::AutoRegister REGISTRATION_UNIQUE_NAME(_OnSaveGame_)(::SKSE::MessagingInterface::kSaveGame, lambda); \
}

#define OnDeleteGame(lambda) \
namespace { \
    static SLT::RegistrationClass::AutoRegister REGISTRATION_UNIQUE_NAME(_OnDeleteGame_)(::SKSE::MessagingInterface::kDeleteGame, lambda); \
}

#define OnInputLoaded(lambda) \
namespace { \
    static SLT::RegistrationClass::AutoRegister REGISTRATION_UNIQUE_NAME(_OnInputLoaded_)(::SKSE::MessagingInterface::kInputLoaded, lambda); \
}

#define OnNewGame(lambda) \
namespace { \
    static SLT::RegistrationClass::AutoRegister REGISTRATION_UNIQUE_NAME(_OnNewGame_)(::SKSE::MessagingInterface::kNewGame, lambda); \
}

#define OnDataLoaded(lambda) \
namespace { \
    static SLT::RegistrationClass::AutoRegister REGISTRATION_UNIQUE_NAME(_OnDataLoaded_)(::SKSE::MessagingInterface::kDataLoaded, lambda); \
}