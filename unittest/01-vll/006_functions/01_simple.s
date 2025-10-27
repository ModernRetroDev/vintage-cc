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
str8_0x0000: ; type: str8
   .byte $0C ; length (u8)
   .byte $0C ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $68,$65,$6C,$6C,$6F,$20,$77,$6F,$72,$6C
   .byte $64,$21
   .byte $00 ; null terminator (u8)

var__main__f: ; type: file
   .byte $00, $00 ; ptr_addr (u16)
   .byte $00 ; mode (u8)
   .byte $00 ; device (u8)
   .byte $00 ; channel (u8)
   .byte $00 ; status (u8)
   .byte $00, $00 ; fname (u16)

str8_0x0001: ; type: str8
   .byte $11 ; length (u8)
   .byte $11 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $40,$3A,$30,$31,$5F,$73,$69,$6D,$70,$6C
   .byte $65,$2E,$75,$74,$65,$73,$74
   .byte $00 ; null terminator (u8)

str8_0x0002: ; type: str8
   .byte $33 ; length (u8)
   .byte $33 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x0003: ; type: str8
   .byte $33 ; length (u8)
   .byte $33 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$20,$63,$61,$6C,$6C,$20,$61,$20,$73
   .byte $69,$6D,$70,$6C,$65,$20,$66,$75,$6E,$63
   .byte $74,$69,$6F,$6E,$20,$28,$6E,$6F,$20,$61
   .byte $72,$67,$73,$2C,$20,$72,$65,$74,$75,$72
   .byte $6E,$20,$76,$61,$6C,$75,$65,$73,$29,$20
   .byte $23
   .byte $00 ; null terminator (u8)

str8_0x0004: ; type: str8
   .byte $33 ; length (u8)
   .byte $33 ; alloc (u8)
   .byte $01 ; element size (u8)
   ; data start
   .byte $23,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D,$2D
   .byte $23
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
; FUNCTION fn_print_hello
;--------------------------------------------------------;
fn_print_hello: 
   ; print__str8 "hello world!"
   lda #<str8_0x0000
   sta ZP_PTR_1
   lda #>str8_0x0000
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   rts

;--------------------------------------------------------;
; MAIN FUNCTION                                          ;
;--------------------------------------------------------;
fn_main: 
   ; set output mode to ISO
   lda #$0F
   jsr BSOUT

   ; setup__file .f 'w' "@:01_simple.utest"
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

   ; ... f.name = "@:01_simple.utest"
   inx
   lda #<str8_0x0001
   sta var__main__f,X
   inx
   lda #>str8_0x0001
   sta var__main__f,X

   ; open__file .f
   lda #<var__main__f
   sta ZP_PTR_2
   lda #>var__main__f
   sta ZP_PTR_2+1
   ldy #0
   lda (ZP_PTR_2),y
   sta ZP_PTR_1
   iny
   lda (ZP_PTR_2),y
   sta ZP_PTR_1+1
   jsr _open__file

   ; setout__file .f
   lda #<var__main__f
   sta ZP_PTR_2
   lda #>var__main__f
   sta ZP_PTR_2+1
   ldy #0
   lda (ZP_PTR_2),y
   sta ZP_PTR_1
   iny
   lda (ZP_PTR_2),y
   sta ZP_PTR_1+1
   jsr _setout__file

   ; print__str8 "#-------------------------------------------------#"
   lda #<str8_0x0002
   sta ZP_PTR_1
   lda #>str8_0x0002
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "# call a simple function (no args, return values) #"
   lda #<str8_0x0003
   sta ZP_PTR_1
   lda #>str8_0x0003
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; print__str8 "#-------------------------------------------------#"
   lda #<str8_0x0004
   sta ZP_PTR_1
   lda #>str8_0x0004
   sta ZP_PTR_1+1
   jsr _print__str8

   ; print__endl
   jsr _print__endl

   ; call print_hello
   jsr fn_print_hello

   ; close__file .f
   lda #<var__main__f
   sta ZP_PTR_2
   lda #>var__main__f
   sta ZP_PTR_2+1
   ldy #0
   lda (ZP_PTR_2),y
   sta ZP_PTR_1
   iny
   lda (ZP_PTR_2),y
   sta ZP_PTR_1+1
   jsr _close__file

   ; shutdown
   jsr _shutdown

   rts

