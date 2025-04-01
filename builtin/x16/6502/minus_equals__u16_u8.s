;[BUILTIN-BLOCK-START]
_minus_equals__u16_u8:
   ;-----------------------------------------------------;
   ; Subtracts a U8 in `ZP_PTR_2` from a U16.            ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING REDUCED.       ;
   ; ZP_PTR_2 = POINTS TO U8 VALUE BEING SUBTRACTED.     ;
   ;-----------------------------------------------------;
   ; subtract the low byte
   ldy #0
   lda (ZP_PTR_1),y
   sec
   sbc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   ; carry over to high byte
   ldy #1
   lda (ZP_PTR_1),y
   sbc #0
   sta (ZP_PTR_1),y
   rts

_minus_equals__u16_u8d:
   ;-----------------------------------------------------;
   ; Subtracts a U8 in register `A` from a U16.          ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING REDUCED.       ;
   ; A = U8 VALUE TO BE SUBTRACTED                       ;
   ;-----------------------------------------------------;
   ; Clobbers:                                           ;
   ; X                                                   ;
   ;-----------------------------------------------------;
   ; subtract the low byte
   ldx ZP_PTR_2
   sta ZP_PTR_2
   ldy #0
   lda (ZP_PTR_1),y
   sec
   sbc ZP_PTR_2
   sta (ZP_PTR_1),y
   ; carry over to high byte
   ldy #1
   lda (ZP_PTR_1),y
   sbc #0
   sta (ZP_PTR_1),y
   stx ZP_PTR_2
   rts
