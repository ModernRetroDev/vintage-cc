;[BUILTIN-BLOCK-START]
_plus_equals__u24_u24:
   ;-----------------------------------------------------;
   ; Adds a u24 from `ZP_PTR_2` to a u24.                ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO u24 VALUE BEING ADDED TO.      ;
   ; ZP_PTR_2 = POINTS TO u24 VALUE BEING ADDED.         ;
   ;-----------------------------------------------------;
   ; add to low byte
   clc
   ldy #0
   lda (ZP_PTR_1),y
   adc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   ; carry over to mid byte
   iny
   lda (ZP_PTR_1),y
   adc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   ; carry over to high byte
   iny
   lda (ZP_PTR_1),y
   adc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   rts
