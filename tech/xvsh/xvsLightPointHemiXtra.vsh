; **HEMISPHERE CODE
; Determine if this vert is above or below the light
;  Multiply by our hemisphere light paramter
;  0.0 Means that it's a regular light
;  -1.0 Means that it's an up hemisphere light
;  1.0 Means that it's a down hemisphere light
mov r6.xyz, c[83].xyz			; Get the world Up vector in Object space
mul r6.xyz, r6.xyz, c[9+%i].w
dp3 r6.w, r6.xyz, r5.xyz
sge r6.w, r6.w, c[51].z 
mul r1.y, r1.y, r6.w