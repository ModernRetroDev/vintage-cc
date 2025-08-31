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

var__main__c: ; type: u8
   .byte $00

str8_0x0000: ; type: str8
   .byte $1D ; length (u8)
   .byte $1D ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$32,$5F,$74,$79,$70,$65,$5F
   .byte $75,$31,$36,$5F,$5F,$61,$64,$64,$69,$74
   .byte $69,$6F,$6E,$2E,$75,$74,$65,$73,$74
   .byte $00 ; null terminator (u8)

str8_0x0001: ; type: str8
   .byte $27 ; length (u8)
   .byte $27 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0002: ; type: str8
   .byte $27 ; length (u8)
   .byte $27 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$75,$31,$36,$20,$61,$64,$64,$69
   .byte $74,$69,$6F,$6E,$20,$28,$73,$6D,$61,$6C
   .byte $6C,$20,$75,$31,$36,$20,$76,$61,$6C,$75
   .byte $65,$73,$29,$20,$20,$20,$20,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x0003: ; type: str8
   .byte $27 ; length (u8)
   .byte $27 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0004: ; type: str8
   .byte $27 ; length (u8)
   .byte $27 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$61,$64,$64,$69,$74,$69,$6F,$6E,$20
   .byte $6F,$66,$20,$75,$31,$36,$20,$76,$61,$6C
   .byte $75,$65,$73,$20,$3C,$20,$32,$35,$35
   .byte $00 ; null terminator (u8)

str8_0x0005: ; type: str8
   .byte $20 ; length (u8)
   .byte $20 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$61,$64,$64,$20,$61,$20
   .byte $75,$38,$20,$76,$61,$72,$20,$74,$6F,$20
   .byte $61,$20,$31,$36,$20,$76,$61,$72,$20,$2A
   .byte $2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0006: ; type: str8
   .byte $17 ; length (u8)
   .byte $17 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$2B,$20,$31,$30,$20,$3D,$20
   .byte $32,$30,$20,$28,$24,$30,$30,$31,$34,$29
   .byte $3A,$20,$24
   .byte $00 ; null terminator (u8)

str8_0x0007: ; type: str8
   .byte $26 ; length (u8)
   .byte $26 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$61,$64,$64,$20,$74,$77
   .byte $6F,$20,$75,$31,$36,$20,$76,$61,$72,$69
   .byte $61,$62,$6C,$65,$73,$20,$74,$6F,$67,$65
   .byte $74,$68,$65,$72,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0008: ; type: str8
   .byte $16 ; length (u8)
   .byte $16 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$2B,$20,$35,$20,$3D,$20,$31
   .byte $35,$20,$28,$24,$30,$30,$30,$66,$29,$3A
   .byte $20,$24
   .byte $00 ; null terminator (u8)

str8_0x0009: ; type: str8
   .byte $24 ; length (u8)
   .byte $24 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$61,$64,$64,$20,$61,$20
   .byte $64,$69,$72,$65,$63,$74,$20,$75,$38,$20
   .byte $74,$6F,$20,$61,$20,$75,$31,$36,$20,$76
   .byte $61,$72,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x000A: ; type: str8
   .byte $16 ; length (u8)
   .byte $16 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$2B,$20,$33,$20,$3D,$20,$31
   .byte $33,$20,$28,$24,$30,$30,$30,$64,$29,$3A
   .byte $20,$24
   .byte $00 ; null terminator (u8)

str8_0x000B: ; type: str8
   .byte $25 ; length (u8)
   .byte $25 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$61,$64,$64,$20,$61,$20
   .byte $64,$69,$72,$65,$63,$74,$20,$75,$31,$36
   .byte $20,$74,$6F,$20,$61,$20,$75,$31,$36,$20
   .byte $76,$61,$72,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x000C: ; type: str8
   .byte $19 ; length (u8)
   .byte $19 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$2B,$20,$32,$35,$36,$20,$3D
   .byte $20,$32,$36,$36,$20,$28,$24,$30,$31,$30
   .byte $61,$29,$3A,$20,$24
   .byte $00 ; null terminator (u8)

