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

var__main__a: ; type: u16
   .byte $00, $00

var__main__b: ; type: u16
   .byte $00, $00

var__main__cmpres: ; type: u8
   .byte $00

str8_0x0000: ; type: str8
   .byte $17 ; length (u8)
   .byte $17 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$33,$5F,$65,$76,$61,$6C,$5F
   .byte $75,$31,$36,$5F,$5F,$67,$74,$2E,$75,$74
   .byte $65,$73,$74
   .byte $00 ; null terminator (u8)

str8_0x0001: ; type: str8
   .byte $29 ; length (u8)
   .byte $29 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x0002: ; type: str8
   .byte $29 ; length (u8)
   .byte $29 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$65,$76,$61,$6C,$2D,$67,$74,$20
   .byte $28,$75,$31,$36,$29,$20,$20,$20,$20,$20
   .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x0003: ; type: str8
   .byte $29 ; length (u8)
   .byte $29 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x0004: ; type: str8
   .byte $26 ; length (u8)
   .byte $26 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$63,$6F,$6D,$70,$61,$72,$69,$73,$6F
   .byte $6E,$73,$20,$6F,$66,$20,$76,$61,$6C,$75
   .byte $65,$73,$20,$3C,$20,$32,$35,$35
   .byte $00 ; null terminator (u8)

str8_0x0005: ; type: str8
   .byte $08 ; length (u8)
   .byte $08 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3E,$20,$35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0006: ; type: str8
   .byte $09 ; length (u8)
   .byte $09 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3E,$20,$31,$30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0007: ; type: str8
   .byte $09 ; length (u8)
   .byte $09 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3E,$20,$31,$35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0008: ; type: str8
   .byte $26 ; length (u8)
   .byte $26 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$63,$6F,$6D,$70,$61,$72,$69,$73,$6F
   .byte $6E,$73,$20,$6F,$66,$20,$76,$61,$6C,$75
   .byte $65,$73,$20,$3E,$20,$32,$35,$35
   .byte $00 ; null terminator (u8)

str8_0x0009: ; type: str8
   .byte $0C ; length (u8)
   .byte $0C ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$20,$3E,$20,$35,$30,$30
   .byte $3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000A: ; type: str8
   .byte $0D ; length (u8)
   .byte $0D ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$20,$3E,$20,$31,$30,$30
   .byte $30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000B: ; type: str8
   .byte $0D ; length (u8)
   .byte $0D ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$20,$3E,$20,$31,$35,$30
   .byte $30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000C: ; type: str8
   .byte $29 ; length (u8)
   .byte $29 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x000D: ; type: str8
   .byte $29 ; length (u8)
   .byte $29 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$65,$76,$61,$6C,$2D,$67,$74,$65
   .byte $71,$20,$28,$75,$31,$36,$29,$20,$20,$20
   .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x000E: ; type: str8
   .byte $29 ; length (u8)
   .byte $29 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x000F: ; type: str8
   .byte $26 ; length (u8)
   .byte $26 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$63,$6F,$6D,$70,$61,$72,$69,$73,$6F
   .byte $6E,$73,$20,$6F,$66,$20,$76,$61,$6C,$75
   .byte $65,$73,$20,$3C,$20,$32,$35,$35
   .byte $00 ; null terminator (u8)

str8_0x0010: ; type: str8
   .byte $09 ; length (u8)
   .byte $09 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3E,$3D,$20,$35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0011: ; type: str8
   .byte $0A ; length (u8)
   .byte $0A ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3E,$3D,$20,$31,$30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0012: ; type: str8
   .byte $0A ; length (u8)
   .byte $0A ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3E,$3D,$20,$31,$35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0013: ; type: str8
   .byte $26 ; length (u8)
   .byte $26 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$63,$6F,$6D,$70,$61,$72,$69,$73,$6F
   .byte $6E,$73,$20,$6F,$66,$20,$76,$61,$6C,$75
   .byte $65,$73,$20,$3E,$20,$32,$35,$35
   .byte $00 ; null terminator (u8)

