;--------------------------------------------------------;
; PLATFORM BOILERPLATE                                   ;
;--------------------------------------------------------;
.include "x16.inc"

.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

   jmp main

;--------------------------------------------------------;
; VARIABLE DEFINITIONS                                   ;
;--------------------------------------------------------;
var__main__f: ; type: file
   .byte $00 ; mode (u8)
   .byte $00 ; device (u8)
   .byte $00 ; channel (u8)
   .byte $00 ; status (u8)
   .byte $00, $00 ; fname (u16)

var__main__ctr: ; type: u8
   .byte $00

var__main__nxt: ; type: u8
   .byte $00

var__main__cmpres: ; type: u8
   .byte $00

var__main__ptr: ; type: ptr
   .byte $00, $00

str8_0x0000: ; type: str8
   .byte $1B ; length (u8)
   .byte $1B ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$32,$5F,$61,$72,$72,$61,$79
   .byte $5F,$5F,$6C,$6F,$61,$64,$73,$74,$6F,$72
   .byte $65,$2E,$75,$74,$65,$73,$74
   .byte $00 ; null terminator (u8)

str8_0x0001: ; type: str8
   .byte $2E ; length (u8)
   .byte $2E ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0002: ; type: str8
   .byte $2E ; length (u8)
   .byte $2E ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$70,$72,$69,$6E,$74,$20,$69,$6E
   .byte $69,$74,$69,$61,$6C,$20,$76,$61,$6C,$75
   .byte $65,$73,$20,$66,$72,$6F,$6D,$20,$77,$69
   .byte $74,$68,$69,$6E,$20,$74,$68,$65,$20,$61
   .byte $72,$72,$61,$79,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x0003: ; type: str8
   .byte $2E ; length (u8)
   .byte $2E ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0004: ; type: str8
   .byte $02 ; length (u8)
   .byte $02 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$20
   .byte $00 ; null terminator (u8)

str8_0x0005: ; type: str8
   .byte $24 ; length (u8)
   .byte $24 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0006: ; type: str8
   .byte $24 ; length (u8)
   .byte $24 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$61,$64,$64,$20,$31,$20,$74,$6F
   .byte $20,$61,$6C,$6C,$20,$76,$61,$6C,$75,$65
   .byte $73,$20,$6F,$66,$20,$74,$68,$65,$20,$61
   .byte $72,$72,$61,$79,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x0007: ; type: str8
   .byte $24 ; length (u8)
   .byte $24 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0008: ; type: str8
   .byte $2C ; length (u8)
   .byte $2C ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0009: ; type: str8
   .byte $2C ; length (u8)
   .byte $2C ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$70,$72,$69,$6E,$74,$20,$66,$69
   .byte $6E,$61,$6C,$20,$76,$61,$6C,$75,$65,$73
   .byte $20,$66,$72,$6F,$6D,$20,$77,$69,$74,$68
   .byte $69,$6E,$20,$74,$68,$65,$20,$61,$72,$72
   .byte $61,$79,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x000A: ; type: str8
   .byte $2C ; length (u8)
   .byte $2C ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x000B: ; type: str8
   .byte $02 ; length (u8)
   .byte $02 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$20
   .byte $00 ; null terminator (u8)

arr8__main__array: ; type: arr8__u8
   .byte $0A ; length (u8)
   .byte $0A ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $02,$04,$06,$08,$0A,$0C,$0E,$10,$12,$14

;--------------------------------------------------------;
; BUILT-IN FUNCTIONS                                     ;
;--------------------------------------------------------;
.global _close__file
.global _div_by_10__u8
.global _mul_by_10__u8
.global _open__file
.global _plus_equals__u16_u8
.global _print__endl
.global _print__str8
.global _print__u8
.global _setout__file
.global _shutdown


_close__file:
   ; close an open file
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO FILE TO BE CLOSED.             ;
   ;-----------------------------------------------------;
   ; load channel number into A
   ldy #2
   lda (ZP_PTR_1),y
   jsr CLOSE
   rts