str8_0x000D: ; type: str8
   .byte $27 ; length (u8)
   .byte $27 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x000E: ; type: str8
   .byte $27 ; length (u8)
   .byte $27 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$75,$31,$36,$20,$61,$64,$64,$69
   .byte $74,$69,$6F,$6E,$20,$28,$6C,$61,$72,$67
   .byte $65,$20,$75,$31,$36,$20,$76,$61,$6C,$75
   .byte $65,$73,$29,$20,$20,$20,$20,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x000F: ; type: str8
   .byte $27 ; length (u8)
   .byte $27 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0010: ; type: str8
   .byte $27 ; length (u8)
   .byte $27 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$61,$64,$64,$69,$74,$69,$6F,$6E,$20
   .byte $6F,$66,$20,$75,$31,$36,$20,$76,$61,$6C
   .byte $75,$65,$73,$20,$3E,$20,$32,$35,$35
   .byte $00 ; null terminator (u8)

str8_0x0011: ; type: str8
   .byte $20 ; length (u8)
   .byte $20 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$61,$64,$64,$20,$61,$20
   .byte $75,$38,$20,$76,$61,$72,$20,$74,$6F,$20
   .byte $61,$20,$31,$36,$20,$76,$61,$72,$20,$2A
   .byte $2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0012: ; type: str8
   .byte $18 ; length (u8)
   .byte $18 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $32,$35,$36,$20,$2B,$20,$31,$30,$20,$3D
   .byte $20,$32,$30,$20,$28,$24,$30,$31,$30,$61
   .byte $29,$3A,$20,$24
   .byte $00 ; null terminator (u8)

str8_0x0013: ; type: str8
   .byte $26 ; length (u8)
   .byte $26 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$61,$64,$64,$20,$74,$77
   .byte $6F,$20,$75,$31,$36,$20,$76,$61,$72,$69
   .byte $61,$62,$6C,$65,$73,$20,$74,$6F,$67,$65
   .byte $74,$68,$65,$72,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0014: ; type: str8
   .byte $18 ; length (u8)
   .byte $18 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $32,$35,$36,$20,$2B,$20,$35,$20,$3D,$20
   .byte $32,$36,$31,$20,$28,$24,$30,$31,$30,$35
   .byte $29,$3A,$20,$24
   .byte $00 ; null terminator (u8)

str8_0x0015: ; type: str8
   .byte $24 ; length (u8)
   .byte $24 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$61,$64,$64,$20,$61,$20
   .byte $64,$69,$72,$65,$63,$74,$20,$75,$38,$20
   .byte $74,$6F,$20,$61,$20,$75,$31,$36,$20,$76
   .byte $61,$72,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0016: ; type: str8
   .byte $18 ; length (u8)
   .byte $18 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $32,$35,$36,$20,$2B,$20,$33,$20,$3D,$20
   .byte $32,$35,$39,$20,$28,$24,$30,$31,$30,$33
   .byte $29,$3A,$20,$24
   .byte $00 ; null terminator (u8)

str8_0x0017: ; type: str8
   .byte $25 ; length (u8)
   .byte $25 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$61,$64,$64,$20,$61,$20
   .byte $64,$69,$72,$65,$63,$74,$20,$75,$31,$36
   .byte $20,$74,$6F,$20,$61,$20,$75,$31,$36,$20
   .byte $76,$61,$72,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0018: ; type: str8
   .byte $1A ; length (u8)
   .byte $1A ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $32,$35,$36,$20,$2B,$20,$32,$35,$36,$20
   .byte $3D,$20,$35,$31,$32,$20,$28,$24,$30,$32
   .byte $30,$30,$29,$3A,$20,$24
   .byte $00 ; null terminator (u8)

;--------------------------------------------------------;
; BUILT-IN FUNCTIONS                                     ;
;--------------------------------------------------------;
.global _close__file
.global _open__file
.global _plus_equals__u16_u16
.global _plus_equals__u16_u8
.global _print__endl
.global _print__str8
.global _print__u16_x
.global _print__u8_x
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


_plus_equals__u16_u16:
   ;-----------------------------------------------------;
   ; Adds a U16 from `ZP_PTR_2` to a U16.                ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING ADDED TO.      ;
   ; ZP_PTR_2 = POINTS TO U16 VALUE BEING ADDED.         ;
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
   adc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   rts

