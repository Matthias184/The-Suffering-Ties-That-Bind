; ***** BEGIN POINTLIGHT ***
; c[8].xyz = position  c[8].w = intensity
; v3 = vertex normal
; **NOTE: This code is duplicated by point lights and should be shared!

sub  r5.xyz, v0.xyz,  c[54].xyz // get relative vector light->vertex

; normalize the light vector
; r1.x = mag(DELTA)2
; r1.y = 1/mag(DELTA)
; r3   = DELTA.normalized()
dp3  r1.x,     r5.xyz,    r5.xyz
rsq  r1.y,     r1.x
mul  r3,       r1.y,      r5.xyz
// we have a normalized light vector now
// try the brut force method: r = 2(s•n)n - s
dp3 r1.x,      r3.xyz,    v3.xyz   // u.dot(n)
mul r1.x,      r1.x,      c[51].w  // 2 * u
mul r2.xyz,    v3.xyz,    r1.xxx     // normal * u
sub r3.xyz,      r3.xyz,    r2.xyz  // u - 2(u.n)n

// The texture matrix will shift UV's from (-1,1) to (0,1) so there's no need to do this with extra instructions!
mov r3.w, c[51].x // w component must be 1.0 so that we can do a full 4 component dot product! 

// if our 'z' component is <0, then set UV's both to 0.
//sge r2.x, c[81].x, r3.z
//mul r3, r3, r2.x

dp4 oT0.x, r3, c[4]
dp4 oT0.y, r3, c[5]

// uncomment this to use the vNormal registers as a source!
//dp4 oT0.x, v3, c[4]
//dp4 oT0.y, v3, c[5]

//mad oT0.x, r1.x, c[51].y, c[51].y // MUL by .5 to transform (-1,1) to (-.5, .5). ADD 0.5 to transform (-.5, .5) to (0, 1)
//mad oT0.y, r1.y, c[51].y, c[51].y