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

str8_0x0000: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $18 ; length (u8)
   .byte $18 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$38,$5F,$74,$79,$70,$65,$5F
   .byte $75,$31,$36,$5F,$5F,$68,$65,$78,$2E,$75
   .byte $74,$65,$73,$74
   .byte $00 ; null terminator (u8)

str8_0x0001: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
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

str8_0x0002: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $2C ; length (u8)
   .byte $2C ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$75,$31,$36,$20,$73,$70,$65,$63
   .byte $69,$66,$69,$65,$64,$20,$61,$73,$20,$68
   .byte $65,$78,$61,$64,$65,$63,$69,$6D,$61,$6C
   .byte $20,$6E,$75,$6D,$62,$65,$72,$73,$20,$20
   .byte $20,$20,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x0003: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
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

str8_0x0004: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $28 ; length (u8)
   .byte $28 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$70,$72,$69,$6E,$74,$20
   .byte $6F,$75,$74,$20,$61,$20,$66,$65,$77,$20
   .byte $62,$69,$6E,$61,$72,$79,$20,$75,$31,$36
   .byte $20,$76,$61,$6C,$75,$65,$73,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0005: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $13 ; length (u8)
   .byte $13 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$30,$30,$20
   .byte $28,$30,$29,$20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0006: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $13 ; length (u8)
   .byte $13 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$30,$31,$20
   .byte $28,$31,$29,$20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0007: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $13 ; length (u8)
   .byte $13 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$30,$32,$20
   .byte $28,$32,$29,$20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0008: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $13 ; length (u8)
   .byte $13 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$30,$34,$20
   .byte $28,$34,$29,$20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0009: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $13 ; length (u8)
   .byte $13 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$30,$38,$20
   .byte $28,$38,$29,$20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x000A: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $12 ; length (u8)
   .byte $12 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$31,$30,$20
   .byte $28,$31,$36,$29,$20,$3A,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x000B: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $12 ; length (u8)
   .byte $12 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$32,$30,$20
   .byte $28,$33,$32,$29,$20,$3A,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x000C: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $12 ; length (u8)
   .byte $12 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$34,$30,$20
   .byte $28,$36,$34,$29,$20,$3A,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x000D: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $11 ; length (u8)
   .byte $11 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$38,$30,$20
   .byte $28,$31,$32,$38,$29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000E: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $11 ; length (u8)
   .byte $11 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$46,$46,$20
   .byte $28,$32,$35,$35,$29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000F: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $3B ; length (u8)
   .byte $3B ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$70,$72,$69,$6E,$74,$20
   .byte $6F,$75,$74,$20,$61,$20,$66,$65,$77,$20
   .byte $62,$69,$6E,$61,$72,$79,$20,$75,$31,$36
   .byte $20,$76,$61,$6C,$75,$65,$73,$3B,$20,$6E
   .byte $6F,$20,$6C,$65,$61,$64,$69,$6E,$67,$20
   .byte $7A,$65,$72,$6F,$73,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0010: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$20,$28,$30,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0011: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$31,$20,$28,$31,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0012: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$32,$20,$28,$32,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0013: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$33,$20,$28,$33,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0014: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$34,$20,$28,$34,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0015: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$35,$20,$28,$35,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0016: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$36,$20,$28,$36,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0017: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$37,$20,$28,$37,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0018: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$38,$20,$28,$38,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0019: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$39,$20,$28,$39,$29
   .byte $20,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x001A: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$41,$20,$28,$31,$30
   .byte $29,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x001B: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$42,$20,$28,$31,$31
   .byte $29,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x001C: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$43,$20,$28,$31,$32
   .byte $29,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x001D: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$44,$20,$28,$31,$33
   .byte $29,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x001E: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$45,$20,$28,$31,$34
   .byte $29,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x001F: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $10 ; length (u8)
   .byte $10 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$46,$20,$28,$31,$35
   .byte $29,$20,$3A,$20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0020: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $2D ; length (u8)
   .byte $2D ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$70,$72,$69,$6E,$74,$20
   .byte $6F,$75,$74,$20,$61,$20,$66,$65,$77,$20
   .byte $68,$65,$78,$61,$64,$65,$63,$69,$6D,$61
   .byte $6C,$20,$75,$31,$36,$20,$76,$61,$6C,$75
   .byte $65,$73,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0021: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $17 ; length (u8)
   .byte $17 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$30,$30,$20
   .byte $28,$30,$29,$20,$20,$20,$20,$3A,$20,$20
   .byte $20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0022: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $17 ; length (u8)
   .byte $17 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$30,$31,$20
   .byte $28,$31,$29,$20,$20,$20,$20,$3A,$20,$20
   .byte $20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0023: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $17 ; length (u8)
   .byte $17 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$30,$32,$20
   .byte $28,$32,$29,$20,$20,$20,$20,$3A,$20,$20
   .byte $20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0024: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $17 ; length (u8)
   .byte $17 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$30,$34,$20
   .byte $28,$34,$29,$20,$20,$20,$20,$3A,$20,$20
   .byte $20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0025: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $17 ; length (u8)
   .byte $17 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$30,$38,$20
   .byte $28,$38,$29,$20,$20,$20,$20,$3A,$20,$20
   .byte $20,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0026: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $16 ; length (u8)
   .byte $16 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$31,$30,$20
   .byte $28,$31,$36,$29,$20,$20,$20,$3A,$20,$20
   .byte $20,$20
   .byte $00 ; null terminator (u8)

