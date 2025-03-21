;[BUILTIN-BLOCK-START]
_mul_by_10__u8:
   ;-----------------------------------------------------;
   ; A = STARTS WITH NUMBER TO BE MULTIPLIED BY 10       ;
   ;-----------------------------------------------------;
   tax ; save a copy of A within X
   asl ; shift A left by one bit
   tay ; save a copy of A within Y
   asl ; shift A left by one bit
   asl ; shift A left by one bit
   sta ZP_PTR_2 ; store A value to ZERO PAGE
   tya ; copy Y back into A

   clc ; clear carry
   adc ZP_PTR_2
   ; A now contains the result ;
   rts
