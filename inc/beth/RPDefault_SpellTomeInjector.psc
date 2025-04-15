scriptname rpdefault_spelltomeinjector extends quest
int property ispelllevel_novice = 1 autoreadonly
int property ispelllevel_apprentice = 2 autoreadonly
int property ispelllevel_adept = 3 autoreadonly
int property ispelllevel_expert = 4 autoreadonly
int property ispelllevel_master = 5 autoreadonly
int property ispellschool_alteration = 1 autoreadonly
int property ispellschool_conjuration = 2 autoreadonly
int property ispellschool_destruction = 3 autoreadonly
int property ispellschool_illusion = 4 autoreadonly
int property ispellschool_restoration = 5 autoreadonly
leveleditem property litemspelltomes00allalteration auto
leveleditem property litemspelltomes00alteration auto
leveleditem property litemspelltomes00allconjuration auto
leveleditem property litemspelltomes00conjuration auto
leveleditem property litemspelltomes00alldestruction auto
leveleditem property litemspelltomes00destruction auto
leveleditem property litemspelltomes00allillusion auto
leveleditem property litemspelltomes00illusion auto
leveleditem property litemspelltomes00allrestoration auto
leveleditem property litemspelltomes00restoration auto
leveleditem property litemspelltomes00allspells auto
leveleditem property litemspelltomes00spells auto
leveleditem property litemspelltomes25allalteration auto
leveleditem property litemspelltomes25alteration auto
leveleditem property litemspelltomes25allconjuration auto
leveleditem property litemspelltomes25conjuration auto
leveleditem property litemspelltomes25alldestruction auto
leveleditem property litemspelltomes25destruction auto
leveleditem property litemspelltomes25allillusion auto
leveleditem property litemspelltomes25illusion auto
leveleditem property litemspelltomes25allrestoration auto
leveleditem property litemspelltomes25restoration auto
leveleditem property litemspelltomes25allspells auto
leveleditem property litemspelltomes25spells auto
leveleditem property litemspelltomes50allalteration auto
leveleditem property litemspelltomes50alteration auto
leveleditem property litemspelltomes50allconjuration auto
leveleditem property litemspelltomes50conjuration auto
leveleditem property litemspelltomes50alldestruction auto
leveleditem property litemspelltomes50destruction auto
leveleditem property litemspelltomes50allillusion auto
leveleditem property litemspelltomes50illusion auto
leveleditem property litemspelltomes50allrestoration auto
leveleditem property litemspelltomes50restoration auto
leveleditem property litemspelltomes50spells auto ; only 1 of these lists for adept
leveleditem property litemspelltomes75allalteration auto
leveleditem property litemspelltomes75alteration auto
leveleditem property litemspelltomes75allconjuration auto
leveleditem property litemspelltomes75conjuration auto
leveleditem property litemspelltomes75alldestruction auto
leveleditem property litemspelltomes75destruction auto
leveleditem property litemspelltomes75allillusion auto
leveleditem property litemspelltomes75illusion auto
leveleditem property litemspelltomes75allrestoration auto
leveleditem property litemspelltomes75restoration auto
leveleditem property litemspelltomes75spells auto ; only 1 of these lists for expert
leveleditem property litemspelltomes100alteration auto
leveleditem property mgritualalterationbooks auto
leveleditem property litemspelltomes100conjuration auto
leveleditem property mgritualconjurationbooks auto
leveleditem property litemspelltomes100destruction auto
leveleditem property mgritualdestructionbooks auto
leveleditem property litemspelltomes100illusion auto
leveleditem property mgritualillusionbooks auto
leveleditem property litemspelltomes100restoration auto
leveleditem property mgritualrestorationbooks auto
function injecttomes(book[] atomestoinject, int[] aispellschool, int[] aispelllevel, int[] aiinjectlevel = none, int[] aiinjectcount = none)
endfunction
function injecttome(book atometoinject, int aispellschool, int aispelllevel, int aiinjectlevel = 1, int aiinjectcount = 1)
endfunction
leveleditem[] function _getspelltomeleveledlists(int aispellschool, int aispelllevel)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1