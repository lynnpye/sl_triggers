#include "su_bridge.h"

using namespace SLT;
using namespace std;

template<class T>
class SUTypedResolutionCallback : public RE::BSScript::IStackCallbackFunctor {
private:
    std::promise<T> promise;

public:
    SUTypedResolutionCallback(std::promise<T> p)
        : promise(std::move(p)) {}
    
    virtual bool IsSUType(RE::BSScript::Variable& result);

    virtual T GetSUValue(RE::BSScript::Variable& result);

    T GetDefaultSUValue() { return T{}; }
    
    void operator()(RE::BSScript::Variable result) override {
        try {
            if (IsSUType(result)) {
                promise.set_value(GetSUValue(result));
                return;
            }

            promise.set_value(GetDefaultSUValue());
        } catch (...) {
            promise.set_exception(std::current_exception());
        }
    }
    
    void SetObject(const RE::BSTSmartPointer<RE::BSScript::Object>&) override {}
};

class SUStringResolutionCallback : public SUTypedResolutionCallback<string> {
    bool IsSUType(RE::BSScript::Variable& result) {
        return result.IsString();
    }

    string GetSUValue(RE::BSScript::Variable& result) {
        return string(result.GetString());
    }
};

class SUIntResolutionCallback : public SUTypedResolutionCallback<int32_t> {
    bool IsSUType(RE::BSScript::Variable& result) {
        return result.IsInt();
    }

    int32_t GetSUValue(RE::BSScript::Variable& result) {
        return result.GetSInt();
    }
};

class SUFloatResolutionCallback : public SUTypedResolutionCallback<float> {
    bool IsSUType(RE::BSScript::Variable& result) {
        return result.IsFloat();
    }

    float GetSUValue(RE::BSScript::Variable& result) {
        return result.GetFloat();
    }
};

class SUBoolResolutionCallback : public SUTypedResolutionCallback<bool> {
    bool IsSUType(RE::BSScript::Variable& result) {
        return result.IsBool();
    }

    bool GetSUValue(RE::BSScript::Variable& result) {
        return result.GetBool();
    }
};

class SUFormResolutionCallback : public SUTypedResolutionCallback<TESForm*> {
    bool IsSUType(RE::BSScript::Variable& result) {
        return result.IsObject();
    }

    TESForm* GetSUValue(RE::BSScript::Variable& result) {
        auto obj = result.GetObject();
        if (obj) {
            auto* vm = BSScript::Internal::VirtualMachine::GetSingleton();
            if (vm) {
                auto* handlePolicy = vm->GetObjectHandlePolicy();
                if (handlePolicy && handlePolicy->HandleIsType(TESForm::FORMTYPE, obj->handle)) {
                    return static_cast<TESForm*>(handlePolicy->GetObjectForHandle(TESForm::FORMTYPE, obj->handle));
                }
            }
        }
        return nullptr;
    }
};


bool StorageUtilBridge::SetStringValue(TESForm* suHost, string_view keyName, string_view value) {
    if (keyName.empty()) {
        logger::error("StorageUtil.SetStringValue: keyName must not be empty");
        return false;
    }

    

    return true;
}