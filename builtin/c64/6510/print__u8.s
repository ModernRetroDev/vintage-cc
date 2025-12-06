;REQUIRES  div_by_10__u8
;REQUIRES  mul_by_10__u8
;
;[BUILTIN-BLOCK-START]
_print__u8:
   ;-----------------------------------------------------;
   ; A = STARTS WITH NUMBER TO BE PRINTED                ;
   ;-----------------------------------------------------;
   tax ; store A value within X
   cmp #10 ; compare A with `10`
   bcc _print__u8__ones; if A < 10 goto `ones`

   cmp #100 ; compare A with `100`
   bcc _print__u8__tens; if A < 100 goto `tens`

   cmp #200 ; compare A with `200`
   bcc _print__u8__lt200; if A < 200 goto `lt200`

   ; ELSE: this is a 2XX number ;
   lda #$32 ; `2`
   jsr CHROUT
   ; SUBTRACT 200 FROM WORKING NUMBER ;
   txa ; store X value within A
   sec ; set carry flag
   sbc #200 ; subtract `200` from A
   jmp _print__u8__tens

_print__u8__lt200:
   ; This is a 1XX number ;
   lda #$31 ; `1`
   jsr CHROUT
   ; SUBTRACT 100 FROM WORKING NUMBER ;
   txa ; store X value within A
   sec ; set carry flag
   sbc #100 ; subtract `100` from A

_print__u8__tens:
   sta ZP_PTR_1 ; store A value to ZERO PAGE
   jsr _div_by_10__u8 ; divide by 10 to get tens place
   tay ; save a copy of A within Y

   clc ; clear carry
   adc #$30 ; point to 0 + remainder
   jsr CHROUT

   ; setup the ones place value
   tya ; restore A from Y
   jsr _mul_by_10__u8 ; mulitply 10s place by 10

   sta ZP_PTR_2 ; store value to sub wtihin ZP2
   lda ZP_PTR_1 ; load stored A (with ones) once again

   sec ; set carry flag
   sbc ZP_PTR_2 ; subtract tens value from tens+ones

_print__u8__ones:
   clc ; clear carry
   adc #$30 ; point to 0 + remainder
   jsr CHROUT

   rts