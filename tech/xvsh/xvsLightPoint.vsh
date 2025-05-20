; ***** BEGIN POINTLIGHT ***
; c[8].xyz = position  c[8].w = intensity
; c[9].xyz = float color RGB 0-1
; c[9].w = Hemisphere parameter
; r2 = ambient lighting
; v3 = vertex normal

sub  r5.xyz, c[8+%i].xyz,    v0.xyz // get relative vector light->vertex

;Get the magnitude and magnitude^2 of the delta
; r1.x = mag(DELTA)2
; r1.y = 1/mag(DELTA)
; r3   = DELTA.normalized()
dp3  r1.x,     r5.xyz,    r5.xyz
rsq  r1.y,     r1.x
mul  r3,       r1.y,      r5.xyz

; Dot the delta with the vertex normal
; r1.z = normal.DOT(DELTA)
dp3  r1.z,     v3,        r3
; if the dot < 1, then set it to 0
max  r1.z,     r1.z,      c[51].z

; insert our hemisphere code if necessary
;!s

; we need (1 / (delta.mag()) ^2 * intensity^2

; compute 1 / delta.mag()
; r1.y = ( 1/mag(DELTA) )^2
mul  r1.y, r1.y, r1.y
; r4.x = r1.y * intensity
mul  r4.x, r1.y, c[8+%i].w

; Clamp our intensity to 2.0
min r4.x, r4.x, c[51].w

; r4.x = (1 - r*r/R*R) * dot coefficient
; r2.xyz = ambient modulated with point light
mul  r4.x, r4.x, r1.z

mad  r2.xyz, c[9+%i].xyz, r4.x, r2.xyz
; ***** END POINTLIGHT ***