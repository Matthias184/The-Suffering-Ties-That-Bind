// Perspective correct texture coords 0
// c[4,5,6] = texture projection matrix
// c[51] = [ 1, .5, 0, 2]
// c[55] = {vLightDir, FallOff}
// c[56] = dropoff facor: [bias, scale, Intensity, zNear]
// c[80] = Pass color

dp4 r1.x, v%i, c[4]			// Run the position through the texture matrix
dp4 r1.y, v%i, c[5]
dp4 r1.w, v%i, c[6]
rcp r2, r1.w				// Compute 1/z
mul r3.xy, r1.xy, r2.w		// Normalize the U & V coordinates

sge r1.z, r1.w, c[51].z				// Make sure we're in front of the convergence point.
mad r1.z, r1.z, c[51].w, -c[51].x	// Remap [0,1] -> [-1,1]  (2x - 1)
mad oT0.xy, r3.xy, r1.z, c[51].y	// Scale & Add 0.5 to recenter coordinates

dp3 r1.x, v3, c[55]			// perform lighting N dot L calculation in world space and store in r1.x
add r1.x, r1.x, c[56].x		// Bias the dot product
mul r1.x, r1.x, c[56].y		// ...now scale

sub r1.z, r1.w, c[56].w		// subtract the near Z offset, so we're relative to the origin of the light
sge r1.y, r1.z, c[51].z		// make sure we're in front of the near clip.
mul r1.x, r1.x, r1.y

mul r1.z, r1.z, r1.z		// compute I*(r*r)/(R*R)
mul r1.z, r1.z, c[55].w		// compute distance fall off
sub r1.z, c[51].x, r1.z
min r1.z, r1.z, c[51].w		// Clamp our intensity to 2.0
mul r1.x, r1.x, r1.z
mul r1.x, r1.x, c[56].z		// Used to fade given other values

mov oD0.xyz, c[80].xyz		// Get the passes color
mul oD0.w, c[80].w, r1.x	// & Alpha