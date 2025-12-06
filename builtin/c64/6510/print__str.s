;REQUIRES  print__str8
;
;[BUILTIN-BLOCK-START]
_print__str:
   ; print out a string of characters
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO STRING POINTER.                ;
   ;-----------------------------------------------------;
   lda ZP_PTR_1
   lda ZP_PTR_1+1

   ldy #0
   lda (ZP_PTR_1),y
   sta ZP_PTR_2
   iny
   lda (ZP_PTR_1),y
   sta ZP_PTR_2+1

   ; point to the str type, Y
   ldy #0
   ; store str8 type to r0
   lda (ZP_PTR_2),y

   cmp #1
   beq _print__str_as_str8
   ; jsr _print__str16 ; disabled for now...
   rts

_print__str_as_str8:
   jsr _print__str8
   rts

