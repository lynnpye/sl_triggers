

#define USE_THREAD 1
namespace {
bool player_isSwimming = false;
bool player_inWater = false;

float player_submergedLevel = 0.0;

RE::BSFixedString OnSLTRPlayerSwimEvent("OnSLTRPlayerSwimEvent");
RE::BSFixedString OnSLTRPlayerWaterEvent("OnSLTRPlayerWaterEvent");
    
void PollFactsAndRunEvents() {
    static SLT::SLTREventSink* sinkleton = SLT::SLTREventSink::GetSingleton();
    auto* thePC = RE::PlayerCharacter::GetSingleton();
    
    if (sinkleton->IsEnabledSwimHooks()) {
        bool b_isSwimming = thePC->AsActorState()->IsSwimming();
        float player_submergedLevel = Util::Actor::GetSubmergedLevel(thePC);
        bool b_inWater = player_submergedLevel > 0.0;
        RE::BSScript::Internal::VirtualMachine* vm = nullptr;

        if (b_isSwimming != player_isSwimming) {
            player_isSwimming = b_isSwimming;

            vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (vm) {
                auto* args = RE::MakeFunctionArguments(
                    static_cast<bool>(player_isSwimming)
                );
                vm->SendEventAll(OnSLTRPlayerSwimEvent, args);
            }
        }

        if (b_inWater != player_inWater) {
            player_inWater = b_inWater;
            
            if (!vm) vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (vm) {
                auto* args = RE::MakeFunctionArguments(
                    static_cast<bool>(player_inWater)
                );
                vm->SendEventAll(OnSLTRPlayerWaterEvent, args);
            }
        }
    }
}

}

#if USE_THREAD == 2
namespace stl
{
	using namespace SKSE::stl;

	template <class T>
	void write_thunk_call(std::uintptr_t a_src)
	{
		SKSE::AllocTrampoline(14);

		auto& trampoline = SKSE::GetTrampoline();
		T::func = trampoline.write_call<5>(a_src, T::thunk);
	}

	template <class F, std::size_t idx, class T>
	void write_vfunc()
	{
		REL::Relocation<std::uintptr_t> vtbl{ F::VTABLE[0] };
		T::func = vtbl.write_vfunc(idx, T::thunk);
	}

	template <std::size_t idx, class T>
	void write_vfunc(REL::VariantID id)
	{
		REL::Relocation<std::uintptr_t> vtbl{ id };
		T::func = vtbl.write_vfunc(idx, T::thunk);
	}
}
#endif

namespace SLT {

class FactFinderThreadManager {
private:
#if USE_THREAD == 1
    std::thread workerThread;
    std::atomic<bool> shouldStop{false};
    std::mutex threadMutex;

    void ThreadWorker() {
        while (!shouldStop.load()) {
            try {
                PollFactsAndRunEvents();
                
                std::this_thread::sleep_for(std::chrono::milliseconds(500));
            }
            catch (const std::exception& e) {
                logger::error("Exception in FactFinderThreadManager thread: {}", e.what());
            }
            catch (...) {
                logger::error("Unknown exception in FactFinderThreadManager thread");
            }
        }
    }
#else

protected:
	struct Hooks
	{
		struct Actor_SetMaximumMovementSpeed
		{
			static float thunk(RE::Actor* a_actor)
			{
                PollFactsAndRunEvents();
				return func(a_actor);
			}
			static inline REL::Relocation<decltype(thunk)> func;
		};


		static void Install()
		{
            logger::debug("stl::write_thunk_call called");
			::stl::write_thunk_call<Actor_SetMaximumMovementSpeed>(REL::RelocationID(37013, 37943).address() + REL::Relocate(0x1A, 0x51));
		}
	};

#endif

public:
#if USE_THREAD == 1
    void StartWorkerThread() {
        std::lock_guard<std::mutex> lock(threadMutex);
        
        // Stop existing thread if running
        StopWorkerThread();
        
        // Reset stop flag and start new thread
        shouldStop.store(false);
        workerThread = std::thread(&FactFinderThreadManager::ThreadWorker, this);
    }

    void StopWorkerThread() {
        if (workerThread.joinable()) {
            shouldStop.store(true);
            workerThread.join();
        }
    }

    ~FactFinderThreadManager() {
        StopWorkerThread();
    }
#else
    static void InstallHooks()
    {
        logger::debug("InstallHooks calling Hooks::Install");
        Hooks::Install();
    }
#endif
};

#if USE_THREAD == 1
static FactFinderThreadManager g_threadManager;

OnPostLoadGame([]{
    // This will stop any existing thread and start a new one
    g_threadManager.StartWorkerThread();
})

OnQuit([]{
    g_threadManager.StopWorkerThread();
})
#else
OnAfterSKSEInit([]{
    logger::debug("OnAfterSKSEInit installing fact finder hooks");
    FactFinderThreadManager::InstallHooks();
})
#endif

}
