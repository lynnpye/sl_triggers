

namespace {
bool player_isSwimming = false;
bool player_inWater = false;

float player_submergedLevel = 0.0;

RE::BSFixedString OnSLTRPlayerSwimEvent("OnSLTRPlayerSwimEvent");
RE::BSFixedString OnSLTRPlayerWaterEvent("OnSLTRPlayerWaterEvent");
}

namespace SLT{

class FactFinderThreadManager {
private:
    std::thread workerThread;
    std::atomic<bool> shouldStop{false};
    std::mutex threadMutex;

    void ThreadWorker() {
        while (!shouldStop.load()) {
            try {
                PollFactsAndRunEvents();
                
                std::this_thread::sleep_for(std::chrono::milliseconds(100));
            }
            catch (const std::exception& e) {
                logger::error("Exception in FactFinderThreadManager thread: {}", e.what());
            }
            catch (...) {
                logger::error("Unknown exception in FactFinderThreadManager thread");
            }
        }
    }

    void PollFactsAndRunEvents() {
        static SLTREventSink* sinkleton = SLTREventSink::GetSingleton();
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

public:
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
};


static FactFinderThreadManager g_threadManager;

OnPostLoadGame([]{
    // This will stop any existing thread and start a new one
    g_threadManager.StartWorkerThread();
})

OnQuit([]{
    g_threadManager.StopWorkerThread();
})

}
