#set shell := ["cmd.exe", "/c"]
set shell := ["powershell.exe", "-c"]

version_fomod :=                read('VERSION')
version_mod :=                  trim_start_matches(replace(version_fomod, '.', '0'), '0')
version_pet_collar_game :=      read('extern/add-ons/sltr_pet_collar_game/VERSION')

dir_project :=                  source_directory()
dir_dep :=                      dir_project / "deployables"
dir_docs :=                     dir_project / "docs"
dir_project_extern :=           dir_project / "extern"
dir_project_addons :=           dir_project_extern / "add-ons"
dir_pet_collar_game :=          dir_project_addons / "sltr_pet_collar_game"
dir_sls_wet_license :=          dir_project_addons / "sls_wet_license_destruction"
dir_consumption :=              dir_project_addons / "sltr_consumption_lifestyle"
dir_test_scripts :=             dir_project_addons / "sltr_test_scripts"
dir_lang_support :=             dir_project_extern / "lang-support"
dir_lang_notepad_plusplus :=    dir_lang_support / "notepad++"
dir_lang_vscode :=              dir_lang_support / "vscode"
dir_project_libraries :=        dir_project_extern / "libraries"
dir_lib_adult_general :=        dir_project_libraries / "adult-general"
dir_lib_example_trigger :=      dir_project_libraries / "example-trigger"
dir_lib_ostim :=                dir_project_libraries / "ostim"
dir_lib_sexlab :=               dir_project_libraries / "sexlab"
dir_lib_sexlabplusplus :=       dir_project_libraries / "sexlabplusplus"
dir_lib_sexlab_dependent :=     dir_project_libraries / "sexlab-dependent"
dir_project_caprica :=          dir_project_extern / "caprica"
dir_project_fomod :=            dir_project / "fomod"
dir_fomod_fomod :=              dir_project_fomod / "fomod"
dir_fomod_core :=               dir_project_fomod / "core"
dir_fomod_ostim :=              dir_project_fomod / "ostim"
dir_fomod_sexlab :=             dir_project_fomod / "sexlab"
dir_fomod_sexlabplusplus :=     dir_project_fomod / "sexlabplusplus"
dir_fomod_example_trigger :=    dir_project_fomod / "example-trigger"
dir_fomod_test_scripts :=       dir_project_fomod / "test-scripts"
dir_fomod_pet_collar_game :=    dir_project_fomod / "pet-collar-game"
dir_fomod_consumption :=        dir_project_fomod / "consumption-lifestyle"
dir_fomod_sls_wet_license :=    dir_project_fomod / "sls-wet-license-destruction"
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

dir_pexout_core :=              dir_project_src / "scripts"
dir_pexout_lib_adult_general := dir_lib_adult_general / "scripts"
dir_pexout_lib_ostim :=         dir_lib_ostim / "scripts"
dir_pexout_lib_sexlab :=        dir_lib_sexlab / "scripts"
dir_pexout_lib_sexlabplusplus := dir_lib_sexlabplusplus / "scripts"

dir_wabbajack :=                absolute_path("/wabbajack")
dir_modlistinstalls :=          dir_wabbajack / "modlistinstalls"

dir_test_sme :=                 dir_modlistinstalls / "SME" / "mods" / "- Dev Files"
dir_sme_plugins :=              dir_test_sme / "SKSE" / "Plugins"
dir_test_nef :=                 dir_modlistinstalls / "NEFARAM.15.4.2" / "mods" / "AaDevelopment"
dir_nef_plugins :=              dir_test_nef / "SKSE" / "Plugins"
dir_sltr_test_scripts :=        dir_project_addons / "sltr_test_scripts"

file_docs_Scripts_md :=         dir_docs / "Scripts.md"
file_src_sltscripts_md :=       dir_project_src / "sl_triggers_sltscripts.md"

file_fomod_info_xml :=          dir_fomod_fomod / "info.xml"

