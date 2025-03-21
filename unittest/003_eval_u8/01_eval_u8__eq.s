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

var__main__cmpres: ; type: u8
   .byte $00

str8_0x0000: ; type: str8
   .byte $16 ; length (u8)
   .byte $16 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$31,$5F,$65,$76,$61,$6C,$5F
   .byte $75,$38,$5F,$5F,$65,$71,$2E,$75,$74,$65
   .byte $73,$74
   .byte $00 ; null terminator (u8)

str8_0x0001: ; type: str8
   .byte $22 ; length (u8)
   .byte $22 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0002: ; type: str8
   .byte $22 ; length (u8)
   .byte $22 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$65,$76,$61,$6C,$75,$61,$74,$69
   .byte $6F,$6E,$20,$6F,$66,$20,$65,$71,$75,$61
   .byte $6C,$69,$74,$79,$20,$63,$68,$65,$63,$6B
   .byte $73,$20,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x0003: ; type: str8
   .byte $22 ; length (u8)
   .byte $22 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0004: ; type: str8
   .byte $0C ; length (u8)
   .byte $0C ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $69,$66,$20,$28,$35,$20,$3D,$3D,$20,$35
   .byte $29,$3A
   .byte $00 ; null terminator (u8)

str8_0x0005: ; type: str8
   .byte $13 ; length (u8)
   .byte $13 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$20,$20,$61,$3A,$20,$5B,$69,$66,$20
   .byte $77,$61,$73,$20,$74,$72,$75,$65,$5D
   .byte $00 ; null terminator (u8)

str8_0x0006: ; type: str8
   .byte $14 ; length (u8)
   .byte $14 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$20,$20,$61,$3A,$20,$5B,$69,$66,$20
   .byte $77,$61,$73,$20,$66,$61,$6C,$73,$65,$5D
   .byte $00 ; null terminator (u8)

str8_0x0007: ; type: str8
   .byte $0C ; length (u8)
   .byte $0C ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $69,$66,$20,$28,$35,$20,$3D,$3D,$20,$36
   .byte $29,$3A
   .byte $00 ; null terminator (u8)

str8_0x0008: ; type: str8
   .byte $13 ; length (u8)
   .byte $13 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$20,$20,$62,$3A,$20,$5B,$69,$66,$20
   .byte $77,$61,$73,$20,$74,$72,$75,$65,$5D
   .byte $00 ; null terminator (u8)

str8_0x0009: ; type: str8
   .byte $14 ; length (u8)
   .byte $14 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$20,$20,$62,$3A,$20,$5B,$69,$66,$20
   .byte $77,$61,$73,$20,$66,$61,$6C,$73,$65,$5D
   .byte $00 ; null terminator (u8)

;--------------------------------------------------------;
; BUILT-IN FUNCTIONS                                     ;
;--------------------------------------------------------;
.global _close__file
.global _open__file
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

   ; setup__file .f 'w' "@:01_eval_u8__eq.utest"
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

   ; ... f.name = "@:01_eval_u8__eq.utest"
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

   ; print__str8 "#--------------------------------#"
   lda #<str8_0x0001
   sta ZP_PTR_1
   lda #>str8_0x0001
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# evaluation of equality checks  #"
   lda #<str8_0x0002
   sta ZP_PTR_1
   lda #>str8_0x0002
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#--------------------------------#"
   lda #<str8_0x0003
   sta ZP_PTR_1
   lda #>str8_0x0003
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "if (5 == 5):"
   lda #<str8_0x0004
   sta ZP_PTR_1
   lda #>str8_0x0004
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; eval_eq__u8 .cmpres 5 5
   lda #1; always true
   sta var__main__cmpres

   ; if .cmpres
   lda var__main__cmpres
   cmp #1
   beq if_0x0000_true
   jmp if_0x0000_else

if_0x0000_true:
   ; print__str8 "   a: [if was true]"
   lda #<str8_0x0005
   sta ZP_PTR_1
   lda #>str8_0x0005
   sta ZP_PTR_1+1
   jsr _print__str8

   ; endif (skip to out)
   jmp if_0x0000_out

if_0x0000_else:
   ; print__str8 "   a: [if was false]"
   lda #<str8_0x0006
   sta ZP_PTR_1
   lda #>str8_0x0006
   sta ZP_PTR_1+1
   jsr _print__str8

   ; endif
if_0x0000_out:

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; print__str8 "if (5 == 6):"
   lda #<str8_0x0007
   sta ZP_PTR_1
   lda #>str8_0x0007
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; eval_eq__u8 .cmpres .cmpres 5
   lda var__main__cmpres
   cmp #5
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
   beq if_0x0001_true
   jmp if_0x0001_else

if_0x0001_true:
   ; print__str8 "   b: [if was true]"
   lda #<str8_0x0008
   sta ZP_PTR_1
   lda #>str8_0x0008
   sta ZP_PTR_1+1
   jsr _print__str8

   ; endif (skip to out)
   jmp if_0x0001_out

if_0x0001_else:
   ; print__str8 "   b: [if was false]"
   lda #<str8_0x0009
   sta ZP_PTR_1
   lda #>str8_0x0009
   sta ZP_PTR_1+1
   jsr _print__str8

   ; endif
if_0x0001_out:

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

