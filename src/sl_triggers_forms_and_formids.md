# Forms and FormIDs

## Overview

Anywhere you must provide a Form value, you can either provide a variable that is or has been set to a Form value or you may use a FormID string. You may also use an int, float, or string value provided it can be cast to an int representing the actual FormID. Note that in such cases (i.e. using an int), this represents an absolute FormID, not relative, and will be dependent on load order.

You can also assign a Form to a variable and it will be stored and can be retrieved later. Comparisons between Forms should work for equality checks.

## Obtaining a Relative FormID
A FormID, being a 32 bit unsigned integer, can be represented as an 8 digit hexadecimal string, and often is, e.g:
    
    0x0000000F

That is the FormID for septims.

Each mod gets an allotment of available FormIDs, but this allotment only allows use of *some* of the hexadecimal characters, not *all*. You could imagine that there is a party with 10 guests and a table with 10 rows of 10 cups of vodka. Not everyone will consume all of their cups, but no one is allowed to drink anyone else's cup. To know which cup is being identified, you have to know both the row *and* the column.

This integer includes both the mod index as well as the relative FormID of the object within the mod. When Skyrim launches, you can imagine a list of mods is being maintained, and the modindex lets you indicate a specific mod. Think of the modindex as the column indicator (whose cup is it?) and the rest becomes the relative FormID (which cup of theirs are they asking for?).

The main Skyrim.exe (i.e. all base game assets like septims) have a modindex of 0x00, with the rest of the DLC, when installed, typically occupying the next few. After that it's up to your modlist.

These represent standard ESPs and they all use the first two hexadecimal digits (i.e. 0x00, 0xAB, 0xFA), leaving 6 hexadecimal digits available for relative FormIDs. That is a lot, allowing roughly 16M records in your ESP.

    Standard (non-ESL flagged) ESP
    detection: FormID does *NOT* begin with 0xFE or 0xFF it is a standard ESP
    modindex: first two hex digits (e.g. 0x00, 0x2A, 0xFD)
    relative FormID: last 6 hex digits (note that leading zeroes are unnecessary) (e.g. 0x800, 0x123ABC)

Now imagine that there is a group of designated drivers. So you pull 1 column of cups and replace it with a column of non-alcoholic beverages and for some inexplicable reason, you limit each designated driver to a single cup. 

That is what ESL (or light ESPs) are about. The 0xFE modindex is reserved when ESLs are supported, so the modindex becomes the next 3 hexadecimal digits, leaving only 3 hexadecimal digits available for relative FormIDs. While still not small, at only 4k records, it is substantially fewer, but is what allows so many ESLs.

    Light (ESL flagged) ESP
    detection: FormID begins with 0xFE
    modindex: the third through sixth hex digits (e.g. starting with 0xFEABC123, modindex is 0xABC)
    relative FormID: last 3 hex digits (note that leading zeroes are unnecessary) (e.g. 0x800, 0xABC, 0xFFF)
        note specifically that with an ESL flagged mod, you are literally unable to have relative FormIDs greater than 0xFFF

Final note about converting FormIDs: if a FormID starts with 0xFF, it is a temporary FormID, created during play, not one loaded from a mod (even if it was created via script from a mod). These are not valid for use as relative FormID conversions.

So, some examples:

    0x00FFFFFF
    type: Standard
    modindex: 0x00
    relative FormID: 0xFFFFFF

    0xFD000001
    type: Standard
    modindex: 0xFD
    relative FormID: 0x1

    0xFE000001
    type: Light/ESL
    modindex: 0x000
    relative FormID: 0x1

    0xFE00FF01
    type: Light/ESL
    modindex: 0x00F
    relative FormID: 0xF01

    0xFE101010
    type: Light/ESL
    modindex: 0x101
    relative FormID: 0x10

    0xFF******
    type: Temporary
    modindex: invalid
    relative FormID: unavailable

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

