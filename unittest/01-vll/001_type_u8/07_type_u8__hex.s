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

var__main__a: ; type: u8
   .byte $00

var__main__b: ; type: u8
   .byte $00

str8_0x0000: ; type: str8
   .byte $17 ; length (u8)
   .byte $17 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$37,$5F,$74,$79,$70,$65,$5F
   .byte $75,$38,$5F,$5F,$68,$65,$78,$2E,$75,$74
   .byte $65,$73,$74
   .byte $00 ; null terminator (u8)

str8_0x0001: ; type: str8
   .byte $2B ; length (u8)
   .byte $2B ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0002: ; type: str8
   .byte $2B ; length (u8)
   .byte $2B ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$75,$38,$20,$73,$70,$65,$63,$69
   .byte $66,$69,$65,$64,$20,$61,$73,$20,$68,$65
   .byte $78,$61,$64,$65,$63,$69,$6D,$61,$6C,$20
   .byte $6E,$75,$6D,$62,$65,$72,$73,$20,$20,$20
   .byte $20,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x0003: ; type: str8
   .byte $2B ; length (u8)
   .byte $2B ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0004: ; type: str8
   .byte $27 ; length (u8)
   .byte $27 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$70,$72,$69,$6E,$74,$20
   .byte $6F,$75,$74,$20,$61,$20,$66,$65,$77,$20
   .byte $62,$69,$6E,$61,$72,$79,$20,$75,$38,$20
   .byte $76,$61,$6C,$75,$65,$73,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0005: ; type: str8
   .byte $11 ; length (u8)
   .byte $11 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$20,$28,$30
   .byte $29,$20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0006: ; type: str8
   .byte $11 ; length (u8)
   .byte $11 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$31,$20,$28,$31
   .byte $29,$20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0007: ; type: str8
   .byte $11 ; length (u8)
   .byte $11 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$32,$20,$28,$32
   .byte $29,$20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0008: ; type: str8
   .byte $11 ; length (u8)
   .byte $11 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$34,$20,$28,$34
   .byte $29,$20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0009: ; type: str8
   .byte $11 ; length (u8)
   .byte $11 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$38,$20,$28,$38
   .byte $29,$20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x000A: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$31,$30,$20,$28,$31
   .byte $36,$29,$20,$3A,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x000B: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$32,$30,$20,$28,$33
   .byte $32,$29,$20,$3A,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x000C: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$34,$30,$20,$28,$36
   .byte $34,$29,$20,$3A,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x000D: ; type: str8
   .byte $0F ; length (u8)
   .byte $0F ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$38,$30,$20,$28,$31
   .byte $32,$38,$29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000E: ; type: str8
   .byte $0F ; length (u8)
   .byte $0F ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$46,$46,$20,$28,$32
   .byte $35,$35,$29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000F: ; type: str8
   .byte $3A ; length (u8)
   .byte $3A ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$70,$72,$69,$6E,$74,$20
   .byte $6F,$75,$74,$20,$61,$20,$66,$65,$77,$20
   .byte $62,$69,$6E,$61,$72,$79,$20,$75,$38,$20
   .byte $76,$61,$6C,$75,$65,$73,$3B,$20,$6E,$6F
   .byte $20,$6C,$65,$61,$64,$69,$6E,$67,$20,$7A
   .byte $65,$72,$6F,$73,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0010: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$20,$28,$30,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0011: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$31,$20,$28,$31,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0012: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$32,$20,$28,$32,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0013: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$33,$20,$28,$33,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0014: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$34,$20,$28,$34,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0015: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$35,$20,$28,$35,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0016: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$36,$20,$28,$36,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0017: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$37,$20,$28,$37,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0018: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$38,$20,$28,$38,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0019: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$39,$20,$28,$39,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x001A: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$41,$20,$28,$31,$30
   .byte $29,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x001B: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$42,$20,$28,$31,$31
   .byte $29,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x001C: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$43,$20,$28,$31,$32
   .byte $29,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x001D: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$44,$20,$28,$31,$33
   .byte $29,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x001E: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$45,$20,$28,$31,$34
   .byte $29,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x001F: ; type: str8
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$46,$20,$28,$31,$35
   .byte $29,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