_plus_equals__u16_u16d:
   ;-----------------------------------------------------;
   ; Adds a U16 from registers `A,X` to a U16.           ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING ADDED TO.      ;
   ; A = LOW BYTE OF U16 VALUE TO BE ADDED               ;
   ; X = HIGH BYTE OF U16 VALUE TO BE ADDED              ;
   ;-----------------------------------------------------;
   ; add to low byte
   clc
   ldy #0
   adc (ZP_PTR_1),y
   sta (ZP_PTR_1),y
   ; carry over to high byte
   txa
   ldy #1
   adc (ZP_PTR_1),y
   sta (ZP_PTR_1),y
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


_print__u16_x:
   ;-----------------------------------------------------;
   ; X = LOW BYTE NUMBER TO BE PRINTED                   ;
   ; Y = HIGH BYTE NUMBER TO BE PRINTED                  ;
   ;-----------------------------------------------------;
   txa
   sta ZP_PTR_1 ; store the low byte of the number
   tya
   sta ZP_PTR_1+1 ; store the high byte of the number

   jsr _print__u8_x ; print out high byte

   lda ZP_PTR_1 ; load low byte of the number
   jsr _print__u8_x ; print out low byte
   rts


_print__u8_x:
   ;-----------------------------------------------------;
   ; A = STARTS WITH NUMBER TO BE PRINTED                ;
   ;-----------------------------------------------------;
   tax ; store A value within X
   ; isolate the upper nibble
   lsr
   lsr
   lsr
   lsr

   cmp #10 ; compare A with `10`
   bcc _print__u8_x__arabic_hi; if A < 10 goto `arabic_hi`

   ; digit is an alpha;
   ; SUBTRACT 10 FROM WORKING NUMBER ;
   sec ; set carry flag
   sbc #10 ; subtract `10` from A
   clc
   adc #97 ; add `97` to A
   jsr CHROUT
   bra _print__u8_x__low

_print__u8_x__arabic_hi:
   ;
   clc ; clear carry
   adc #$30 ; point to 0 + remainder
   jsr CHROUT

_print__u8_x__low:
   txa ; store X value within A
   ; isolate the lower nibble
   and #$0F

   cmp #10 ; compare A with `10`
   bcc _print__u8_x__arabic_low; if A < 10 goto `arabic_low`

   ; digit is an alpha;
   sbc #10 ; subtract `10` from A
   clc
   adc #97 ; add `97` to A
   jsr CHROUT
   bra _print__u8_x__out

_print__u8_x__arabic_low:
   ;
   clc ; clear carry
   adc #$30 ; point to 0 + remainder
   jsr CHROUT

