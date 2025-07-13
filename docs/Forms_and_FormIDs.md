# Forms and FormIDs

## Overview

Anywhere you must provide a Form value, you can either provide a variable that is or has been set to a Form value or you may use a FormID string. You may also use an int, float, or string value provided it can be cast to an int representing the actual FormID. Note that in such cases (i.e. using an int), this represents an absolute FormID, not relative, and will be dependent on load order.

You can also assign a Form to a variable and it will be stored and can be retrieved later. Comparisons between Forms should work for equality checks.

## Valid FormID Strings
The following are valid formats for a FormID string, with examples:

<table>
<thead valign="top">
<tr><th>Format</th><th>Syntax</th><th>Examples</th></tr>
</thead>
<tbody valign="top" align="left">
<tr>
    <td>Numeric</td>
    <td>&lt;decimal number&gt;<br>&lt;0x hex number&gt;</td>
    <td>
    <i>These are load order dependent, because they are absolute integer values, not relative.<br>
    For purposes of demonstration below, Skyrim is at index 0x00, SexLab at index 0x10, and SLTR at index 0xFF00F.</i><br>
    <br>
    e.g. Septim<br>
    15<br>
    0xf<br>
    e.g. SLTR Main Quest (ESL-ified)<br>
    4278253631<br>
    0xFF00F83F<br>
    e.g. SexLabFramework Quest (ESM flagged)<br>
    268438882<br>
    0x10000D62
    </td>
</tr>
<tr>
    <td rowspan="2">FormID Strings
    </td>
    <td>
    Pipe-Delimited<br>
    "&lt;decimal number&gt;|&lt;modname&gt;"<br>
    "&lt;0x hex number&gt;|&lt;modname&gt;"
    </td>
    <td>
    e.g. Septim<br>
    "15|Skyrim.esm"<br>
    "0xf|Skyrim.esm"<br>
    e.g. SLTR Main Quest (ESL-ified)<br>
    "2111|sl_triggers.esp"<br>
    "0x83f|sl_triggers.esp"<br>
    e.g. SexLabFramework Quest (ESM flagged)<br>
    "3426|SexLab.esm"<br>
    "0xd62|SexLab.esm"
    </td>
</tr>
<tr>
    <td>
    Colon-Delimited<br>
    "&lt;modname&gt;:&lt;decimal number&gt;"<br>
    "&lt;modname&gt;:&lt;0x hex number&gt;"
    </td>
    <td>
    e.g. Septim<br>
    "Skyrim.esm:15"<br>
    "Skyrim.esm:0xf"<br>
    e.g. SLTR Main Quest (ESL-ified)<br>
    "sl_triggers.esp:2111"<br>
    "sl_triggers.esp:0x83f"<br>
    e.g. SexLabFramework Quest (ESM flagged)<br>
    "SexLab.esm:3426"<br>
    "SexLab.esm:0xd62"
    </td>
</tr>
</tbody>
</table>

