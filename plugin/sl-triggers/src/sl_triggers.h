#pragma once

namespace SLT {

#pragma region SLTNativeFunctions declaration
class SLTNativeFunctions {
public:
// Non-latent functions
static bool DeleteTrigger(PAPYRUS_NATIVE_DECL, std::string_view extKeyStr, std::string_view trigKeyStr);

static RE::TESForm* GetForm(PAPYRUS_NATIVE_DECL, std::string_view a_editorID);

static std::string GetNumericLiteral(PAPYRUS_NATIVE_DECL, std::string_view token);

static std::vector<std::string> GetScriptsList(PAPYRUS_NATIVE_DECL);

static SLTSessionId GetSessionId(PAPYRUS_NATIVE_DECL);

static std::string GetTimestamp(PAPYRUS_NATIVE_DECL);

static std::string GetTopicInfoResponse(PAPYRUS_NATIVE_DECL, RE::TESTopicInfo* topicInfo);

static std::string GetTranslatedString(PAPYRUS_NATIVE_DECL, std::string_view input);

static std::vector<std::string> GetTriggerKeys(PAPYRUS_NATIVE_DECL, std::string_view extensionKey);

static void LogDebug(PAPYRUS_NATIVE_DECL, std::string_view logmsg);

static void LogError(PAPYRUS_NATIVE_DECL, std::string_view logmsg);

static void LogInfo(PAPYRUS_NATIVE_DECL, std::string_view logmsg);

static void LogWarn(PAPYRUS_NATIVE_DECL, std::string_view logmsg);

static std::vector<std::string> MCMGetAttributeData(PAPYRUS_NATIVE_DECL, bool isTriggerAttribute, std::string_view extensionKey, std::string_view attrName, std::string_view info);

static std::vector<std::string> MCMGetLayout(PAPYRUS_NATIVE_DECL, bool isTriggerAttribute, std::string_view extensionKey, std::string_view dataFile);

static std::vector<std::string> MCMGetLayoutData(PAPYRUS_NATIVE_DECL, bool isTriggerAttribute, std::string_view extensionKey, std::string_view layout, int row);

static std::int32_t NormalizeScriptfilename(PAPYRUS_NATIVE_DECL, std::string_view scriptfilename);

static std::vector<std::int32_t> NormalizeTimestamp(PAPYRUS_NATIVE_DECL, std::string_view sourceTimestamp);

static std::vector<std::int32_t> NormalizeTimestampComponents(PAPYRUS_NATIVE_DECL, std::vector<std::int32_t> optionalSourceTimestampComponents);

static bool RunOperationOnActor(PAPYRUS_NATIVE_DECL, RE::Actor* cmdTarget, RE::ActiveEffect* cmdPrimary,
                                            std::vector<std::string> tokens);

static bool RunSLTRMain(PAPYRUS_NATIVE_DECL, RE::Actor* cmdTarget, std::string_view scriptname, std::vector<std::string> strlist, std::vector<std::int32_t> intlist, std::vector<float> floatlist, std::vector<bool> boollist, std::vector<RE::TESForm*> formlist);

static void SetExtensionEnabled(PAPYRUS_NATIVE_DECL, std::string_view extensionKey,
                                            bool enabledState);

static void SetCombatSinkEnabled(PAPYRUS_NATIVE_DECL, bool isEnabled);

static void SetEquipSinkEnabled(PAPYRUS_NATIVE_DECL, bool isEnabled);

static void SetHitSinkEnabled(PAPYRUS_NATIVE_DECL, bool isEnabled);

static bool IsCombatSinkEnabled(PAPYRUS_NATIVE_DECL);

static bool IsEquipSinkEnabled(PAPYRUS_NATIVE_DECL);

static bool IsHitSinkEnabled(PAPYRUS_NATIVE_DECL);

static bool SmartEquals(PAPYRUS_NATIVE_DECL, std::string_view a, std::string_view b);
//static std::vector<std::string> SplitFileContents(PAPYRUS_NATIVE_DECL, std::string_view filecontents);

//static std::vector<std::string> SplitScriptContents(PAPYRUS_NATIVE_DECL, std::string_view scriptfilename);

static std::vector<std::string> SplitScriptContentsAndTokenize(PAPYRUS_NATIVE_DECL, std::string_view scriptfilename);

static bool StartScript(PAPYRUS_NATIVE_DECL, RE::Actor* cmdTarget, std::string_view initialScriptName);

static std::vector<std::string> Tokenize(PAPYRUS_NATIVE_DECL, std::string_view input);

static std::vector<std::string> Tokenizev2(PAPYRUS_NATIVE_DECL, std::string_view input);

static std::vector<std::string> TokenizeForVariableSubstitution(PAPYRUS_NATIVE_DECL, std::string_view input);

static std::string Trim(PAPYRUS_NATIVE_DECL, std::string_view str);
};
#pragma endregion


#pragma region SLTPapyrusFunctionProvider

class SLTPapyrusFunctionProvider : public SLT::binding::PapyrusFunctionProvider<SLTPapyrusFunctionProvider> {
public:
    // Static Papyrus function implementations
    static RE::TESForm* GetForm(PAPYRUS_STATIC_ARGS, std::string_view someFormOfFormIdentification) {
        return SLT::SLTNativeFunctions::GetForm(PAPYRUS_FN_PARMS, someFormOfFormIdentification);
    }