file_catchup_exclusion :=       dir_project / "catchup_exclusion.txt"
file_plugin_release :=          dir_project_plugin_release / "sl-triggers.dll"
file_tesv_flags :=              dir_project_inc_beth / "TESV_Papyrus_Flags.flg"
file_caprica_exe :=             dir_project_caprica / "Caprica.exe"

file_sl_triggersStatics :=      dir_project_scripts / "sl_triggersStatics.psc"

fomod_filename :=               "SLTriggersRedux-" + version_fomod + ".zip"
file_dep_fomod :=               dir_dep / fomod_filename
mod_filename :=                 "sl_triggers" + version_fomod + ".zip"
file_dep_mod :=                 dir_dep / mod_filename
test_script_filename :=         "sltr_test_scripts" + version_fomod + ".zip"
file_dep_test_scripts :=        dir_dep / test_script_filename
pet_collar_game_filename :=     "sltr_pet_collar_game" + version_pet_collar_game + ".zip"
file_dep_pet_collar_game :=     dir_dep / pet_collar_game_filename
lang_npp_filename :=            "notepad++-sltscript-support.zip"
file_dep_lang_npp :=            dir_dep / lang_npp_filename
lang_vscode_filename :=         "vscode-sltscript-support.zip"
file_dep_lang_vscode :=         dir_dep / lang_vscode_filename

