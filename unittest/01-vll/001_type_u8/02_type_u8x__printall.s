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

var__main__ctr: ; type: u8
   .byte $00

var__main__cmpres: ; type: u8
   .byte $00

str8_0x0000: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $1D ; length (u8)
   .byte $1D ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$32,$2D,$74,$79,$70,$65,$2D
   .byte $75,$38,$78,$2D,$2D,$70,$72,$69,$6E,$74
   .byte $61,$6C,$6C,$2E,$75,$74,$65,$73,$74
   .byte $00 ; null terminator (u8)

str8_0x0001: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $34 ; length (u8)
   .byte $34 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$23
   .byte $00 ; null terminator (u8)

str8_0x0002: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $34 ; length (u8)
   .byte $34 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$50,$52,$49,$4E,$54,$20,$41,$4C
   .byte $4C,$20,$56,$41,$4C,$55,$45,$53,$20,$4F
   .byte $46,$20,$41,$20,$55,$38,$20,$49,$4E,$20
   .byte $48,$45,$58,$20,$46,$4F,$52,$4D,$28,$30
   .byte $2D,$32,$35,$35,$29,$20,$20,$20,$20,$20
   .byte $20,$23
   .byte $00 ; null terminator (u8)

str8_0x0003: ; type: str8
   .byte $00, $00 ; ptr_addr (u16)
   .byte $34 ; length (u8)
   .byte $34 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$23
   .byte $00 ; null terminator (u8)

;--------------------------------------------------------;
; BUILT-IN FUNCTIONS                                     ;
;--------------------------------------------------------;
.global _close__file
.global _open__file
.global _print__char
.global _print__endl
.global _print__str8
.global _print__u8_x
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


_print__char:
   ;-----------------------------------------------------;
   ; A = STARTS WITH CHARACTER TO BE PRINTED             ;
   ;-----------------------------------------------------;
   ; print out a single character
   jsr CHROUT
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

   ; setup__file .f 'w' "@:02-type-u8x--printall.utest"
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

   ; print__str8 "#--------------------------------------------------#"
   lda #<str8_0x0001
   sta ZP_PTR_1
   lda #>str8_0x0001
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# PRINT ALL VALUES OF A U8 IN HEX FORM(0-255)      #"
   lda #<str8_0x0002
   sta ZP_PTR_1
   lda #>str8_0x0002
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#--------------------------------------------------#"
   lda #<str8_0x0003
   sta ZP_PTR_1
   lda #>str8_0x0003
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; equals__u8_u8 .ctr 0
   lda #0
   sta var__main__ctr

   ; loop
loop_0x0000:
   ; print__u8_x .ctr
   lda var__main__ctr
   jsr _print__u8_x

   ; print__char '
   lda #$20
   jsr _print__char

   ; print__u8_X .ctr
   lda var__main__ctr
   jsr _print__u8_xx

   ; print__endl
   jsr _print__endl

   ; eval_eq__u8 .cmpres .ctr 255
   lda var__main__ctr
   cmp #255
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
   beq if_0x0000_true
   jmp if_0x0000_else

if_0x0000_true:
   ; endloop
   jmp loop_0x0000_out
   ; endif
if_0x0000_else:
if_0x0000_out:

   ; increment__u8 .ctr
   lda var__main__ctr
   clc ; clear carry
   adc #1
   sta var__main__ctr

   ; endloop
   jmp loop_0x0000
loop_0x0000_out:
   ; close__file .f
   lda #<var__main__f
   sta ZP_PTR_1
   lda #>var__main__f
   sta ZP_PTR_1+1
   jsr _close__file

   ; shutdown
   jsr _shutdown

   rts

