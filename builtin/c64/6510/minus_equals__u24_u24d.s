;[BUILTIN-BLOCK-START]
_minus_equals__u24_u24d:
   ;-----------------------------------------------------;
   ; Subtracts a u24 in r0,r0+1,r0+2 from a u24.         ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO u24 VALUE BEING REDUCED.       ;
   ; r0   = LOW BYTE OF u24 VALUE TO BE SUBTRACTED.      ;
   ; r0+1 = MID BYTE OF u24 VALUE TO BE SUBTRACTED.      ;
   ; r0+2 = HIGH BYTE OF u24 VALUE TO BE SUBTRACTED.     ;
   ;-----------------------------------------------------;
   ; subtract the low byte
   ldy #0
   lda (ZP_PTR_1),y
   sec
   sbc r0
   sta (ZP_PTR_1),y
   ; carry over to mid byte
   iny
   lda (ZP_PTR_1),y
   sbc r0+1
   sta (ZP_PTR_1),y
   ; carry over to high byte
   iny
   lda (ZP_PTR_1),y
   sbc r0+2
   sta (ZP_PTR_1),y
   rts
