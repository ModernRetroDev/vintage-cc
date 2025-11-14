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

var__main__a: ; type: u16
   .byte $00, $00

var__main__b: ; type: u16
   .byte $00, $00

var__main__c: ; type: u8
   .byte $00

str8_0x0000: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $20, $00 ; length (u16)
   .byte $20, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$35,$5F,$74,$79,$70,$65,$5F
   .byte $75,$31,$36,$5F,$5F,$73,$75,$62,$74,$72
   .byte $61,$63,$74,$69,$6F,$6E,$2E,$75,$74,$65
   .byte $73,$74
   .byte $00 ; null terminator (u8)

str8_0x0001: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0002: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$75,$31,$36,$20,$73,$75,$62,$74
   .byte $72,$61,$63,$74,$69,$6F,$6E,$20,$28,$73
   .byte $6D,$61,$6C,$6C,$20,$75,$31,$36,$20,$76
   .byte $61,$6C,$75,$65,$73,$29,$20,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x0003: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0004: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2A, $00 ; length (u16)
   .byte $2A, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$73,$75,$62,$74,$72,$61,$63,$74,$69
   .byte $6F,$6E,$20,$6F,$66,$20,$75,$31,$36,$20
   .byte $76,$61,$6C,$75,$65,$73,$20,$3C,$20,$32
   .byte $35,$35
   .byte $00 ; null terminator (u8)

str8_0x0005: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $26, $00 ; length (u16)
   .byte $26, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$20,$75,$38,$2F,$75,$31,$36,$20
   .byte $76,$61,$72,$73,$3B,$20,$6E,$6F,$20,$63
   .byte $61,$72,$72,$79,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0006: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $17, $00 ; length (u16)
   .byte $17, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $32,$35,$20,$2D,$20,$31,$30,$20,$3D,$20
   .byte $31,$35,$20,$28,$24,$30,$30,$30,$66,$29
   .byte $3A,$20,$24
   .byte $00 ; null terminator (u8)

str8_0x0007: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $26, $00 ; length (u16)
   .byte $26, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$20,$75,$38,$2F,$75,$31,$36,$20
   .byte $76,$61,$72,$73,$3B,$20,$6E,$6F,$20,$63
   .byte $61,$72,$72,$79,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0008: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $19, $00 ; length (u16)
   .byte $19, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $33,$30,$30,$20,$2D,$20,$32,$30,$20,$3D
   .byte $20,$32,$38,$30,$20,$28,$24,$30,$31,$31
   .byte $38,$29,$3A,$20,$24
   .byte $00 ; null terminator (u8)

str8_0x0009: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $25, $00 ; length (u16)
   .byte $25, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$20,$75,$38,$2F,$75,$31,$36,$20
   .byte $76,$61,$72,$73,$3B,$20,$77,$2F,$63,$61
   .byte $72,$72,$79,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x000A: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $19, $00 ; length (u16)
   .byte $19, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $33,$30,$30,$20,$2D,$20,$32,$35,$30,$20
   .byte $3D,$20,$35,$30,$20,$28,$24,$30,$30,$33
   .byte $32,$29,$3A,$20,$24
   .byte $00 ; null terminator (u8)

str8_0x000B: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2A, $00 ; length (u16)
   .byte $2A, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$20,$64,$69,$72,$65,$63,$74,$20
   .byte $75,$38,$20,$77,$2F,$75,$31,$36,$3B,$20
   .byte $6E,$6F,$20,$63,$61,$72,$72,$79,$20,$2A
   .byte $2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x000C: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $17, $00 ; length (u16)
   .byte $17, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $32,$35,$20,$2D,$20,$31,$30,$20,$3D,$20
   .byte $31,$35,$20,$28,$24,$30,$30,$30,$66,$29
   .byte $3A,$20,$24
   .byte $00 ; null terminator (u8)

str8_0x000D: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2A, $00 ; length (u16)
   .byte $2A, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$20,$64,$69,$72,$65,$63,$74,$20
   .byte $75,$38,$20,$77,$2F,$75,$31,$36,$3B,$20
   .byte $6E,$6F,$20,$63,$61,$72,$72,$79,$20,$2A
   .byte $2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x000E: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $19, $00 ; length (u16)
   .byte $19, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $33,$30,$30,$20,$2D,$20,$32,$30,$20,$3D
   .byte $20,$32,$38,$30,$20,$28,$24,$30,$31,$31
   .byte $38,$29,$3A,$20,$24
   .byte $00 ; null terminator (u8)

