; ***** BEGIN BUMPMAPPING ***
; c[51] = bump light source position
; #define _D3DVSDE_TEXCOORD0       v5   -> old uvs
; #define _D3DVSDE_TEXCOORD1       v6   -> tangent
; #define _D3DVSDE_TEXCOORD1       v7   -> binormal
; **NOTE: This code is duplicated by point lights and should be shared!
; ***** BEGIN BUMPST ***
; c[52].x = bump shift

sub  r5.xyz, c[53].xyz,    v0.xyz // get relative vector light->vertex

; normalize the light vector
; r1.x = mag(DELTA)2
; r1.y = 1/mag(DELTA)
; r3   = DELTA.normalized()
dp3  r1.x,     r5.xyz,    r5.xyz
rsq  r1.y,     r1.x
mul  r3,       r1.y,      r5.xyz

// Dot light source with binormal and tangent
dp3   r2.x, v6, r3
dp3   r2.y, v7, r3
mul r2.xy, r2.xy, c52.xx

// add our newly generated offset UVs to the original UVs
add r2.x, r2.x, v5.x
add r2.y, r2.y, v5.y

mov oT0.xy, r2.xy
//mov oT0.xy, r3.xy