    static std::string GetNumericLiteral(PAPYRUS_STATIC_ARGS, std::string_view token) {
        return SLT::SLTNativeFunctions::GetNumericLiteral(PAPYRUS_FN_PARMS, token);
    }

    static std::vector<std::string> GetScriptsList(PAPYRUS_STATIC_ARGS) {
        return SLT::SLTNativeFunctions::GetScriptsList(PAPYRUS_FN_PARMS);
    }

    static std::int32_t GetSessionId(PAPYRUS_STATIC_ARGS) {
        return SLT::SLTNativeFunctions::GetSessionId(PAPYRUS_FN_PARMS);
    }

    static std::string GetTopicInfoResponse(PAPYRUS_STATIC_ARGS, RE::TESTopicInfo* topicInfo) {
        return SLT::SLTNativeFunctions::GetTopicInfoResponse(PAPYRUS_FN_PARMS, topicInfo);
    }

    static std::string GetTranslatedString(PAPYRUS_STATIC_ARGS, std::string_view input) {
        return SLT::SLTNativeFunctions::GetTranslatedString(PAPYRUS_FN_PARMS, input);
    }

    static std::int32_t NormalizeScriptfilename(PAPYRUS_STATIC_ARGS, std::string_view scriptfilename) {
        return SLT::SLTNativeFunctions::NormalizeScriptfilename(PAPYRUS_FN_PARMS, scriptfilename);
    }

    static std::vector<std::int32_t> NormalizeTimestamp(PAPYRUS_STATIC_ARGS, std::string_view optionalSourceTimestamp) {
        return SLT::SLTNativeFunctions::NormalizeTimestamp(PAPYRUS_FN_PARMS, optionalSourceTimestamp);
    }

    static std::vector<std::int32_t> NormalizeTimestampComponents(PAPYRUS_STATIC_ARGS, std::vector<std::int32_t> optionalSourceTimestampComponents) {
        return SLT::SLTNativeFunctions::NormalizeTimestampComponents(PAPYRUS_FN_PARMS, optionalSourceTimestampComponents);
    }

    static bool SmartEquals(PAPYRUS_STATIC_ARGS, std::string_view a, std::string_view b) {
        return SLT::SLTNativeFunctions::SmartEquals(PAPYRUS_FN_PARMS, a, b);
    }

