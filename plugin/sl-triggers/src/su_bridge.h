#pragma once

#pragma region StorageUtilBridge
namespace SLT {

struct StorageUtilBridge {

    static bool SetStringValue(TESForm* suHost, std::string_view keyName, std::string_view value);

};

}
#pragma endregion