_div_by_10__u8:
   ;-----------------------------------------------------;
   ; A = STARTS WITH NUMBER TO BE DIVIDED BY 10          ;
   ;-----------------------------------------------------;
   ; X = STORES WORKING NUMBER                           ;
   ; Y = RESULT REGISTER                                 ;
   ;-----------------------------------------------------;
   tax ; copy A to X
   lda #0 ; put 0 into A
   tay ; store 0 in Y

   ;-----------------------------------------------------;
   ; Check if Number is greater than 160                 ;
   ;-----------------------------------------------------;
   txa ; copy working number back into A
   cmp #160 ; compare A with 160
   bcc _div_by_10__u8__ck80; branch if < 160

   ; SUBTRACT 160 FROM WORKING NUMBER ;
   sec ; set carry flag
   sbc #160 ; subtract `160` from A
   tax ; copy A to X
   lda %00010000
   tay

_div_by_10__u8__ck80:
   ;-----------------------------------------------------;
   ; Check if Number is greater than 80                  ;
   ;-----------------------------------------------------;
   txa ; copy working number back into A
   cmp #80 ; compare A with 80
   bcc _div_by_10__u8__ck40; branch if < 80

   ; SUBTRACT 80 FROM WORKING NUMBER ;
   sec ; set carry flag
   sbc #80 ; subtract `80` from A
   tax ; copy A to X

   ; UPDATE RESULT REGISTER
   tya ; copy Y to A
   clc ; clear carry flag
   adc #%00001000
   tay

_div_by_10__u8__ck40:
   ;-----------------------------------------------------;
   ; Check if Number is greater than 40                  ;
   ;-----------------------------------------------------;
   txa ; copy working number back into A
   cmp #40 ; compare A with 40
   bcc _div_by_10__u8__ck20; branch if < 40

   ; SUBTRACT 40 FROM WORKING NUMBER ;
   sec ; set carry flag
   sbc #40 ; subtract `40` from A
   tax ; copy A to X

   ; UPDATE RESULT REGISTER
   tya ; copy Y to A
   clc ; clear carry flag
   adc #%00000100
   tay

_div_by_10__u8__ck20:
   ;-----------------------------------------------------;
   ; Check if Number is greater than 20                  ;
   ;-----------------------------------------------------;
   txa ; copy working number back into A
   cmp #20 ; compare A with 20
   bcc _div_by_10__u8__ck10; branch if < 20

   ; SUBTRACT 20 FROM WORKING NUMBER ;
   sec ; set carry flag
   sbc #20 ; subtract `20` from A
   tax ; copy A to X

   ; UPDATE RESULT REGISTER
   tya ; copy Y to A
   clc ; clear carry flag
   adc #%00000010
   tay

_div_by_10__u8__ck10:
   ;-----------------------------------------------------;
   ; Check if Number is greater than 10                  ;
   ;-----------------------------------------------------;
   txa ; copy working number back into A
   cmp #10 ; compare A with 10
   bcc _div_by_10__u8__done; branch if < 10

   ; SUBTRACT 10 FROM WORKING NUMBER ;
   ; sec ; set carry flag
   ; sbc #20 ; subtract `20` from A
   ; tax ; copy A to X

   ; UPDATE RESULT REGISTER
   tya ; copy Y to A
   clc ; clear carry flag
   adc #%00000001
   tay

_div_by_10__u8__done:
   ;-----------------------------------------------------;
   ; FINAL RESULT IS STORED WITHIN Y; MOVE IT TO A       ;
   ;-----------------------------------------------------;
   tya
   rts


_mul_by_10__u8:
   ;-----------------------------------------------------;
   ; A = STARTS WITH NUMBER TO BE MULTIPLIED BY 10       ;
   ;-----------------------------------------------------;
   tax ; save a copy of A within X
   asl ; shift A left by one bit
   tay ; save a copy of A within Y
   asl ; shift A left by one bit
   asl ; shift A left by one bit
   sta ZP_PTR_2 ; store A value to ZERO PAGE
   tya ; copy Y back into A

   clc ; clear carry
   adc ZP_PTR_2
   ; A now contains the result ;
   rts