    //static std::vector<std::string> SplitScriptContents(PAPYRUS_STATIC_ARGS, std::string_view scriptfilename) {
    //    return SLT::SLTNativeFunctions::SplitScriptContents(PAPYRUS_FN_PARMS, scriptfilename);
    //}

    static std::vector<std::string> SplitScriptContentsAndTokenize(PAPYRUS_STATIC_ARGS, std::string_view scriptfilename) {
        return SLT::SLTNativeFunctions::SplitScriptContentsAndTokenize(PAPYRUS_FN_PARMS, scriptfilename);
    }

    static std::vector<std::string> Tokenize(PAPYRUS_STATIC_ARGS, std::string_view input) {
        return SLT::SLTNativeFunctions::Tokenize(PAPYRUS_FN_PARMS, input);
    }

    static std::vector<std::string> Tokenizev2(PAPYRUS_STATIC_ARGS, std::string_view input) {
        return SLT::SLTNativeFunctions::Tokenizev2(PAPYRUS_FN_PARMS, input);
    }

    static std::vector<std::string> TokenizeForVariableSubstitution(PAPYRUS_STATIC_ARGS, std::string_view input) {
        return SLT::SLTNativeFunctions::TokenizeForVariableSubstitution(PAPYRUS_FN_PARMS, input);
    }

    static std::string Trim(PAPYRUS_STATIC_ARGS, std::string_view str) {
        return SLT::SLTNativeFunctions::Trim(PAPYRUS_FN_PARMS, str);
    }

    void RegisterAllFunctions(RE::BSScript::Internal::VirtualMachine* vm, std::string_view className) {
        SLT::binding::PapyrusRegistrar<SLTPapyrusFunctionProvider> reg(vm, className);
        
        reg.RegisterStatic("GetForm", &SLTPapyrusFunctionProvider::GetForm);
        reg.RegisterStatic("GetNumericLiteral", &SLTPapyrusFunctionProvider::GetNumericLiteral);
        reg.RegisterStatic("GetScriptsList", &SLTPapyrusFunctionProvider::GetScriptsList);
        reg.RegisterStatic("GetSessionId", &SLTPapyrusFunctionProvider::GetSessionId);
        reg.RegisterStatic("GetTopicInfoResponse", &SLTPapyrusFunctionProvider::GetTopicInfoResponse);
        reg.RegisterStatic("GetTranslatedString", &SLTPapyrusFunctionProvider::GetTranslatedString);
        reg.RegisterStatic("NormalizeScriptfilename", &SLTPapyrusFunctionProvider::NormalizeScriptfilename);
        reg.RegisterStatic("SmartEquals", &SLTPapyrusFunctionProvider::SmartEquals);
        //reg.RegisterStatic("SplitScriptContents", &SLTPapyrusFunctionProvider::SplitScriptContents);
        reg.RegisterStatic("SplitScriptContentsAndTokenize", &SLTPapyrusFunctionProvider::SplitScriptContentsAndTokenize);
        reg.RegisterStatic("Tokenize", &SLTPapyrusFunctionProvider::Tokenize);
        reg.RegisterStatic("Tokenizev2", &SLTPapyrusFunctionProvider::Tokenizev2);
        reg.RegisterStatic("TokenizeForVariableSubstitution", &SLTPapyrusFunctionProvider::TokenizeForVariableSubstitution);
        reg.RegisterStatic("Trim", &SLTPapyrusFunctionProvider::Trim);
    }
};

#pragma endregion

#pragma region SLTInternalPapyrusFunctionProvider
class SLTInternalPapyrusFunctionProvider : public SLT::binding::PapyrusFunctionProvider<SLTInternalPapyrusFunctionProvider> {
public:
    // Static Papyrus function implementations
    // NON-LATENT
    static bool DeleteTrigger(PAPYRUS_STATIC_ARGS, std::string extKeyStr, std::string trigKeyStr) {
        return SLT::SLTNativeFunctions::DeleteTrigger(PAPYRUS_FN_PARMS, extKeyStr, trigKeyStr);
    }

