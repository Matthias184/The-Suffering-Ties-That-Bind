// LightFooter.vsh
mul r2.w, r2.w, c[80].w // modulate lighting by ambient (just modulate alpha, really)
min r2.xyz, r2.xyz, c[82].xyz
mul oD0, r2, c[51].yyyx // half rgb