str8_0x0014: ; type: str8
   .byte $0D ; length (u8)
   .byte $0D ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$20,$3E,$3D,$20,$35,$30
   .byte $30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0015: ; type: str8
   .byte $0E ; length (u8)
   .byte $0E ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$20,$3E,$3D,$20,$31,$30
   .byte $30,$30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0016: ; type: str8
   .byte $0E ; length (u8)
   .byte $0E ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$20,$3E,$3D,$20,$31,$35
   .byte $30,$30,$3A,$20
   .byte $00 ; null terminator (u8)

;--------------------------------------------------------;
; BUILT-IN FUNCTIONS                                     ;
;--------------------------------------------------------;
.global _close__file
.global _eval_gt__u16
.global _eval_gteq__u16
.global _eval_lt__u16
.global _eval_lteq__u16
.global _open__file
.global _print__bool
.global _print__endl
.global _print__str8
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


_eval_gt__u16:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO VALUE ONE.                     ;
   ; ZP_PTR_2 = POINTS TO VALUE TWO.                     ;
   ;-----------------------------------------------------;
   jsr _eval_lteq__u16
   ; flip the value returned by `<=`
   cmp #1
   beq _eval_gt__u16__false
   lda #1
   bra _eval_gt__u16__out
_eval_gt__u16__false:
   lda #0
_eval_gt__u16__out:
   rts


_eval_gteq__u16:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO VALUE ONE.                     ;
   ; ZP_PTR_2 = POINTS TO VALUE TWO.                     ;
   ;-----------------------------------------------------;
   jsr _eval_lt__u16
   ; flip the value returned by `<`
   cmp #1
   beq _eval_gteq__u16__false
   lda #1
   bra _eval_gteq__u16__out
_eval_gteq__u16__false:
   lda #0
_eval_gteq__u16__out:
   rts


_eval_lt__u16:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO VALUE ONE.                     ;
   ; ZP_PTR_2 = POINTS TO VALUE TWO.                     ;
   ;-----------------------------------------------------;
   ; compare high byte first
   ldy #1
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lt__u16__true   ; high-byte is less than; exit now
   beq _eval_lt__u16__byte_2 ; high-byte is same.. check low-byte
   ; high byte greater-than; exit now
   lda #0
   bra _eval_lt__u16__out

_eval_lt__u16__byte_2:
   ; now compare the low bytes
   ldy #0
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lt__u16__true
   ; low byte not less-than; exit now
   lda #0
   bra _eval_lt__u16__out
_eval_lt__u16__true:
   lda #1
_eval_lt__u16__out:
   rts


_eval_lteq__u16:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO VALUE ONE.                     ;
   ; ZP_PTR_2 = POINTS TO VALUE TWO.                     ;
   ;-----------------------------------------------------;
   ; compare high byte first
   ldy #1
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lteq__u16__true   ; high-byte is less than; exit now
   beq _eval_lteq__u16__byte_2 ; high-byte is same.. check low-byte
   ; high byte greater-than; exit now
   lda #0
   bra _eval_lteq__u16__out

_eval_lteq__u16__byte_2:
   ; now compare the low bytes
   ldy #0
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lteq__u16__true ; low-byte is less than; exit now
   beq _eval_lteq__u16__true ; low-byte is equal-to; exit now
   ; low byte is greater-than; exit now
   lda #0
   bra _eval_lteq__u16__out
_eval_lteq__u16__true:
   lda #1
_eval_lteq__u16__out:
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


_print__bool:
   ;-----------------------------------------------------;
   ; A = STARTS WITH BOOL TO BE PRINTED                  ;
   ;-----------------------------------------------------;
   cmp #0
   beq _print__bool__false
   lda #'t'
   jsr CHROUT
   lda #'r'
   jsr CHROUT
   lda #'u'
   jsr CHROUT
   lda #'e'
   jsr CHROUT
   jmp _print__bool__out
