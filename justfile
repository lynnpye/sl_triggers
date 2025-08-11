#set shell := ["cmd.exe", "/c"]
set shell := ["powershell.exe", "-c"]

version_mod :=                  read('VERSION')
version_pet_collar_game :=      read('extern/add-ons/sltr_pet_collar_game/VERSION')

dir_project :=                  source_directory()
dir_dep :=                      dir_project / "deployables"
dir_project_extern :=           dir_project / "extern"
dir_project_addons :=           dir_project_extern / "add-ons"
dir_pet_collar_game :=          dir_project_addons / "sltr_pet_collar_game"
dir_test_scripts :=             dir_project_addons / "sltr_test_scripts"
dir_lang_support :=             dir_project_extern / "lang-support"
dir_lang_notepad_plusplus :=    dir_lang_support / "notepad++"
dir_lang_vscode :=              dir_lang_support / "vscode"
dir_project_caprica :=          dir_project_extern / "caprica"
dir_project_inc :=              dir_project / "inc"
dir_project_inc_beth :=         dir_project_inc / "beth"
dir_project_inc_skse :=         dir_project_inc / "skse"
dir_project_plugin :=           dir_project / "plugin" / "sl-triggers"
dir_project_plugin_release :=   dir_project_plugin / "build" / "release-msvc"
dir_project_src :=              dir_project / "src"
dir_project_pexoutput :=        dir_project_src / "scripts"
dir_project_skse_plugins :=     dir_project_src / "SKSE" / "Plugins"
dir_project_skse_sltr :=        dir_project_skse_plugins / "sl_triggers"
dir_project_sltr_caprica :=     dir_project_skse_sltr / "caprica"
dir_project_sltr_peximport :=   dir_project_skse_sltr / "peximport"
dir_project_scripts :=          dir_project_src / "source" / "scripts"
dir_project_headers :=          dir_project_src / "source" / "headeronly"

dir_wabbajack :=                absolute_path("/wabbajack")
dir_modlistinstalls :=          dir_wabbajack / "modlistinstalls"

dir_test_sme :=                 dir_modlistinstalls / "SME" / "mods" / "- Dev Files"
dir_sme_plugins :=              dir_test_sme / "SKSE" / "Plugins"
dir_test_nef :=                 dir_modlistinstalls / "NEFARAM.15.4.2" / "mods" / "AaDevelopment"
dir_nef_plugins :=              dir_test_nef / "SKSE" / "Plugins"
dir_sltr_test_scripts :=        dir_project_addons / "sltr_test_scripts"

file_catchup_exclusion :=       dir_project / "catchup_exclusion.txt"
file_plugin_release :=          dir_project_plugin_release / "sl-triggers.dll"
file_tesv_flags :=              dir_project_inc_beth / "TESV_Papyrus_Flags.flg"
file_caprica_exe :=             dir_project_caprica / "Caprica.exe"

file_sl_triggersStatics :=      dir_project_scripts / "sl_triggersStatics.psc"

mod_filename :=                 "sl_triggers" + version_mod + ".zip"
file_dep_mod :=                 dir_dep / mod_filename
test_script_filename :=         "sltr_test_scripts" + version_mod + ".zip"
file_dep_test_scripts :=        dir_dep / test_script_filename
pet_collar_game_filename :=     "sltr_pet_collar_game" + version_pet_collar_game + ".zip"
file_dep_pet_collar_game :=     dir_dep / pet_collar_game_filename
lang_npp_filename :=            "notepad++-sltscript-support.zip"
file_dep_lang_npp :=            dir_dep / lang_npp_filename
lang_vscode_filename :=         "vscode-sltscript-support.zip"
file_dep_lang_vscode :=         dir_dep / lang_vscode_filename