str8_0x000F: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $29, $00 ; length (u16)
   .byte $29, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$20,$64,$69,$72,$65,$63,$74,$20
   .byte $75,$38,$20,$77,$2F,$75,$31,$36,$3B,$20
   .byte $77,$2F,$63,$61,$72,$72,$79,$20,$2A,$2A
   .byte $2A
   .byte $00 ; null terminator (u8)

str8_0x0010: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $19, $00 ; length (u16)
   .byte $19, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $33,$30,$30,$20,$2D,$20,$32,$35,$30,$20
   .byte $3D,$20,$35,$30,$20,$28,$24,$30,$30,$33
   .byte $32,$29,$3A,$20,$24
   .byte $00 ; null terminator (u8)

str8_0x0011: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $24, $00 ; length (u16)
   .byte $24, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$69,$6F,$6E,$20,$62,$65,$74,$77
   .byte $65,$65,$6E,$20,$75,$31,$36,$20,$76,$61
   .byte $72,$73,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0012: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $19, $00 ; length (u16)
   .byte $19, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $33,$30,$30,$20,$2D,$20,$32,$35,$30,$20
   .byte $3D,$20,$35,$30,$20,$28,$24,$30,$30,$33
   .byte $32,$29,$3A,$20,$24
   .byte $00 ; null terminator (u8)

str8_0x0013: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0014: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$75,$31,$36,$20,$73,$75,$62,$74
   .byte $72,$61,$63,$74,$69,$6F,$6E,$20,$28,$6C
   .byte $61,$72,$67,$65,$20,$75,$31,$36,$20,$76
   .byte $61,$6C,$75,$65,$73,$29,$20,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x0015: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0016: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2A, $00 ; length (u16)
   .byte $2A, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$73,$75,$62,$74,$72,$61,$63,$74,$69
   .byte $6F,$6E,$20,$6F,$66,$20,$75,$31,$36,$20
   .byte $76,$61,$6C,$75,$65,$73,$20,$3E,$20,$32
   .byte $35,$35
   .byte $00 ; null terminator (u8)

str8_0x0017: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $24, $00 ; length (u16)
   .byte $24, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$69,$6F,$6E,$20,$62,$65,$74,$77
   .byte $65,$65,$6E,$20,$75,$31,$36,$20,$76,$61
   .byte $72,$73,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0018: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $1C, $00 ; length (u16)
   .byte $1C, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $35,$30,$30,$30,$20,$2D,$20,$34,$38,$30
   .byte $30,$20,$3D,$20,$32,$30,$30,$20,$28,$24
   .byte $30,$30,$63,$38,$29,$3A,$20,$24
   .byte $00 ; null terminator (u8)

str8_0x0019: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $1D, $00 ; length (u16)
   .byte $1D, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$20,$61,$20,$64,$69,$72,$65,$63
   .byte $74,$20,$75,$31,$36,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x001A: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $1C, $00 ; length (u16)
   .byte $1C, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $35,$30,$30,$30,$20,$2D,$20,$34,$38,$30
   .byte $30,$20,$3D,$20,$32,$30,$30,$20,$28,$24
   .byte $30,$30,$63,$38,$29,$3A,$20,$24
   .byte $00 ; null terminator (u8)

;--------------------------------------------------------;
; BUILT-IN FUNCTIONS                                     ;
;--------------------------------------------------------;
.global _close__file
.global _minus_equals__u16_u16
.global _minus_equals__u16_u8
.global _open__file
.global _print__endl
.global _print__str8
.global _print__u16_x
.global _print__u8_x
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


_minus_equals__u16_u16:
   ;-----------------------------------------------------;
   ; Subtracts a U16 in `ZP_PTR_2` from a U16.           ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING REDUCED.       ;
   ; ZP_PTR_2 = POINTS TO U16 VALUE BEING SUBTRACTED.    ;
   ;-----------------------------------------------------;
   ; subtract the low byte
   ldy #0
   lda (ZP_PTR_1),y
   sec
   sbc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   ; carry over to high byte
   ldy #1
   lda (ZP_PTR_1),y
   sbc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   rts

