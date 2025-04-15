scriptname rpdefault_math
float function getpi() global
endfunction
float function min(float anum01, float anum02) global
endfunction
float function max(float anum01, float anum02) global
endfunction
float function clamp(float anum, float afmin, float afmax) global
endfunction
float function atan2(float afa, float afb) global
endfunction
float function atan2rad(float afa, float afb) global
endfunction
int function log2n(int ainum) global
endfunction
float[] function getoffset3ddata(float[] afstartposition, float[] afstartangle, float[] afoffsetposition, float[] afoffsetangle) global
endfunction
float[] function createquaternionfromeuler(float afanglex, float afangley, float afanglez) global
endfunction
float[] function createeulerfromquaternion(float[] afquat) global
endfunction
float[] function createeulerfrommatrix(float[] afmatrix) global
endfunction
float function normalizeangle(float afangle) global
endfunction
float[] function multiplyquaternions(float[] afqa, float[] afqb) global
endfunction
float[] function addquaternions(float[] afqa, float[] afqb) global
endfunction
float[] function subtractquaternions(float[] afqa, float[] afqb) global
endfunction
function inversequaternion(float[] afq) global
endfunction
float[] function creatematrixfromeuler(float afanglex, float afangley, float afanglez) global
endfunction
float[] function creatematrixfromquaternion(float[] afquat) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1