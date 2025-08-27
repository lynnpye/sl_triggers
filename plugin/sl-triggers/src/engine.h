#pragma once


namespace SLT {

#pragma region VoidCallbackFunctor
class VoidCallbackFunctor : public RE::BSScript::IStackCallbackFunctor {
public:
    explicit VoidCallbackFunctor(std::function<void()> callback)
        : onDone(std::move(callback)) {}

    void operator()(RE::BSScript::Variable) override {
        if (onDone) {
            onDone();
        }
    }

    void SetObject(const RE::BSTSmartPointer<RE::BSScript::Object>&) override {}

private:
    std::function<void()> onDone;
};
#pragma endregion

#pragma region OperationRunner
class OperationRunner {
public:
    static bool RunOperationOnActor(RE::Actor* targetActor, 
                                   RE::ActiveEffect* cmdPrimary, 
                                   const std::vector<RE::BSFixedString>& params);
    
    static bool RunOperationOnActor(RE::Actor* targetActor, 
                                   RE::ActiveEffect* cmdPrimary, 
                                   const std::vector<std::string>& params);

    static bool RunSLTRMain(RE::Actor* cmdActor, std::string_view scriptname, std::vector<std::string> strlist,
        std::vector<std::int32_t> intlist, std::vector<float> floatlist,
        std::vector<bool> boollist, std::vector<RE::TESForm*> formlist);
};
#pragma endregion

#pragma region Function Libraries declaration

struct CaseInsensitiveHash {
    std::size_t operator()(std::string_view key) const {
        std::string lower_key = Util::String::ToLower(key);
        return std::hash<std::string>{}(lower_key);
    }
};

struct CaseInsensitiveEqual {
    bool operator()(std::string_view lhs, std::string_view rhs) const {
        return Util::String::iEquals(lhs, rhs);
    }
};

struct FunctionLibrary {

    static const std::string_view SLTCmdLib;
    static std::vector<std::unique_ptr<FunctionLibrary>> g_FunctionLibraries;
    static std::unordered_map<std::string, std::string, CaseInsensitiveHash, CaseInsensitiveEqual> functionScriptCache;


    std::string configFile;
    std::string functionFile;
    std::string extensionKey;
    std::int32_t priority;
    bool enabled;

    explicit FunctionLibrary(std::string_view _configFile, std::string_view _functionFile, std::string_view _extensionKey, std::int32_t _priority, bool _enabled = true)
        : configFile(_configFile), functionFile(_functionFile), extensionKey(_extensionKey), priority(_priority), enabled(_enabled) {}

    static std::vector<FunctionLibrary*> ByExtensionKey(std::string_view _extensionKey);
    static void GetFunctionLibraries();
    static void RefreshFunctionLibraryCache();
    static bool PrecacheLibraries();

    std::string GetDescription() {
        return std::format("ExtKey({}) CmdLib({}) Pri({}) Enabled({})", extensionKey, functionFile, priority, enabled);
    }
};
#pragma endregion
}