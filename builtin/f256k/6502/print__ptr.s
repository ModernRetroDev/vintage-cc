;REQUIRES  putchar
;REQUIRES  print__u8_xx
;
;[BUILTIN-BLOCK-START]
_print__ptr:
   ;-----------------------------------------------------;
   ; X = LOW BYTE NUMBER TO BE PRINTED                   ;
   ; Y = HIGH BYTE NUMBER TO BE PRINTED                  ;
   ;-----------------------------------------------------;
   lda #'0'
   jsr _putchar
   lda #$78 ; 'x' char
   jsr _putchar

   txa
   sta ZP_PTR_1 ; store the low byte of the number
   tya
   sta ZP_PTR_1+1 ; store the high byte of the number

   jsr _print__u8_xx ; print out high byte

   lda ZP_PTR_1 ; load low byte of the number
   jsr _print__u8_xx ; print out low byte
   rts