_minus_equals__u16_u16d:
   ;-----------------------------------------------------;
   ; Subtracts a U16 in registers `A,X` from a U16.      ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING REDUCED.       ;
   ; A = LOW BYTE OF U16 VALUE BEING SUBTRACTED          ;
   ; X = HIGH BYTE OF U16 VALUE BEING SUBTRACTED         ;
   ;-----------------------------------------------------;
   ; Clobbers:                                           ;
   ; ZP_PTR_2                                            ;
   ;-----------------------------------------------------;
   ; subtract the low byte
   sta ZP_PTR_2
   ldy #0
   lda (ZP_PTR_1),y
   sec
   sbc ZP_PTR_2
   sta (ZP_PTR_1),y
   ; carry over to high byte
   txa
   sta ZP_PTR_2
   ldy #1
   lda (ZP_PTR_1),y
   sbc ZP_PTR_2
   sta (ZP_PTR_1),y
   rts


_minus_equals__u16_u8:
   ;-----------------------------------------------------;
   ; Subtracts a U8 in `ZP_PTR_2` from a U16.            ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING REDUCED.       ;
   ; ZP_PTR_2 = POINTS TO U8 VALUE BEING SUBTRACTED.     ;
   ;-----------------------------------------------------;
   ; subtract the low byte
   ldy #0
   lda (ZP_PTR_1),y
   sec
   sbc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   ; carry over to high byte
   ldy #1
   lda (ZP_PTR_1),y
   sbc #0
   sta (ZP_PTR_1),y
   rts

