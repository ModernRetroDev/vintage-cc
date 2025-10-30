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

var__main__c: ; type: u8
   .byte $00

var__main__cmpres: ; type: u8
   .byte $00

str8_0x0000: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $16 ; length (u8)
   .byte $16 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$33,$5F,$65,$76,$61,$6C,$5F
   .byte $75,$38,$5F,$5F,$67,$74,$2E,$75,$74,$65
   .byte $73,$74
   .byte $00 ; null terminator (u8)

str8_0x0001: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
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
   .byte $00, $00 ; ptr_addr (u16)
   .byte $29 ; length (u8)
   .byte $29 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$65,$76,$61,$6C,$2D,$67,$74,$20
   .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x0003: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
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
   .byte $00, $00 ; ptr_addr (u16)
   .byte $0D ; length (u8)
   .byte $0D ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2E,$61,$20,$28,$31,$30,$29,$20,$3E,$20
   .byte $35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0005: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $0E ; length (u8)
   .byte $0E ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2E,$61,$20,$28,$31,$30,$29,$20,$3E,$20
   .byte $31,$30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0006: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $0E ; length (u8)
   .byte $0E ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2E,$61,$20,$28,$31,$30,$29,$20,$3E,$20
   .byte $31,$35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0007: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $0D ; length (u8)
   .byte $0D ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $35,$20,$3E,$20,$2E,$61,$20,$28,$31,$30
   .byte $29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0008: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $0E ; length (u8)
   .byte $0E ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3E,$20,$2E,$61,$20,$28,$31
   .byte $30,$29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0009: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $0E ; length (u8)
   .byte $0E ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$35,$20,$3E,$20,$2E,$61,$20,$28,$31
   .byte $30,$29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000A: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $08 ; length (u8)
   .byte $08 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3E,$20,$35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000B: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $09 ; length (u8)
   .byte $09 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3E,$20,$31,$30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000C: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $09 ; length (u8)
   .byte $09 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3E,$20,$31,$35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000D: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $13 ; length (u8)
   .byte $13 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2E,$61,$20,$28,$31,$30,$29,$20,$3E,$20
   .byte $2E,$62,$20,$28,$32,$30,$29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000E: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $13 ; length (u8)
   .byte $13 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2E,$61,$20,$28,$31,$30,$29,$20,$3E,$20
   .byte $2E,$62,$20,$28,$31,$30,$29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000F: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
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

str8_0x0010: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $29 ; length (u8)
   .byte $29 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$65,$76,$61,$6C,$2D,$67,$74,$65
   .byte $71,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x0011: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
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

str8_0x0012: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $0E ; length (u8)
   .byte $0E ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2E,$61,$20,$28,$31,$30,$29,$20,$3C,$3D
   .byte $20,$35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0013: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $0F ; length (u8)
   .byte $0F ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2E,$61,$20,$28,$31,$30,$29,$20,$3C,$3D
   .byte $20,$31,$30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0014: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $0E ; length (u8)
   .byte $0E ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $35,$20,$3C,$3D,$20,$2E,$61,$20,$28,$31
   .byte $30,$29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0015: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $0F ; length (u8)
   .byte $0F ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3C,$3D,$20,$2E,$61,$20,$28
   .byte $31,$30,$29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0016: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $09 ; length (u8)
   .byte $09 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3C,$3D,$20,$35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0017: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $0A ; length (u8)
   .byte $0A ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3C,$3D,$20,$31,$30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0018: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $14 ; length (u8)
   .byte $14 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2E,$61,$20,$28,$31,$30,$29,$20,$3C,$3D
   .byte $20,$2E,$62,$20,$28,$32,$30,$29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0019: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $14 ; length (u8)
   .byte $14 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2E,$61,$20,$28,$31,$30,$29,$20,$3C,$3D
   .byte $20,$2E,$62,$20,$28,$31,$30,$29,$3A,$20
   .byte $00 ; null terminator (u8)

