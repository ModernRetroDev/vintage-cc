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

var__main__b: ; type: u24
   .byte $00, $00, $00

var__main__cmpres: ; type: u8
   .byte $00

str8_0x0000: ; type: str8
   .byte <(str8_0x0000+2), >(str8_0x0000+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $17, $00 ; length (u16)
   .byte $17, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$32,$5F,$65,$76,$61,$6C,$5F
   .byte $75,$32,$34,$5F,$5F,$6C,$74,$2E,$75,$74
   .byte $65,$73,$74
   .byte $00 ; null terminator (u8)

str8_0x0001: ; type: str8
   .byte <(str8_0x0001+2), >(str8_0x0001+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $29, $00 ; length (u16)
   .byte $29, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x0002: ; type: str8
   .byte <(str8_0x0002+2), >(str8_0x0002+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $29, $00 ; length (u16)
   .byte $29, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$65,$76,$61,$6C,$2D,$6C,$74,$20
   .byte $28,$75,$32,$34,$29,$20,$20,$20,$20,$20
   .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x0003: ; type: str8
   .byte <(str8_0x0003+2), >(str8_0x0003+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $29, $00 ; length (u16)
   .byte $29, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x0004: ; type: str8
   .byte <(str8_0x0004+2), >(str8_0x0004+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$63,$6F,$6D,$70,$61,$72,$69,$73,$6F
   .byte $6E,$73,$20,$6F,$66,$20,$76,$61,$6C,$75
   .byte $65,$73,$20,$3C,$20,$30,$78,$46,$46
   .byte $00 ; null terminator (u8)

str8_0x0005: ; type: str8
   .byte <(str8_0x0005+2), >(str8_0x0005+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $08, $00 ; length (u16)
   .byte $08, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3C,$20,$35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0006: ; type: str8
   .byte <(str8_0x0006+2), >(str8_0x0006+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $09, $00 ; length (u16)
   .byte $09, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3C,$20,$31,$30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0007: ; type: str8
   .byte <(str8_0x0007+2), >(str8_0x0007+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $09, $00 ; length (u16)
   .byte $09, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3C,$20,$31,$35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0008: ; type: str8
   .byte <(str8_0x0008+2), >(str8_0x0008+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $34, $00 ; length (u16)
   .byte $34, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$63,$6F,$6D,$70,$61,$72,$69,$73,$6F
   .byte $6E,$73,$20,$6F,$66,$20,$76,$61,$6C,$75
   .byte $65,$73,$20,$3E,$20,$30,$78,$46,$46,$20
   .byte $61,$6E,$64,$20,$3C,$20,$30,$78,$46,$46
   .byte $46,$46
   .byte $00 ; null terminator (u8)

str8_0x0009: ; type: str8
   .byte <(str8_0x0009+2), >(str8_0x0009+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $0C, $00 ; length (u16)
   .byte $0C, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$20,$3C,$20,$35,$30,$30
   .byte $3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000A: ; type: str8
   .byte <(str8_0x000A+2), >(str8_0x000A+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $0D, $00 ; length (u16)
   .byte $0D, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$20,$3C,$20,$31,$30,$30
   .byte $30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000B: ; type: str8
   .byte <(str8_0x000B+2), >(str8_0x000B+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $0D, $00 ; length (u16)
   .byte $0D, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$20,$3C,$20,$31,$35,$30
   .byte $30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000C: ; type: str8
   .byte <(str8_0x000C+2), >(str8_0x000C+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $29, $00 ; length (u16)
   .byte $29, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$63,$6F,$6D,$70,$61,$72,$69,$73,$6F
   .byte $6E,$73,$20,$6F,$66,$20,$76,$61,$6C,$75
   .byte $65,$73,$20,$3E,$20,$30,$78,$46,$46,$46
   .byte $46
   .byte $00 ; null terminator (u8)

str8_0x000D: ; type: str8
   .byte <(str8_0x000D+2), >(str8_0x000D+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $14, $00 ; length (u16)
   .byte $14, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$30,$30,$30,$30,$20,$3C
   .byte $20,$35,$30,$30,$30,$30,$30,$30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x000E: ; type: str8
   .byte <(str8_0x000E+2), >(str8_0x000E+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $15, $00 ; length (u16)
   .byte $15, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$30,$30,$30,$30,$20,$3C
   .byte $20,$31,$30,$30,$30,$30,$30,$30,$30,$3A
   .byte $20
   .byte $00 ; null terminator (u8)

str8_0x000F: ; type: str8
   .byte <(str8_0x000F+2), >(str8_0x000F+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $15, $00 ; length (u16)
   .byte $15, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$30,$30,$30,$30,$20,$3C
   .byte $20,$31,$35,$30,$30,$30,$30,$30,$30,$3A
   .byte $20
   .byte $00 ; null terminator (u8)

str8_0x0010: ; type: str8
   .byte <(str8_0x0010+2), >(str8_0x0010+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $29, $00 ; length (u16)
   .byte $29, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x0011: ; type: str8
   .byte <(str8_0x0011+2), >(str8_0x0011+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $29, $00 ; length (u16)
   .byte $29, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$65,$76,$61,$6C,$2D,$6C,$74,$65
   .byte $71,$20,$28,$75,$32,$34,$29,$20,$20,$20
   .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x0012: ; type: str8
   .byte <(str8_0x0012+2), >(str8_0x0012+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $29, $00 ; length (u16)
   .byte $29, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x0013: ; type: str8
   .byte <(str8_0x0013+2), >(str8_0x0013+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$63,$6F,$6D,$70,$61,$72,$69,$73,$6F
   .byte $6E,$73,$20,$6F,$66,$20,$76,$61,$6C,$75
   .byte $65,$73,$20,$3C,$20,$30,$78,$46,$46
   .byte $00 ; null terminator (u8)

str8_0x0014: ; type: str8
   .byte <(str8_0x0014+2), >(str8_0x0014+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $09, $00 ; length (u16)
   .byte $09, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3C,$3D,$20,$35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0015: ; type: str8
   .byte <(str8_0x0015+2), >(str8_0x0015+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $0A, $00 ; length (u16)
   .byte $0A, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3C,$3D,$20,$31,$30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0016: ; type: str8
   .byte <(str8_0x0016+2), >(str8_0x0016+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $0A, $00 ; length (u16)
   .byte $0A, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$20,$3C,$3D,$20,$31,$35,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0017: ; type: str8
   .byte <(str8_0x0017+2), >(str8_0x0017+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $34, $00 ; length (u16)
   .byte $34, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$63,$6F,$6D,$70,$61,$72,$69,$73,$6F
   .byte $6E,$73,$20,$6F,$66,$20,$76,$61,$6C,$75
   .byte $65,$73,$20,$3E,$20,$30,$78,$46,$46,$20
   .byte $61,$6E,$64,$20,$3C,$20,$30,$78,$46,$46
   .byte $46,$46
   .byte $00 ; null terminator (u8)

str8_0x0018: ; type: str8
   .byte <(str8_0x0018+2), >(str8_0x0018+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $0D, $00 ; length (u16)
   .byte $0D, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$20,$3C,$3D,$20,$35,$30
   .byte $30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x0019: ; type: str8
   .byte <(str8_0x0019+2), >(str8_0x0019+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $0E, $00 ; length (u16)
   .byte $0E, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$20,$3C,$3D,$20,$31,$30
   .byte $30,$30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x001A: ; type: str8
   .byte <(str8_0x001A+2), >(str8_0x001A+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $0E, $00 ; length (u16)
   .byte $0E, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$20,$3C,$3D,$20,$31,$35
   .byte $30,$30,$3A,$20
   .byte $00 ; null terminator (u8)

str8_0x001B: ; type: str8
   .byte <(str8_0x001B+2), >(str8_0x001B+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $34, $00 ; length (u16)
   .byte $34, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$74,$65,$73,$74,$20,$6F,$75,$74
   .byte $20,$63,$6F,$6D,$70,$61,$72,$69,$73,$6F
   .byte $6E,$73,$20,$6F,$66,$20,$76,$61,$6C,$75
   .byte $65,$73,$20,$3E,$20,$30,$78,$46,$46,$20
   .byte $61,$6E,$64,$20,$3C,$20,$30,$78,$46,$46
   .byte $46,$46
   .byte $00 ; null terminator (u8)

str8_0x001C: ; type: str8
   .byte <(str8_0x001C+2), >(str8_0x001C+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $15, $00 ; length (u16)
   .byte $15, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$30,$30,$30,$30,$20,$3C
   .byte $3D,$20,$35,$30,$30,$30,$30,$30,$30,$3A
   .byte $20
   .byte $00 ; null terminator (u8)

str8_0x001D: ; type: str8
   .byte <(str8_0x001D+2), >(str8_0x001D+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $16, $00 ; length (u16)
   .byte $16, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$30,$30,$30,$30,$20,$3C
   .byte $3D,$20,$31,$30,$30,$30,$30,$30,$30,$30
   .byte $3A,$20
   .byte $00 ; null terminator (u8)

str8_0x001E: ; type: str8
   .byte <(str8_0x001E+2), >(str8_0x001E+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $16, $00 ; length (u16)
   .byte $16, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $31,$30,$30,$30,$30,$30,$30,$30,$20,$3C
   .byte $3D,$20,$31,$35,$30,$30,$30,$30,$30,$30
   .byte $3A,$20
   .byte $00 ; null terminator (u8)

;--------------------------------------------------------;
; BUILT-IN FUNCTIONS                                     ;
;--------------------------------------------------------;
.global _close__file
.global _eval_lt__u24
.global _eval_lteq__u24
.global _open__file
.global _print__bool
.global _print__endl
.global _print__str8
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


_eval_lt__u24:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO VALUE ONE.                     ;
   ; ZP_PTR_2 = POINTS TO VALUE TWO.                     ;
   ;-----------------------------------------------------;
   ; compare high byte first
   ldy #2
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lt__u24__true   ; high-byte is less than; exit now
   beq _eval_lt__u24__byte_2 ; high-byte is same.. check low-byte
   ; high byte greater-than; exit now
   lda #0
   bra _eval_lt__u24__out

_eval_lt__u24__byte_2:
   ; now compare mid byte
   ldy #1
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lt__u24__true   ; mid-byte is less than; exit now
   beq _eval_lt__u24__byte_1 ; mid-byte is same.. check low-byte
   ; mid byte greater-than; exit now
   lda #0
   bra _eval_lt__u24__out

_eval_lt__u24__byte_1:
   ; now compare the low bytes
   ldy #0
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lt__u24__true
   ; low byte not less-than; exit now
   lda #0
   bra _eval_lt__u24__out
_eval_lt__u24__true:
   lda #1
_eval_lt__u24__out:
   rts


_eval_lteq__u24:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO VALUE ONE.                     ;
   ; ZP_PTR_2 = POINTS TO VALUE TWO.                     ;
   ;-----------------------------------------------------;
   ; compare high byte first
   ldy #2
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lteq__u24__true   ; high-byte is less than; exit now
   beq _eval_lteq__u24__byte_2 ; high-byte is same.. check low-byte
   ; high byte greater-than; exit now
   lda #0
   bra _eval_lteq__u24__out

_eval_lteq__u24__byte_2:
   ; now compare mid byte
   ldy #1
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lteq__u24__true   ; mid-byte is less than; exit now
   beq _eval_lteq__u24__byte_1 ; mid-byte is same.. check low-byte
   ; mid byte greater-than; exit now
   lda #0
   bra _eval_lteq__u24__out

_eval_lteq__u24__byte_1:
   ; now compare the low bytes
   ldy #0
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lteq__u24__true ; low byte is less-than; exit now
   beq _eval_lteq__u24__true ; low-byte is equal-to; exit now
   ; low byte not less-than; exit now
   lda #0
   bra _eval_lteq__u24__out
_eval_lteq__u24__true:
   lda #1
_eval_lteq__u24__out:
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

   ; setup__file .f 'w' "@:02_eval_u24__lt.utest"
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

   ; print__str8 "#---------------------------------------#"
   lda #<str8_0x0001
   sta ZP_PTR_1
   lda #>str8_0x0001
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# eval-lt (u24)                         #"
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

   ; print__str8 "# test out comparisons of values < 0xFF"
   lda #<str8_0x0004
   sta ZP_PTR_1
   lda #>str8_0x0004
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 10
   lda #$0A
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; equals__u24_u24 .b 5
   lda #$05
   sta var__main__b
   lda #$00
   sta var__main__b+1
   lda #$00
   sta var__main__b+2

   ; eval_lt__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lt__u24
   sta var__main__cmpres

   ; print__str8 "10 < 5: "
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

   ; equals__u24_u24 .a 10
   lda #$0A
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; equals__u24_u24 .b 10
   lda #$0A
   sta var__main__b
   lda #$00
   sta var__main__b+1
   lda #$00
   sta var__main__b+2

   ; eval_lt__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lt__u24
   sta var__main__cmpres

   ; print__str8 "10 < 10: "
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

   ; equals__u24_u24 .a 10
   lda #$0A
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; equals__u24_u24 .b 15
   lda #$0F
   sta var__main__b
   lda #$00
   sta var__main__b+1
   lda #$00
   sta var__main__b+2

   ; eval_lt__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lt__u24
   sta var__main__cmpres

   ; print__str8 "10 < 15: "
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

   ; print__str8 "# test out comparisons of values > 0xFF and < 0xFFFF"
   lda #<str8_0x0008
   sta ZP_PTR_1
   lda #>str8_0x0008
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 1000
   lda #$E8
   sta var__main__a
   lda #$03
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; equals__u24_u24 .b 500
   lda #$F4
   sta var__main__b
   lda #$01
   sta var__main__b+1
   lda #$00
   sta var__main__b+2

   ; eval_lt__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lt__u24
   sta var__main__cmpres

   ; print__str8 "1000 < 500: "
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

   ; equals__u24_u24 .a 1000
   lda #$E8
   sta var__main__a
   lda #$03
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; equals__u24_u24 .b 1000
   lda #$E8
   sta var__main__b
   lda #$03
   sta var__main__b+1
   lda #$00
   sta var__main__b+2

   ; eval_lt__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lt__u24
   sta var__main__cmpres

   ; print__str8 "1000 < 1000: "
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

   ; equals__u24_u24 .a 1000
   lda #$E8
   sta var__main__a
   lda #$03
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; equals__u24_u24 .b 1500
   lda #$DC
   sta var__main__b
   lda #$05
   sta var__main__b+1
   lda #$00
   sta var__main__b+2

   ; eval_lt__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lt__u24
   sta var__main__cmpres

   ; print__str8 "1000 < 1500: "
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

   ; print__str8 "# test out comparisons of values > 0xFFFF"
   lda #<str8_0x000C
   sta ZP_PTR_1
   lda #>str8_0x000C
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 10000000
   lda #$80
   sta var__main__a
   lda #$96
   sta var__main__a+1
   lda #$98
   sta var__main__a+2

   ; equals__u24_u24 .b 5000000
   lda #$40
   sta var__main__b
   lda #$4B
   sta var__main__b+1
   lda #$4C
   sta var__main__b+2

   ; eval_lt__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lt__u24
   sta var__main__cmpres

   ; print__str8 "10000000 < 5000000: "
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

   ; equals__u24_u24 .a 10000000
   lda #$80
   sta var__main__a
   lda #$96
   sta var__main__a+1
   lda #$98
   sta var__main__a+2

   ; equals__u24_u24 .b 10000000
   lda #$80
   sta var__main__b
   lda #$96
   sta var__main__b+1
   lda #$98
   sta var__main__b+2

   ; eval_lt__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lt__u24
   sta var__main__cmpres

   ; print__str8 "10000000 < 10000000: "
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

   ; equals__u24_u24 .a 10000000
   lda #$80
   sta var__main__a
   lda #$96
   sta var__main__a+1
   lda #$98
   sta var__main__a+2

   ; equals__u24_u24 .b 15000000
   lda #$C0
   sta var__main__b
   lda #$E1
   sta var__main__b+1
   lda #$E4
   sta var__main__b+2

   ; eval_lt__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lt__u24
   sta var__main__cmpres

   ; print__str8 "10000000 < 15000000: "
   lda #<str8_0x000F
   sta ZP_PTR_1
   lda #>str8_0x000F
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
   lda #<str8_0x0010
   sta ZP_PTR_1
   lda #>str8_0x0010
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# eval-lteq (u24)                       #"
   lda #<str8_0x0011
   sta ZP_PTR_1
   lda #>str8_0x0011
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#---------------------------------------#"
   lda #<str8_0x0012
   sta ZP_PTR_1
   lda #>str8_0x0012
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# test out comparisons of values < 0xFF"
   lda #<str8_0x0013
   sta ZP_PTR_1
   lda #>str8_0x0013
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 10
   lda #$0A
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; equals__u24_u24 .b 5
   lda #$05
   sta var__main__b
   lda #$00
   sta var__main__b+1
   lda #$00
   sta var__main__b+2

   ; eval_lteq__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lteq__u24
   sta var__main__cmpres

   ; print__str8 "10 <= 5: "
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

   ; equals__u24_u24 .a 10
   lda #$0A
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; equals__u24_u24 .b 10
   lda #$0A
   sta var__main__b
   lda #$00
   sta var__main__b+1
   lda #$00
   sta var__main__b+2

   ; eval_lteq__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lteq__u24
   sta var__main__cmpres

   ; print__str8 "10 <= 10: "
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

   ; equals__u24_u24 .a 10
   lda #$0A
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; equals__u24_u24 .b 15
   lda #$0F
   sta var__main__b
   lda #$00
   sta var__main__b+1
   lda #$00
   sta var__main__b+2

   ; eval_lteq__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lteq__u24
   sta var__main__cmpres

   ; print__str8 "10 <= 15: "
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

   ; print__str8 "# test out comparisons of values > 0xFF and < 0xFFFF"
   lda #<str8_0x0017
   sta ZP_PTR_1
   lda #>str8_0x0017
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 1000
   lda #$E8
   sta var__main__a
   lda #$03
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; equals__u24_u24 .b 500
   lda #$F4
   sta var__main__b
   lda #$01
   sta var__main__b+1
   lda #$00
   sta var__main__b+2

   ; eval_lteq__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lteq__u24
   sta var__main__cmpres

   ; print__str8 "1000 <= 500: "
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

   ; equals__u24_u24 .a 1000
   lda #$E8
   sta var__main__a
   lda #$03
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; equals__u24_u24 .b 1000
   lda #$E8
   sta var__main__b
   lda #$03
   sta var__main__b+1
   lda #$00
   sta var__main__b+2

   ; eval_lteq__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lteq__u24
   sta var__main__cmpres

   ; print__str8 "1000 <= 1000: "
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

   ; equals__u24_u24 .a 1000
   lda #$E8
   sta var__main__a
   lda #$03
   sta var__main__a+1
   lda #$00
   sta var__main__a+2

   ; equals__u24_u24 .b 1500
   lda #$DC
   sta var__main__b
   lda #$05
   sta var__main__b+1
   lda #$00
   sta var__main__b+2

   ; eval_lteq__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lteq__u24
   sta var__main__cmpres

   ; print__str8 "1000 <= 1500: "
   lda #<str8_0x001A
   sta ZP_PTR_1
   lda #>str8_0x001A
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; print__str8 "# test out comparisons of values > 0xFF and < 0xFFFF"
   lda #<str8_0x001B
   sta ZP_PTR_1
   lda #>str8_0x001B
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 10000000
   lda #$80
   sta var__main__a
   lda #$96
   sta var__main__a+1
   lda #$98
   sta var__main__a+2

   ; equals__u24_u24 .b 5000000
   lda #$40
   sta var__main__b
   lda #$4B
   sta var__main__b+1
   lda #$4C
   sta var__main__b+2

   ; eval_lteq__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lteq__u24
   sta var__main__cmpres

   ; print__str8 "10000000 <= 5000000: "
   lda #<str8_0x001C
   sta ZP_PTR_1
   lda #>str8_0x001C
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 10000000
   lda #$80
   sta var__main__a
   lda #$96
   sta var__main__a+1
   lda #$98
   sta var__main__a+2

   ; equals__u24_u24 .b 10000000
   lda #$80
   sta var__main__b
   lda #$96
   sta var__main__b+1
   lda #$98
   sta var__main__b+2

   ; eval_lteq__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lteq__u24
   sta var__main__cmpres

   ; print__str8 "10000000 <= 10000000: "
   lda #<str8_0x001D
   sta ZP_PTR_1
   lda #>str8_0x001D
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__bool .cmpres
   lda var__main__cmpres
   jsr _print__bool

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 10000000
   lda #$80
   sta var__main__a
   lda #$96
   sta var__main__a+1
   lda #$98
   sta var__main__a+2

   ; equals__u24_u24 .b 15000000
   lda #$C0
   sta var__main__b
   lda #$E1
   sta var__main__b+1
   lda #$E4
   sta var__main__b+2

   ; eval_lteq__u24 .cmpres .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _eval_lteq__u24
   sta var__main__cmpres

   ; print__str8 "10000000 <= 15000000: "
   lda #<str8_0x001E
   sta ZP_PTR_1
   lda #>str8_0x001E
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

