;[BUILTIN-BLOCK-START]
_rshift__u24_n:
   ;-----------------------------------------------------;
   ; Shifts a u24 value right a number of times.         ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO u24 VALUE TO BE SHIFTED.       ;
   ; X = CONTAINS NUMBER OF TIMES TO SHIFT VALUE.        ;
   ;-----------------------------------------------------;

   ; Save the u24 value to r0
   ldy #0
   lda (ZP_PTR_1),y
   sta r0
   iny 
   lda (ZP_PTR_1),y
   sta r0+1
   iny 
   lda (ZP_PTR_1),y
   sta r0+2

   ldy #0 ; y is used as a ctr for stopping the shift
   stx r2

_rshift__u24_n__check:
   cpy r2
   bne _rshift__u24_n__again
   bra _rshift__u24_n__out

_rshift__u24_n__again:
   lda r0+2
   clc
   ror
   sta r0+2
   lda r0+1
   ror
   sta r0+1
   lda r0
   ror
   sta r0
   iny
   bra _rshift__u24_n__check

_rshift__u24_n__out:
   ; Save updated u24 value to ZP_PTR_1
   ldy #0
   lda r0
   sta (ZP_PTR_1),y
   iny 
   lda r0+1
   sta (ZP_PTR_1),y
   iny 
   lda r0+2
   sta (ZP_PTR_1),y

   rts
