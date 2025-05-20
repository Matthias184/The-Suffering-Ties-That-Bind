; ***** BEGIN SPOTLIGHT ***
; c[8].xyz = position  c[8].w = 1_R2()
; c[9].xyz = direction  c[9].w = InvRadius2()
; c[10].xyz = float color RGB 0-1  c[10].w = GetLs()
; c[30].x = dot product scale   c[30].y = dot product bias
; c[30].z = max intensity
; r2 = ambient lighting
; v3 = vertex normal
;c[51] = [ 1, .5, 0, 2.0]

; get relative vector light->vertex
	sub r5.xyz, v0.xyz, c[8+%i].xyz          ;$$$ r5.xyz = vfDelta
; Dot the delta with the light direction        	
	dp3 r5.w, c[9+%i].xyz, r5.xyz
; Get l*l
	mul r6.x, r5.w, r5.w                        ;$$$ r6.x = l*l = vfL
; Get 1 - l*l/L*L  (1/L*L) is stored in vfLightDirection(w)
	mul r6.z, c[9+%i].w, r6.x
	sub r6.z, c[51].x, r6.z
; Make sure 1 - l*l/L*L >= 0
	max r6.z, r6.z, c[51].z                       ;$$$ r6.z = vfIntensity
	
; Now subtract off the component of vfDelta along vfLightDirection
;  This will give us the perpendicular component.  vfDelta - vfLightDirection*l
; first multiply LightDirection *vfL
	mul r7.xyz, c[9+%i].xyz, r5.w
; now vfDelta - result	         
	sub r7.xyz, r5.xyz, r7.xyz                        ;$$$ r7.xyz = vfVperpendicular
; Get r*r
	dp3 r7.w, r7.xyz, r7.xyz                          ;$$$ r7.w = vfPerpendicular.Mag2()  (r*r)
; Get 1/r*r
	rcp r8, r7.w
; Multiply by l*l
	mul r6.z, r6.z, r6.x
; multiply I/r*r (stored in w component)
	mul r6.z, r6.z, c[8+%i].w
; multiply by 1/r*r
    mul r6.z, r6.z, r8.x
; Clamp intensity
	min r6.z, r6.z, c[30].z

; Dot the light direction with the vertex normal	
	dp3 r8.x, v3, -c[9+%i].xyz
; Scale the dot product
	mad r8.x, r8.x, c[30].x, c[30].y

; Handle Backfacing
	sge r8.w, r8.x, c[51].z
	mul r8.x, r8.x, r8.w	

; See if l >= Ls.  (L=computed length, Ls = spotlight start) and set to zero if outside the cone
	sge r8.w, r5.w, c[10+%i].w
    mul r8.x, r8.x, r8.w
; Get Vd dot Vn * (1 - l*l/L*L) * (1 - r*r/(l*l * R*R))
	mul r6.z, r8.x, r6.z
; Add the contribution from the light, r2 = precomputed vertex light (or just ambient if no precomp lighting)
	mad r2.xyz, c[10+%i].xyz, r6.z, r2.xyz

; ***** END SPOTLIGHT ***