Scriptname sl_triggersCommandLine Hidden

; CommandLine - container for an execution-relevant line of SLTScript
; Contains line number and parsed tokens for script execution

; Factory functions - return handle to CommandLine object
int function CreateEmpty() global native
int function CreateNew(int lineNumber, string[] tokens) global native

; Line number management
int function GetLineNumber(int handle) global native
function SetLineNumber(int handle, int lineNumber) global native

; Token management  
string[] function GetTokens(int handle) global native
function SetTokens(int handle, string[] tokens) global native

; Utility functions
function Destroy(int handle) global native

; Helper functions
bool function IsValid(int handle) global
    return sl_triggersForgeObject.IsValidHandle(handle)
endFunction

; Get token count
int function GetTokenCount(int handle) global
    string[] tokens = GetTokens(handle)
    if tokens
        return tokens.length
    endif
    return 0
endFunction

; Get specific token by index
string function GetToken(int handle, int index) global
    string[] tokens = GetTokens(handle)
    if tokens && index >= 0 && index < tokens.length
        return tokens[index]
    endif
    return ""
endFunction

; Add token to existing tokens
function AddToken(int handle, string token) global
    string[] currentTokens = GetTokens(handle)
    string[] newTokens
    
    if currentTokens
        newTokens = PapyrusUtil.StringArray(currentTokens.length + 1)
        int i = 0
        while i < currentTokens.length
            newTokens[i] = currentTokens[i]
            i += 1
        endwhile
        newTokens[currentTokens.length] = token
    else
        newTokens = new string[1]
        newTokens[0] = token
    endif
    
    SetTokens(handle, newTokens)
endFunction