;[BUILTIN-BLOCK-START]
_print__u16:
   ;-----------------------------------------------------;
   ; X = LOW BYTE NUMBER TO BE PRINTED                   ;
   ; Y = HIGH BYTE NUMBER TO BE PRINTED                  ;
   ;-----------------------------------------------------;
   txa
   sta ZP_PTR_1 ; store the low byte of the number
   tya
   sta ZP_PTR_1+1 ; store the high byte of the number

   ;-----------------------------------------------------;
   ; We will store base ten values as bytes within the   ;
   ; first three general purpose registers.              ;
   ;-----------------------------------------------------;
   ldx #0 ; tracks if all numbers should be printed
   lda #0
   sta r0L ; b10 - byte 1
   sta r0H ; b10 - byte 2
   sta r1L ; b10 - byte 3
   sta r1H ; b10 - byte 4
   sta r2L ; b10 - byte 5

   lda ZP_PTR_1
   and #$01
   cmp #$01
   bne _print__u16__add_bit_2
   ;
   lda #$01
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_2:
   lda ZP_PTR_1
   and #$02
   cmp #$02
   bne _print__u16__add_bit_3
   ;
   lda #$02
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_3:
   lda ZP_PTR_1
   and #$04
   cmp #$04
   bne _print__u16__add_bit_4
   ;
   lda #$04
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_4:
   lda ZP_PTR_1
   and #$08
   cmp #$08
   bne _print__u16__add_bit_5
   ;
   lda #$08
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_5:
   lda ZP_PTR_1
   and #$10
   cmp #$10
   bne _print__u16__add_bit_6
   ;
   ; add 1 to tens place
   lda #1
   clc
   adc r0H
   sta r0H
   ; add 6 to ones place
   lda #6
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_6:
   lda ZP_PTR_1
   and #$20
   cmp #$20
   bne _print__u16__add_bit_7
   ;
   ; add 3 to tens place
   lda #3
   clc
   adc r0H
   sta r0H
   ; add 2 to ones place
   lda #2
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_7:
   lda ZP_PTR_1
   and #$40
   cmp #$40
   bne _print__u16__add_bit_8
   ;
   ; add 6 to tens place
   lda #6
   clc
   adc r0H
   sta r0H
   ; add 4 to ones place
   lda #4
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_8:
   lda ZP_PTR_1
   and #$80
   cmp #$80
   bne _print__u16__add_bit_9
   ;
   ; add 1 to hundreds place
   lda #1
   clc
   adc r1L
   sta r1L
   ; add 2 to tens place
   lda #2
   clc
   adc r0H
   sta r0H
   ; add 8 to ones place
   lda #8
   clc
   adc r0L
   sta r0L
;---------------------------------------------------------
_print__u16__add_bit_9:
   lda ZP_PTR_1+1
   and #$01
   cmp #$01
   bne _print__u16__add_bit_10
   ;
   ; add 2 to hundreds place
   lda #2
   clc
   adc r1L
   sta r1L
   ; add 5 to tens place
   lda #5
   clc
   adc r0H
   sta r0H
   ; add 6 to ones place
   lda #6
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_10:
   lda ZP_PTR_1+1
   and #$02
   cmp #$02
   bne _print__u16__add_bit_11
   ;
   ; add 5 to hundreds place
   lda #5
   clc
   adc r1L
   sta r1L
   ; add 1 to tens place
   lda #1
   clc
   adc r0H
   sta r0H
   ; add 2 to ones place
   lda #2
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_11:
   lda ZP_PTR_1+1
   and #$04
   cmp #$04
   bne _print__u16__add_bit_12
   ;
   ; add 1 to thousands place
   lda #1
   clc
   adc r1H
   sta r1H
   ; add 2 to tens place
   lda #2
   clc
   adc r0H
   sta r0H
   ; add 4 to ones place
   lda #4
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_12:
   lda ZP_PTR_1+1
   and #$08
   cmp #$08
   bne _print__u16__add_bit_13
   ;
   ; add 2 to thousands place
   lda #2
   clc
   adc r1H
   sta r1H
   ; add 4 to tens place
   lda #4
   clc
   adc r0H
   sta r0H
   ; add 8 to ones place
   lda #8
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_13:
   lda ZP_PTR_1+1
   and #$10
   cmp #$10
   bne _print__u16__add_bit_14
   ;
   ; add 4 to thousands place
   lda #4
   clc
   adc r1H
   sta r1H
   ; add 9 to tens place
   lda #9
   clc
   adc r0H
   sta r0H
   ; add 6 to ones place
   lda #6
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_14:
   lda ZP_PTR_1+1
   and #$20
   cmp #$20
   bne _print__u16__add_bit_15
   ;
   ; add 8 to thousands place
   lda #8
   clc
   adc r1H
   sta r1H
   ; add 1 to hundreds place
   lda #1
   clc
   adc r1L
   sta r1L
   ; add 9 to tens place
   lda #9
   clc
   adc r0H
   sta r0H
   ; add 2 to ones place
   lda #2
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_15:
   lda ZP_PTR_1+1
   and #$40
   cmp #$40
   bne _print__u16__add_bit_16
   ;
   ; add 1 to ten-thousands place
   lda #1
   clc
   adc r2L
   sta r2L
   ; add 6 to thousands place
   lda #6
   clc
   adc r1H
   sta r1H
   ; add 3 to hundreds place
   lda #3
   clc
   adc r1L
   sta r1L
   ; add 8 to tens place
   lda #8
   clc
   adc r0H
   sta r0H
   ; add 4 to ones place
   lda #4
   clc
   adc r0L
   sta r0L