_minus_equals__u16_u8d:
   ;-----------------------------------------------------;
   ; Subtracts a U8 in register `A` from a U16.          ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING REDUCED.       ;
   ; A = U8 VALUE TO BE SUBTRACTED                       ;
   ;-----------------------------------------------------;
   ; Clobbers:                                           ;
   ; X                                                   ;
   ;-----------------------------------------------------;
   ; subtract the low byte
   ldx ZP_PTR_2
   sta ZP_PTR_2
   ldy #0
   lda (ZP_PTR_1),y
   sec
   sbc ZP_PTR_2
   sta (ZP_PTR_1),y
   ; carry over to high byte
   ldy #1
   lda (ZP_PTR_1),y
   sbc #0
   sta (ZP_PTR_1),y
   stx ZP_PTR_2
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

   ; ptr_init for `str8_0x001A`
   ldx #0
   lda #<(str8_0x001A+2)
   sta str8_0x001A,X
   inx
   lda #>(str8_0x001A+2)
   sta str8_0x001A,X

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

   ; setup__file .f 'w' "@:05_type_u16__subtraction.utest"
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

   ; print__str8 "#-------------------------------------#"
   lda #<str8_0x0001
   sta ZP_PTR_1
   lda #>str8_0x0001
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# u16 subtraction (small u16 values)  #"
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

   ; print__str8 "# test out subtraction of u16 values < 255"
   lda #<str8_0x0004
   sta ZP_PTR_1
   lda #>str8_0x0004
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 25
   lda #<25
   sta var__main__a
   lda #>25
   sta var__main__a+1

   ; equals__u8_u8 .c 10
   lda #10
   sta var__main__c

   ; minus_equals__u16_u8 .a .c
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__c
   sta ZP_PTR_2
   lda #>var__main__c
   sta ZP_PTR_2+1
   jsr _minus_equals__u16_u8

   ; print__str8 "*** subtract u8/u16 vars; no carry ***"
   lda #<str8_0x0005
   sta ZP_PTR_1
   lda #>str8_0x0005
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "25 - 10 = 15 ($000f): $"
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

   ; equals__u16_u16 .a 300
   lda #<300
   sta var__main__a
   lda #>300
   sta var__main__a+1

   ; equals__u8_u8 .c 20
   lda #20
   sta var__main__c

   ; minus_equals__u16_u8 .a .c
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__c
   sta ZP_PTR_2
   lda #>var__main__c
   sta ZP_PTR_2+1
   jsr _minus_equals__u16_u8

   ; print__str8 "*** subtract u8/u16 vars; no carry ***"
   lda #<str8_0x0007
   sta ZP_PTR_1
   lda #>str8_0x0007
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "300 - 20 = 280 ($0118): $"
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

   ; equals__u16_u16 .a 300
   lda #<300
   sta var__main__a
   lda #>300
   sta var__main__a+1

   ; equals__u8_u8 .c 250
   lda #250
   sta var__main__c

   ; minus_equals__u16_u8 .a .c
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__c
   sta ZP_PTR_2
   lda #>var__main__c
   sta ZP_PTR_2+1
   jsr _minus_equals__u16_u8

   ; print__str8 "*** subtract u8/u16 vars; w/carry ***"
   lda #<str8_0x0009
   sta ZP_PTR_1
   lda #>str8_0x0009
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "300 - 250 = 50 ($0032): $"
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

   ; equals__u16_u16 .a 25
   lda #<25
   sta var__main__a
   lda #>25
   sta var__main__a+1

   ; minus_equals__u16_u8 .a 10
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #10
   jsr _minus_equals__u16_u8d

   ; print__str8 "*** subtract direct u8 w/u16; no carry ***"
   lda #<str8_0x000B
   sta ZP_PTR_1
   lda #>str8_0x000B
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "25 - 10 = 15 ($000f): $"
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

   ; equals__u16_u16 .a 300
   lda #<300
   sta var__main__a
   lda #>300
   sta var__main__a+1

   ; minus_equals__u16_u8 .a 20
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #20
   jsr _minus_equals__u16_u8d

   ; print__str8 "*** subtract direct u8 w/u16; no carry ***"
   lda #<str8_0x000D
   sta ZP_PTR_1
   lda #>str8_0x000D
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "300 - 20 = 280 ($0118): $"
   lda #<str8_0x000E
   sta ZP_PTR_1
   lda #>str8_0x000E
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

   ; equals__u16_u16 .a 300
   lda #<300
   sta var__main__a
   lda #>300
   sta var__main__a+1

   ; minus_equals__u16_u8 .a 250
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #250
   jsr _minus_equals__u16_u8d

   ; print__str8 "*** subtract direct u8 w/u16; w/carry ***"
   lda #<str8_0x000F
   sta ZP_PTR_1
   lda #>str8_0x000F
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "300 - 250 = 50 ($0032): $"
   lda #<str8_0x0010
   sta ZP_PTR_1
   lda #>str8_0x0010
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

   ; equals__u16_u16 .a 300
   lda #<300
   sta var__main__a
   lda #>300
   sta var__main__a+1

   ; equals__u16_u16 .b 250
   lda #<250
   sta var__main__b
   lda #>250
   sta var__main__b+1

   ; minus_equals__u16_u16 .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _minus_equals__u16_u16

   ; print__str8 "*** subtraction between u16 vars ***"
   lda #<str8_0x0011
   sta ZP_PTR_1
   lda #>str8_0x0011
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "300 - 250 = 50 ($0032): $"
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

   ; print__str8 "#-------------------------------------#"
   lda #<str8_0x0013
   sta ZP_PTR_1
   lda #>str8_0x0013
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# u16 subtraction (large u16 values)  #"
   lda #<str8_0x0014
   sta ZP_PTR_1
   lda #>str8_0x0014
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#-------------------------------------#"
   lda #<str8_0x0015
   sta ZP_PTR_1
   lda #>str8_0x0015
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# test out subtraction of u16 values > 255"
   lda #<str8_0x0016
   sta ZP_PTR_1
   lda #>str8_0x0016
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 5000
   lda #<5000
   sta var__main__a
   lda #>5000
   sta var__main__a+1

   ; equals__u16_u16 .b 4800
   lda #<4800
   sta var__main__b
   lda #>4800
   sta var__main__b+1

   ; minus_equals__u16_u16 .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _minus_equals__u16_u16

   ; print__str8 "*** subtraction between u16 vars ***"
   lda #<str8_0x0017
   sta ZP_PTR_1
   lda #>str8_0x0017
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "5000 - 4800 = 200 ($00c8): $"
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

   ; equals__u16_u16 .a 5000
   lda #<5000
   sta var__main__a
   lda #>5000
   sta var__main__a+1

   ; minus_equals__u16_u16 .a 4800
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<4800
   ldx #>4800
   jsr _minus_equals__u16_u16d

   ; print__str8 "*** subtract a direct u16 ***"
   lda #<str8_0x0019
   sta ZP_PTR_1
   lda #>str8_0x0019
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "5000 - 4800 = 200 ($00c8): $"
   lda #<str8_0x001A
   sta ZP_PTR_1
   lda #>str8_0x001A
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

