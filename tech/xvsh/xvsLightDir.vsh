; **DIRECTIONAL LIGHTING** shoudl only be applied to characters or objects without precomputed lighting!
dp3  r1.x, v3, c[8+%i]                  // perform lighting N dot L calculation in world space and store in r0.x
max  r1.x, r1.x, c[50].z                // set to >= 0.f
mad  r2.xyz,  c[9+%i].xyz, r1.x, r2.xyz // modulate precomputed lighting by this