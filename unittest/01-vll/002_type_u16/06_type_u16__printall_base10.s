;--------------------------------------------------------;
; PLATFORM BOILERPLATE                                   ;
;--------------------------------------------------------;
.include "x16.inc"

.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

   jmp fn_main

;--------------------------------------------------------;
; VARIABLE DEFINITIONS                                   ;
;--------------------------------------------------------;
var__main__f: ; type: file
   .byte $00, $00 ; ptr_addr (u16)
   .byte $00 ; mode (u8)
   .byte $00 ; device (u8)
   .byte $00 ; channel (u8)
   .byte $00 ; status (u8)
   .byte $00, $00 ; fname (u16)

var__main__cmpres: ; type: u8
   .byte $00

var__main__ctr: ; type: u16
   .byte $00, $00

var__main__stop: ; type: u16
   .byte $00, $00

str8_0x0000: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $24, $00 ; length (u16)
   .byte $24, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$36,$5F,$74,$79,$70,$65,$5F
   .byte $75,$31,$36,$5F,$5F,$70,$72,$69,$6E,$74
   .byte $61,$6C,$6C,$5F,$62,$61,$73,$65,$31,$30
   .byte $2E,$75,$74,$65,$73,$74
   .byte $00 ; null terminator (u8)

str8_0x0001: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2D, $00 ; length (u16)
   .byte $2D, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0002: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2D, $00 ; length (u16)
   .byte $2D, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$50,$72,$69,$6E,$74,$20,$61,$6C
   .byte $6C,$20,$76,$61,$6C,$75,$65,$73,$20,$6F
   .byte $66,$20,$61,$20,$75,$31,$36,$20,$69,$6E
   .byte $20,$62,$61,$73,$65,$31,$30,$20,$66,$6F
   .byte $72,$6D,$20,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x0003: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2D, $00 ; length (u16)
   .byte $2D, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

;--------------------------------------------------------;
; BUILT-IN FUNCTIONS                                     ;
;--------------------------------------------------------;
.global _close__file
.global _eval_eq__u16
.global _open__file
.global _print__endl
.global _print__str8
.global _print__u16
.global _setout__file
.global _setup__file
.global _shutdown


_close__file:
   ; close an open file
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO A FILE PTR TO BE CLOSED.       ;
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

   ; load channel number into A
   ldy #2
   lda (ZP_PTR_1),y
   jsr CLOSE
   rts


_eval_eq__u16:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO VALUE ONE.                     ;
   ; ZP_PTR_2 = POINTS TO VALUE TWO.                     ;
   ;-----------------------------------------------------;
   ; compare low byte first
   ldy #0
   lda (ZP_PTR_2),y
   cmp (ZP_PTR_1),y
   beq _eval_eq__u16__byte_2
   ; low byte not equal; exit now
   lda #0
   bra _eval_eq__u16__out

_eval_eq__u16__byte_2:
   ; now compare high byte
   ldy #1
   lda (ZP_PTR_2),y
   cmp (ZP_PTR_1),y
   beq _eval_eq__u16__true
   ; high byte not equal; exit now
   lda #0
   bra _eval_eq__u16__out
_eval_eq__u16__true:
   lda #1
_eval_eq__u16__out:
   rts


_open__file:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO FILE PTR TO BE OPENED.         ;
   ;-----------------------------------------------------;
   ; CLOBBERS ZP_PTR_2 and ZP_PTR_3.                     ;
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

   ; set ZP_PTR_2 to point to the str8 filename
   ldy #04
   lda (ZP_PTR_1),y
   sta ZP_PTR_2
   iny
   lda (ZP_PTR_1),y
   sta ZP_PTR_2+1

   ; ZP_PTR_2 now points to the str8 filename

   ; save a copy of the str8 pointer in ZP_PTR_3
   clc
   lda ZP_PTR_2
   adc #06 ; skip over: str_type (1), length (2), allocated (2), and elemsize (1)
   sta ZP_PTR_3
   lda ZP_PTR_2+1
   adc #0
   sta ZP_PTR_3+1

   ; load str8 length from ZP_PTR_2
   ldy #1
   lda (ZP_PTR_2),y

   ; adjust ZP_PTR_3 to point at str8 data
   ldx ZP_PTR_3
   ldy ZP_PTR_3+1
   
   ;-----------------------------------------------------;
   ; Set the name of the file to be opened               ;
   ;-----------------------------------------------------;
   jsr SETNAM

   ; store the device# within ZP_PTR_2
   ldy #01
   lda (ZP_PTR_1),y
   sta ZP_PTR_2

   ; store the mode within ZP_PTR_2+1
   ldy #0
   lda (ZP_PTR_1),y
   sta ZP_PTR_2+1

   ; load channel number into A
   ldy #2
   lda (ZP_PTR_1),y

   ldx ZP_PTR_2   ; device #
   ldy ZP_PTR_2+1 ; mode
   
   ;-----------------------------------------------------;
   ; Set other file parameters                           ;
   ;-----------------------------------------------------;
   jsr SETLFS
   
   ;-----------------------------------------------------;
   ; Open the File                                       ;
   ;-----------------------------------------------------;
   jsr OPEN
   rts


