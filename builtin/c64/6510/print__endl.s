;[BUILTIN-BLOCK-START]
_print__endl:
   ; print an end of line character
   lda #$0D
   jsr CHROUT
   rts
