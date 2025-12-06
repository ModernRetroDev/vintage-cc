;[BUILTIN-BLOCK-START]
_lshift__u16_n:
   ;-----------------------------------------------------;
   ; Shifts a U16 value left a number of times.          ;
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

_lshift__u16_n__check:
   cpy r1
   bne _lshift__u16_n__again
   jmp _lshift__u16_n__out

_lshift__u16_n__again:
   lda r0L
   asl
   sta r0L
   lda r0H
   rol
   sta r0H
   iny
   jmp _lshift__u16_n__check

_lshift__u16_n__out:
   ; Save updated U16 value to ZP_PTR_1
   ldy #0
   lda r0L
   sta (ZP_PTR_1),y
   iny 
   lda r0H
   sta (ZP_PTR_1),y

   rts
