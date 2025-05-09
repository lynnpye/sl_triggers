#include "Hooks.h"
namespace plugin {
    void Hooks::install() {
        QuitGameHook::install();
    }

    void Hooks::quitGame() {
    }
}  // namespace plugin
