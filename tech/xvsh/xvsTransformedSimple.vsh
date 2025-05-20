;dcl_position v0
;dcl_normal v3
;dcl_texcoord0 v5
;dcl_color0 v10

#pragma screenspace 

vs.1.1              ; version instruction
mov  oPos,   v0     ; transformed position with rhw
mov  oD0,    v10     ; lighting
mov  oT0.xy, v5.xy  ; uv's