str8_0x0027: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $16 ; length (u8)
   .byte $16 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$32,$30,$20
   .byte $28,$33,$32,$29,$20,$20,$20,$3A,$20,$20
   .byte $20,$20
   .byte $00 ; null terminator (u8)

str8_0x0028: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $16 ; length (u8)
   .byte $16 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$34,$30,$20
   .byte $28,$36,$34,$29,$20,$20,$20,$3A,$20,$20
   .byte $20,$20
   .byte $00 ; null terminator (u8)

str8_0x0029: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $15 ; length (u8)
   .byte $15 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$30,$38,$30,$20
   .byte $28,$31,$32,$38,$29,$20,$20,$3A,$20,$20
   .byte $20
   .byte $00 ; null terminator (u8)

str8_0x002A: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $15 ; length (u8)
   .byte $15 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$31,$30,$30,$20
   .byte $28,$32,$35,$36,$29,$20,$20,$3A,$20,$20
   .byte $20
   .byte $00 ; null terminator (u8)

str8_0x002B: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $15 ; length (u8)
   .byte $15 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$32,$30,$30,$20
   .byte $28,$35,$31,$32,$29,$20,$20,$3A,$20,$20
   .byte $20
   .byte $00 ; null terminator (u8)

str8_0x002C: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $14 ; length (u8)
   .byte $14 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$34,$30,$30,$20
   .byte $28,$31,$30,$32,$34,$29,$20,$3A,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x002D: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $14 ; length (u8)
   .byte $14 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$30,$38,$30,$30,$20
   .byte $28,$32,$30,$34,$38,$29,$20,$3A,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x002E: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $14 ; length (u8)
   .byte $14 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$31,$30,$30,$30,$20
   .byte $28,$34,$30,$39,$36,$29,$20,$3A,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x002F: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $14 ; length (u8)
   .byte $14 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$32,$30,$30,$30,$20
   .byte $28,$38,$31,$39,$32,$29,$20,$3A,$20,$20
   .byte $00 ; null terminator (u8)

str8_0x0030: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $13 ; length (u8)
   .byte $13 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$34,$30,$30,$30,$20
   .byte $28,$31,$36,$33,$38,$34,$29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0031: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $13 ; length (u8)
   .byte $13 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$38,$30,$30,$30,$20
   .byte $28,$33,$32,$37,$36,$38,$29,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0032: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $13 ; length (u8)
   .byte $13 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $20,$2A,$20,$30,$78,$46,$46,$46,$46,$20
   .byte $28,$36,$35,$35,$33,$35,$29,$3A,$20
   .byte $00 ; null terminator (u8)