_open__file:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO FILE TO BE OPENED.             ;
   ;-----------------------------------------------------;
   ; CLOBBERS ZP_PTR_2 and ZP_PTR_3.                     ;
   ;-----------------------------------------------------;
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
   adc #03 ; skip over: length, allocated, and elemsize
   sta ZP_PTR_3
   lda ZP_PTR_2+1
   adc #0
   sta ZP_PTR_3+1

   ; load str8 length from ZP_PTR_2
   ldy #0
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


_plus_equals__u16_u8:
   ;-----------------------------------------------------;
   ; Adds a U8 from `ZP_PTR_2` to a U16.                 ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING ADDED TO.      ;
   ; ZP_PTR_2 = POINTS TO U8 VALUE BEING ADDED.          ;
   ;-----------------------------------------------------;
   ; add to low byte
   clc
   ldy #0
   lda (ZP_PTR_1),y
   adc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   ; carry over to high byte
   ldy #1
   lda (ZP_PTR_1),y
   adc #0
   sta (ZP_PTR_1),y
   rts

_plus_equals__u16_u8d:
   ;-----------------------------------------------------;
   ; Adds a U8 from register `A` to a U16.               ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING ADDED TO.      ;
   ; A = U8 VALUE TO BE ADDED                            ;
   ;-----------------------------------------------------;
   ; add to low byte
   clc
   ldy #0
   adc (ZP_PTR_1),y
   sta (ZP_PTR_1),y
   ; carry over to high byte
   ldy #1
   lda (ZP_PTR_1),y
   adc #0
   sta (ZP_PTR_1),y
   rts


_print__endl:
   ; print an end of line character
   lda #$0D
   jsr CHROUT
   rts


_print__str8:
   ; print out a string of characters
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO STRING TO BE PRINTED.          ;
   ;-----------------------------------------------------;
   ; zero out iteration counter, Y
   ldy #0
   ; store str8 length to ZP_PTR_2
   lda (ZP_PTR_1),y
   sta ZP_PTR_2
   ; increment ZP_PTR_1 by 3 bytes
   clc
   lda ZP_PTR_1
   adc #3
   sta ZP_PTR_1
   lda ZP_PTR_1+1
   adc #0
   sta ZP_PTR_1+1
print__str8_loop:
   cpy ZP_PTR_2
   beq print__str8_done
   lda (ZP_PTR_1),y
   jsr CHROUT
   iny
   bra print__str8_loop
print__str8_done:
   rts


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


_setout__file:
   ; change the default output to a file write
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO FILE TO BE SET AS DEFAULT.     ;
   ;-----------------------------------------------------;
   ; load channel number into A
   ldy #2
   lda (ZP_PTR_1),y
   tax
   jsr CHKOUT
   rts


_shutdown:
   ; shut off the system immediately
   ldx #$42
   ldy #$01
   lda #$00
   jsr $FEC9
   rts


;--------------------------------------------------------;
; MAIN FUNCTION                                          ;
;--------------------------------------------------------;
main: 
   ; set output mode to ISO
   lda #$0F
   jsr BSOUT

   ; setup__file .f 'w' "@:02_array__loadstore.utest"
   ; ... f.mode = 1
   ldx #0
   lda #1
   sta var__main__f,X

   ; ... f.device = 8
   inx
   lda #8
   sta var__main__f,X

   ; ... f.channel = 1
   inx
   lda #1
   sta var__main__f,X

   ; ... f.status = 0
   inx
   lda #0
   sta var__main__f,X

   ; ... f.name = "@:02_array__loadstore.utest"
   inx
   lda #<str8_0x0000
   sta var__main__f,X
   inx
   lda #>str8_0x0000
   sta var__main__f,X

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

   ; print__str8 "#--------------------------------------------#"
   lda #<str8_0x0001
   sta ZP_PTR_1
   lda #>str8_0x0001
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# print initial values from within the array #"
   lda #<str8_0x0002
   sta ZP_PTR_1
   lda #>str8_0x0002
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#--------------------------------------------#"
   lda #<str8_0x0003
   sta ZP_PTR_1
   lda #>str8_0x0003
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .ctr 0
   lda #0
   sta var__main__ctr

   ; loop