;--------------------------------------------------------;
; BUILT-IN FUNCTIONS                                     ;
;--------------------------------------------------------;
.global _close__file
.global _open__file
.global _print__bool
.global _print__endl
.global _print__str8
.global _setout__file
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

   ; ZP_PTR_2 now points to the str8 filename pointer

   ; save the location that it points to in ZP_PTR_3
   ldy #0
   lda (ZP_PTR_2),y
   sta ZP_PTR_3
   iny
   lda (ZP_PTR_2),y
   sta ZP_PTR_3+1

   ; store a copy of that location in to ZP_PTR_2
   lda ZP_PTR_3
   sta ZP_PTR_2
   lda ZP_PTR_3+1
   sta ZP_PTR_2+1

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

   ; ptr_init for `str8_0x0004`
   ldx #0
   lda #<(str8_0x0004+2)
   sta str8_0x0004,X
   inx
   lda #>(str8_0x0004+2)
   sta str8_0x0004,X

   ; ptr_init for `str8_0x0005`
   ldx #0
   lda #<(str8_0x0005+2)
   sta str8_0x0005,X
   inx
   lda #>(str8_0x0005+2)
   sta str8_0x0005,X

   ; ptr_init for `str8_0x0006`
   ldx #0
   lda #<(str8_0x0006+2)
   sta str8_0x0006,X
   inx
   lda #>(str8_0x0006+2)
   sta str8_0x0006,X

   ; ptr_init for `str8_0x0007`
   ldx #0
   lda #<(str8_0x0007+2)
   sta str8_0x0007,X
   inx
   lda #>(str8_0x0007+2)
   sta str8_0x0007,X

   ; ptr_init for `str8_0x0008`
   ldx #0
   lda #<(str8_0x0008+2)
   sta str8_0x0008,X
   inx
   lda #>(str8_0x0008+2)
   sta str8_0x0008,X

   ; ptr_init for `str8_0x0009`
   ldx #0
   lda #<(str8_0x0009+2)
   sta str8_0x0009,X
   inx
   lda #>(str8_0x0009+2)
   sta str8_0x0009,X

   ; ptr_init for `str8_0x000A`
   ldx #0
   lda #<(str8_0x000A+2)
   sta str8_0x000A,X
   inx
   lda #>(str8_0x000A+2)
   sta str8_0x000A,X

   ; ptr_init for `str8_0x000B`
   ldx #0
   lda #<(str8_0x000B+2)
   sta str8_0x000B,X
   inx
   lda #>(str8_0x000B+2)
   sta str8_0x000B,X

   ; ptr_init for `str8_0x000C`
   ldx #0
   lda #<(str8_0x000C+2)
   sta str8_0x000C,X
   inx
   lda #>(str8_0x000C+2)
   sta str8_0x000C,X

   ; ptr_init for `str8_0x000D`
   ldx #0
   lda #<(str8_0x000D+2)
   sta str8_0x000D,X
   inx
   lda #>(str8_0x000D+2)
   sta str8_0x000D,X

   ; ptr_init for `str8_0x000E`
   ldx #0
   lda #<(str8_0x000E+2)
   sta str8_0x000E,X
   inx
   lda #>(str8_0x000E+2)
   sta str8_0x000E,X

   ; ptr_init for `str8_0x000F`
   ldx #0
   lda #<(str8_0x000F+2)
   sta str8_0x000F,X
   inx
   lda #>(str8_0x000F+2)
   sta str8_0x000F,X

   ; ptr_init for `str8_0x0010`
   ldx #0
   lda #<(str8_0x0010+2)
   sta str8_0x0010,X
   inx
   lda #>(str8_0x0010+2)
   sta str8_0x0010,X

   ; ptr_init for `str8_0x0011`
   ldx #0
   lda #<(str8_0x0011+2)
   sta str8_0x0011,X
   inx
   lda #>(str8_0x0011+2)
   sta str8_0x0011,X

   ; ptr_init for `str8_0x0012`
   ldx #0
   lda #<(str8_0x0012+2)
   sta str8_0x0012,X
   inx
   lda #>(str8_0x0012+2)
   sta str8_0x0012,X

   ; ptr_init for `str8_0x0013`
   ldx #0
   lda #<(str8_0x0013+2)
   sta str8_0x0013,X
   inx
   lda #>(str8_0x0013+2)
   sta str8_0x0013,X

   ; ptr_init for `str8_0x0014`
   ldx #0
   lda #<(str8_0x0014+2)
   sta str8_0x0014,X
   inx
   lda #>(str8_0x0014+2)
   sta str8_0x0014,X

   ; ptr_init for `str8_0x0015`
   ldx #0
   lda #<(str8_0x0015+2)
   sta str8_0x0015,X
   inx
   lda #>(str8_0x0015+2)
   sta str8_0x0015,X

   ; ptr_init for `str8_0x0016`
   ldx #0
   lda #<(str8_0x0016+2)
   sta str8_0x0016,X
   inx
   lda #>(str8_0x0016+2)
   sta str8_0x0016,X

   ; ptr_init for `str8_0x0017`
   ldx #0
   lda #<(str8_0x0017+2)
   sta str8_0x0017,X
   inx
   lda #>(str8_0x0017+2)
   sta str8_0x0017,X

   ; ptr_init for `str8_0x0018`
   ldx #0
   lda #<(str8_0x0018+2)
   sta str8_0x0018,X
   inx
   lda #>(str8_0x0018+2)
   sta str8_0x0018,X

   ; ptr_init for `str8_0x0019`
   ldx #0
   lda #<(str8_0x0019+2)
   sta str8_0x0019,X
   inx
   lda #>(str8_0x0019+2)
   sta str8_0x0019,X

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

   ; equals__u8_u8 .a 10
   lda #10
   sta var__main__a

   ; equals__u8_u8 .b 20
   lda #20
   sta var__main__b

   ; setup__file .f 'w' "@:03_eval_u8__gt.utest"
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

   ; ... f.name = "@:03_eval_u8__gt.utest"
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

   ; equals__u8_u8 .c .a
   lda var__main__a
   sta var__main__c

   ; plus_equals__u8_u8 .c .b
   lda var__main__c
   clc ; clear carry
   adc var__main__b
   sta var__main__c

   ; print__str8 "#---------------------------------------#"
   lda #<str8_0x0001
   sta ZP_PTR_1
   lda #>str8_0x0001
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# eval-gt                               #"
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

   ; eval_gt__u8 .cmpres .a 5
   lda var__main__a
   cmp #5
   beq eval_0x0000_fail
   bcs eval_0x0000
