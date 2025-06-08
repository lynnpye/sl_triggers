scriptname sl_triggers_internal Hidden

; latent (yields like Utility.Wait())
bool Function       ExecuteAndPending() global native ; hah... no... you're serious?

Function            CleanupThreadContext() global native ; move along
bool Function       DeleteTrigger(string _extensionKey, string _triggerKey) global native ; I strongly advise against it
string[] Function   GetTriggerKeys(string extensionKey) global native ; I would pass
Function            PauseExecution(string reason) global native ; please... just... no
bool Function       PrepareContextForTargetedScript(Actor _targetActor, string _scriptname) global native ; also not likely for you
Function            Pung() global native ; not for external application
Function            RegisterExtension(Quest extensionQuest) global native ; only for extensions of sl_triggersExtension
Form Function       ResolveFormVariable(string variableName) global native ; nope, not this one either
string Function     ResolveValueVariable(string variableName) global native ; colder
Function            ResumeExecution() global native ; nah
Function            SetCustomResolveFormResult(int threadContextHandle, Form resultingForm) global native ; these are not the functions you are looking for
Function            SetLibrariesForExtensionAllowed(string _extensionKey, bool _allowed) global native ; please don't
Function            WalkTheStack() global native ; I mean... it won't do what you think it will