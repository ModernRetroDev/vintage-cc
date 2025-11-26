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
   .byte <(var__main__f+2), >(var__main__f+2) ; ptr_addr (u16)
   .byte $00 ; mode (u8)
   .byte $00 ; device (u8)
   .byte $00 ; channel (u8)
   .byte $00 ; status (u8)
   .byte $00, $00 ; fname (u16)

var__main__a: ; type: u24
   .byte $00, $00, $00

str8_0x0000: ; type: str8
   .byte <(str8_0x0000+2), >(str8_0x0000+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $22, $00 ; length (u16)
   .byte $22, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$33,$5F,$74,$79,$70,$65,$5F
   .byte $75,$32,$34,$5F,$5F,$62,$69,$74,$73,$68
   .byte $69,$66,$74,$5F,$6C,$65,$66,$74,$2E,$75
   .byte $74,$65,$73,$74
   .byte $00 ; null terminator (u8)

str8_0x0001: ; type: str8
   .byte <(str8_0x0001+2), >(str8_0x0001+2) ; ptr_addr (u16)
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
   .byte <(str8_0x0002+2), >(str8_0x0002+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$75,$32,$34,$20,$62,$69,$74,$73
   .byte $68,$69,$66,$74,$20,$28,$73,$6D,$61,$6C
   .byte $6C,$20,$75,$32,$34,$20,$76,$61,$6C,$75
   .byte $65,$73,$29,$20,$20,$20,$20,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x0003: ; type: str8
   .byte <(str8_0x0003+2), >(str8_0x0003+2) ; ptr_addr (u16)
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
   .byte <(str8_0x0004+2), >(str8_0x0004+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$62,$69,$74,$73,$68,$69,$66,$74,$20
   .byte $6F,$66,$20,$75,$32,$34,$20,$76,$61,$6C
   .byte $75,$65,$73,$20,$3C,$20,$32,$35,$35
   .byte $00 ; null terminator (u8)

str8_0x0005: ; type: str8
   .byte <(str8_0x0005+2), >(str8_0x0005+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2F, $00 ; length (u16)
   .byte $2F, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$30,$30,$30,$30,$30,$30,$30
   .byte $30,$20,$3C,$3C,$20,$31,$20,$20,$20,$23
   .byte $20,$20,$20,$30,$20,$2D,$2D,$3E,$20,$20
   .byte $20,$30,$20,$28,$30,$78,$30,$30,$30,$30
   .byte $30,$30,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x0006: ; type: str8
   .byte <(str8_0x0006+2), >(str8_0x0006+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2F, $00 ; length (u16)
   .byte $2F, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$30,$30,$30,$30,$30,$30,$30
   .byte $31,$20,$3C,$3C,$20,$31,$20,$20,$20,$23
   .byte $20,$20,$20,$31,$20,$2D,$2D,$3E,$20,$20
   .byte $20,$32,$20,$28,$30,$78,$30,$30,$30,$30
   .byte $30,$32,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x0007: ; type: str8
   .byte <(str8_0x0007+2), >(str8_0x0007+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2F, $00 ; length (u16)
   .byte $2F, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$30,$30,$30,$30,$30,$30,$31
   .byte $30,$20,$3C,$3C,$20,$31,$20,$20,$20,$23
   .byte $20,$20,$20,$32,$20,$2D,$2D,$3E,$20,$20
   .byte $20,$34,$20,$28,$30,$78,$30,$30,$30,$30
   .byte $30,$34,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x0008: ; type: str8
   .byte <(str8_0x0008+2), >(str8_0x0008+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2F, $00 ; length (u16)
   .byte $2F, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$30,$30,$30,$30,$30,$31,$30
   .byte $30,$20,$3C,$3C,$20,$31,$20,$20,$20,$23
   .byte $20,$20,$20,$34,$20,$2D,$2D,$3E,$20,$20
   .byte $20,$38,$20,$28,$30,$78,$30,$30,$30,$30
   .byte $30,$38,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x0009: ; type: str8
   .byte <(str8_0x0009+2), >(str8_0x0009+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2F, $00 ; length (u16)
   .byte $2F, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$30,$30,$30,$30,$31,$30,$30
   .byte $30,$20,$3C,$3C,$20,$31,$20,$20,$20,$23
   .byte $20,$20,$20,$38,$20,$2D,$2D,$3E,$20,$20
   .byte $31,$36,$20,$28,$30,$78,$30,$30,$30,$30
   .byte $31,$30,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x000A: ; type: str8
   .byte <(str8_0x000A+2), >(str8_0x000A+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2F, $00 ; length (u16)
   .byte $2F, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$30,$30,$30,$31,$30,$30,$30
   .byte $30,$20,$3C,$3C,$20,$31,$20,$20,$20,$23
   .byte $20,$20,$31,$36,$20,$2D,$2D,$3E,$20,$20
   .byte $33,$32,$20,$28,$30,$78,$30,$30,$30,$30
   .byte $32,$30,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x000B: ; type: str8
   .byte <(str8_0x000B+2), >(str8_0x000B+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2F, $00 ; length (u16)
   .byte $2F, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$30,$30,$31,$30,$30,$30,$30
   .byte $30,$20,$3C,$3C,$20,$31,$20,$20,$20,$23
   .byte $20,$20,$33,$32,$20,$2D,$2D,$3E,$20,$20
   .byte $36,$34,$20,$28,$30,$78,$30,$30,$30,$30
   .byte $34,$30,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x000C: ; type: str8
   .byte <(str8_0x000C+2), >(str8_0x000C+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2F, $00 ; length (u16)
   .byte $2F, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$30,$31,$30,$30,$30,$30,$30
   .byte $30,$20,$3C,$3C,$20,$31,$20,$20,$20,$23
   .byte $20,$20,$36,$34,$20,$2D,$2D,$3E,$20,$31
   .byte $32,$38,$20,$28,$30,$78,$30,$30,$30,$30
   .byte $38,$30,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x000D: ; type: str8
   .byte <(str8_0x000D+2), >(str8_0x000D+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2F, $00 ; length (u16)
   .byte $2F, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$31,$30,$30,$30,$30,$30,$30
   .byte $30,$20,$3C,$3C,$20,$31,$20,$20,$20,$23
   .byte $20,$31,$32,$38,$20,$2D,$2D,$3E,$20,$32
   .byte $35,$36,$20,$28,$30,$78,$30,$30,$30,$31
   .byte $30,$30,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x000E: ; type: str8
   .byte <(str8_0x000E+2), >(str8_0x000E+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2F, $00 ; length (u16)
   .byte $2F, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$31,$31,$31,$31,$31,$31,$31
   .byte $31,$20,$3C,$3C,$20,$31,$20,$20,$20,$23
   .byte $20,$32,$35,$35,$20,$2D,$2D,$3E,$20,$35
   .byte $31,$30,$20,$28,$30,$78,$30,$30,$30,$31
   .byte $46,$45,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x000F: ; type: str8
   .byte <(str8_0x000F+2), >(str8_0x000F+2) ; ptr_addr (u16)
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

str8_0x0010: ; type: str8
   .byte <(str8_0x0010+2), >(str8_0x0010+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$75,$32,$34,$20,$62,$69,$74,$73
   .byte $68,$69,$66,$74,$20,$28,$6D,$69,$64,$20
   .byte $75,$32,$34,$20,$76,$61,$6C,$75,$65,$73
   .byte $29,$20,$20,$20,$20,$20,$20,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x0011: ; type: str8
   .byte <(str8_0x0011+2), >(str8_0x0011+2) ; ptr_addr (u16)
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

str8_0x0012: ; type: str8
   .byte <(str8_0x0012+2), >(str8_0x0012+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$62,$69,$74,$73,$68,$69,$66,$74,$20
   .byte $6F,$66,$20,$75,$32,$34,$20,$76,$61,$6C
   .byte $75,$65,$73,$20,$3E,$20,$32,$35,$35
   .byte $00 ; null terminator (u8)

str8_0x0013: ; type: str8
   .byte <(str8_0x0013+2), >(str8_0x0013+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $32, $00 ; length (u16)
   .byte $32, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$31,$3A,$30,$30,$30,$30,$30
   .byte $30,$30,$30,$20,$3C,$3C,$20,$31,$20,$20
   .byte $20,$23,$20,$32,$35,$36,$20,$2D,$2D,$3E
   .byte $20,$20,$35,$31,$32,$20,$28,$30,$78,$30
   .byte $30,$30,$32,$30,$30,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x0014: ; type: str8
   .byte <(str8_0x0014+2), >(str8_0x0014+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $32, $00 ; length (u16)
   .byte $32, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$31,$3A,$30,$30,$30,$30,$30
   .byte $30,$30,$31,$20,$3C,$3C,$20,$31,$20,$20
   .byte $20,$23,$20,$32,$35,$37,$20,$2D,$2D,$3E
   .byte $20,$20,$35,$31,$34,$20,$28,$30,$78,$30
   .byte $30,$30,$32,$30,$32,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x0015: ; type: str8
   .byte <(str8_0x0015+2), >(str8_0x0015+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $32, $00 ; length (u16)
   .byte $32, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$31,$3A,$30,$30,$30,$30,$30
   .byte $30,$31,$30,$20,$3C,$3C,$20,$31,$20,$20
   .byte $20,$23,$20,$32,$35,$38,$20,$2D,$2D,$3E
   .byte $20,$20,$35,$31,$36,$20,$28,$30,$78,$30
   .byte $30,$30,$32,$30,$34,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x0016: ; type: str8
   .byte <(str8_0x0016+2), >(str8_0x0016+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $32, $00 ; length (u16)
   .byte $32, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$31,$3A,$30,$30,$30,$30,$30
   .byte $31,$30,$30,$20,$3C,$3C,$20,$31,$20,$20
   .byte $20,$23,$20,$32,$36,$30,$20,$2D,$2D,$3E
   .byte $20,$20,$35,$32,$30,$20,$28,$30,$78,$30
   .byte $30,$30,$32,$30,$38,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x0017: ; type: str8
   .byte <(str8_0x0017+2), >(str8_0x0017+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $32, $00 ; length (u16)
   .byte $32, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$31,$3A,$30,$30,$30,$30,$31
   .byte $30,$30,$30,$20,$3C,$3C,$20,$31,$20,$20
   .byte $20,$23,$20,$32,$36,$34,$20,$2D,$2D,$3E
   .byte $20,$20,$35,$32,$38,$20,$28,$30,$78,$30
   .byte $30,$30,$32,$31,$30,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x0018: ; type: str8
   .byte <(str8_0x0018+2), >(str8_0x0018+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $32, $00 ; length (u16)
   .byte $32, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$31,$3A,$30,$30,$30,$31,$30
   .byte $30,$30,$30,$20,$3C,$3C,$20,$31,$20,$20
   .byte $20,$23,$20,$32,$37,$32,$20,$2D,$2D,$3E
   .byte $20,$20,$35,$34,$34,$20,$28,$30,$78,$30
   .byte $30,$30,$32,$32,$30,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x0019: ; type: str8
   .byte <(str8_0x0019+2), >(str8_0x0019+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $32, $00 ; length (u16)
   .byte $32, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$31,$3A,$30,$30,$31,$30,$30
   .byte $30,$30,$30,$20,$3C,$3C,$20,$31,$20,$20
   .byte $20,$23,$20,$32,$38,$38,$20,$2D,$2D,$3E
   .byte $20,$20,$35,$37,$36,$20,$28,$30,$78,$30
   .byte $30,$30,$32,$34,$30,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x001A: ; type: str8
   .byte <(str8_0x001A+2), >(str8_0x001A+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $32, $00 ; length (u16)
   .byte $32, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$31,$3A,$30,$31,$30,$30,$30
   .byte $30,$30,$30,$20,$3C,$3C,$20,$31,$20,$20
   .byte $20,$23,$20,$33,$32,$30,$20,$2D,$2D,$3E
   .byte $20,$20,$36,$34,$30,$20,$28,$30,$78,$30
   .byte $30,$30,$32,$38,$30,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x001B: ; type: str8
   .byte <(str8_0x001B+2), >(str8_0x001B+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $32, $00 ; length (u16)
   .byte $32, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$31,$3A,$31,$30,$30,$30,$30
   .byte $30,$30,$30,$20,$3C,$3C,$20,$31,$20,$20
   .byte $20,$23,$20,$33,$38,$34,$20,$2D,$2D,$3E
   .byte $20,$20,$37,$36,$38,$20,$28,$30,$78,$30
   .byte $30,$30,$33,$30,$30,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x001C: ; type: str8
   .byte <(str8_0x001C+2), >(str8_0x001C+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $32, $00 ; length (u16)
   .byte $32, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$3A,$31,$3A,$31,$31,$31,$31,$31
   .byte $31,$31,$31,$20,$3C,$3C,$20,$31,$20,$20
   .byte $20,$23,$20,$35,$31,$31,$20,$2D,$2D,$3E
   .byte $20,$31,$30,$32,$32,$20,$28,$30,$78,$30
   .byte $30,$30,$33,$46,$45,$29,$3A,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x001D: ; type: str8
   .byte <(str8_0x001D+2), >(str8_0x001D+2) ; ptr_addr (u16)
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

str8_0x001E: ; type: str8
   .byte <(str8_0x001E+2), >(str8_0x001E+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$75,$32,$34,$20,$62,$69,$74,$73
   .byte $68,$69,$66,$74,$20,$28,$6C,$61,$72,$67
   .byte $65,$20,$75,$32,$34,$20,$76,$61,$6C,$75
   .byte $65,$73,$29,$20,$20,$20,$20,$20,$23
   .byte $00 ; null terminator (u8)

str8_0x001F: ; type: str8
   .byte <(str8_0x001F+2), >(str8_0x001F+2) ; ptr_addr (u16)
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

str8_0x0020: ; type: str8
   .byte <(str8_0x0020+2), >(str8_0x0020+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2A, $00 ; length (u16)
   .byte $2A, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$62,$69,$74,$73,$68,$69,$66,$74,$20
   .byte $6F,$66,$20,$75,$32,$34,$20,$76,$61,$6C
   .byte $75,$65,$73,$20,$3E,$20,$30,$78,$46,$46
   .byte $46,$46
   .byte $00 ; null terminator (u8)

str8_0x0021: ; type: str8
   .byte <(str8_0x0021+2), >(str8_0x0021+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $41, $00 ; length (u16)
   .byte $41, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$62,$30,$31,$30,$31,$30,$31,$30,$31
   .byte $30,$31,$30,$31,$30,$31,$30,$31,$30,$31
   .byte $30,$31,$30,$31,$30,$31,$20,$3C,$3C,$20
   .byte $31,$3B,$20,$28,$30,$62,$31,$30,$31,$30
   .byte $31,$30,$31,$30,$31,$30,$31,$30,$31,$30
   .byte $31,$30,$31,$30,$31,$30,$31,$30,$31,$30
   .byte $29,$3A,$20,$30,$62
   .byte $00 ; null terminator (u8)

;--------------------------------------------------------;
; BUILT-IN FUNCTIONS                                     ;
;--------------------------------------------------------;
.global _close__file
.global _open__file
.global _print__endl
.global _print__str8
.global _print__u24_b
.global _print__u24_xx
.global _print__u8_b
.global _print__u8_xx
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


_print__u24_b:
   ;-----------------------------------------------------;
   ; X = LOW BYTE NUMBER TO BE PRINTED                   ;
   ; Y = MID BYTE NUMBER TO BE PRINTED                   ;
   ; A = HIGH BYTE NUMBER TO BE PRINTED                  ;
   ;-----------------------------------------------------;
   sta r0 ; store high byte
   tya
   sta r1 ; store mid byte
   txa
   sta r2 ; store low byte

   ; print out high byte
   lda r0
   jsr _print__u8_b

   ; print out mid byte
   lda r1
   jsr _print__u8_b

   ; print out low byte
   lda r2
   jsr _print__u8_b

   rts


_print__u24_xx:
   ;-----------------------------------------------------;
   ; X = LOW BYTE NUMBER TO BE PRINTED                   ;
   ; Y = MID BYTE NUMBER TO BE PRINTED                   ;
   ; A = HIGH BYTE NUMBER TO BE PRINTED                  ;
   ;-----------------------------------------------------;
   sta r0 ; store high byte
   tya
   sta r1 ; store mid byte
   txa
   sta r2 ; store low byte

   ; print out high byte
   lda r0
   jsr _print__u8_xx

   ; print out mid byte
   lda r1
   jsr _print__u8_xx

   ; print out low byte
   lda r2
   jsr _print__u8_xx

   rts


_print__u8_b:
   ;-----------------------------------------------------;
   ; A = STARTS WITH NUMBER TO BE PRINTED                ;
   ;-----------------------------------------------------;
   tax ; store A value within X

   ; print value of highest bit (bit 8)
   and #%10000000
   ldy #$30
   cmp #$0
   beq _print__u8_b_8
   ldy #$31
_print__u8_b_8:
   tya
   jsr CHROUT

   ; print value of bit 7
   txa
   and #%1000000
   ldy #$30
   cmp #$0
   beq _print__u8_b_7
   ldy #$31
_print__u8_b_7:
   tya
   jsr CHROUT

   ; print value of bit 6
   txa
   and #%100000
   ldy #$30
   cmp #$0
   beq _print__u8_b_6
   ldy #$31
_print__u8_b_6:
   tya
   jsr CHROUT

   ; print value of bit 5
   txa
   and #%10000
   ldy #$30
   cmp #$0
   beq _print__u8_b_5
   ldy #$31
_print__u8_b_5:
   tya
   jsr CHROUT

   ; print value of bit 4
   txa
   and #%1000
   ldy #$30
   cmp #$0
   beq _print__u8_b_4
   ldy #$31
_print__u8_b_4:
   tya
   jsr CHROUT

   ; print value of bit 3
   txa
   and #%100
   ldy #$30
   cmp #$0
   beq _print__u8_b_3
   ldy #$31
_print__u8_b_3:
   tya
   jsr CHROUT

   ; print value of bit 2
   txa
   and #%10
   ldy #$30
   cmp #$0
   beq _print__u8_b_2
   ldy #$31
_print__u8_b_2:
   tya
   jsr CHROUT

   ; print value of bit 1
   txa
   and #%1
   ldy #$30
   cmp #$0
   beq _print__u8_b_1
   ldy #$31
_print__u8_b_1:
   tya
   jsr CHROUT

   rts


_print__u8_xx:
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
   bcc _print__u8_xx__arabic_hi; if A < 10 goto `arabic_hi`

   ; digit is an alpha;
   ; SUBTRACT 10 FROM WORKING NUMBER ;
   sec ; set carry flag
   sbc #10 ; subtract `10` from A
   clc
   adc #65 ; add `65` to A
   jsr CHROUT
   bra _print__u8_xx__low

_print__u8_xx__arabic_hi:
   ;
   clc ; clear carry
   adc #$30 ; point to 0 + remainder
   jsr CHROUT

_print__u8_xx__low:
   txa ; store X value within A
   ; isolate the lower nibble
   and #$0F

   cmp #10 ; compare A with `10`
   bcc _print__u8_xx__arabic_low; if A < 10 goto `arabic_low`

   ; digit is an alpha;
   sbc #10 ; subtract `10` from A
   clc
   adc #65 ; add `65` to A
   jsr CHROUT
   bra _print__u8_xx__out

_print__u8_xx__arabic_low:
   ;
   clc ; clear carry
   adc #$30 ; point to 0 + remainder
   jsr CHROUT

_print__u8_xx__out:
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
; MAIN FUNCTION                                          ;
;--------------------------------------------------------;
fn_main: 
   ; set output mode to ISO
   lda #$0F
   jsr BSOUT

   ; setup__file .f 'w' "@:03_type_u24__bitshift_left.utest"
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

   ; print__str8 "# u24 bitshift (small u24 values)     #"
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

   ; print__str8 "# test out bitshift of u24 values < 255"
   lda #<str8_0x0004
   sta ZP_PTR_1
   lda #>str8_0x0004
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 0
   lda #$00
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:00000000 << 1   #   0 -->   0 (0x000000): 0x"
   lda #<str8_0x0005
   sta ZP_PTR_1
   lda #>str8_0x0005
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 1
   lda #$01
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:00000001 << 1   #   1 -->   2 (0x000002): 0x"
   lda #<str8_0x0006
   sta ZP_PTR_1
   lda #>str8_0x0006
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 2
   lda #$02
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:00000010 << 1   #   2 -->   4 (0x000004): 0x"
   lda #<str8_0x0007
   sta ZP_PTR_1
   lda #>str8_0x0007
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 4
   lda #$04
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:00000100 << 1   #   4 -->   8 (0x000008): 0x"
   lda #<str8_0x0008
   sta ZP_PTR_1
   lda #>str8_0x0008
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 8
   lda #$08
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:00001000 << 1   #   8 -->  16 (0x000010): 0x"
   lda #<str8_0x0009
   sta ZP_PTR_1
   lda #>str8_0x0009
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 16
   lda #$10
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:00010000 << 1   #  16 -->  32 (0x000020): 0x"
   lda #<str8_0x000A
   sta ZP_PTR_1
   lda #>str8_0x000A
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 32
   lda #$20
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:00100000 << 1   #  32 -->  64 (0x000040): 0x"
   lda #<str8_0x000B
   sta ZP_PTR_1
   lda #>str8_0x000B
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 64
   lda #$40
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:01000000 << 1   #  64 --> 128 (0x000080): 0x"
   lda #<str8_0x000C
   sta ZP_PTR_1
   lda #>str8_0x000C
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 128
   lda #$80
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:10000000 << 1   # 128 --> 256 (0x000100): 0x"
   lda #<str8_0x000D
   sta ZP_PTR_1
   lda #>str8_0x000D
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 255
   lda #$FF
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:11111111 << 1   # 255 --> 510 (0x0001FE): 0x"
   lda #<str8_0x000E
   sta ZP_PTR_1
   lda #>str8_0x000E
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

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

   ; print__str8 "# u24 bitshift (mid u24 values)       #"
   lda #<str8_0x0010
   sta ZP_PTR_1
   lda #>str8_0x0010
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#-------------------------------------#"
   lda #<str8_0x0011
   sta ZP_PTR_1
   lda #>str8_0x0011
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# test out bitshift of u24 values > 255"
   lda #<str8_0x0012
   sta ZP_PTR_1
   lda #>str8_0x0012
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 256
   lda #$00
   sta var__main__a
   lda #$01
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:1:00000000 << 1   # 256 -->  512 (0x000200): 0x"
   lda #<str8_0x0013
   sta ZP_PTR_1
   lda #>str8_0x0013
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 257
   lda #$01
   sta var__main__a
   lda #$01
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:1:00000001 << 1   # 257 -->  514 (0x000202): 0x"
   lda #<str8_0x0014
   sta ZP_PTR_1
   lda #>str8_0x0014
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 258
   lda #$02
   sta var__main__a
   lda #$01
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:1:00000010 << 1   # 258 -->  516 (0x000204): 0x"
   lda #<str8_0x0015
   sta ZP_PTR_1
   lda #>str8_0x0015
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 260
   lda #$04
   sta var__main__a
   lda #$01
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:1:00000100 << 1   # 260 -->  520 (0x000208): 0x"
   lda #<str8_0x0016
   sta ZP_PTR_1
   lda #>str8_0x0016
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 264
   lda #$08
   sta var__main__a
   lda #$01
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:1:00001000 << 1   # 264 -->  528 (0x000210): 0x"
   lda #<str8_0x0017
   sta ZP_PTR_1
   lda #>str8_0x0017
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 272
   lda #$10
   sta var__main__a
   lda #$01
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:1:00010000 << 1   # 272 -->  544 (0x000220): 0x"
   lda #<str8_0x0018
   sta ZP_PTR_1
   lda #>str8_0x0018
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 288
   lda #$20
   sta var__main__a
   lda #$01
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:1:00100000 << 1   # 288 -->  576 (0x000240): 0x"
   lda #<str8_0x0019
   sta ZP_PTR_1
   lda #>str8_0x0019
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 320
   lda #$40
   sta var__main__a
   lda #$01
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:1:01000000 << 1   # 320 -->  640 (0x000280): 0x"
   lda #<str8_0x001A
   sta ZP_PTR_1
   lda #>str8_0x001A
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 384
   lda #$80
   sta var__main__a
   lda #$01
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:1:10000000 << 1   # 384 -->  768 (0x000300): 0x"
   lda #<str8_0x001B
   sta ZP_PTR_1
   lda #>str8_0x001B
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 511
   lda #$FF
   sta var__main__a
   lda #$01
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b:1:11111111 << 1   # 511 --> 1022 (0x0003FE): 0x"
   lda #<str8_0x001C
   sta ZP_PTR_1
   lda #>str8_0x001C
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_xx .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_xx

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; print__str8 "#-------------------------------------#"
   lda #<str8_0x001D
   sta ZP_PTR_1
   lda #>str8_0x001D
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# u24 bitshift (large u24 values)     #"
   lda #<str8_0x001E
   sta ZP_PTR_1
   lda #>str8_0x001E
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#-------------------------------------#"
   lda #<str8_0x001F
   sta ZP_PTR_1
   lda #>str8_0x001F
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# test out bitshift of u24 values > 0xFFFF"
   lda #<str8_0x0020
   sta ZP_PTR_1
   lda #>str8_0x0020
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 0b010101010101010101010101
   lda #$55
   sta var__main__a
   lda #$55
   sta var__main__a+1
   lda #$55
   sta var__main__a+2

   ; lshift__u24 .a
   lda var__main__a
   asl
   sta var__main__a
   lda var__main__a+1
   rol
   sta var__main__a+1
   lda var__main__a+2
   rol
   sta var__main__a+2

   ; print__str8 "0b010101010101010101010101 << 1; (0b101010101010101010101010): 0b"
   lda #<str8_0x0021
   sta ZP_PTR_1
   lda #>str8_0x0021
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__u24_b .a
   ldx var__main__a
   ldy var__main__a+1
   lda var__main__a+2
   jsr _print__u24_b

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

