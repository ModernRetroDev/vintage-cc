;[BUILTIN-BLOCK-START]
_minus_equals__u16_u16:
   ;-----------------------------------------------------;
   ; Subtracts a U16 in `ZP_PTR_2` from a U16.           ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING REDUCED.       ;
   ; ZP_PTR_2 = POINTS TO U16 VALUE BEING SUBTRACTED.    ;
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
   sbc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   rts

_minus_equals__u16_u16d:
   ;-----------------------------------------------------;
   ; Subtracts a U16 in registers `A,X` from a U16.      ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING REDUCED.       ;
   ; A = LOW BYTE OF U16 VALUE BEING SUBTRACTED          ;
   ; X = HIGH BYTE OF U16 VALUE BEING SUBTRACTED         ;
   ;-----------------------------------------------------;
   ; Clobbers:                                           ;
   ; ZP_PTR_2                                            ;
   ;-----------------------------------------------------;
   ; subtract the low byte
   sta ZP_PTR_2
   ldy #0
   lda (ZP_PTR_1),y
   sec
   sbc ZP_PTR_2
   sta (ZP_PTR_1),y
   ; carry over to high byte
   txa
   sta ZP_PTR_2
   ldy #1
   lda (ZP_PTR_1),y
   sbc ZP_PTR_2
   sta (ZP_PTR_1),y
   rts
