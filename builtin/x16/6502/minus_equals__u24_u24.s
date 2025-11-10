;[BUILTIN-BLOCK-START]
_minus_equals__u24_u24:
   ;-----------------------------------------------------;
   ; Subtracts a u24 in `ZP_PTR_2` from a u24.           ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO u24 VALUE BEING REDUCED.       ;
   ; ZP_PTR_2 = POINTS TO u24 VALUE BEING SUBTRACTED.    ;
   ;-----------------------------------------------------;
   ; subtract the low byte
   ldy #0
   lda (ZP_PTR_1),y
   sec
   sbc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   ; carry over to mid byte
   iny
   lda (ZP_PTR_1),y
   sbc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   ; carry over to high byte
   iny
   lda (ZP_PTR_1),y
   sbc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   rts
