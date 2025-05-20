; Landsplatalpha.vsh
;sub  r5.xyz, c[53].xyz,    v0.xyz // get relative vector light->vertex
;dp3  r1.x,     r5.xyz,    r5.xyz
// multiply by 1/fadedist2
;mul r1.x,      r1.x,      c[52].x
;mad  r1.y,      r1.x,      -r1.x, c[51].x // 1.f - x*x
;mul  r2.w,    v10.w,    r1.y // rAlpha * pAlpha[]
;mov  oD0,     r2 // this is done by the lighting-footer in all cases except fullbright cheat.

; formula is 1 - (Zdepth * (1/fadedist))^2
mul r1.x,   -r0.z,      c[52].x
mad r1.y,  r1.x,      -r1.x, c[51].x // 1.f - x*x
mul r2.w,  v10.w,    r1.y // rAlpha * pAlpha[]