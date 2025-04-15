scriptname sl_triggersMCMSetup extends SKI_ConfigBase

;/
The order you call these in is the order they will be displayed in the MCM
/;

; DescribeSliderAttribute
; Tells setup to render the attribute via a Slider
; _formatString is optional
; _ptype accepted values: PTYPE_INT, PTYPE_FLOAT
Function DescribeSliderAttribute(string _extensionKey, string _attributeName, int _ptype, string _label, float _minValue, float _maxValue, float _interval, string _formatString = "", float _defaultValue = 0.0)
EndFunction

; DescribeMenuAttribute
; Tells setup to render the attribute via a menu
; _ptype accepted values: PTYPE_INT, PTYPE_STRING
Function DescribeMenuAttribute(string _extensionKey, string _attributeName, int _ptype, string _label, int _defaultIndex, string[] _menuSelections)
EndFunction

; DescribeKeymapAttribute
; Tells setup to render the attribute via a keymap
; _ptype accepted values: PTYPE_INT
Function DescribeKeymapAttribute(string _extensionKey, string _attributeName, int _ptype, string _label, int _defaultValue = -1)
EndFunction

; DescribeToggleAttribute
; Tells setup to render the attribute via a toggle
; _ptype accepted values: PTYPE_INT
Function DescribeToggleAttribute(string _extensionKey, string _attributeName, int _ptype, string _label, int _defaultValue = 0)
EndFunction

; DescribeInputAttribute
; Tells setup to render the attribute via an input
; _ptype accepted values: Any
Function DescribeInputAttribute(string _extensionKey, string _attributeName, int _ptype, string _label, string _defaultValue = "")
EndFunction

; AddCommandList
; Tells setup to render a dropdown list of available commands.
; You can call this multiple times to add the option of running
; multiple commands from the same trigger (i.e. 3 was legacy setting)
Function AddCommandList(string _extensionKey, string _attributeName, string _label)
EndFunction

; SetTriggers
; Tells setup the triggerKeys specific to your extension.
; Overwrites any previous values.
bool Function SetTriggers(string _extensionKey, string[] _triggerKeys)
EndFunction