_print__u8_x__out:
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

   ; setup__file .f 'w' "@:02_type_u16__addition.utest"
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

   ; ... f.name = "@:02_type_u16__addition.utest"
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

   ; print__str8 "#-------------------------------------#"
   lda #<str8_0x0001
   sta ZP_PTR_1
   lda #>str8_0x0001
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# u16 addition (small u16 values)     #"
   lda #<str8_0x0002
   sta ZP_PTR_1
   lda #>str8_0x0002
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#-------------------------------------#"
   lda #<str8_0x0003
   sta ZP_PTR_1
   lda #>str8_0x0003
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# test out addition of u16 values < 255"
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

   ; equals__u8_u8 .c 10
   lda #10
   sta var__main__c

   ; plus_equals__u16_u8 .a .c
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__c
   sta ZP_PTR_2
   lda #>var__main__c
   sta ZP_PTR_2+1
   jsr _plus_equals__u16_u8

   ; print__str8 "*** add a u8 var to a 16 var ***"
   lda #<str8_0x0005
   sta ZP_PTR_1
   lda #>str8_0x0005
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "10 + 10 = 20 ($0014): $"
   lda #<str8_0x0006
   sta ZP_PTR_1
   lda #>str8_0x0006
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16_x .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16_x

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

   ; plus_equals__u16_u16 .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _plus_equals__u16_u16

   ; print__str8 "*** add two u16 variables together ***"
   lda #<str8_0x0007
   sta ZP_PTR_1
   lda #>str8_0x0007
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "10 + 5 = 15 ($000f): $"
   lda #<str8_0x0008
   sta ZP_PTR_1
   lda #>str8_0x0008
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16_x .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16_x

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 10
   lda #<10
   sta var__main__a
   lda #>10
   sta var__main__a+1

   ; plus_equals__u16_u16 .a 3
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #3
   jsr _plus_equals__u16_u8d

   ; print__str8 "*** add a direct u8 to a u16 var ***"
   lda #<str8_0x0009
   sta ZP_PTR_1
   lda #>str8_0x0009
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "10 + 3 = 13 ($000d): $"
   lda #<str8_0x000A
   sta ZP_PTR_1
   lda #>str8_0x000A
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16_x .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16_x

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 10
   lda #<10
   sta var__main__a
   lda #>10
   sta var__main__a+1

   ; plus_equals__u16_u16 .a 256
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<256
   ldx #>256
   jsr _plus_equals__u16_u16d

   ; print__str8 "*** add a direct u16 to a u16 var ***"
   lda #<str8_0x000B
   sta ZP_PTR_1
   lda #>str8_0x000B
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "10 + 256 = 266 ($010a): $"
   lda #<str8_0x000C
   sta ZP_PTR_1
   lda #>str8_0x000C
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16_x .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16_x

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; print__str8 "#-------------------------------------#"
   lda #<str8_0x000D
   sta ZP_PTR_1
   lda #>str8_0x000D
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# u16 addition (large u16 values)     #"
   lda #<str8_0x000E
   sta ZP_PTR_1
   lda #>str8_0x000E
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#-------------------------------------#"
   lda #<str8_0x000F
   sta ZP_PTR_1
   lda #>str8_0x000F
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# test out addition of u16 values > 255"
   lda #<str8_0x0010
   sta ZP_PTR_1
   lda #>str8_0x0010
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 256
   lda #<256
   sta var__main__a
   lda #>256
   sta var__main__a+1

   ; equals__u8_u8 .c 10
   lda #10
   sta var__main__c

   ; plus_equals__u16_u8 .a .c
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__c
   sta ZP_PTR_2
   lda #>var__main__c
   sta ZP_PTR_2+1
   jsr _plus_equals__u16_u8

   ; print__str8 "*** add a u8 var to a 16 var ***"
   lda #<str8_0x0011
   sta ZP_PTR_1
   lda #>str8_0x0011
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "256 + 10 = 20 ($010a): $"
   lda #<str8_0x0012
   sta ZP_PTR_1
   lda #>str8_0x0012
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16_x .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16_x

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 256
   lda #<256
   sta var__main__a
   lda #>256
   sta var__main__a+1

   ; equals__u16_u16 .b 5
   lda #<5
   sta var__main__b
   lda #>5
   sta var__main__b+1

   ; plus_equals__u16_u16 .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _plus_equals__u16_u16

   ; print__str8 "*** add two u16 variables together ***"
   lda #<str8_0x0013
   sta ZP_PTR_1
   lda #>str8_0x0013
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "256 + 5 = 261 ($0105): $"
   lda #<str8_0x0014
   sta ZP_PTR_1
   lda #>str8_0x0014
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16_x .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16_x

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 256
   lda #<256
   sta var__main__a
   lda #>256
   sta var__main__a+1

   ; plus_equals__u16_u8 .a 3
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #3
   jsr _plus_equals__u16_u8d

   ; print__str8 "*** add a direct u8 to a u16 var ***"
   lda #<str8_0x0015
   sta ZP_PTR_1
   lda #>str8_0x0015
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "256 + 3 = 259 ($0103): $"
   lda #<str8_0x0016
   sta ZP_PTR_1
   lda #>str8_0x0016
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16_x .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16_x

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 256
   lda #<256
   sta var__main__a
   lda #>256
   sta var__main__a+1

   ; plus_equals__u16_u16 .a 256
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<256
   ldx #>256
   jsr _plus_equals__u16_u16d

   ; print__str8 "*** add a direct u16 to a u16 var ***"
   lda #<str8_0x0017
   sta ZP_PTR_1
   lda #>str8_0x0017
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "256 + 256 = 512 ($0200): $"
   lda #<str8_0x0018
   sta ZP_PTR_1
   lda #>str8_0x0018
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16_x .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16_x

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

