;[BUILTIN-BLOCK-START]
_print__u8_b:
   ;-----------------------------------------------------;
   ; A = STARTS WITH NUMBER TO BE PRINTED                ;
   ;-----------------------------------------------------;
   tax ; store A value within X

   ; print value of highest bit (bit 8)
   and #%10000000
   ldy #$30
   cmp #$0
   beq _print__u8_b_8
   ldy #$31
_print__u8_b_8:
   tya
   jsr CHROUT

   ; print value of bit 7
   txa
   and #%1000000
   ldy #$30
   cmp #$0
   beq _print__u8_b_7
   ldy #$31
_print__u8_b_7:
   tya
   jsr CHROUT

   ; print value of bit 6
   txa
   and #%100000
   ldy #$30
   cmp #$0
   beq _print__u8_b_6
   ldy #$31
_print__u8_b_6:
   tya
   jsr CHROUT

   ; print value of bit 5
   txa
   and #%10000
   ldy #$30
   cmp #$0
   beq _print__u8_b_5
   ldy #$31
_print__u8_b_5:
   tya
   jsr CHROUT

   ; print value of bit 4
   txa
   and #%1000
   ldy #$30
   cmp #$0
   beq _print__u8_b_4
   ldy #$31
_print__u8_b_4:
   tya
   jsr CHROUT

   ; print value of bit 3
   txa
   and #%100
   ldy #$30
   cmp #$0
   beq _print__u8_b_3
   ldy #$31
_print__u8_b_3:
   tya
   jsr CHROUT

   ; print value of bit 2
   txa
   and #%10
   ldy #$30
   cmp #$0
   beq _print__u8_b_2
   ldy #$31
_print__u8_b_2:
   tya
   jsr CHROUT

   ; print value of bit 1
   txa
   and #%1
   ldy #$30
   cmp #$0
   beq _print__u8_b_1
   ldy #$31
_print__u8_b_1:
   tya
   jsr CHROUT

   rts