;--------------------------------------------------------;
; BUILT-IN FUNCTIONS                                     ;
;--------------------------------------------------------;
.global _close__file
.global _open__file
.global _print__endl
.global _print__str8
.global _print__u16
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

   ; ptr_init for `str8_0x001A`
   ldx #0
   lda #<(str8_0x001A+2)
   sta str8_0x001A,X
   inx
   lda #>(str8_0x001A+2)
   sta str8_0x001A,X

   ; ptr_init for `str8_0x001B`
   ldx #0
   lda #<(str8_0x001B+2)
   sta str8_0x001B,X
   inx
   lda #>(str8_0x001B+2)
   sta str8_0x001B,X

   ; ptr_init for `str8_0x001C`
   ldx #0
   lda #<(str8_0x001C+2)
   sta str8_0x001C,X
   inx
   lda #>(str8_0x001C+2)
   sta str8_0x001C,X

   ; ptr_init for `str8_0x001D`
   ldx #0
   lda #<(str8_0x001D+2)
   sta str8_0x001D,X
   inx
   lda #>(str8_0x001D+2)
   sta str8_0x001D,X

   ; ptr_init for `str8_0x001E`
   ldx #0
   lda #<(str8_0x001E+2)
   sta str8_0x001E,X
   inx
   lda #>(str8_0x001E+2)
   sta str8_0x001E,X

   ; ptr_init for `str8_0x001F`
   ldx #0
   lda #<(str8_0x001F+2)
   sta str8_0x001F,X
   inx
   lda #>(str8_0x001F+2)
   sta str8_0x001F,X

   ; ptr_init for `str8_0x0020`
   ldx #0
   lda #<(str8_0x0020+2)
   sta str8_0x0020,X
   inx
   lda #>(str8_0x0020+2)
   sta str8_0x0020,X

   ; ptr_init for `str8_0x0021`
   ldx #0
   lda #<(str8_0x0021+2)
   sta str8_0x0021,X
   inx
   lda #>(str8_0x0021+2)
   sta str8_0x0021,X

   ; ptr_init for `str8_0x0022`
   ldx #0
   lda #<(str8_0x0022+2)
   sta str8_0x0022,X
   inx
   lda #>(str8_0x0022+2)
   sta str8_0x0022,X

   ; ptr_init for `str8_0x0023`
   ldx #0
   lda #<(str8_0x0023+2)
   sta str8_0x0023,X
   inx
   lda #>(str8_0x0023+2)
   sta str8_0x0023,X

   ; ptr_init for `str8_0x0024`
   ldx #0
   lda #<(str8_0x0024+2)
   sta str8_0x0024,X
   inx
   lda #>(str8_0x0024+2)
   sta str8_0x0024,X

   ; ptr_init for `str8_0x0025`
   ldx #0
   lda #<(str8_0x0025+2)
   sta str8_0x0025,X
   inx
   lda #>(str8_0x0025+2)
   sta str8_0x0025,X

   ; ptr_init for `str8_0x0026`
   ldx #0
   lda #<(str8_0x0026+2)
   sta str8_0x0026,X
   inx
   lda #>(str8_0x0026+2)
   sta str8_0x0026,X

   ; ptr_init for `str8_0x0027`
   ldx #0
   lda #<(str8_0x0027+2)
   sta str8_0x0027,X
   inx
   lda #>(str8_0x0027+2)
   sta str8_0x0027,X

   ; ptr_init for `str8_0x0028`
   ldx #0
   lda #<(str8_0x0028+2)
   sta str8_0x0028,X
   inx
   lda #>(str8_0x0028+2)
   sta str8_0x0028,X

   ; ptr_init for `str8_0x0029`
   ldx #0
   lda #<(str8_0x0029+2)
   sta str8_0x0029,X
   inx
   lda #>(str8_0x0029+2)
   sta str8_0x0029,X

   ; ptr_init for `str8_0x002A`
   ldx #0
   lda #<(str8_0x002A+2)
   sta str8_0x002A,X
   inx
   lda #>(str8_0x002A+2)
   sta str8_0x002A,X

   ; ptr_init for `str8_0x002B`
   ldx #0
   lda #<(str8_0x002B+2)
   sta str8_0x002B,X
   inx
   lda #>(str8_0x002B+2)
   sta str8_0x002B,X

   ; ptr_init for `str8_0x002C`
   ldx #0
   lda #<(str8_0x002C+2)
   sta str8_0x002C,X
   inx
   lda #>(str8_0x002C+2)
   sta str8_0x002C,X

   ; ptr_init for `str8_0x002D`
   ldx #0
   lda #<(str8_0x002D+2)
   sta str8_0x002D,X
   inx
   lda #>(str8_0x002D+2)
   sta str8_0x002D,X

   ; ptr_init for `str8_0x002E`
   ldx #0
   lda #<(str8_0x002E+2)
   sta str8_0x002E,X
   inx
   lda #>(str8_0x002E+2)
   sta str8_0x002E,X

   ; ptr_init for `str8_0x002F`
   ldx #0
   lda #<(str8_0x002F+2)
   sta str8_0x002F,X
   inx
   lda #>(str8_0x002F+2)
   sta str8_0x002F,X

   ; ptr_init for `str8_0x0030`
   ldx #0
   lda #<(str8_0x0030+2)
   sta str8_0x0030,X
   inx
   lda #>(str8_0x0030+2)
   sta str8_0x0030,X

   ; ptr_init for `str8_0x0031`
   ldx #0
   lda #<(str8_0x0031+2)
   sta str8_0x0031,X
   inx
   lda #>(str8_0x0031+2)
   sta str8_0x0031,X

   ; ptr_init for `str8_0x0032`
   ldx #0
   lda #<(str8_0x0032+2)
   sta str8_0x0032,X
   inx
   lda #>(str8_0x0032+2)
   sta str8_0x0032,X

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

   ; setup__file .f 'w' "@:08_type_u16__hex.utest"
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

   ; ... f.name = "@:08_type_u16__hex.utest"
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

   ; print__str8 "#------------------------------------------#"
   lda #<str8_0x0001
   sta ZP_PTR_1
   lda #>str8_0x0001
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# u16 specified as hexadecimal numbers     #"
   lda #<str8_0x0002
   sta ZP_PTR_1
   lda #>str8_0x0002
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#------------------------------------------#"
   lda #<str8_0x0003
   sta ZP_PTR_1
   lda #>str8_0x0003
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; print__str8 "*** print out a few binary u16 values***"
   lda #<str8_0x0004
   sta ZP_PTR_1
   lda #>str8_0x0004
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0000
   lda #<0
   sta var__main__a
   lda #>0
   sta var__main__a+1

   ; print__str8 " * 0x0000 (0)  :   "
   lda #<str8_0x0005
   sta ZP_PTR_1
   lda #>str8_0x0005
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0001
   lda #<1
   sta var__main__a
   lda #>1
   sta var__main__a+1

   ; print__str8 " * 0x0001 (1)  :   "
   lda #<str8_0x0006
   sta ZP_PTR_1
   lda #>str8_0x0006
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0002
   lda #<2
   sta var__main__a
   lda #>2
   sta var__main__a+1

   ; print__str8 " * 0x0002 (2)  :   "
   lda #<str8_0x0007
   sta ZP_PTR_1
   lda #>str8_0x0007
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0004
   lda #<4
   sta var__main__a
   lda #>4
   sta var__main__a+1

   ; print__str8 " * 0x0004 (4)  :   "
   lda #<str8_0x0008
   sta ZP_PTR_1
   lda #>str8_0x0008
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0008
   lda #<8
   sta var__main__a
   lda #>8
   sta var__main__a+1

   ; print__str8 " * 0x0008 (8)  :   "
   lda #<str8_0x0009
   sta ZP_PTR_1
   lda #>str8_0x0009
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0010
   lda #<16
   sta var__main__a
   lda #>16
   sta var__main__a+1

   ; print__str8 " * 0x0010 (16) :  "
   lda #<str8_0x000A
   sta ZP_PTR_1
   lda #>str8_0x000A
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0020
   lda #<32
   sta var__main__a
   lda #>32
   sta var__main__a+1

   ; print__str8 " * 0x0020 (32) :  "
   lda #<str8_0x000B
   sta ZP_PTR_1
   lda #>str8_0x000B
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0040
   lda #<64
   sta var__main__a
   lda #>64
   sta var__main__a+1

   ; print__str8 " * 0x0040 (64) :  "
   lda #<str8_0x000C
   sta ZP_PTR_1
   lda #>str8_0x000C
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0080
   lda #<128
   sta var__main__a
   lda #>128
   sta var__main__a+1

   ; print__str8 " * 0x0080 (128): "
   lda #<str8_0x000D
   sta ZP_PTR_1
   lda #>str8_0x000D
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x00FF
   lda #<255
   sta var__main__a
   lda #>255
   sta var__main__a+1

   ; print__str8 " * 0x00FF (255): "
   lda #<str8_0x000E
   sta ZP_PTR_1
   lda #>str8_0x000E
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; print__str8 "*** print out a few binary u16 values; no leading zeros ***"
   lda #<str8_0x000F
   sta ZP_PTR_1
   lda #>str8_0x000F
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0
   lda #<0
   sta var__main__a
   lda #>0
   sta var__main__a+1

   ; print__str8 " * 0x0 (0)  :   "
   lda #<str8_0x0010
   sta ZP_PTR_1
   lda #>str8_0x0010
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x1
   lda #<1
   sta var__main__a
   lda #>1
   sta var__main__a+1

   ; print__str8 " * 0x1 (1)  :   "
   lda #<str8_0x0011
   sta ZP_PTR_1
   lda #>str8_0x0011
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x2
   lda #<2
   sta var__main__a
   lda #>2
   sta var__main__a+1

   ; print__str8 " * 0x2 (2)  :   "
   lda #<str8_0x0012
   sta ZP_PTR_1
   lda #>str8_0x0012
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x3
   lda #<3
   sta var__main__a
   lda #>3
   sta var__main__a+1

   ; print__str8 " * 0x3 (3)  :   "
   lda #<str8_0x0013
   sta ZP_PTR_1
   lda #>str8_0x0013
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x4
   lda #<4
   sta var__main__a
   lda #>4
   sta var__main__a+1

   ; print__str8 " * 0x4 (4)  :   "
   lda #<str8_0x0014
   sta ZP_PTR_1
   lda #>str8_0x0014
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x5
   lda #<5
   sta var__main__a
   lda #>5
   sta var__main__a+1

   ; print__str8 " * 0x5 (5)  :   "
   lda #<str8_0x0015
   sta ZP_PTR_1
   lda #>str8_0x0015
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x6
   lda #<6
   sta var__main__a
   lda #>6
   sta var__main__a+1

   ; print__str8 " * 0x6 (6)  :   "
   lda #<str8_0x0016
   sta ZP_PTR_1
   lda #>str8_0x0016
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x7
   lda #<7
   sta var__main__a
   lda #>7
   sta var__main__a+1

   ; print__str8 " * 0x7 (7)  :   "
   lda #<str8_0x0017
   sta ZP_PTR_1
   lda #>str8_0x0017
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x8
   lda #<8
   sta var__main__a
   lda #>8
   sta var__main__a+1

   ; print__str8 " * 0x8 (8)  :   "
   lda #<str8_0x0018
   sta ZP_PTR_1
   lda #>str8_0x0018
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x9
   lda #<9
   sta var__main__a
   lda #>9
   sta var__main__a+1

   ; print__str8 " * 0x9 (9)  :   "
   lda #<str8_0x0019
   sta ZP_PTR_1
   lda #>str8_0x0019
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0xA
   lda #<10
   sta var__main__a
   lda #>10
   sta var__main__a+1

   ; print__str8 " * 0xA (10) :   "
   lda #<str8_0x001A
   sta ZP_PTR_1
   lda #>str8_0x001A
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0xB
   lda #<11
   sta var__main__a
   lda #>11
   sta var__main__a+1

   ; print__str8 " * 0xB (11) :   "
   lda #<str8_0x001B
   sta ZP_PTR_1
   lda #>str8_0x001B
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0xC
   lda #<12
   sta var__main__a
   lda #>12
   sta var__main__a+1

   ; print__str8 " * 0xC (12) :   "
   lda #<str8_0x001C
   sta ZP_PTR_1
   lda #>str8_0x001C
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0xD
   lda #<13
   sta var__main__a
   lda #>13
   sta var__main__a+1

   ; print__str8 " * 0xD (13) :   "
   lda #<str8_0x001D
   sta ZP_PTR_1
   lda #>str8_0x001D
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0xE
   lda #<14
   sta var__main__a
   lda #>14
   sta var__main__a+1

   ; print__str8 " * 0xE (14) :   "
   lda #<str8_0x001E
   sta ZP_PTR_1
   lda #>str8_0x001E
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0xF
   lda #<15
   sta var__main__a
   lda #>15
   sta var__main__a+1

   ; print__str8 " * 0xF (15) :   "
   lda #<str8_0x001F
   sta ZP_PTR_1
   lda #>str8_0x001F
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; print__str8 "*** print out a few hexadecimal u16 values***"
   lda #<str8_0x0020
   sta ZP_PTR_1
   lda #>str8_0x0020
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0000
   lda #<0
   sta var__main__a
   lda #>0
   sta var__main__a+1

   ; print__str8 " * 0x0000 (0)    :     "
   lda #<str8_0x0021
   sta ZP_PTR_1
   lda #>str8_0x0021
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0001
   lda #<1
   sta var__main__a
   lda #>1
   sta var__main__a+1

   ; print__str8 " * 0x0001 (1)    :     "
   lda #<str8_0x0022
   sta ZP_PTR_1
   lda #>str8_0x0022
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0002
   lda #<2
   sta var__main__a
   lda #>2
   sta var__main__a+1

   ; print__str8 " * 0x0002 (2)    :     "
   lda #<str8_0x0023
   sta ZP_PTR_1
   lda #>str8_0x0023
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0004
   lda #<4
   sta var__main__a
   lda #>4
   sta var__main__a+1

   ; print__str8 " * 0x0004 (4)    :     "
   lda #<str8_0x0024
   sta ZP_PTR_1
   lda #>str8_0x0024
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0008
   lda #<8
   sta var__main__a
   lda #>8
   sta var__main__a+1

   ; print__str8 " * 0x0008 (8)    :     "
   lda #<str8_0x0025
   sta ZP_PTR_1
   lda #>str8_0x0025
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0010
   lda #<16
   sta var__main__a
   lda #>16
   sta var__main__a+1

   ; print__str8 " * 0x0010 (16)   :    "
   lda #<str8_0x0026
   sta ZP_PTR_1
   lda #>str8_0x0026
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0020
   lda #<32
   sta var__main__a
   lda #>32
   sta var__main__a+1

   ; print__str8 " * 0x0020 (32)   :    "
   lda #<str8_0x0027
   sta ZP_PTR_1
   lda #>str8_0x0027
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0040
   lda #<64
   sta var__main__a
   lda #>64
   sta var__main__a+1

   ; print__str8 " * 0x0040 (64)   :    "
   lda #<str8_0x0028
   sta ZP_PTR_1
   lda #>str8_0x0028
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0080
   lda #<128
   sta var__main__a
   lda #>128
   sta var__main__a+1

   ; print__str8 " * 0x0080 (128)  :   "
   lda #<str8_0x0029
   sta ZP_PTR_1
   lda #>str8_0x0029
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0100
   lda #<256
   sta var__main__a
   lda #>256
   sta var__main__a+1

   ; print__str8 " * 0x0100 (256)  :   "
   lda #<str8_0x002A
   sta ZP_PTR_1
   lda #>str8_0x002A
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0200
   lda #<512
   sta var__main__a
   lda #>512
   sta var__main__a+1

   ; print__str8 " * 0x0200 (512)  :   "
   lda #<str8_0x002B
   sta ZP_PTR_1
   lda #>str8_0x002B
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0400
   lda #<1024
   sta var__main__a
   lda #>1024
   sta var__main__a+1

   ; print__str8 " * 0x0400 (1024) :  "
   lda #<str8_0x002C
   sta ZP_PTR_1
   lda #>str8_0x002C
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x0800
   lda #<2048
   sta var__main__a
   lda #>2048
   sta var__main__a+1

   ; print__str8 " * 0x0800 (2048) :  "
   lda #<str8_0x002D
   sta ZP_PTR_1
   lda #>str8_0x002D
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x1000
   lda #<4096
   sta var__main__a
   lda #>4096
   sta var__main__a+1

   ; print__str8 " * 0x1000 (4096) :  "
   lda #<str8_0x002E
   sta ZP_PTR_1
   lda #>str8_0x002E
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x2000
   lda #<8192
   sta var__main__a
   lda #>8192
   sta var__main__a+1

   ; print__str8 " * 0x2000 (8192) :  "
   lda #<str8_0x002F
   sta ZP_PTR_1
   lda #>str8_0x002F
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x4000
   lda #<16384
   sta var__main__a
   lda #>16384
   sta var__main__a+1

   ; print__str8 " * 0x4000 (16384): "
   lda #<str8_0x0030
   sta ZP_PTR_1
   lda #>str8_0x0030
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0x8000
   lda #<32768
   sta var__main__a
   lda #>32768
   sta var__main__a+1

   ; print__str8 " * 0x8000 (32768): "
   lda #<str8_0x0031
   sta ZP_PTR_1
   lda #>str8_0x0031
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

   ; print__endl
   jsr _print__endl

   ; equals__u16_u16 .a 0xFFFF
   lda #<65535
   sta var__main__a
   lda #>65535
   sta var__main__a+1

   ; print__str8 " * 0xFFFF (65535): "
   lda #<str8_0x0032
   sta ZP_PTR_1
   lda #>str8_0x0032
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u16 .a
   ldx var__main__a
   ldy var__main__a+1
   jsr _print__u16

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

