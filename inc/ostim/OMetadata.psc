scriptname ometadata
string function getname(string id) global native
string[] function scenestonames(string[] ids) global native
bool function istransition(string id) global native
int function getdefaultspeed(string id) global native
int function getmaxspeed(string id) global native
int function getactorcount(string id) global native
string function getanimationid(string id, int index) global native
bool function hasrequirement(string id, int position, string requirement) global native
bool function hasanyrequirement(string id, int position, string[] requirements) global native
bool function hasanyrequirementcsv(string id, int position, string requirements) global native
bool function hasallrequirements(string id, int position, string[] requirements) global native
bool function hasallrequirementscsv(string id, int position, string requirements) global native
string function getautotransitionforactor(string id, int position, string type) global native
string[] function getscenetags(string id) global native
bool function hasscenetag(string id, string tag) global native
bool function hasanyscenetag(string id, string[] tags) global native
bool function hasanyscenetagcsv(string id, string tags) global native
bool function hasallscenetags(string id, string[] tags) global native
bool function hasallscenetagscsv(string id, string tags) global native
string[] function getscenetagoverlap(string id, string[] tags) global native
string[] function getscenetagoverlapcsv(string id, string tags) global native
string[] function getactortags(string id, int position) global native
bool function hasactortag(string id, int position, string tag) global native
bool function hasanyactortag(string id, int position, string[] tags) global native
bool function hasanyactortagcsv(string id, int position, string tags) global native
bool function hasallactortags(string id, int position, string[] tags) global native
bool function hasallactortagscsv(string id, int position, string tags) global native
string[] function getactortagoverlap(string id, int position, string[] tags) global native
string[] function getactortagoverlapcsv(string id, int position, string tags) global native
bool function hasactions(string id) global native
int function findaction(string id, string type) global native
int function findanyaction(string id, string[] types) global native
int function findanyactioncsv(string id, string types) global native
int[] function findactions(string id, string type) global native
int[] function findallactions(string id, string[] types) global native
int[] function findallactionscsv(string id, string types) global native
int function findactionforactor(string id, int position, string type) global native
int function findanyactionforactor(string id, int position, string[] types) global native
int function findanyactionforactorcsv(string id, int position, string types) global native
int[] function findactionsforactor(string id, int position, string type) global native
int[] function findallactionsforactor(string id, int position, string[] types) global native
int[] function findallactionsforactorcsv(string id, int position, string types) global native
int function findactionforactors(string id, int[] positions, string type) global native
int function findactionforactorscsv(string id, string positions, string type) global native
int function findanyactionforactors(string id, int[] positions, string[] types) global native
int function findanyactionforactorscsv(string id, string positions, string types) global native
int[] function findactionsforactors(string id, int[] positions, string type) global native
int[] function findactionsforactorscsv(string id, string positions, string type) global native
int[] function findallactionsforactors(string id, int[] positions, string[] types) global native
int[] function findallactionsforactorscsv(string id, string positions, string types) global native
int function findactionfortarget(string id, int position, string type) global native
int function findanyactionfortarget(string id, int position, string[] types) global native
int function findanyactionfortargetcsv(string id, int position, string types) global native
int[] function findactionsfortarget(string id, int position, string type) global native
int[] function findallactionsfortarget(string id, int position, string[] types) global native
int[] function findallactionsfortargetcsv(string id, int position, string types) global native
int function findactionfortargets(string id, int[] positions, string type) global native
int function findactionfortargetscsv(string id, string positions, string type) global native
int function findanyactionfortargets(string id, int[] positions, string[] types) global native
int function findanyactionfortargetscsv(string id, string positions, string types) global native
int[] function findactionsfortargets(string id, int[] positions, string type) global native
int[] function findactionsfortargetscsv(string id, string positions, string type) global native
int[] function findallactionsfortargets(string id, int[] positions, string[] types) global native
int[] function findallactionsfortargetscsv(string id, string positions, string types) global native
int function findactionforperformer(string id, int position, string type) global native
int function findanyactionforperformer(string id, int position, string[] types) global native
int function findanyactionforperformercsv(string id, int position, string types) global native
int[] function findactionsforperformer(string id, int position, string type) global native
int[] function findallactionsforperformer(string id, int position, string[] types) global native
int[] function findallactionsforperformercsv(string id, int position, string types) global native
int function findactionforperformers(string id, int[] positions, string type) global native
int function findactionforperformerscsv(string id, string positions, string type) global native
int function findanyactionforperformers(string id, int[] positions, string[] types) global native
int function findanyactionforperformerscsv(string id, string positions, string types) global native
int[] function findactionsforperformers(string id, int[] positions, string type) global native
int[] function findactionsforperformerscsv(string id, string positions, string type) global native
int[] function findallactionsforperformers(string id, int[] positions, string[] types) global native
int[] function findallactionsforperformerscsv(string id, string positions, string types) global native
int function findactionforactorandtarget(string id, int actorposition, int targetposition, string type) global native
int function findanyactionforactorandtarget(string id, int actorposition, int targetposition, string[] types) global native
int function findanyactionforactorandtargetcsv(string id, int actorposition, int targetposition, string types) global native
int[] function findactionsforactorandtarget(string id, int actorposition, int targetposition, string type) global native
int[] function findallactionsforactorandtarget(string id, int actorposition, int targetposition, string[] types) global native
int[] function findallactionsforactorandtargetcsv(string id, int actorposition, int targetposition, string types) global native
int function findactionforactorsandtargets(string id, int[] actorpositions, int[] targetpositions, string type) global native
int function findactionforactorsandtargetscsv(string id, string actorpositions, string targetpositions, string type) global native
int function findanyactionforactorsandtargets(string id, int[] actorpositions, int[] targetpositions, string[] types) global native
int function findanyactionforactorsandtargetscsv(string id, string actorpositions, string targetpositions, string types) global native
int[] function findactionsforactorsandtargets(string id, int[] actorpositions, int[] targetpositions, string type) global native
int[] function findactionsforactorsandtargetscsv(string id, string actorpositions, string targetpositions, string type) global native
int[] function findallactionsforactorsandtargets(string id, int[] actorpositions, int[] targetpositions, string[] types) global native
int[] function findallactionsforactorsandtargetscsv(string id, string actorpositions, string targetpositions, string types) global native
int function findactionformate(string id, int position, string type) global native
int function findanyactionformate(string id, int position, string[] types) global native
int function findanyactionformatecsv(string id, int position, string types) global native
int[] function findactionsformate(string id, int position, string type) global native
int[] function findallactionsformate(string id, int position, string[] types) global native
int[] function findallactionsformatecsv(string id, int position, string types) global native
int function findactionformatesany(string id, int[] positions, string type) global native
int function findactionformatesanycsv(string id, string positions, string type) global native
int function findanyactionformatesany(string id, int[] positions, string[] types) global native
int function findanyactionformatesanycsv(string id, string positions, string types) global native
int[] function findactionsformatesany(string id, int[] positions, string type) global native
int[] function findactionsformatesanycsv(string id, string positions, string type) global native
int[] function findallactionsformatesany(string id, int[] positions, string[] types) global native
int[] function findallactionsformatesanycsv(string id, string positions, string types) global native
int function findactionformatesall(string id, int[] positions, string type) global native
int function findactionformatesallcsv(string id, string positions, string type) global native
int function findanyactionformatesall(string id, int[] positions, string[] types) global native
int function findanyactionformatesallcsv(string id, string positions, string types) global native
int[] function findactionsformatesall(string id, int[] positions, string type) global native
int[] function findactionsformatesallcsv(string id, string positions, string type) global native
int[] function findallactionsformatesall(string id, int[] positions, string[] types) global native
int[] function findallactionsformatesallcsv(string id, string positions, string types) global native
int function findactionforparticipant(string id, int position, string type) global native
int function findanyactionforparticipant(string id, int position, string[] types) global native
int function findanyactionforparticipantcsv(string id, int position, string types) global native
int[] function findactionsforparticipant(string id, int position, string type) global native
int[] function findallactionsforparticipant(string id, int position, string[] types) global native
int[] function findallactionsforparticipantcsv(string id, int position, string types) global native
int function findactionforparticipantsany(string id, int[] positions, string type) global native
int function findactionforparticipantsanycsv(string id, string positions, string type) global native
int function findanyactionforparticipantsany(string id, int[] positions, string[] types) global native
int function findanyactionforparticipantsanycsv(string id, string positions, string types) global native
int[] function findactionsforparticipantsany(string id, int[] positions, string type) global native
int[] function findactionsforparticipantsanycsv(string id, string positions, string type) global native
int[] function findallactionsforparticipantsany(string id, int[] positions, string[] types) global native
int[] function findallactionsforparticipantsanycsv(string id, string positions, string types) global native
int function findactionforparticipantsall(string id, int[] positions, string type) global native
int function findactionforparticipantsallcsv(string id, string positions, string type) global native
int function findanyactionforparticipantsall(string id, int[] positions, string[] types) global native
int function findanyactionforparticipantsallcsv(string id, string positions, string types) global native
int[] function findactionsforparticipantsall(string id, int[] positions, string type) global native
int[] function findactionsforparticipantsallcsv(string id, string positions, string type) global native
int[] function findallactionsforparticipantsall(string id, int[] positions, string[] types) global native
int[] function findallactionsforparticipantsallcsv(string id, string positions, string types) global native
int function findactionsuperloadcsvv2(string id, string actorpositions = "", string targetpositions = "", string performerpositions = "", string matepositionsany = "", string matepositionsall = "", string participantpositionsany = "", string participantpositionsall = "", string types = "", string anyactiontag = "", string allactiontags = "", string actiontagwhitelist = "", string actiontagblacklist = "", string anycustomintrecord = "", string allcustomintrecords = "", string anycustomfloatrecord = "", string allcustomfloatrecords = "", string anycustomstringrecord = "", string allcustomstringrecords = "", string anycustomintlistrecord = "", string allcustomintlistrecords = "", string anycustomfloatlistrecord = "", string allcustomfloatlistrecords = "", string anycustomstringlistrecord = "", string allcustomstringlistrecords = "") global native
int[] function findactionssuperloadcsvv2(string id, string actorpositions = "", string targetpositions = "", string performerpositions = "", string matepositionsany = "", string matepositionsall = "", string participantpositionsany = "", string participantpositionsall = "", string types = "", string anyactiontag = "", string allactiontags = "", string actiontagwhitelist = "", string actiontagblacklist = "", string anycustomintrecord = "", string allcustomintrecords = "", string anycustomfloatrecord = "", string allcustomfloatrecords = "", string anycustomstringrecord = "", string allcustomstringrecords = "", string anycustomintlistrecord = "", string allcustomintlistrecords = "", string anycustomfloatlistrecord = "", string allcustomfloatlistrecords = "", string anycustomstringlistrecord = "", string allcustomstringlistrecords = "") global native
string[] function getactiontypes(string id) global native
string function getactiontype(string id, int index) global native
int[] function getactionactors(string id) global native
int function getactionactor(string id, int index) global native
int[] function getactiontargets(string id) global native
int function getactiontarget(string id, int index) global native
int[] function getactionperformers(string id) global native
int function getactionperformer(string id, int index) global native
string[] function getactiontags(string id, int index) global native
string[] function getallactionstags(string id) global native
bool function hasactiontag(string id, int index, string tag) global native
bool function hasactiontagonany(string id, string tag) global native
bool function hasanyactiontag(string id, int index, string[] tags) global native
bool function hasanyactiontagcsv(string id, int index, string tags) global native
bool function hasanyactiontagonany(string id, string[] tags) global native
bool function hasanyactiontagonanycsv(string id, string tags) global native
bool function hasallactiontags(string id, int index, string[] tags) global native
bool function hasallactiontagscsv(string id, int index, string tags) global native
bool function hasallactiontagsonany(string id, string[] tags) global native
bool function hasallactiontagsonanycsv(string id, string tags) global native
bool function hasallactiontagsoverall(string id, string[] tags) global native
bool function hasallactiontagsoverallcsv(string id, string tags) global native
string[] function getactiontagoverlap(string id, int index, string[] tags) global native
string[] function getactiontagoverlapcsv(string id, int index, string tags) global native
string[] function getactiontagoverlapoverall(string id, string[] tags) global native
string[] function getactiontagoverlapoverallcsv(string id, string tags) global native
bool function hascustomactionactorint(string id, int index, string record) global native
int function getcustomactionactorint(string id, int index, string record, int fallback = 0) global native
bool function iscustomactionactorint(string id, int index, string record, int value) global native
bool function hascustomactionactorfloat(string id, int index, string record) global native
float function getcustomactionactorfloat(string id, int index, string record, float fallback = 0.0) global native
bool function iscustomactionactorfloat(string id, int index, string record, float value) global native
bool function hascustomactionactorstring(string id, int index, string record) global native
string function getcustomactionactorstring(string id, int index, string record, string fallback = "") global native
bool function iscustomactionactorstring(string id, int index, string record, string value) global native
bool function hascustomactionactorintlist(string id, int index, string record) global native
int[] function getcustomactionactorintlist(string id, int index, string record) global native
bool function customactionactorintlistcontains(string id, int index, string record, int value) global native
bool function customactionactorintlistcontainsany(string id, int index, string record, int[] values) global native
bool function customactionactorintlistcontainsanycsv(string id, int index, string record, string values) global native
bool function customactionactorintlistcontainsall(string id, int index, string record, int[] values) global native
bool function customactionactorintlistcontainsallcsv(string id, int index, string record, string values) global native
int[] function getcustomactionactorintlistoverlap(string id, int index, string record, int[] values) global native
int[] function getcustomactionactorintlistoverlapcsv(string id, int index, string record, string values) global native
bool function hascustomactionactorfloatlist(string id, int index, string record) global native
float[] function getcustomactionactorfloatlist(string id, int index, string record) global native
bool function customactionactorfloatlistcontains(string id, int index, string record, float value) global native
bool function customactionactorfloatlistcontainsany(string id, int index, string record, float[] values) global native
bool function customactionactorfloatlistcontainsanycsv(string id, int index, string record, string values) global native
bool function customactionactorfloatlistcontainsall(string id, int index, string record, float[] values) global native
bool function customactionactorfloatlistcontainsallcsv(string id, int index, string record, string values) global native
float[] function getcustomactionactorfloatlistoverlap(string id, int index, string record, float[] values) global native
float[] function getcustomactionactorfloatlistoverlapcsv(string id, int index, string record, string values) global native
bool function hascustomactionactorstringlist(string id, int index, string record) global native
string[] function getcustomactionactorstringlist(string id, int index, string record) global native
bool function customactionactorstringlistcontains(string id, int index, string record, string value) global native
bool function customactionactorstringlistcontainsany(string id, int index, string record, string[] values) global native
bool function customactionactorstringlistcontainsanycsv(string id, int index, string record, string values) global native
bool function customactionactorstringlistcontainsall(string id, int index, string record, string[] values) global native
bool function customactionactorstringlistcontainsallcsv(string id, int index, string record, string values) global native
string[] function getcustomactionactorstringlistoverlap(string id, int index, string record, string[] values) global native
string[] function getcustomactionactorstringlistoverlapcsv(string id, int index, string record, string values) global native
bool function hascustomactiontargetint(string id, int index, string record) global native
int function getcustomactiontargetint(string id, int index, string record, int fallback = 0) global native
bool function iscustomactiontargetint(string id, int index, string record, int value) global native
bool function hascustomactiontargetfloat(string id, int index, string record) global native
float function getcustomactiontargetfloat(string id, int index, string record, float fallback = 0.0) global native
bool function iscustomactiontargetfloat(string id, int index, string record, float value) global native
bool function hascustomactiontargetstring(string id, int index, string record) global native
string function getcustomactiontargetstring(string id, int index, string record, string fallback = "") global native
bool function iscustomactiontargetstring(string id, int index, string record, string value) global native
bool function hascustomactiontargetintlist(string id, int index, string record) global native
int[] function getcustomactiontargetintlist(string id, int index, string record) global native
bool function customactiontargetintlistcontains(string id, int index, string record, int value) global native
bool function customactiontargetintlistcontainsany(string id, int index, string record, int[] values) global native
bool function customactiontargetintlistcontainsanycsv(string id, int index, string record, string values) global native
bool function customactiontargetintlistcontainsall(string id, int index, string record, int[] values) global native
bool function customactiontargetintlistcontainsallcsv(string id, int index, string record, string values) global native
int[] function getcustomactiontargetintlistoverlap(string id, int index, string record, int[] values) global native
int[] function getcustomactiontargetintlistoverlapcsv(string id, int index, string record, string values) global native
bool function hascustomactiontargetfloatlist(string id, int index, string record) global native
float[] function getcustomactiontargetfloatlist(string id, int index, string record) global native
bool function customactiontargetfloatlistcontains(string id, int index, string record, float value) global native
bool function customactiontargetfloatlistcontainsany(string id, int index, string record, float[] values) global native
bool function customactiontargetfloatlistcontainsanycsv(string id, int index, string record, string values) global native
bool function customactiontargetfloatlistcontainsall(string id, int index, string record, float[] values) global native
bool function customactiontargetfloatlistcontainsallcsv(string id, int index, string record, string values) global native
float[] function getcustomactiontargetfloatlistoverlap(string id, int index, string record, float[] values) global native
float[] function getcustomactiontargetfloatlistoverlapcsv(string id, int index, string record, string values) global native
bool function hascustomactiontargetstringlist(string id, int index, string record) global native
string[] function getcustomactiontargetstringlist(string id, int index, string record) global native
bool function customactiontargetstringlistcontains(string id, int index, string record, string value) global native
bool function customactiontargetstringlistcontainsany(string id, int index, string record, string[] values) global native
bool function customactiontargetstringlistcontainsanycsv(string id, int index, string record, string values) global native
bool function customactiontargetstringlistcontainsall(string id, int index, string record, string[] values) global native
bool function customactiontargetstringlistcontainsallcsv(string id, int index, string record, string values) global native
string[] function getcustomactiontargetstringlistoverlap(string id, int index, string record, string[] values) global native
string[] function getcustomactiontargetstringlistoverlapcsv(string id, int index, string record, string values) global native
bool function hascustomactionperformerint(string id, int index, string record) global native
int function getcustomactionperformerint(string id, int index, string record, int fallback = 0) global native
bool function iscustomactionperformerint(string id, int index, string record, int value) global native
bool function hascustomactionperformerfloat(string id, int index, string record) global native
float function getcustomactionperformerfloat(string id, int index, string record, float fallback = 0.0) global native
bool function iscustomactionperformerfloat(string id, int index, string record, float value) global native
bool function hascustomactionperformerstring(string id, int index, string record) global native
string function getcustomactionperformerstring(string id, int index, string record, string fallback = "") global native
bool function iscustomactionperformerstring(string id, int index, string record, string value) global native
bool function hascustomactionperformerintlist(string id, int index, string record) global native
int[] function getcustomactionperformerintlist(string id, int index, string record) global native
bool function customactionperformerintlistcontains(string id, int index, string record, int value) global native
bool function customactionperformerintlistcontainsany(string id, int index, string record, int[] values) global native
bool function customactionperformerintlistcontainsanycsv(string id, int index, string record, string values) global native
bool function customactionperformerintlistcontainsall(string id, int index, string record, int[] values) global native
bool function customactionperformerintlistcontainsallcsv(string id, int index, string record, string values) global native
int[] function getcustomactionperformerintlistoverlap(string id, int index, string record, int[] values) global native
int[] function getcustomactionperformerintlistoverlapcsv(string id, int index, string record, string values) global native
bool function hascustomactionperformerfloatlist(string id, int index, string record) global native
float[] function getcustomactionperformerfloatlist(string id, int index, string record) global native
bool function customactionperformerfloatlistcontains(string id, int index, string record, float value) global native
bool function customactionperformerfloatlistcontainsany(string id, int index, string record, float[] values) global native
bool function customactionperformerfloatlistcontainsanycsv(string id, int index, string record, string values) global native
bool function customactionperformerfloatlistcontainsall(string id, int index, string record, float[] values) global native
bool function customactionperformerfloatlistcontainsallcsv(string id, int index, string record, string values) global native
float[] function getcustomactionperformerfloatlistoverlap(string id, int index, string record, float[] values) global native
float[] function getcustomactionperformerfloatlistoverlapcsv(string id, int index, string record, string values) global native
bool function hascustomactionperformerstringlist(string id, int index, string record) global native
string[] function getcustomactionperformerstringlist(string id, int index, string record) global native
bool function customactionperformerstringlistcontains(string id, int index, string record, string value) global native
bool function customactionperformerstringlistcontainsany(string id, int index, string record, string[] values) global native
bool function customactionperformerstringlistcontainsanycsv(string id, int index, string record, string values) global native
bool function customactionperformerstringlistcontainsall(string id, int index, string record, string[] values) global native
bool function customactionperformerstringlistcontainsallcsv(string id, int index, string record, string values) global native
string[] function getcustomactionperformerstringlistoverlap(string id, int index, string record, string[] values) global native
string[] function getcustomactionperformerstringlistoverlapcsv(string id, int index, string record, string values) global native
int function getcustomsceneactorintmin(string id, int position, string record, int fallback = 0) global native
int function getcustomsceneactorintmax(string id, int position, string record, int fallback = 0) global native
int function getcustomsceneactorintsum(string id, int position, string record, int startvalue = 0) global native
int function getcustomsceneactorintproduct(string id, int position, string record, int startvalue = 1) global native
float function getcustomsceneactorfloatmin(string id, int position, string record, float fallback = 0.0) global native
float function getcustomsceneactorfloatmax(string id, int position, string record, float fallback = 0.0) global native
float function getcustomsceneactorfloatsum(string id, int position, string record, float startvalue = 0.0) global native
float function getcustomsceneactorfloatproduct(string id, int position, string record, float startvalue = 1.0) global native
int function findactionsuperloadcsv(string id, string actorpositions = "", string targetpositions = "", string performerpositions = "", string matepositionsany = "", string matepositionsall = "", string participantpositionsany = "", string participantpositionsall = "", string types = "")
endfunction
int[] function findactionssuperloadcsv(string id, string actorpositions = "", string targetpositions = "", string performerpositions = "", string matepositionsany = "", string matepositionsall = "", string participantpositionsany = "", string participantpositionsall = "", string types = "")
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1