# non-wrapped stringified versions for use in commands
raw_dir_project_src :=          replace(dir_project_src,                '/', '\')
raw_dir_lang_npp :=             replace(dir_lang_notepad_plusplus,      '/', '\')
raw_dir_lang_vscode :=          replace(dir_lang_vscode,                '/', '\')
raw_dir_project_fomod :=        replace(dir_project_fomod,              '/', '\')

raw_dir_fomod_core :=           replace(dir_fomod_core,                 '/', '\')
raw_dir_fomod_ostim :=          replace(dir_fomod_ostim,                '/', '\')
raw_dir_fomod_sexlab :=         replace(dir_fomod_sexlab,               '/', '\')
raw_dir_fomod_sexlabplusplus := replace(dir_fomod_sexlabplusplus,       '/', '\')
raw_dir_fomod_example_trigger := replace(dir_fomod_example_trigger,     '/', '\')
raw_dir_fomod_test_scripts :=   replace(dir_fomod_test_scripts,         '/', '\')
raw_dir_fomod_pet_collar_game := replace(dir_fomod_pet_collar_game,     '/', '\')
raw_dir_fomod_consumption :=    replace(dir_fomod_consumption,          '/', '\')
raw_dir_fomod_sls_wet_license := replace(dir_fomod_sls_wet_license,     '/', '\')

raw_dir_pex_core :=             replace(dir_pexout_core,                '/', '\')
raw_dir_pex_lib_adult_general := replace(dir_pexout_lib_adult_general,  '/', '\')
raw_dir_pex_lib_ostim :=        replace(dir_pexout_lib_ostim,           '/', '\')
raw_dir_pex_lib_sexlab :=       replace(dir_pexout_lib_sexlab,          '/', '\')
raw_dir_pex_lib_sexlabplusplus := replace(dir_pexout_lib_sexlabplusplus,'/', '\')

raw_file_Scripts_md :=          replace(file_docs_Scripts_md,           '/', '\')
raw_file_sltscripts_md :=       replace(file_src_sltscripts_md,         '/', '\')

raw_file_dep_mod :=             replace(file_dep_mod,                   '/', '\')
raw_file_pet_collar_game :=     replace(file_dep_pet_collar_game,       '/', '\')
raw_file_test_scripts :=        replace(file_dep_test_scripts,          '/', '\')
raw_file_lang_npp :=            replace(file_dep_lang_npp,              '/', '\')
raw_file_lang_vscode :=         replace(file_dep_lang_vscode,           '/', '\')
raw_file_dep_fomod :=           replace(file_dep_fomod,                 '/', '\')

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

str_file_Scripts_md :=          replace("\"" + file_docs_Scripts_md + "\"",             '/', '\')
str_file_sltscripts_md :=       replace("\"" + file_src_sltscripts_md + "\"",           '/', '\')

str_file_catchup_exclusion :=   replace("\"" + file_catchup_exclusion + "\"",           '/', '\')
str_file_plugin_release :=      replace("\"" + file_plugin_release + "\"",              '/', '\')
str_file_tesv_flags :=          replace("\"" + file_tesv_flags + "\"",                  '/', '\')
str_file_caprica_exe :=         replace("\"" + file_caprica_exe + "\"",                 '/', '\')

str_file_sl_triggersStatics :=  replace("\"" + file_sl_triggersStatics + "\"",          '/', '\')

str_file_dep_mod :=             replace("\"" + file_dep_mod + "\"",                     '/', '\')
str_file_dep_test_scripts :=    replace("\"" + file_dep_test_scripts + "\"",            '/', '\')
str_file_dep_pet_collar_game := replace("\"" + file_dep_pet_collar_game + "\"",         '/', '\')

fileglob_sltr_test_scripts :=   replace("\"" + dir_sltr_test_scripts / "*.*" + "\"",    '/', '\')

str_dir_addon_pet_collar_game := replace("\"" + dir_pet_collar_game + "\\\"",           '/', '\')
str_dir_addon_sls_wet_license := replace("\"" + dir_sls_wet_license + "\\\"",            '/', '\')
str_dir_addon_consumption :=    replace("\"" + dir_consumption + "\\\"",                '/', '\')
str_dir_addon_test_scripts :=   replace("\"" + dir_test_scripts + "\\\"",               '/', '\')

str_dir_lib_adult_general :=    replace("\"" + dir_lib_adult_general + "\\\"",          '/', '\')
str_dir_lib_example_trigger :=  replace("\"" + dir_lib_example_trigger + "\\\"",        '/', '\')
str_dir_lib_ostim :=            replace("\"" + dir_lib_ostim + "\\\"",                  '/', '\')
str_dir_lib_sexlab :=           replace("\"" + dir_lib_sexlab + "\\\"",                 '/', '\')
str_dir_lib_sexlabplusplus :=   replace("\"" + dir_lib_sexlabplusplus + "\\\"",         '/', '\')
str_dir_lib_sexlab_dependent := replace("\"" + dir_lib_sexlab_dependent + "\\\"",       '/', '\')

str_dir_fomod_core :=           replace("\"" + dir_fomod_core + "\\\"",                 '/', '\')
str_dir_fomod_ostim :=          replace("\"" + dir_fomod_ostim + "\\\"",                '/', '\')
str_dir_fomod_sexlab :=         replace("\"" + dir_fomod_sexlab + "\\\"",               '/', '\')
str_dir_fomod_sexlabplusplus := replace("\"" + dir_fomod_sexlabplusplus + "\\\"",       '/', '\')
str_dir_fomod_example_trigger := replace("\"" + dir_fomod_example_trigger + "\\\"",         '/', '\')
str_dir_fomod_test_scripts :=   replace("\"" + dir_fomod_test_scripts + "\\\"",         '/', '\')
str_dir_fomod_pet_collar_game := replace("\"" + dir_fomod_pet_collar_game + "\\\"",     '/', '\')
str_dir_fomod_consumption :=    replace("\"" + dir_fomod_consumption + "\\\"",          '/', '\')
str_dir_fomod_sls_wet_license := replace("\"" + dir_fomod_sls_wet_license + "\\\"",     '/', '\')

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
    jcx SltParser "./src/sl_triggers_function_library" "SLTriggers Redux Base Function Library" "./src/source/scripts/sl_triggersCmdLibSLT.psc" "./src/source/scripts/sl_triggersCmdLibCore.psc" "./src/source/scripts/sl_triggersCmdLibRacemenuNIO.psc" "./src/source/scripts/sl_triggersCmdLibNFF.psc" "./src/source/scripts/sl_triggersCmdLibBase.psc"
    jcx SltParser "./extern/libraries/ostim/sl_triggers_function_library_ostim" "OStim Function Library" "./extern/libraries/ostim/source/scripts/sl_triggersCmdLibOStim.psc"
    jcx SltParser "./extern/libraries/sexlab/sl_triggers_function_library_sexlab" "SexLab 1.66 Function Library" "./extern/libraries/sexlab/source/scripts/sl_triggersCmdLibSexLab.psc"
    jcx SltParser "./extern/libraries/sexlab-dependent/sl_triggers_function_library_sexlab_dependent" "SexLab Dependent Function Library" "./extern/libraries/sexlab-dependent/source/scripts/sl_triggersCmdLibSexLabDependent.psc"
    jcx SltParser "./extern/libraries/sexlabplusplus/sl_triggers_function_library_sexlab" "SexLab P+ Function Library" "./extern/libraries/sexlabplusplus/source/scripts/sl_triggersCmdLibSexLab.psc"
    jcx SltParser "./extern/libraries/adult-general/sl_triggers_function_library_adult_general" "Adult General Function Library" "./extern/libraries/adult-general/source/scripts/sl_triggersCmdLibOSLAroused.psc" "./extern/libraries/adult-general/source/scripts/sl_triggersCmdLibSLIF.psc"
    xcopy /y {{str_file_Scripts_md}} {{str_file_sltscripts_md}}
    Get-Content "./src/sl_triggers_function_library.md" , "./extern/libraries/sexlabplusplus/sl_triggers_function_library_sexlab.md" , "./extern/libraries/sexlab/sl_triggers_function_library_sexlab.md" , "./extern/libraries/sexlab-dependent/sl_triggers_function_library_sexlab_dependent.md" , "./extern/libraries/ostim/sl_triggers_function_library_ostim.md" , "./extern/libraries/adult-general/sl_triggers_function_library_adult_general.md" | Set-Content "./docs/Function_Libraries.md"

packagefomod:
    powershell.exe -Command "if (Test-Path '{{raw_dir_fomod_core}}') { Remove-Item -Path '{{raw_dir_fomod_core}}' -Recurse }"
    powershell.exe -Command "if (Test-Path '{{raw_dir_fomod_ostim}}') { Remove-Item -Path '{{raw_dir_fomod_ostim}}' -Recurse }"
    powershell.exe -Command "if (Test-Path '{{raw_dir_fomod_sexlab}}') { Remove-Item -Path '{{raw_dir_fomod_sexlab}}' -Recurse }"
    powershell.exe -Command "if (Test-Path '{{raw_dir_fomod_sexlabplusplus}}') { Remove-Item -Path '{{raw_dir_fomod_sexlabplusplus}}' -Recurse }"
    powershell.exe -Command "if (Test-Path '{{raw_dir_fomod_example_trigger}}') { Remove-Item -Path '{{raw_dir_fomod_example_trigger}}' -Recurse }"
    powershell.exe -Command "if (Test-Path '{{raw_dir_fomod_test_scripts}}') { Remove-Item -Path '{{raw_dir_fomod_test_scripts}}' -Recurse }"
    powershell.exe -Command "if (Test-Path '{{raw_dir_fomod_pet_collar_game}}') { Remove-Item -Path '{{raw_dir_fomod_pet_collar_game}}' -Recurse }"
    powershell.exe -Command "if (Test-Path '{{raw_dir_fomod_consumption}}') { Remove-Item -Path '{{raw_dir_fomod_consumption}}' -Recurse }"
    powershell.exe -Command "if (Test-Path '{{raw_dir_fomod_sls_wet_license}}') { Remove-Item -Path '{{raw_dir_fomod_sls_wet_license}}' -Recurse }"
    #Core
    xcopy /e /i /y {{str_dir_project_src}} {{str_dir_fomod_core}}
    #OStim
    xcopy /e /i /y {{str_dir_lib_adult_general}} {{str_dir_fomod_ostim}}
    xcopy /e /i /y {{str_dir_lib_ostim}} {{str_dir_fomod_ostim}}
    #SexLab
    xcopy /e /i /y {{str_dir_lib_adult_general}} {{str_dir_fomod_sexlab}}
    xcopy /e /i /y {{str_dir_lib_sexlab_dependent}} {{str_dir_fomod_sexlab}}
    xcopy /e /i /y {{str_dir_lib_sexlab}} {{str_dir_fomod_sexlab}}
    #SexLab P+
    xcopy /e /i /y {{str_dir_lib_adult_general}} {{str_dir_fomod_sexlabplusplus}}
    xcopy /e /i /y {{str_dir_lib_sexlab_dependent}} {{str_dir_fomod_sexlabplusplus}}
    xcopy /e /i /y {{str_dir_lib_sexlabplusplus}} {{str_dir_fomod_sexlabplusplus}}
    #Example Trigger
    xcopy /e /i /y {{str_dir_lib_example_trigger}} {{str_dir_fomod_example_trigger}}
    #Test Scripts
    xcopy /e /i /y {{str_dir_addon_test_scripts}} {{str_dir_fomod_test_scripts}}
    #PetCollar Game
    xcopy /e /i /y {{str_dir_addon_pet_collar_game}} {{str_dir_fomod_pet_collar_game}}
    #Consumption Lifestyle
    xcopy /e /i /y {{str_dir_addon_consumption}} {{str_dir_fomod_consumption}}
    #SLS Wet License Destruction
    xcopy /e /i /y {{str_dir_addon_sls_wet_license}} {{str_dir_fomod_sls_wet_license}}
    #Build the FOMOD
    powershell.exe -Command "if (Test-Path '{{raw_file_dep_fomod}}') { Remove-Item -Path '{{raw_file_dep_fomod}}' }"
    powershell.exe -Command "Compress-Archive -Path '{{raw_dir_project_fomod}}\\*' -DestinationPath '{{raw_file_dep_fomod}}'"

cleanscripts:
    powershell.exe -Command "if (Test-Path '{{raw_dir_pex_core}}') { Remove-Item -Path '{{raw_dir_pex_core}}' -Recurse }"
    powershell.exe -Command "if (Test-Path '{{raw_dir_pex_lib_adult_general}}') { Remove-Item -Path '{{raw_dir_pex_lib_adult_general}}' -Recurse }"
    powershell.exe -Command "if (Test-Path '{{raw_dir_pex_lib_ostim}}') { Remove-Item -Path '{{raw_dir_pex_lib_ostim}}' -Recurse }"
    powershell.exe -Command "if (Test-Path '{{raw_dir_pex_lib_sexlab}}') { Remove-Item -Path '{{raw_dir_pex_lib_sexlab}}' -Recurse }"
    powershell.exe -Command "if (Test-Path '{{raw_dir_pex_lib_sexlabplusplus}}') { Remove-Item -Path '{{raw_dir_pex_lib_sexlabplusplus}}' -Recurse }"

# More targeted replacement (safer - targets specifically the GetModVersion function)
update-version-safe:
    @echo "Updating version to {{version_mod}} in sl_triggersStatics.psc"
    powershell.exe -File update-version.ps1 -ScriptPath "{{file_sl_triggersStatics}}" -InfoXmlPath "{{file_fomod_info_xml}}" -NewVersion "{{version_mod}}" -NewFomodVersion "{{version_fomod}}"

_package_preclean:
    powershell.exe -File clean-deps.ps1 -dir_dep "{{dir_dep}}"

packagemodonly: 
    powershell.exe -Command "if (Test-Path '{{raw_file_dep_mod}}') { Remove-Item -Path '{{raw_file_dep_mod}}' }"
    powershell.exe -Command "Compress-Archive -Path '{{raw_dir_project_src}}\\*' -DestinationPath '{{raw_file_dep_mod}}'"

packagelang:
    powershell.exe -Command "Compress-Archive -Path '{{raw_dir_lang_npp}}\\*' -DestinationPath '{{raw_file_lang_npp}}'"
    powershell.exe -Command "Compress-Archive -Path '{{raw_dir_lang_vscode}}\\*' -DestinationPath '{{raw_file_lang_vscode}}'"

packageall: _package_preclean packagefomod packagelang
    @echo "Packaging all"