loop_0x0000:
   ; eval_eq__u8 .cmpres .ctr 10
   lda var__main__ctr
   cmp #10
   beq eval_0x0000
   lda #0; false
   bra eval_0x0000_out
eval_0x0000:
   lda #1; true
eval_0x0000_out:
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

   ; print__u8 .ctr
   lda var__main__ctr
   jsr _print__u8

   ; print__str8 "  "
   lda #<str8_0x0004
   sta ZP_PTR_1
   lda #>str8_0x0004
   sta ZP_PTR_1+1
   jsr _print__str8

   ; ref__arr8 .ptr .array .ctr
   ; hop over 3 bytes to point at data
   clc
   lda #<arr8__main__array
   adc #3
   sta var__main__ptr
   lda #>arr8__main__array
   adc #0
   sta var__main__ptr+1
   lda #<var__main__ptr
   sta ZP_PTR_1
   lda #>var__main__ptr
   sta ZP_PTR_1+1
   lda #<var__main__ctr
   sta ZP_PTR_2
   lda #>var__main__ctr
   sta ZP_PTR_2+1
   jsr _plus_equals__u16_u8

   ; load__u8 .nxt .ptr
   lda #<var__main__ptr
   sta ZP_PTR_1
   lda #>var__main__ptr
   sta ZP_PTR_1+1
   ldy #0
   lda (ZP_PTR_1),y
   sta ZP_PTR_2
   ldy #1
   lda (ZP_PTR_1),y
   sta ZP_PTR_2+1
   ldy #0
   lda (ZP_PTR_2),y
   sta var__main__nxt

   ; print__u8 .nxt
   lda var__main__nxt
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; increment__u8 .ctr
   lda var__main__ctr
   clc ; clear carry
   adc #1
   sta var__main__ctr

   ; endloop
   jmp loop_0x0000
loop_0x0000_out:
   ; print__str8 "#----------------------------------#"
   lda #<str8_0x0005
   sta ZP_PTR_1
   lda #>str8_0x0005
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# add 1 to all values of the array #"
   lda #<str8_0x0006
   sta ZP_PTR_1
   lda #>str8_0x0006
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#----------------------------------#"
   lda #<str8_0x0007
   sta ZP_PTR_1
   lda #>str8_0x0007
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .ctr 0
   lda #0
   sta var__main__ctr

   ; loop
loop_0x0001:
   ; eval_eq__u8 .cmpres .ctr 10
   lda var__main__ctr
   cmp #10
   beq eval_0x0001
   lda #0; false
   bra eval_0x0001_out
eval_0x0001:
   lda #1; true
eval_0x0001_out:
   sta var__main__cmpres

   ; if .cmpres
   lda var__main__cmpres
   cmp #1
   beq if_0x0001_true
   jmp if_0x0001_else

if_0x0001_true:
   ; endloop
   jmp loop_0x0001_out
   ; endif