_print__endl:
   ; print an end of line character
   lda #$0D
   jsr CHROUT
   rts


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
print__str8_loop:
   cpy ZP_PTR_2
   beq print__str8_done
   cpx #1
   bne print__str8_unescaped
   ;-----------------------------------------------------;
   ; Has preceding escape char                           ;
   ;-----------------------------------------------------;
   lda (ZP_PTR_1),y
   cmp #$6E ; `n` character
   bne print__str8_check_backslash
   ; print an end of line character
   lda #$0D
   jsr CHROUT
   ldx #0
   iny
   bra print__str8_loop
print__str8_check_backslash:
   lda (ZP_PTR_1),y
   cmp #$5C ; backslash char
   bne print__str8_check_unhandled
   ; print out a backslash
   jsr CHROUT
   ldx #0
   iny
   bra print__str8_loop
print__str8_check_unhandled:
   ldx #0
   iny
   bra print__str8_loop
print__str8_unescaped:
   lda (ZP_PTR_1),y
   cmp #$5C ; backslash char
   bne print__str8_unescaped_print
   ; else: set escape flag and continue
   ldx #1
   iny
   bra print__str8_loop
print__str8_unescaped_print:
   jsr CHROUT
   iny
   bra print__str8_loop
print__str8_done:
   rts


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


_setout__file:
   ; change the default output to a file write
   ;-------------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO FILE PTR TO BE SET AS DEFAULT.   ;
   ;-------------------------------------------------------;
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

   ; load channel number into A
   ldy #2
   lda (ZP_PTR_1),y
   tax
   jsr CHKOUT
   rts


_setup__file:
   ; configure a file (prior to opening)
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO A FILE PTR TO BE CONFIGURED.   ;
   ; ZP_PTR_2 = POINTS TO A STRING PTR USED FOR FNAME.   ;
   ;-----------------------------------------------------;
   ; Get the location pointed to by the file pointer     ;
   ; (save it to ZP_PTR_1)                               ;
   ;-----------------------------------------------------;
   lda ZP_PTR_1
   sta ZP_PTR_3
   lda ZP_PTR_1+1
   sta ZP_PTR_3+1

   ldy #0
   lda (ZP_PTR_3),y
   sta ZP_PTR_1
   iny
   lda (ZP_PTR_3),y
   sta ZP_PTR_1+1
   ;-----------------------------------------------------;
   ; Get the location pointed to by the str8 pointer     ;
   ; (save it to ZP_PTR_2)                               ;
   ;-----------------------------------------------------;
   lda ZP_PTR_2
   sta ZP_PTR_3
   lda ZP_PTR_2+1
   sta ZP_PTR_3+1

   ldy #0
   lda (ZP_PTR_3),y
   sta ZP_PTR_2
   iny
   lda (ZP_PTR_3),y
   sta ZP_PTR_2+1

   ; ... f.mode = 1
   ldy #0
   lda #1
   sta (ZP_PTR_1),y
   ; ... f.device = 8
   iny
   lda #8
   sta (ZP_PTR_1),y
   ; ... f.channel = 1
   iny
   lda #1
   sta (ZP_PTR_1),y
   ; ... f.status = 0
   iny
   lda #1
   sta (ZP_PTR_1),y
   ; ... f.name = ...
   iny
   lda ZP_PTR_2
   sta (ZP_PTR_1),y
   iny
   lda ZP_PTR_2+1
   sta (ZP_PTR_1),y
   rts