eval_0x0000_fail:
   lda #0; false
   jmp eval_0x0000_out
eval_0x0000:
   lda #1; true
eval_0x0000_out:
   sta var__main__cmpres

   ; print__str8 ".a (10) > 5: "
   lda #<str8_0x0004
   sta ZP_PTR_1
   lda #>str8_0x0004
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; eval_gt__u8 .cmpres .a 10
   lda var__main__a
   cmp #10
   beq eval_0x0001_fail
   bcs eval_0x0001
eval_0x0001_fail:
   lda #0; false
   jmp eval_0x0001_out
eval_0x0001:
   lda #1; true
eval_0x0001_out:
   sta var__main__cmpres

   ; print__str8 ".a (10) > 10: "
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

   ; eval_gt__u8 .cmpres .a 15
   lda var__main__a
   cmp #15
   beq eval_0x0002_fail
   bcs eval_0x0002
eval_0x0002_fail:
   lda #0; false
   jmp eval_0x0002_out
eval_0x0002:
   lda #1; true
eval_0x0002_out:
   sta var__main__cmpres

   ; print__str8 ".a (10) > 15: "
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

   ; print__endl
   jsr _print__endl

   ; eval_gt__u8 .cmpres 5 .a
   lda #5
   cmp var__main__a
   beq eval_0x0003_fail
   bcs eval_0x0003
eval_0x0003_fail:
   lda #0; false
   jmp eval_0x0003_out
eval_0x0003:
   lda #1; true
eval_0x0003_out:
   sta var__main__cmpres

   ; print__str8 "5 > .a (10): "
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

   ; eval_gt__u8 .cmpres 10 .a
   lda #10
   cmp var__main__a
   beq eval_0x0004_fail
   bcs eval_0x0004
eval_0x0004_fail:
   lda #0; false
   jmp eval_0x0004_out
eval_0x0004:
   lda #1; true
eval_0x0004_out:
   sta var__main__cmpres

   ; print__str8 "10 > .a (10): "
   lda #<str8_0x0008
   sta ZP_PTR_1
   lda #>str8_0x0008
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; eval_gt__u8 .cmpres 15 .a
   lda #15
   cmp var__main__a
   beq eval_0x0005_fail
   bcs eval_0x0005
eval_0x0005_fail:
   lda #0; false
   jmp eval_0x0005_out
eval_0x0005:
   lda #1; true
eval_0x0005_out:
   sta var__main__cmpres

   ; print__str8 "15 > .a (10): "
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

   ; print__endl
   jsr _print__endl

   ; eval_gt__u8 .cmpres 10 5
   lda #1; always true
   sta var__main__cmpres

   ; print__str8 "10 > 5: "
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

   ; eval_gt__u8 .cmpres 10 10
   lda #0; always false
   sta var__main__cmpres

   ; print__str8 "10 > 10: "
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

   ; eval_gt__u8 .cmpres 10 15
   lda #0; always false
   sta var__main__cmpres

   ; print__str8 "10 > 15: "
   lda #<str8_0x000C
   sta ZP_PTR_1
   lda #>str8_0x000C
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; eval_gt__u8 .cmpres .a .b
   lda var__main__b
   sta ZP_PTR_1
   lda var__main__a
   cmp ZP_PTR_1
   beq eval_0x0006_fail
   bcs eval_0x0006
eval_0x0006_fail:
   lda #0; false
   jmp eval_0x0006_out
eval_0x0006:
   lda #1; true
