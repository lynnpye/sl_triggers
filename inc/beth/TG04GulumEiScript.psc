scriptname tg04gulumeiscript extends referencealias  conditional
tg04questscript property ptg04qs  auto  conditional
scene property ptg04scene  auto  conditional
scene property ptg04alertscene auto conditional
quest property ptg04quest auto
objectreference property pkillchest auto
objectreference property pdoortobrinewater auto
referencealias property pdeedalias auto
referencealias property pkillnotealias auto
int property pgulumdeathsetup auto
event onupdate()
endevent
event ondying(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1