_print__u16__add_bit_16:
   lda ZP_PTR_1+1
   and #$80
   cmp #$80
   bne _print__u16__carry_1s
   ;
   ; add 3 to ten-thousands place
   lda #3
   clc
   adc r2L
   sta r2L
   ; add 2 to thousands place
   lda #2
   clc
   adc r1H
   sta r1H
   ; add 7 to hundreds place
   lda #7
   clc
   adc r1L
   sta r1L
   ; add 6 to tens place
   lda #6
   clc
   adc r0H
   sta r0H
   ; add 8 to ones place
   lda #8
   clc
   adc r0L
   sta r0L


_print__u16__carry_1s:
   ; check byte 1 (1s place) for carries
   lda r0L
   sec
   sbc #10
   bmi _print__u16__carry_10s
   ; else: carry a ten and try again
   lda r0L
   sec
   sbc #10
   sta r0L
   lda r0H
   clc
   adc #1
   sta r0H
   jmp _print__u16__carry_1s

_print__u16__carry_10s:
   ; check byte 2 (10s place) for carries
   lda r0H
   sec
   sbc #10
   bmi _print__u16__carry_100s
   ; else: carry over value and try again
   lda r0H
   sec
   sbc #10
   sta r0H
   lda r1L
   clc
   adc #1
   sta r1L
   jmp _print__u16__carry_10s

_print__u16__carry_100s:
   ; check byte 3 (100s place) for carries
   lda r1L
   sec
   sbc #10
   bmi _print__u16__carry_1000s
   ; else: carry over value and try again
   lda r1L
   sec
   sbc #10
   sta r1L
   lda r1H
   clc
   adc #1
   sta r1H
   jmp _print__u16__carry_100s

_print__u16__carry_1000s:
   ; check byte 3 (1000s place) for carries
   lda r1H
   sec
   sbc #10
   bmi _print__u16__show_values
   ; else: carry over value and try again
   lda r1H
   sec
   sbc #10
   sta r1H
   lda r2L
   clc
   adc #1
   sta r2L
   jmp _print__u16__carry_1000s


_print__u16__show_values:
   ;-----------------------------------------------------;
   ; Finally print out the calculated base 10 value.     ;
   ;-----------------------------------------------------;
   ; b10 byte 5
   lda r2L
   cmp #0
   beq _print__u16__show_byte_4
   ;
   lda r2L
   clc
   adc #$30 ; point to 0 + remainder
   jsr CHROUT
   ; set x to 1 to indicate that a char was printed
   ldx #1

_print__u16__show_byte_4:
   ; b10 byte 4
   cpx #1
   beq _print__u16__show_byte_4_always
   lda r1H
   cmp #0
   beq _print__u16__show_byte_3
   ldx #1
_print__u16__show_byte_4_always:
   lda r1H
   clc
   adc #$30 ; point to 0 + remainder
   jsr CHROUT

_print__u16__show_byte_3:
   ; b10 byte 3
   cpx #1
   beq _print__u16__show_byte_3_always
   lda r1L
   cmp #0
   beq _print__u16__show_byte_2
   ldx #1
_print__u16__show_byte_3_always:
   lda r1L
   clc
   adc #$30 ; point to 0 + remainder
   jsr CHROUT

_print__u16__show_byte_2:
   ; b10 byte 2
   cpx #1
   beq _print__u16__show_byte_2_always
   lda r0H
   cmp #0
   beq _print__u16__show_byte_1
   ldx #1
_print__u16__show_byte_2_always:
   lda r0H
   clc
   adc #$30 ; point to 0 + remainder
   jsr CHROUT

_print__u16__show_byte_1:
   ; b10 byte 1
   lda r0L
   clc
   adc #$30 ; point to 0 + remainder
   jsr CHROUT

   rts
