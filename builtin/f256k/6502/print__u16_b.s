;REQUIRES  print__u8_b
;
;[BUILTIN-BLOCK-START]
_print__u16_b:
   ;-----------------------------------------------------;
   ; X = LOW BYTE NUMBER TO BE PRINTED                   ;
   ; Y = HIGH BYTE NUMBER TO BE PRINTED                  ;
   ;-----------------------------------------------------;
   txa
   sta ZP_PTR_1 ; store the low byte of the number
   tya
   sta ZP_PTR_1+1 ; store the high byte of the number

   jsr _print__u8_b ; print out high byte

   lda ZP_PTR_1 ; load low byte of the number
   jsr _print__u8_b ; print out low byte
   rts