if_0x0001_else:
if_0x0001_out:

   ; ref__arr8 .ptr .array .ctr
   ; hop over 3 bytes to point at data
   clc
   lda #<arr8__main__array
   adc #3
   sta var__main__ptr
   lda #>arr8__main__array
   adc #0
   sta var__main__ptr+1
   lda #<var__main__ptr
   sta ZP_PTR_1
   lda #>var__main__ptr
   sta ZP_PTR_1+1
   lda #<var__main__ctr
   sta ZP_PTR_2
   lda #>var__main__ctr
   sta ZP_PTR_2+1
   jsr _plus_equals__u16_u8

   ; load__u8 .nxt .ptr
   lda #<var__main__ptr
   sta ZP_PTR_1
   lda #>var__main__ptr
   sta ZP_PTR_1+1
   ldy #0
   lda (ZP_PTR_1),y
   sta ZP_PTR_2
   ldy #1
   lda (ZP_PTR_1),y
   sta ZP_PTR_2+1
   ldy #0
   lda (ZP_PTR_2),y
   sta var__main__nxt

   ; increment__u8 .nxt
   lda var__main__nxt
   clc ; clear carry
   adc #1
   sta var__main__nxt

   ; print__u8 .nxt
   lda var__main__nxt
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; store__u8 .ptr .nxt
   lda #<var__main__ptr
   sta ZP_PTR_1
   lda #>var__main__ptr
   sta ZP_PTR_1+1
   ldy #0
   lda (ZP_PTR_1),y
   sta ZP_PTR_2
   ldy #1
   lda (ZP_PTR_1),y
   sta ZP_PTR_2+1
   ldy #0
   lda var__main__nxt
   sta (ZP_PTR_2),y

   ; increment__u8 .ctr
   lda var__main__ctr
   clc ; clear carry
   adc #1
   sta var__main__ctr

   ; endloop
   jmp loop_0x0001
loop_0x0001_out:
   ; print__str8 "#------------------------------------------#"
   lda #<str8_0x0008
   sta ZP_PTR_1
   lda #>str8_0x0008
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# print final values from within the array #"
   lda #<str8_0x0009
   sta ZP_PTR_1
   lda #>str8_0x0009
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#------------------------------------------#"
   lda #<str8_0x000A
   sta ZP_PTR_1
   lda #>str8_0x000A
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .ctr 0
   lda #0
   sta var__main__ctr

   ; loop
loop_0x0002:
   ; eval_eq__u8 .cmpres .ctr 10
   lda var__main__ctr
   cmp #10
   beq eval_0x0002
   lda #0; false
   bra eval_0x0002_out
eval_0x0002:
   lda #1; true
eval_0x0002_out:
   sta var__main__cmpres

   ; if .cmpres
   lda var__main__cmpres
   cmp #1
   beq if_0x0002_true
   jmp if_0x0002_else

if_0x0002_true:
   ; endloop
   jmp loop_0x0002_out
   ; endif
if_0x0002_else:
if_0x0002_out:

   ; print__u8 .ctr
   lda var__main__ctr
   jsr _print__u8

   ; print__str8 "  "
   lda #<str8_0x000B
   sta ZP_PTR_1
   lda #>str8_0x000B
   sta ZP_PTR_1+1
   jsr _print__str8

   ; ref__arr8 .ptr .array .ctr
   ; hop over 3 bytes to point at data
   clc
   lda #<arr8__main__array
   adc #3
   sta var__main__ptr
   lda #>arr8__main__array
   adc #0
   sta var__main__ptr+1
   lda #<var__main__ptr
   sta ZP_PTR_1
   lda #>var__main__ptr
   sta ZP_PTR_1+1
   lda #<var__main__ctr
   sta ZP_PTR_2
   lda #>var__main__ctr
   sta ZP_PTR_2+1
   jsr _plus_equals__u16_u8

   ; load__u8 .nxt .ptr
   lda #<var__main__ptr
   sta ZP_PTR_1
   lda #>var__main__ptr
   sta ZP_PTR_1+1
   ldy #0
   lda (ZP_PTR_1),y
   sta ZP_PTR_2
   ldy #1
   lda (ZP_PTR_1),y
   sta ZP_PTR_2+1
   ldy #0
   lda (ZP_PTR_2),y
   sta var__main__nxt

   ; print__u8 .nxt
   lda var__main__nxt
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; increment__u8 .ctr
   lda var__main__ctr
   clc ; clear carry
   adc #1
   sta var__main__ctr

   ; endloop
   jmp loop_0x0002
loop_0x0002_out:
   ; close__file .f
   lda #<var__main__f
   sta ZP_PTR_1
   lda #>var__main__f
   sta ZP_PTR_1+1
   jsr _close__file

   ; shutdown
   jsr _shutdown

   rts

