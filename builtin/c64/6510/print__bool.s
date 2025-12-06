;[BUILTIN-BLOCK-START]
_print__bool:
   ;-----------------------------------------------------;
   ; A = STARTS WITH BOOL TO BE PRINTED                  ;
   ;-----------------------------------------------------;
   cmp #0
   beq _print__bool__false
   lda #'t' + $20
   jsr CHROUT
   lda #'r' + $20
   jsr CHROUT
   lda #'u' + $20
   jsr CHROUT
   lda #'e' + $20
   jsr CHROUT
   jmp _print__bool__out
_print__bool__false:
   lda #'f' + $20
   jsr CHROUT
   lda #'a' + $20
   jsr CHROUT
   lda #'l' + $20
   jsr CHROUT
   lda #'s' + $20
   jsr CHROUT
   lda #'e' + $20
   jsr CHROUT
_print__bool__out:
   rts