_print__bool__false:
   lda #'f'
   jsr CHROUT
   lda #'a'
   jsr CHROUT
   lda #'l'
   jsr CHROUT
   lda #'s'
   jsr CHROUT
   lda #'e'
   jsr CHROUT
_print__bool__out:
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

   ; setup__file .f 'w' "@:03_eval_u16__gt.utest"
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

   ; ... f.name = "@:03_eval_u16__gt.utest"
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

   ; print__str8 "#---------------------------------------#"
   lda #<str8_0x0001
   sta ZP_PTR_1
   lda #>str8_0x0001
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# eval-gt (u16)                         #"
   lda #<str8_0x0002
   sta ZP_PTR_1
   lda #>str8_0x0002
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#---------------------------------------#"
   lda #<str8_0x0003
   sta ZP_PTR_1
   lda #>str8_0x0003
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# test out comparisons of values < 255"
   lda #<str8_0x0004
   sta ZP_PTR_1
   lda #>str8_0x0004
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 10
   lda #<10
   sta var__main__a
   lda #>10
   sta var__main__a+1

   ; equals__u16_u16 .b 5
   lda #<5
   sta var__main__b
   lda #>5
   sta var__main__b+1

   ; eval_gt__u16 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_gt__u16
   sta var__main__cmpres

   ; print__str8 "10 > 5: "
   lda #<str8_0x0005
   sta ZP_PTR_1
   lda #>str8_0x0005
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 10
   lda #<10
   sta var__main__a
   lda #>10
   sta var__main__a+1

   ; equals__u16_u16 .b 10
   lda #<10
   sta var__main__b
   lda #>10
   sta var__main__b+1

   ; eval_gt__u16 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_gt__u16
   sta var__main__cmpres

   ; print__str8 "10 > 10: "
   lda #<str8_0x0006
   sta ZP_PTR_1
   lda #>str8_0x0006
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 10
   lda #<10
   sta var__main__a
   lda #>10
   sta var__main__a+1

   ; equals__u16_u16 .b 15
   lda #<15
   sta var__main__b
   lda #>15
   sta var__main__b+1

   ; eval_gt__u16 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_gt__u16
   sta var__main__cmpres

   ; print__str8 "10 > 15: "
   lda #<str8_0x0007
   sta ZP_PTR_1
   lda #>str8_0x0007
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; print__str8 "# test out comparisons of values > 255"
   lda #<str8_0x0008
   sta ZP_PTR_1
   lda #>str8_0x0008
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 1000
   lda #<1000
   sta var__main__a
   lda #>1000
   sta var__main__a+1

   ; equals__u16_u16 .b 500
   lda #<500
   sta var__main__b
   lda #>500
   sta var__main__b+1

   ; eval_gt__u16 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_gt__u16
   sta var__main__cmpres

   ; print__str8 "1000 > 500: "
   lda #<str8_0x0009
   sta ZP_PTR_1
   lda #>str8_0x0009
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 1000
   lda #<1000
   sta var__main__a
   lda #>1000
   sta var__main__a+1

   ; equals__u16_u16 .b 1000
   lda #<1000
   sta var__main__b
   lda #>1000
   sta var__main__b+1

   ; eval_gt__u16 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_gt__u16
   sta var__main__cmpres

   ; print__str8 "1000 > 1000: "
   lda #<str8_0x000A
   sta ZP_PTR_1
   lda #>str8_0x000A
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 1000
   lda #<1000
   sta var__main__a
   lda #>1000
   sta var__main__a+1

   ; equals__u16_u16 .b 1500
   lda #<1500
   sta var__main__b
   lda #>1500
   sta var__main__b+1

   ; eval_gt__u16 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_gt__u16
   sta var__main__cmpres

   ; print__str8 "1000 > 1500: "
   lda #<str8_0x000B
   sta ZP_PTR_1
   lda #>str8_0x000B
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; print__str8 "#---------------------------------------#"
   lda #<str8_0x000C
   sta ZP_PTR_1
   lda #>str8_0x000C
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# eval-gteq (u16)                       #"
   lda #<str8_0x000D
   sta ZP_PTR_1
   lda #>str8_0x000D
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#---------------------------------------#"
   lda #<str8_0x000E
   sta ZP_PTR_1
   lda #>str8_0x000E
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# test out comparisons of values < 255"
   lda #<str8_0x000F
   sta ZP_PTR_1
   lda #>str8_0x000F
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 10
   lda #<10
   sta var__main__a
   lda #>10
   sta var__main__a+1

   ; equals__u16_u16 .b 5
   lda #<5
   sta var__main__b
   lda #>5
   sta var__main__b+1

   ; _eval_gteq__u16 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_gteq__u16
   sta var__main__cmpres

   ; print__str8 "10 >= 5: "
   lda #<str8_0x0010
   sta ZP_PTR_1
   lda #>str8_0x0010
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 10
   lda #<10
   sta var__main__a
   lda #>10
   sta var__main__a+1

   ; equals__u16_u16 .b 10
   lda #<10
   sta var__main__b
   lda #>10
   sta var__main__b+1

   ; _eval_gteq__u16 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_gteq__u16
   sta var__main__cmpres

   ; print__str8 "10 >= 10: "
   lda #<str8_0x0011
   sta ZP_PTR_1
   lda #>str8_0x0011
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 10
   lda #<10
   sta var__main__a
   lda #>10
   sta var__main__a+1

   ; equals__u16_u16 .b 15
   lda #<15
   sta var__main__b
   lda #>15
   sta var__main__b+1

   ; _eval_gteq__u16 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_gteq__u16
   sta var__main__cmpres

   ; print__str8 "10 >= 15: "
   lda #<str8_0x0012
   sta ZP_PTR_1
   lda #>str8_0x0012
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; print__str8 "# test out comparisons of values > 255"
   lda #<str8_0x0013
   sta ZP_PTR_1
   lda #>str8_0x0013
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 1000
   lda #<1000
   sta var__main__a
   lda #>1000
   sta var__main__a+1

   ; equals__u16_u16 .b 500
   lda #<500
   sta var__main__b
   lda #>500
   sta var__main__b+1

   ; _eval_gteq__u16 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_gteq__u16
   sta var__main__cmpres

   ; print__str8 "1000 >= 500: "
   lda #<str8_0x0014
   sta ZP_PTR_1
   lda #>str8_0x0014
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 1000
   lda #<1000
   sta var__main__a
   lda #>1000
   sta var__main__a+1

   ; equals__u16_u16 .b 1000
   lda #<1000
   sta var__main__b
   lda #>1000
   sta var__main__b+1

   ; _eval_gteq__u16 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_gteq__u16
   sta var__main__cmpres

   ; print__str8 "1000 >= 1000: "
   lda #<str8_0x0015
   sta ZP_PTR_1
   lda #>str8_0x0015
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 1000
   lda #<1000
   sta var__main__a
   lda #>1000
   sta var__main__a+1

   ; equals__u16_u16 .b 1500
   lda #<1500
   sta var__main__b
   lda #>1500
   sta var__main__b+1

   ; _eval_gteq__u16 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_gteq__u16
   sta var__main__cmpres

   ; print__str8 "1000 >= 1500: "
   lda #<str8_0x0016
   sta ZP_PTR_1
   lda #>str8_0x0016
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; close__file .f
   lda #<var__main__f
   sta ZP_PTR_1
   lda #>var__main__f
   sta ZP_PTR_1+1
   jsr _close__file

   ; shutdown
   jsr _shutdown

   rts

