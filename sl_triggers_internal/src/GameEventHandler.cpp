#include "GameEventHandler.h"
#include "Hooks.h"


namespace plugin {

    void GameEventHandler::onLoad() {
        //logger::info("onLoad()");
        Hooks::install();
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
        //logger::info("onDataLoaded()");
    }

    void GameEventHandler::onNewGame() {
        plugin::Util::GenerateNewSessionId();
    }

    void GameEventHandler::onPreLoadGame() {
        //logger::info("onPreLoadGame()");
    }

    void GameEventHandler::onPostLoadGame() {
        plugin::Util::GenerateNewSessionId();
    }

    void GameEventHandler::onSaveGame() {
        //logger::info("onSaveGame()");
    }

    void GameEventHandler::onDeleteGame() {
        //logger::info("onDeleteGame()");
    }
}  // namespace plugin