_shutdown:
   ; shut off the system immediately
   ldx #$42
   ldy #$01
   lda #$00
   jsr $FEC9
   rts


;--------------------------------------------------------;
; INIT FUNCTION                                          ;
;--------------------------------------------------------;
fn__init: 
   ; ptr_init for `var__main__f`
   ldx #0
   lda #<(var__main__f+2)
   sta var__main__f,X
   inx
   lda #>(var__main__f+2)
   sta var__main__f,X

   ; ptr_init for `str8_0x0000`
   ldx #0
   lda #<(str8_0x0000+2)
   sta str8_0x0000,X
   inx
   lda #>(str8_0x0000+2)
   sta str8_0x0000,X

   ; ptr_init for `str8_0x0001`
   ldx #0
   lda #<(str8_0x0001+2)
   sta str8_0x0001,X
   inx
   lda #>(str8_0x0001+2)
   sta str8_0x0001,X

   ; ptr_init for `str8_0x0002`
   ldx #0
   lda #<(str8_0x0002+2)
   sta str8_0x0002,X
   inx
   lda #>(str8_0x0002+2)
   sta str8_0x0002,X

   ; ptr_init for `str8_0x0003`
   ldx #0
   lda #<(str8_0x0003+2)
   sta str8_0x0003,X
   inx
   lda #>(str8_0x0003+2)
   sta str8_0x0003,X

   rts

;--------------------------------------------------------;
; MAIN FUNCTION                                          ;
;--------------------------------------------------------;
fn_main: 
   ; set output mode to ISO
   lda #$0F
   jsr BSOUT

   ; run init fn
   jsr fn__init

   ; setup__file .f 'w' "@:06_type_u16__printall_base10.utest"
   lda #<var__main__f
   sta ZP_PTR_1
   lda #>var__main__f
   sta ZP_PTR_1+1
   lda #<str8_0x0000
   sta ZP_PTR_2
   lda #>str8_0x0000
   sta ZP_PTR_2+1
   jsr _setup__file

   ; open__file .f
   lda #<var__main__f
   sta ZP_PTR_1
   lda #>var__main__f
   sta ZP_PTR_1+1
   jsr _open__file

   ; setout__file .f
   lda #<var__main__f
   sta ZP_PTR_1
   lda #>var__main__f
   sta ZP_PTR_1+1
   jsr _setout__file

   ; print__str8 "#-------------------------------------------#"
   lda #<str8_0x0001
   sta ZP_PTR_1
   lda #>str8_0x0001
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# Print all values of a u16 in base10 form  #"
   lda #<str8_0x0002
   sta ZP_PTR_1
   lda #>str8_0x0002
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#-------------------------------------------#"
   lda #<str8_0x0003
   sta ZP_PTR_1
   lda #>str8_0x0003
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .ctr 0
   lda #<0
   sta var__main__ctr
   lda #>0
   sta var__main__ctr+1

   ; equals__u16_u16 .stop 65535
   lda #<65535
   sta var__main__stop
   lda #>65535
   sta var__main__stop+1

   ; loop
loop_0x0000:
   ; print__u16 .ctr
   ldx var__main__ctr
   ldy var__main__ctr+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; eval_eq__u16 .cmpres .ctr .stop
   lda #<var__main__ctr
   sta ZP_PTR_1
   lda #>var__main__ctr
   sta ZP_PTR_1+1
   lda #<var__main__stop
   sta ZP_PTR_2
   lda #>var__main__stop
   sta ZP_PTR_2+1
   jsr _eval_eq__u16
   sta var__main__cmpres

   ; if .cmpres
   lda var__main__cmpres
   cmp #1
   beq if_0x0000_true
   jmp if_0x0000_else

if_0x0000_true:
   ; endloop
   jmp loop_0x0000_out
   ; endif
if_0x0000_else:
if_0x0000_out:

   ; increment__u16 .ctr
   lda var__main__ctr
   clc ; clear carry
   adc #1
   sta var__main__ctr
   lda var__main__ctr+1
   adc #0
   sta var__main__ctr+1

   ; endloop
   jmp loop_0x0000
loop_0x0000_out:
   ; close__file .f
   lda #<var__main__f
   sta ZP_PTR_1
   lda #>var__main__f
   sta ZP_PTR_1+1
   jsr _close__file

   ; shutdown
   jsr _shutdown

   rts

