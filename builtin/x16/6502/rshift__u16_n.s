;[BUILTIN-BLOCK-START]
_rshift__u16_n:
   ;-----------------------------------------------------;
   ; Shifts a U16 value right a number of times.         ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE TO BE SHIFTED.       ;
   ; X = CONTAINS NUMBER OF TIMES TO SHIFT VALUE.        ;
   ;-----------------------------------------------------;

   ; Save the U16 value to r0
   ldy #0
   lda (ZP_PTR_1),y
   sta r0L
   iny 
   lda (ZP_PTR_1),y
   sta r0H

   ldy #0 ; y is used as a ctr for stopping the shift
   stx r1

_rshift__u16_n__check:
   cpy r1
   bne _rshift__u16_n__again
   bra _rshift__u16_n__out

_rshift__u16_n__again:
   lda r0H
   clc
   ror
   sta r0H
   lda r0L
   ror
   sta r0L
   iny
   bra _rshift__u16_n__check

_rshift__u16_n__out:
   ; Save updated U16 value to ZP_PTR_1
   ldy #0
   lda r0L
   sta (ZP_PTR_1),y
   iny 
   lda r0H
   sta (ZP_PTR_1),y

   rts
