dp3  r1.x, v3, c[55]			// perform lighting N dot L calculation in world space and store in r1.x
add  r1.x, r1.x, c[56].x		// add an offset to the dot product
mul  r1.x, r1.x, c[56].y		// Now scale the result
dp3  r1.y, v0, c[57]			// dot our position with the shadow plane 0 normal
sge  r1.y, r1.y, c[57].w		// if we're behind plane 0, then zero out our contribution
dp3  r1.z, v0, c[58]			// dot our position with the shadow plane 1 normal
sge  r1.z, r1.z, c[58].w		// if we're behind plane 1, then zero out our contribution
dp3  r1.w, v0, c[59]			// dot our position with the shadow plane 2 normal
sge  r1.w, r1.w, c[59].w		// if we're behind plane 2, then zero out our contribution
mul  r1.x, r1.x, r1.y			// modulate plane 0 result with our existing dot product
mul  r1.x, r1.x, r1.z			// modulate plane 1 result with our existing dot product
mul  r1.x, r1.x, r1.w			// modulate plane 2 result with our existing dot product
max  r1.x, r1.x, c[51].z		// set to >= 0.f
min  r1.x, r1.x, c[51].x		// set to <= 1.f
mov  r2, c[80]					// get our fixed color
mul  oD0, r2, r1.x				// now modulate it by our dot product computations