;--------------------------------------------------------;
; BUILT-IN FUNCTIONS                                     ;
;--------------------------------------------------------;
.global _close__file
.global _div_by_10__u8
.global _mul_by_10__u8
.global _open__file
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
   ; zero out escape char indicator, X
   ldx #0
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
fn_main: 
   ; set output mode to ISO
   lda #$0F
   jsr BSOUT

   ; setup__file .f 'w' "@:07_type_u8__hex.utest"
   ; ... f.ptr_addr[0] = #<(var__main__f+2)
   ldx #0
   lda #<(var__main__f+2)
   sta var__main__f,X

   ; ... f.ptr_addr[1] = #>(var__main__f+2)
   inx
   lda #>(var__main__f+2)
   sta var__main__f,X

   ; ... f.mode = 1
   inx
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

   ; ... f.name = "@:07_type_u8__hex.utest"
   inx
   lda #<str8_0x0000
   sta var__main__f,X
   inx
   lda #>str8_0x0000
   sta var__main__f,X

   ; open__file .f
   lda #<var__main__f
   sta ZP_PTR_2
   lda #>var__main__f
   sta ZP_PTR_2+1
   ldy #0
   lda (ZP_PTR_2),y
   sta ZP_PTR_1
   iny
   lda (ZP_PTR_2),y
   sta ZP_PTR_1+1
   jsr _open__file

   ; setout__file .f
   lda #<var__main__f
   sta ZP_PTR_2
   lda #>var__main__f
   sta ZP_PTR_2+1
   ldy #0
   lda (ZP_PTR_2),y
   sta ZP_PTR_1
   iny
   lda (ZP_PTR_2),y
   sta ZP_PTR_1+1
   jsr _setout__file

   ; print__str8 "#-----------------------------------------#"
   lda #<str8_0x0001
   sta ZP_PTR_1
   lda #>str8_0x0001
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# u8 specified as hexadecimal numbers     #"
   lda #<str8_0x0002
   sta ZP_PTR_1
   lda #>str8_0x0002
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#-----------------------------------------#"
   lda #<str8_0x0003
   sta ZP_PTR_1
   lda #>str8_0x0003
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; print__str8 "*** print out a few binary u8 values***"
   lda #<str8_0x0004
   sta ZP_PTR_1
   lda #>str8_0x0004
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x00
   lda #0
   sta var__main__a

   ; print__str8 " * 0x00 (0)  :   "
   lda #<str8_0x0005
   sta ZP_PTR_1
   lda #>str8_0x0005
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x01
   lda #1
   sta var__main__a

   ; print__str8 " * 0x01 (1)  :   "
   lda #<str8_0x0006
   sta ZP_PTR_1
   lda #>str8_0x0006
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x02
   lda #2
   sta var__main__a

   ; print__str8 " * 0x02 (2)  :   "
   lda #<str8_0x0007
   sta ZP_PTR_1
   lda #>str8_0x0007
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x04
   lda #4
   sta var__main__a

   ; print__str8 " * 0x04 (4)  :   "
   lda #<str8_0x0008
   sta ZP_PTR_1
   lda #>str8_0x0008
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x08
   lda #8
   sta var__main__a

   ; print__str8 " * 0x08 (8)  :   "
   lda #<str8_0x0009
   sta ZP_PTR_1
   lda #>str8_0x0009
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x10
   lda #16
   sta var__main__a

   ; print__str8 " * 0x10 (16) :  "
   lda #<str8_0x000A
   sta ZP_PTR_1
   lda #>str8_0x000A
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x20
   lda #32
   sta var__main__a

   ; print__str8 " * 0x20 (32) :  "
   lda #<str8_0x000B
   sta ZP_PTR_1
   lda #>str8_0x000B
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x40
   lda #64
   sta var__main__a

   ; print__str8 " * 0x40 (64) :  "
   lda #<str8_0x000C
   sta ZP_PTR_1
   lda #>str8_0x000C
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x80
   lda #128
   sta var__main__a

   ; print__str8 " * 0x80 (128): "
   lda #<str8_0x000D
   sta ZP_PTR_1
   lda #>str8_0x000D
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0xFF
   lda #255
   sta var__main__a

   ; print__str8 " * 0xFF (255): "
   lda #<str8_0x000E
   sta ZP_PTR_1
   lda #>str8_0x000E
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; print__str8 "*** print out a few binary u8 values; no leading zeros ***"
   lda #<str8_0x000F
   sta ZP_PTR_1
   lda #>str8_0x000F
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x0
   lda #0
   sta var__main__a

   ; print__str8 " * 0x0 (0)  :   "
   lda #<str8_0x0010
   sta ZP_PTR_1
   lda #>str8_0x0010
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x1
   lda #1
   sta var__main__a

   ; print__str8 " * 0x1 (1)  :   "
   lda #<str8_0x0011
   sta ZP_PTR_1
   lda #>str8_0x0011
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x2
   lda #2
   sta var__main__a

   ; print__str8 " * 0x2 (2)  :   "
   lda #<str8_0x0012
   sta ZP_PTR_1
   lda #>str8_0x0012
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x3
   lda #3
   sta var__main__a

   ; print__str8 " * 0x3 (3)  :   "
   lda #<str8_0x0013
   sta ZP_PTR_1
   lda #>str8_0x0013
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x4
   lda #4
   sta var__main__a

   ; print__str8 " * 0x4 (4)  :   "
   lda #<str8_0x0014
   sta ZP_PTR_1
   lda #>str8_0x0014
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x5
   lda #5
   sta var__main__a

   ; print__str8 " * 0x5 (5)  :   "
   lda #<str8_0x0015
   sta ZP_PTR_1
   lda #>str8_0x0015
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x6
   lda #6
   sta var__main__a

   ; print__str8 " * 0x6 (6)  :   "
   lda #<str8_0x0016
   sta ZP_PTR_1
   lda #>str8_0x0016
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x7
   lda #7
   sta var__main__a

   ; print__str8 " * 0x7 (7)  :   "
   lda #<str8_0x0017
   sta ZP_PTR_1
   lda #>str8_0x0017
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x8
   lda #8
   sta var__main__a

   ; print__str8 " * 0x8 (8)  :   "
   lda #<str8_0x0018
   sta ZP_PTR_1
   lda #>str8_0x0018
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0x9
   lda #9
   sta var__main__a

   ; print__str8 " * 0x9 (9)  :   "
   lda #<str8_0x0019
   sta ZP_PTR_1
   lda #>str8_0x0019
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0xA
   lda #10
   sta var__main__a

   ; print__str8 " * 0xA (10) :   "
   lda #<str8_0x001A
   sta ZP_PTR_1
   lda #>str8_0x001A
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0xB
   lda #11
   sta var__main__a

   ; print__str8 " * 0xB (11) :   "
   lda #<str8_0x001B
   sta ZP_PTR_1
   lda #>str8_0x001B
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0xC
   lda #12
   sta var__main__a

   ; print__str8 " * 0xC (12) :   "
   lda #<str8_0x001C
   sta ZP_PTR_1
   lda #>str8_0x001C
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0xD
   lda #13
   sta var__main__a

   ; print__str8 " * 0xD (13) :   "
   lda #<str8_0x001D
   sta ZP_PTR_1
   lda #>str8_0x001D
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0xE
   lda #14
   sta var__main__a

   ; print__str8 " * 0xE (14) :   "
   lda #<str8_0x001E
   sta ZP_PTR_1
   lda #>str8_0x001E
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 0xF
   lda #15
   sta var__main__a

   ; print__str8 " * 0xF (15) :   "
   lda #<str8_0x001F
   sta ZP_PTR_1
   lda #>str8_0x001F
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u8 .a
   lda var__main__a
   jsr _print__u8

   ; print__endl
   jsr _print__endl

   ; close__file .f
   lda #<var__main__f
   sta ZP_PTR_2
   lda #>var__main__f
   sta ZP_PTR_2+1
   ldy #0
   lda (ZP_PTR_2),y
   sta ZP_PTR_1
   iny
   lda (ZP_PTR_2),y
   sta ZP_PTR_1+1
   jsr _close__file

   ; shutdown
   jsr _shutdown

   rts