    static std::vector<std::string> GetTriggerKeys(PAPYRUS_STATIC_ARGS, std::string_view extensionKey) {
        return SLT::SLTNativeFunctions::GetTriggerKeys(PAPYRUS_FN_PARMS, extensionKey);
    }

    static void LogDebug(PAPYRUS_STATIC_ARGS, std::string_view logmsg) {
        SLT::SLTNativeFunctions::LogDebug(PAPYRUS_FN_PARMS, logmsg);
    }

    static void LogError(PAPYRUS_STATIC_ARGS, std::string_view logmsg) {
        SLT::SLTNativeFunctions::LogError(PAPYRUS_FN_PARMS, logmsg);
    }

    static void LogInfo(PAPYRUS_STATIC_ARGS, std::string_view logmsg) {
        SLT::SLTNativeFunctions::LogInfo(PAPYRUS_FN_PARMS, logmsg);
    }

    static void LogWarn(PAPYRUS_STATIC_ARGS, std::string_view logmsg) {
        SLT::SLTNativeFunctions::LogWarn(PAPYRUS_FN_PARMS, logmsg);
    }

    static std::vector<std::string> MCMGetAttributeData(PAPYRUS_STATIC_ARGS, bool isTriggerAttribute, std::string_view extensionKey, std::string_view attrName, std::string_view info) {
        return SLTNativeFunctions::MCMGetAttributeData(PAPYRUS_FN_PARMS, isTriggerAttribute, extensionKey, attrName, info);
    }

    static std::vector<std::string> MCMGetLayout(PAPYRUS_STATIC_ARGS, bool isTriggerAttribute, std::string_view extensionKey, std::string_view dataFile) {
        return SLTNativeFunctions::MCMGetLayout(PAPYRUS_FN_PARMS, isTriggerAttribute, extensionKey, dataFile);
    }

    static std::vector<std::string> MCMGetLayoutData(PAPYRUS_STATIC_ARGS, bool isTriggerAttribute, std::string_view extensionKey, std::string_view layout, std::int32_t row) {
        return SLTNativeFunctions::MCMGetLayoutData(PAPYRUS_FN_PARMS, isTriggerAttribute, extensionKey, layout, row);
    }

    static bool RunOperationOnActor(PAPYRUS_STATIC_ARGS, RE::Actor* cmdTarget, RE::ActiveEffect* cmdPrimary,
                                            std::vector<std::string> tokens) {
        return SLT::SLTNativeFunctions::RunOperationOnActor(PAPYRUS_FN_PARMS, cmdTarget, cmdPrimary, tokens);
    }

    static bool RunSLTRMain(PAPYRUS_STATIC_ARGS, RE::Actor* cmdActor, std::string_view scriptname, std::vector<std::string> strlist,
        std::vector<std::int32_t> intlist, std::vector<float> floatlist, std::vector<bool> boollist, std::vector<RE::TESForm*> formlist) {
        return SLT::SLTNativeFunctions::RunSLTRMain(PAPYRUS_FN_PARMS, cmdActor, scriptname, strlist, intlist, floatlist, boollist, formlist);
    }

    static void SetExtensionEnabled(PAPYRUS_STATIC_ARGS, std::string_view extensionKey, bool enabledState) {
        SLT::SLTNativeFunctions::SetExtensionEnabled(PAPYRUS_FN_PARMS, extensionKey, enabledState);
    }

    static void SetCombatSinkEnabled(PAPYRUS_STATIC_ARGS, bool isEnabled) {
        SLT::SLTNativeFunctions::SetCombatSinkEnabled(PAPYRUS_FN_PARMS, isEnabled);
    }

    static void SetEquipSinkEnabled(PAPYRUS_STATIC_ARGS, bool isEnabled) {
        SLT::SLTNativeFunctions::SetEquipSinkEnabled(PAPYRUS_FN_PARMS, isEnabled);
    }