eval_0x0006_out:
   sta var__main__cmpres

   ; print__str8 ".a (10) > .b (20): "
   lda #<str8_0x000D
   sta ZP_PTR_1
   lda #>str8_0x000D
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .b 10
   lda #10
   sta var__main__b

   ; eval_gt__u8 .cmpres .a .b
   lda var__main__b
   sta ZP_PTR_1
   lda var__main__a
   cmp ZP_PTR_1
   beq eval_0x0007_fail
   bcs eval_0x0007
eval_0x0007_fail:
   lda #0; false
   jmp eval_0x0007_out
eval_0x0007:
   lda #1; true
eval_0x0007_out:
   sta var__main__cmpres

   ; print__str8 ".a (10) > .b (10): "
   lda #<str8_0x000E
   sta ZP_PTR_1
   lda #>str8_0x000E
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
   lda #<str8_0x000F
   sta ZP_PTR_1
   lda #>str8_0x000F
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# eval-gteq                             #"
   lda #<str8_0x0010
   sta ZP_PTR_1
   lda #>str8_0x0010
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#---------------------------------------#"
   lda #<str8_0x0011
   sta ZP_PTR_1
   lda #>str8_0x0011
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .a 10
   lda #10
   sta var__main__a

   ; equals__u8_u8 .b 20
   lda #20
   sta var__main__b

   ; eval_lteq__u8 .cmpres .a 5
   lda var__main__a
   cmp #5
   beq eval_0x0008_fail
   bcs eval_0x0008
eval_0x0008_fail:
   lda #1; true
   jmp eval_0x0008_out
eval_0x0008:
   lda #0; false
eval_0x0008_out:
   sta var__main__cmpres

   ; print__str8 ".a (10) <= 5: "
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

   ; eval_lteq__u8 .cmpres .a 10
   lda var__main__a
   cmp #10
   beq eval_0x0009_fail
   bcs eval_0x0009
eval_0x0009_fail:
   lda #1; true
   jmp eval_0x0009_out
eval_0x0009:
   lda #0; false
eval_0x0009_out:
   sta var__main__cmpres

   ; print__str8 ".a (10) <= 10: "
   lda #<str8_0x0013
   sta ZP_PTR_1
   lda #>str8_0x0013
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; eval_lteq__u8 .cmpres 5 .a
   lda #5
   cmp var__main__a
   beq eval_0x000A_fail
   bcs eval_0x000A
eval_0x000A_fail:
   lda #1; true
   jmp eval_0x000A_out
eval_0x000A:
   lda #0; false
eval_0x000A_out:
   sta var__main__cmpres

   ; print__str8 "5 <= .a (10): "
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

   ; eval_lteq__u8 .cmpres 10 .a
   lda #10
   cmp var__main__a
   beq eval_0x000B_fail
   bcs eval_0x000B
eval_0x000B_fail:
   lda #1; true
   jmp eval_0x000B_out
eval_0x000B:
   lda #0; false
eval_0x000B_out:
   sta var__main__cmpres

   ; print__str8 "10 <= .a (10): "
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

   ; print__endl
   jsr _print__endl

   ; eval_lteq__u8 .cmpres 10 5
   lda #0; always false
   sta var__main__cmpres

   ; print__str8 "10 <= 5: "
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

   ; eval_lteq__u8 .cmpres 10 10
   lda #1; always true
   sta var__main__cmpres

   ; print__str8 "10 <= 10: "
   lda #<str8_0x0017
   sta ZP_PTR_1
   lda #>str8_0x0017
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; eval_lteq__u8 .cmpres .a .b
   lda var__main__b
   sta ZP_PTR_1
   lda var__main__a
   cmp ZP_PTR_1
   beq eval_0x000C_fail
   bcs eval_0x000C
eval_0x000C_fail:
   lda #1; true
   jmp eval_0x000C_out
eval_0x000C:
   lda #0; false
eval_0x000C_out:
   sta var__main__cmpres

   ; print__str8 ".a (10) <= .b (20): "
   lda #<str8_0x0018
   sta ZP_PTR_1
   lda #>str8_0x0018
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .b 10
   lda #10
   sta var__main__b

   ; eval_lteq__u8 .cmpres .a .b
   lda var__main__b
   sta ZP_PTR_1
   lda var__main__a
   cmp ZP_PTR_1
   beq eval_0x000D_fail
   bcs eval_0x000D
eval_0x000D_fail:
   lda #1; true
   jmp eval_0x000D_out
eval_0x000D:
   lda #0; false
eval_0x000D_out:
   sta var__main__cmpres

   ; print__str8 ".a (10) <= .b (10): "
   lda #<str8_0x0019
   sta ZP_PTR_1
   lda #>str8_0x0019
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

