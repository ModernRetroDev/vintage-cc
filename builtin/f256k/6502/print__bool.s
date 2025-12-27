;REQUIRES  putchar
;
;[BUILTIN-BLOCK-START]
_print__bool:
   ;-----------------------------------------------------;
   ; A = STARTS WITH BOOL TO BE PRINTED                  ;
   ;-----------------------------------------------------;
   cmp #0
   beq _print__bool__false
   lda #$54 ; T
   jsr _putchar
   lda #$52 ; R
   jsr _putchar
   lda #$55 ; U
   jsr _putchar
   lda #$45 ; E
   jsr _putchar
   jmp _print__bool__out
_print__bool__false:
   lda #$46 ; F
   jsr _putchar
   lda #$41 ; A
   jsr _putchar
   lda #$4C ; L
   jsr _putchar
   lda #$53 ; S
   jsr _putchar
   lda #$45 ; E
   jsr _putchar
_print__bool__out:
   rts