    static void SetHitSinkEnabled(PAPYRUS_STATIC_ARGS, bool isEnabled) {
        SLT::SLTNativeFunctions::SetHitSinkEnabled(PAPYRUS_FN_PARMS, isEnabled);
    }

    static bool IsCombatSinkEnabled(PAPYRUS_STATIC_ARGS) {
        return SLT::SLTNativeFunctions::IsCombatSinkEnabled(PAPYRUS_FN_PARMS);
    }

    static bool IsEquipSinkEnabled(PAPYRUS_STATIC_ARGS) {
        return SLT::SLTNativeFunctions::IsEquipSinkEnabled(PAPYRUS_FN_PARMS);
    }

    static bool IsHitSinkEnabled(PAPYRUS_STATIC_ARGS) {
        return SLT::SLTNativeFunctions::IsHitSinkEnabled(PAPYRUS_FN_PARMS);
    }

    static bool StartScript(PAPYRUS_STATIC_ARGS, RE::Actor* cmdTarget, std::string_view initialScriptName) {
        return SLT::SLTNativeFunctions::StartScript(PAPYRUS_FN_PARMS, cmdTarget, initialScriptName);
    }

    void RegisterAllFunctions(RE::BSScript::Internal::VirtualMachine* vm, std::string_view className) {
        SLT::binding::PapyrusRegistrar<SLTInternalPapyrusFunctionProvider> reg(vm, className);

        reg.RegisterStatic("DeleteTrigger", &SLTInternalPapyrusFunctionProvider::DeleteTrigger);
        reg.RegisterStatic("GetTriggerKeys", &SLTInternalPapyrusFunctionProvider::GetTriggerKeys);
        reg.RegisterStatic("LogDebug", &SLTInternalPapyrusFunctionProvider::LogDebug);
        reg.RegisterStatic("LogError", &SLTInternalPapyrusFunctionProvider::LogError);
        reg.RegisterStatic("LogInfo", &SLTInternalPapyrusFunctionProvider::LogInfo);
        reg.RegisterStatic("LogWarn", &SLTInternalPapyrusFunctionProvider::LogWarn);
        reg.RegisterStatic("MCMGetAttributeData", &SLTInternalPapyrusFunctionProvider::MCMGetAttributeData);
        reg.RegisterStatic("MCMGetLayout", &SLTInternalPapyrusFunctionProvider::MCMGetLayout);
        reg.RegisterStatic("MCMGetLayoutData", &SLTInternalPapyrusFunctionProvider::MCMGetLayoutData);
        reg.RegisterStatic("RunOperationOnActor", &SLTInternalPapyrusFunctionProvider::RunOperationOnActor);
        reg.RegisterStatic("SetExtensionEnabled", &SLTInternalPapyrusFunctionProvider::SetExtensionEnabled);
        reg.RegisterStatic("SetCombatSinkEnabled", &SLTInternalPapyrusFunctionProvider::SetCombatSinkEnabled);
        reg.RegisterStatic("SetEquipSinkEnabled", &SLTInternalPapyrusFunctionProvider::SetEquipSinkEnabled);
        reg.RegisterStatic("SetHitSinkEnabled", &SLTInternalPapyrusFunctionProvider::SetHitSinkEnabled);
        reg.RegisterStatic("IsCombatSinkEnabled", &SLTInternalPapyrusFunctionProvider::IsCombatSinkEnabled);
        reg.RegisterStatic("IsEquipSinkEnabled", &SLTInternalPapyrusFunctionProvider::IsEquipSinkEnabled);
        reg.RegisterStatic("IsHitSinkEnabled", &SLTInternalPapyrusFunctionProvider::IsHitSinkEnabled);
        reg.RegisterStatic("StartScript", &SLTInternalPapyrusFunctionProvider::StartScript);
    }
};
#pragma endregion

}