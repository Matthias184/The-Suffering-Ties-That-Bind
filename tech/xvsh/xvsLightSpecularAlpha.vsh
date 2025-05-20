// LightSpecularAlpha.vsh
mul r2.w, r2.w, r3.y     // modulate our lighting alpha by the 'y' component of r3, which is teh result of the reflection vector
sub r2.w, c[51].x, r2.w  // store 1.0 - w, since for water we want full alpha at max reflection
mul r2.w, r2.w, c[70].y  // put in the range of (max alpha - min alpha)
add r2.w, r2.w, c[70].x  // alpha = min alpha + (max alpha - min alpha)
