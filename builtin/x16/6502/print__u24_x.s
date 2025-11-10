;REQUIRES  print__u8_x
;
;[BUILTIN-BLOCK-START]
_print__u24_x:
   ;-----------------------------------------------------;
   ; X = LOW BYTE NUMBER TO BE PRINTED                   ;
   ; Y = MID BYTE NUMBER TO BE PRINTED                   ;
   ; A = HIGH BYTE NUMBER TO BE PRINTED                  ;
   ;-----------------------------------------------------;
   sta r0 ; store high byte
   tya
   sta r1 ; store mid byte
   txa
   sta r2 ; store low byte

   ; print out high byte
   lda r0
   jsr _print__u8_x

   ; print out mid byte
   lda r1
   jsr _print__u8_x

   ; print out low byte
   lda r2
   jsr _print__u8_x

   rts
