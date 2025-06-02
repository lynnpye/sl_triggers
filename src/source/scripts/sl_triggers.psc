scriptname sl_triggers Hidden

Function SetLibrariesForExtensionAllowed(string _extensionKey, bool _allowed) global native

bool Function PrepareContextForTargetedScript(Actor _targetActor, string _scriptname) global native

int Function GetActiveScriptCount() global native

int Function GetSessionId() global native

bool Function IsLoaded() global native

string Function GetTranslatedString(string _translationKey) global native

string[] Function Tokenize(string _tokenString) global native

bool Function DeleteTrigger(string _extensionKey, string _triggerKey) global native

Form Function GetForm(string someFormOfFormIdentification) global native

bool Function SmartEquals(string a, string b) global native

Function WalkTheStack() global native

Function Pung() global native

bool Function ExecuteAndPending() global native

Function CleanupThreadContext() global native

string Function ResolveValueVariable(string variableName) global native

Form Function ResolveFormVariable(string variableName) global native

string[] Function GetScriptsList() global native

string[] Function GetTriggerKeys(string extensionKey) global native