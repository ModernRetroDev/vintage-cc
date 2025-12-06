;REQUIRES  print__char
;
;[BUILTIN-BLOCK-START]
_print__str8:
   ; print out a string of characters
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO STRING POINTER.                ;
   ;-----------------------------------------------------;
   lda ZP_PTR_1
   sta ZP_PTR_2
   lda ZP_PTR_1+1
   sta ZP_PTR_2+1

   ldy #0
   lda (ZP_PTR_2),y
   sta ZP_PTR_1
   iny
   lda (ZP_PTR_2),y
   sta ZP_PTR_1+1

   ; zero out escape char indicator, X
   ldx #0
   ; point to the str8 length, Y
   ldy #1
   ; store str8 length to ZP_PTR_2
   lda (ZP_PTR_1),y
   sta ZP_PTR_2
   ; zero out iteration counter, Y
   ldy #0
   ; increment ZP_PTR_1 by 5 bytes
   clc
   lda ZP_PTR_1
   adc #6
   sta ZP_PTR_1
   lda ZP_PTR_1+1
   adc #0
   sta ZP_PTR_1+1
_print__str8_loop:
   cpy ZP_PTR_2
   beq _print__str8_done
   cpx #1
   bne _print__str8_unescaped
   ;-----------------------------------------------------;
   ; Has preceding escape char                           ;
   ;-----------------------------------------------------;
   lda (ZP_PTR_1),y
   cmp #$6E ; `n` character
   bne _print__str8_check_backslash
   ; print an end of line character
   lda #$0D
   jsr CHROUT
   ldx #0
   iny
   jmp _print__str8_loop
_print__str8_check_backslash:
   lda (ZP_PTR_1),y
   cmp #$5C ; backslash char
   bne _print__str8_check_unhandled
   ; print out a backslash
   jsr CHROUT
   ldx #0
   iny
   jmp _print__str8_loop
_print__str8_check_unhandled:
   ldx #0
   iny
   jmp _print__str8_loop
_print__str8_unescaped:
   lda (ZP_PTR_1),y
   cmp #$5C ; backslash char
   bne _print__str8_unescaped_print
   ; else: set escape flag and continue
   ldx #1
   iny
   jmp _print__str8_loop
_print__str8_unescaped_print:
   jsr _print__char_flip_alpha
   jsr CHROUT
   iny
   jmp _print__str8_loop
_print__str8_done:
   rts
