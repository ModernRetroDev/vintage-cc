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
   .byte $08 ; device (u8)
   .byte $00 ; channel (u8)
   .byte $00 ; status (u8)
   .byte $00, $00 ; fname (u16)

var__main__a: ; type: u24
   .byte $00, $00, $00

var__main__b: ; type: u24
   .byte $00, $00, $00

var__main__c: ; type: u8
   .byte $00

var__main__d: ; type: u16
   .byte $00, $00

str8_0x0000: ; type: str8
   .byte <(str8_0x0000+2), >(str8_0x0000+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $20, $00 ; length (u16)
   .byte $20, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$35,$5F,$74,$79,$70,$65,$5F
   .byte $75,$32,$34,$5F,$5F,$73,$75,$62,$74,$72
   .byte $61,$63,$74,$69,$6F,$6E,$2E,$75,$74,$65
   .byte $73,$74
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
   .byte $23,$20,$75,$32,$34,$20,$73,$75,$62,$74
   .byte $72,$61,$63,$74,$69,$6F,$6E,$20,$28,$73
   .byte $6D,$61,$6C,$6C,$20,$75,$32,$34,$20,$76
   .byte $61,$6C,$75,$65,$73,$29,$20,$20,$23
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
   .byte $26, $00 ; length (u16)
   .byte $26, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$20,$61,$20,$75,$38,$20,$76,$61
   .byte $72,$20,$74,$6F,$20,$61,$20,$75,$32,$34
   .byte $20,$76,$61,$72,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0005: ; type: str8
   .byte <(str8_0x0005+2), >(str8_0x0005+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $1F, $00 ; length (u16)
   .byte $1F, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$78,$46,$30,$30,$30,$30,$41,$20,$2D
   .byte $20,$30,$78,$41,$20,$3D,$20,$28,$30,$78
   .byte $46,$30,$30,$30,$30,$30,$29,$3B,$20,$30
   .byte $78
   .byte $00 ; null terminator (u8)

str8_0x0006: ; type: str8
   .byte <(str8_0x0006+2), >(str8_0x0006+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $27, $00 ; length (u16)
   .byte $27, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$20,$61,$20,$75,$31,$36,$20,$76
   .byte $61,$72,$20,$74,$6F,$20,$61,$20,$75,$32
   .byte $34,$20,$76,$61,$72,$20,$2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0007: ; type: str8
   .byte <(str8_0x0007+2), >(str8_0x0007+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $22, $00 ; length (u16)
   .byte $22, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$78,$31,$30,$30,$44,$41,$44,$20,$2D
   .byte $20,$30,$78,$30,$44,$41,$44,$20,$3D,$20
   .byte $28,$30,$78,$31,$30,$30,$30,$30,$30,$29
   .byte $3B,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x0008: ; type: str8
   .byte <(str8_0x0008+2), >(str8_0x0008+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2B, $00 ; length (u16)
   .byte $2B, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$20,$74,$77,$6F,$20,$75,$32,$34
   .byte $20,$76,$61,$72,$69,$61,$62,$6C,$65,$73
   .byte $20,$74,$6F,$67,$65,$74,$68,$65,$72,$20
   .byte $2A,$2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x0009: ; type: str8
   .byte <(str8_0x0009+2), >(str8_0x0009+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $24, $00 ; length (u16)
   .byte $24, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$78,$41,$30,$43,$46,$46,$46,$20,$2D
   .byte $20,$30,$78,$30,$30,$43,$46,$46,$46,$20
   .byte $3D,$20,$28,$30,$78,$41,$30,$30,$30,$30
   .byte $30,$29,$3B,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x000A: ; type: str8
   .byte <(str8_0x000A+2), >(str8_0x000A+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $29, $00 ; length (u16)
   .byte $29, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$20,$61,$20,$64,$69,$72,$65,$63
   .byte $74,$20,$75,$38,$20,$74,$6F,$20,$61,$20
   .byte $75,$32,$34,$20,$76,$61,$72,$20,$2A,$2A
   .byte $2A
   .byte $00 ; null terminator (u8)

str8_0x000B: ; type: str8
   .byte <(str8_0x000B+2), >(str8_0x000B+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $24, $00 ; length (u16)
   .byte $24, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$78,$41,$30,$30,$30,$46,$41,$20,$2D
   .byte $20,$30,$78,$30,$30,$30,$30,$46,$41,$20
   .byte $3D,$20,$28,$30,$78,$41,$30,$30,$30,$30
   .byte $30,$29,$3B,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x000C: ; type: str8
   .byte <(str8_0x000C+2), >(str8_0x000C+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2A, $00 ; length (u16)
   .byte $2A, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$20,$61,$20,$64,$69,$72,$65,$63
   .byte $74,$20,$75,$31,$36,$20,$74,$6F,$20,$61
   .byte $20,$75,$32,$34,$20,$76,$61,$72,$20,$2A
   .byte $2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x000D: ; type: str8
   .byte <(str8_0x000D+2), >(str8_0x000D+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $24, $00 ; length (u16)
   .byte $24, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$78,$41,$30,$30,$31,$31,$31,$20,$2D
   .byte $20,$30,$78,$30,$30,$30,$31,$31,$31,$20
   .byte $3D,$20,$28,$30,$78,$41,$30,$30,$30,$30
   .byte $30,$29,$3B,$20,$30,$78
   .byte $00 ; null terminator (u8)

str8_0x000E: ; type: str8
   .byte <(str8_0x000E+2), >(str8_0x000E+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $2A, $00 ; length (u16)
   .byte $2A, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $2A,$2A,$2A,$20,$73,$75,$62,$74,$72,$61
   .byte $63,$74,$20,$61,$20,$64,$69,$72,$65,$63
   .byte $74,$20,$75,$32,$34,$20,$74,$6F,$20,$61
   .byte $20,$75,$32,$34,$20,$76,$61,$72,$20,$2A
   .byte $2A,$2A
   .byte $00 ; null terminator (u8)

str8_0x000F: ; type: str8
   .byte <(str8_0x000F+2), >(str8_0x000F+2) ; ptr_addr (u16)
   .byte $01 ; str_type (u8)
   .byte $24, $00 ; length (u16)
   .byte $24, $00 ; alloc (u16)
   .byte $01 ; element size (u8)
   ; data start
   .byte $30,$78,$41,$43,$30,$42,$41,$41,$20,$2D
   .byte $20,$30,$78,$30,$43,$30,$42,$41,$41,$20
   .byte $3D,$20,$28,$30,$78,$41,$30,$30,$30,$30
   .byte $30,$29,$3B,$20,$30,$78
   .byte $00 ; null terminator (u8)

;--------------------------------------------------------;
; BUILT-IN FUNCTIONS                                     ;
;--------------------------------------------------------;
.global _close__file
.global _minus_equals__u24_u24
.global _minus_equals__u24_u24d
.global _open__file
.global _print__endl
.global _print__str8
.global _print__u24_xx
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


_minus_equals__u24_u24:
   ;-----------------------------------------------------;
   ; Subtracts a u24 in `ZP_PTR_2` from a u24.           ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO u24 VALUE BEING REDUCED.       ;
   ; ZP_PTR_2 = POINTS TO u24 VALUE BEING SUBTRACTED.    ;
   ;-----------------------------------------------------;
   ; subtract the low byte
   ldy #0
   lda (ZP_PTR_1),y
   sec
   sbc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   ; carry over to mid byte
   iny
   lda (ZP_PTR_1),y
   sbc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   ; carry over to high byte
   iny
   lda (ZP_PTR_1),y
   sbc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   rts


_minus_equals__u24_u24d:
   ;-----------------------------------------------------;
   ; Subtracts a u24 in r0,r0+1,r0+2 from a u24.         ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO u24 VALUE BEING REDUCED.       ;
   ; r0   = LOW BYTE OF u24 VALUE TO BE SUBTRACTED.      ;
   ; r0+1 = MID BYTE OF u24 VALUE TO BE SUBTRACTED.      ;
   ; r0+2 = HIGH BYTE OF u24 VALUE TO BE SUBTRACTED.     ;
   ;-----------------------------------------------------;
   ; subtract the low byte
   ldy #0
   lda (ZP_PTR_1),y
   sec
   sbc r0
   sta (ZP_PTR_1),y
   ; carry over to mid byte
   iny
   lda (ZP_PTR_1),y
   sbc r0+1
   sta (ZP_PTR_1),y
   ; carry over to high byte
   iny
   lda (ZP_PTR_1),y
   sbc r0+2
   sta (ZP_PTR_1),y
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

   ; setup__file .f 'w' "@:05_type_u24__subtraction.utest"
   lda #<var__main__f
   sta ZP_PTR_1
   lda #>var__main__f
   sta ZP_PTR_1+1
   lda #<str8_0x0000
   sta ZP_PTR_2
   lda #>str8_0x0000
   sta ZP_PTR_2+1
   ldx #1
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

   ; print__str8 "# u24 subtraction (small u24 values)  #"
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

   ; print__endl
   jsr _print__endl

   ; equals__u24_u24 .a 0xF0000A
   lda #$0A
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$F0
   sta var__main__a+2

   ; equals__u8_u8 .c 0xA
   lda #10
   sta var__main__c

   ; minus_equals__u24_u8 .a .c
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda var__main__c
   sta r0
   lda #0
   sta r0+1
   lda #0
   sta r0+2
   jsr _minus_equals__u24_u24d

   ; print__str8 "*** subtract a u8 var to a u24 var ***"
   lda #<str8_0x0004
   sta ZP_PTR_1
   lda #>str8_0x0004
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "0xF0000A - 0xA = (0xF00000); 0x"
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

   ; equals__u24_u24 .a 0x100DAD
   lda #$AD
   sta var__main__a
   lda #$0D
   sta var__main__a+1
   lda #$10
   sta var__main__a+2

   ; equals__u16_u16 .d 0x0DAD
   lda #<3501
   sta var__main__d
   lda #>3501
   sta var__main__d+1

   ; minus_equals__u24_u16 .a .d
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda var__main__d
   sta r0
   lda var__main__d+1
   sta r0+1
   lda #0
   sta r0+2
   jsr _minus_equals__u24_u24d

   ; print__str8 "*** subtract a u16 var to a u24 var ***"
   lda #<str8_0x0006
   sta ZP_PTR_1
   lda #>str8_0x0006
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "0x100DAD - 0x0DAD = (0x100000); 0x"
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

   ; equals__u24_u24 .a 0xA0CFFF
   lda #$FF
   sta var__main__a
   lda #$CF
   sta var__main__a+1
   lda #$A0
   sta var__main__a+2

   ; equals__u24_u24 .b 0x00CFFF
   lda #$FF
   sta var__main__b
   lda #$CF
   sta var__main__b+1
   lda #$00
   sta var__main__b+2

   ; minus_equals__u24_u24 .a .b
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #<var__main__b
   sta ZP_PTR_2
   lda #>var__main__b
   sta ZP_PTR_2+1
   jsr _minus_equals__u24_u24

   ; print__str8 "*** subtract two u24 variables together ***"
   lda #<str8_0x0008
   sta ZP_PTR_1
   lda #>str8_0x0008
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "0xA0CFFF - 0x00CFFF = (0xA00000); 0x"
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

   ; equals__u24_u24 .a 0xA000FA
   lda #$FA
   sta var__main__a
   lda #$00
   sta var__main__a+1
   lda #$A0
   sta var__main__a+2

   ; minus_equals__u24_u8 .a 0x0000FA
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #250
   sta r0
   lda #0
   sta r0+1
   lda #0
   sta r0+2
   jsr _minus_equals__u24_u24d

   ; print__str8 "*** subtract a direct u8 to a u24 var ***"
   lda #<str8_0x000A
   sta ZP_PTR_1
   lda #>str8_0x000A
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "0xA000FA - 0x0000FA = (0xA00000); 0x"
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

   ; equals__u24_u24 .a 0xA00111
   lda #$11
   sta var__main__a
   lda #$01
   sta var__main__a+1
   lda #$A0
   sta var__main__a+2

   ; minus_equals__u24_u16 .a 0x000111
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #$11
   sta r0
   lda #$01
   sta r0+1
   lda #0
   sta r0+2
   jsr _minus_equals__u24_u24d

   ; print__str8 "*** subtract a direct u16 to a u24 var ***"
   lda #<str8_0x000C
   sta ZP_PTR_1
   lda #>str8_0x000C
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "0xA00111 - 0x000111 = (0xA00000); 0x"
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

   ; equals__u24_u24 .a 0xAC0BAA
   lda #$AA
   sta var__main__a
   lda #$0B
   sta var__main__a+1
   lda #$AC
   sta var__main__a+2

   ; minus_equals__u24_u24 .a 0x0C0BAA
   lda #<var__main__a
   sta ZP_PTR_1
   lda #>var__main__a
   sta ZP_PTR_1+1
   lda #$AA
   sta r0
   lda #$0B
   sta r0+1
   lda #$0C
   sta r0+2
   jsr _minus_equals__u24_u24d

   ; print__str8 "*** subtract a direct u24 to a u24 var ***"
   lda #<str8_0x000E
   sta ZP_PTR_1
   lda #>str8_0x000E
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "0xAC0BAA - 0x0C0BAA = (0xA00000); 0x"
   lda #<str8_0x000F
   sta ZP_PTR_1
   lda #>str8_0x000F
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

   ; close__file .f
   lda #<var__main__f
   sta ZP_PTR_1
   lda #>var__main__f
   sta ZP_PTR_1+1
   jsr _close__file

   ; shutdown
   jsr _shutdown

   rts

