scriptname sl_triggersListGenerators

MagicEffect[] Function CreateMGEFList(int count) global
    if count < 1 || count > 127
        return none
    endif

    if count == 1
        return new MagicEffect[1]
   	elseif count == 2
		return new MagicEffect[2]
	elseif count == 3
		return new MagicEffect[3]
	elseif count == 4
		return new MagicEffect[4]
	elseif count == 5
		return new MagicEffect[5]
	elseif count == 6
		return new MagicEffect[6]
	elseif count == 7
		return new MagicEffect[7]
	elseif count == 8
		return new MagicEffect[8]
	elseif count == 9
		return new MagicEffect[9]
	elseif count == 10
		return new MagicEffect[10]
	elseif count == 11
		return new MagicEffect[11]
	elseif count == 12
		return new MagicEffect[12]
	elseif count == 13
		return new MagicEffect[13]
	elseif count == 14
		return new MagicEffect[14]
	elseif count == 15
		return new MagicEffect[15]
	elseif count == 16
		return new MagicEffect[16]
	elseif count == 17
		return new MagicEffect[17]
	elseif count == 18
		return new MagicEffect[18]
	elseif count == 19
		return new MagicEffect[19]
	elseif count == 20
		return new MagicEffect[20]
	elseif count == 21
		return new MagicEffect[21]
	elseif count == 22
		return new MagicEffect[22]
	elseif count == 23
		return new MagicEffect[23]
	elseif count == 24
		return new MagicEffect[24]
	elseif count == 25
		return new MagicEffect[25]
	elseif count == 26
		return new MagicEffect[26]
	elseif count == 27
		return new MagicEffect[27]
	elseif count == 28
		return new MagicEffect[28]
	elseif count == 29
		return new MagicEffect[29]
	elseif count == 30
		return new MagicEffect[30]
	elseif count == 31
		return new MagicEffect[31]
	elseif count == 32
		return new MagicEffect[32]
	elseif count == 33
		return new MagicEffect[33]
	elseif count == 34
		return new MagicEffect[34]
	elseif count == 35
		return new MagicEffect[35]
	elseif count == 36
		return new MagicEffect[36]
	elseif count == 37
		return new MagicEffect[37]
	elseif count == 38
		return new MagicEffect[38]
	elseif count == 39
		return new MagicEffect[39]
	elseif count == 40
		return new MagicEffect[40]
	elseif count == 41
		return new MagicEffect[41]
	elseif count == 42
		return new MagicEffect[42]
	elseif count == 43
		return new MagicEffect[43]
	elseif count == 44
		return new MagicEffect[44]
	elseif count == 45
		return new MagicEffect[45]
	elseif count == 46
		return new MagicEffect[46]
	elseif count == 47
		return new MagicEffect[47]
	elseif count == 48
		return new MagicEffect[48]
	elseif count == 49
		return new MagicEffect[49]
	elseif count == 50
		return new MagicEffect[50]
	elseif count == 51
		return new MagicEffect[51]
	elseif count == 52
		return new MagicEffect[52]
	elseif count == 53
		return new MagicEffect[53]
	elseif count == 54
		return new MagicEffect[54]
	elseif count == 55
		return new MagicEffect[55]
	elseif count == 56
		return new MagicEffect[56]
	elseif count == 57
		return new MagicEffect[57]
	elseif count == 58
		return new MagicEffect[58]
	elseif count == 59
		return new MagicEffect[59]
	elseif count == 60
		return new MagicEffect[60]
	elseif count == 61
		return new MagicEffect[61]
	elseif count == 62
		return new MagicEffect[62]
	elseif count == 63
		return new MagicEffect[63]
	elseif count == 64
		return new MagicEffect[64]
	elseif count == 65
		return new MagicEffect[65]
	elseif count == 66
		return new MagicEffect[66]
	elseif count == 67
		return new MagicEffect[67]
	elseif count == 68
		return new MagicEffect[68]
	elseif count == 69
		return new MagicEffect[69]
	elseif count == 70
		return new MagicEffect[70]
	elseif count == 71
		return new MagicEffect[71]
	elseif count == 72
		return new MagicEffect[72]
	elseif count == 73
		return new MagicEffect[73]
	elseif count == 74
		return new MagicEffect[74]
	elseif count == 75
		return new MagicEffect[75]
	elseif count == 76
		return new MagicEffect[76]
	elseif count == 77
		return new MagicEffect[77]
	elseif count == 78
		return new MagicEffect[78]
	elseif count == 79
		return new MagicEffect[79]
	elseif count == 80
		return new MagicEffect[80]
	elseif count == 81
		return new MagicEffect[81]
	elseif count == 82
		return new MagicEffect[82]
	elseif count == 83
		return new MagicEffect[83]
	elseif count == 84
		return new MagicEffect[84]
	elseif count == 85
		return new MagicEffect[85]
	elseif count == 86
		return new MagicEffect[86]
	elseif count == 87
		return new MagicEffect[87]
	elseif count == 88
		return new MagicEffect[88]
	elseif count == 89
		return new MagicEffect[89]
	elseif count == 90
		return new MagicEffect[90]
	elseif count == 91
		return new MagicEffect[91]
	elseif count == 92
		return new MagicEffect[92]
	elseif count == 93
		return new MagicEffect[93]
	elseif count == 94
		return new MagicEffect[94]
	elseif count == 95
		return new MagicEffect[95]
	elseif count == 96
		return new MagicEffect[96]
	elseif count == 97
		return new MagicEffect[97]
	elseif count == 98
		return new MagicEffect[98]
	elseif count == 99
		return new MagicEffect[99]
	elseif count == 100
		return new MagicEffect[100]
	elseif count == 101
		return new MagicEffect[101]
	elseif count == 102
		return new MagicEffect[102]
	elseif count == 103
		return new MagicEffect[103]
	elseif count == 104
		return new MagicEffect[104]
	elseif count == 105
		return new MagicEffect[105]
	elseif count == 106
		return new MagicEffect[106]
	elseif count == 107
		return new MagicEffect[107]
	elseif count == 108
		return new MagicEffect[108]
	elseif count == 109
		return new MagicEffect[109]
	elseif count == 110
		return new MagicEffect[110]
	elseif count == 111
		return new MagicEffect[111]
	elseif count == 112
		return new MagicEffect[112]
	elseif count == 113
		return new MagicEffect[113]
	elseif count == 114
		return new MagicEffect[114]
	elseif count == 115
		return new MagicEffect[115]
	elseif count == 116
		return new MagicEffect[116]
	elseif count == 117
		return new MagicEffect[117]
	elseif count == 118
		return new MagicEffect[118]
	elseif count == 119
		return new MagicEffect[119]
	elseif count == 120
		return new MagicEffect[120]
	elseif count == 121
		return new MagicEffect[121]
	elseif count == 122
		return new MagicEffect[122]
	elseif count == 123
		return new MagicEffect[123]
	elseif count == 124
		return new MagicEffect[124]
	elseif count == 125
		return new MagicEffect[125]
	elseif count == 126
		return new MagicEffect[126]
	elseif count == 127
		return new MagicEffect[127]
    endif
EndFunction