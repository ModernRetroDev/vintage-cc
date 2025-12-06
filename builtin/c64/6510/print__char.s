;[BUILTIN-BLOCK-START]
_print__char_flip_alpha:
   ; store A in X
   tax

   ; Check for a lowercase character ;
   ; check A >= #$41
   cmp #$41
   bcc _print__char_flip_alpha__unmodified ; branch if false

   ; check A < #$5B
   txa
   cmp #$5B
   bcc _print__char_flip_alpha__lowercase ; branch if true

   ; else check for a capital
   txa
   ; check A >= #$61
   cmp #$61
   bcc _print__char_flip_alpha__unmodified ; branch if false

   ; check A < #$7B
   txa
   cmp #$7B
   bcc _print__char_flip_alpha__uppercase ; branch if true
_print__char_flip_alpha__unmodified:
   txa
   rts
_print__char_flip_alpha__uppercase:
   txa
   sec
   sbc #$20
   rts
_print__char_flip_alpha__lowercase:
   txa
   clc
   adc #$20
   rts

_print__char:
   ;-----------------------------------------------------;
   ; A = STARTS WITH CHARACTER TO BE PRINTED             ;
   ;-----------------------------------------------------;
   ; print out a single character
   jsr _print__char_flip_alpha
   jsr CHROUT
   rts
