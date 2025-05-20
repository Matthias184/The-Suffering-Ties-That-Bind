;vs.1.1              ; version instruction

dcl_position0 v0

; Transform vertex position
m4x4 r0, v0, c[0]
mov  oPos, r0

;fog
;dp3 r0.w, r0, r0
;rsq r1.w, r0.w
;mul r0.z, r0.w, r1.w

;max  r1.x, r0.z,    c[51].x
;min  r1.x, r1.x,    c[51].y
;mad  oFog.x, r1.x, -c[51].z, c[51].w

;mov  oFog, r0.z

mad  oFog, -r0.z, c[50].z, c[50].w