# non-wrapped stringified versions for use in commands
raw_dir_project_src :=          replace(dir_project_src,                '/', '\')
raw_dir_pet_collar_game :=      replace(dir_pet_collar_game,            '/', '\')
raw_dir_test_scripts :=         replace(dir_test_scripts,               '/', '\')
raw_dir_lang_npp :=             replace(dir_lang_notepad_plusplus,      '/', '\')
raw_dir_lang_vscode :=          replace(dir_lang_vscode,                '/', '\')

raw_file_dep_mod :=             replace(file_dep_mod,                   '/', '\')
raw_file_pet_collar_game :=     replace(file_dep_pet_collar_game,       '/', '\')
raw_file_test_scripts :=        replace(file_dep_test_scripts,          '/', '\')
raw_file_lang_npp :=            replace(file_dep_lang_npp,              '/', '\')
raw_file_lang_vscode :=         replace(file_dep_lang_vscode,           '/', '\')

# stringified versions for use in commands
str_dir_test_sme :=             replace("\"" + dir_test_sme + "\\\"",                   '/', '\')
str_dir_sme_plugins :=          replace("\"" + dir_sme_plugins + "\\\"",                '/', '\')
str_dir_test_nef :=             replace("\"" + dir_test_nef + "\\\"",                   '/', '\')
str_dir_nef_plugins :=          replace("\"" + dir_nef_plugins + "\\\"",                '/', '\')

str_dir_project :=              replace("\"" + dir_project + "\\\"",                    '/', '\')
str_dir_dep :=                  replace("\"" + dir_dep + "\\\"",                        '/', '\')
str_dir_project_inc_beth :=     replace("\"" + dir_project_inc_beth + "\\\"",           '/', '\')
str_dir_project_inc_skse :=     replace("\"" + dir_project_inc_skse + "\\\"",           '/', '\')
str_dir_project_caprica :=      replace("\"" + dir_project_caprica + "\\\"",            '/', '\')
str_dir_project_src :=          replace("\"" + dir_project_src + "\\\"",                '/', '\')
str_dir_project_skse_plugins := replace("\"" + dir_project_skse_plugins + "\\\"",       '/', '\')
str_dir_project_sltr_caprica := replace("\"" + dir_project_sltr_caprica + "\\\"",       '/', '\')
str_dir_project_peximport :=    replace("\"" + dir_project_sltr_peximport + "\\\"",     '/', '\')
str_dir_project_scripts :=      replace("\"" + dir_project_scripts + "\\\"",            '/', '\')
str_dir_project_headers :=      replace("\"" + dir_project_headers + "\\\"",            '/', '\')

str_file_catchup_exclusion :=   replace("\"" + file_catchup_exclusion + "\"",           '/', '\')
str_file_plugin_release :=      replace("\"" + file_plugin_release + "\"",              '/', '\')
str_file_tesv_flags :=          replace("\"" + file_tesv_flags + "\"",                  '/', '\')
str_file_caprica_exe :=         replace("\"" + file_caprica_exe + "\"",                 '/', '\')

str_file_sl_triggersStatics :=  replace("\"" + file_sl_triggersStatics + "\"",          '/', '\')

str_file_dep_mod :=             replace("\"" + file_dep_mod + "\"",                     '/', '\')
str_file_dep_test_scripts :=    replace("\"" + file_dep_test_scripts + "\"",            '/', '\')
str_file_dep_pet_collar_game := replace("\"" + file_dep_pet_collar_game + "\"",         '/', '\')

fileglob_sltr_test_scripts :=   replace("\"" + dir_sltr_test_scripts / "*.*" + "\"",    '/', '\')


default:
    @just --list

_vcdevenv:
    @vcdevenv.cmd

[working-directory: 'plugin/sl-triggers']
buildplugin: _vcdevenv
    cmake.EXE --build ./build/release-msvc --target all

_prepsrc:
    # Placeholder: xcopy /y {{str_file_caprica_exe}} {{str_dir_project_sltr_caprica}}
    xcopy /y {{str_file_tesv_flags}} {{str_dir_project_sltr_caprica}}
    xcopy /y {{str_file_plugin_release}} {{str_dir_project_skse_plugins}}
    # Placeholder: xcopy /y {{str_dir_project_inc_beth}} {{str_dir_project_peximport}}
    # Placeholder: xcopy /y {{str_dir_project_inc_skse}} {{str_dir_project_peximport}}
    xcopy /i /y {{str_dir_project_headers}} {{str_dir_project_peximport}}

[working-directory: '/']
populateSME: _prepsrc
    xcopy /e /i /y /exclude:{{str_file_catchup_exclusion}} {{str_dir_project_src}} {{str_dir_test_sme}}
    xcopy /s /i /y {{fileglob_sltr_test_scripts}} {{str_dir_test_sme}}

[working-directory: '/']
populateNEF: _prepsrc
    xcopy /e /i /y /exclude:{{str_file_catchup_exclusion}} {{str_dir_project_src}} {{str_dir_test_nef}}
    xcopy /s /i /y {{fileglob_sltr_test_scripts}} {{str_dir_test_nef}}

generatedocs:
    jcx SltParser

# More targeted replacement (safer - targets specifically the GetModVersion function)
update-version-safe:
    @echo "Updating version to {{version_mod}} in sl_triggersStatics.psc"
    powershell.exe -File update-version.ps1 -ScriptPath "{{file_sl_triggersStatics}}" -NewVersion "{{version_mod}}"

_package_preclean:
    powershell.exe -File clean-deps.ps1 -dir_dep "{{dir_dep}}"

packagemodonly: 
    powershell.exe -Command "if (Test-Path '{{raw_file_dep_mod}}') { Remove-Item -Path '{{raw_file_dep_mod}}' }"
    powershell.exe -Command "Compress-Archive -Path '{{raw_dir_project_src}}\\*' -DestinationPath '{{raw_file_dep_mod}}'"

packagelang:
    powershell.exe -Command "Compress-Archive -Path '{{raw_dir_lang_npp}}\\*' -DestinationPath '{{raw_file_lang_npp}}'"
    powershell.exe -Command "Compress-Archive -Path '{{raw_dir_lang_vscode}}\\*' -DestinationPath '{{raw_file_lang_vscode}}'"

packageall: _package_preclean packagemodonly packagelang
    powershell.exe -Command "Compress-Archive -Path '{{raw_dir_pet_collar_game}}\\*' -DestinationPath '{{raw_file_pet_collar_game}}'"
    powershell.exe -Command "Compress-Archive -Path '{{raw_dir_test_scripts}}\\*' -DestinationPath '{{raw_file_test_scripts}}'"
