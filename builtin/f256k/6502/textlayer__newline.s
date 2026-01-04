;[BUILTIN-BLOCK-START]
_textlayer__scroll_up:
   ; store the source address in r14
   lda #<$C050
   sta r14
   lda #>$C050
   sta r14+1

   ; store the destination address in r15
   lda #<$C000
   sta r15
   lda #>$C000
   sta r15+1
   ;
   ; set X (row counter) to zero
   ldx #$00
_textlayer__scroll_up__next_row:
   ; set Y (column counter) to zero
   ldy #$00
   ;--------------------------;
   ; Iterate over the 59 rows ;
   ;--------------------------;
   ;
_textlayer__scroll_up__copy_row:
   ;-----------------------------;
   ; Iterate over the 80 columns ;
   ;-----------------------------;
   ; copy the character at that position
   lda #$02
   sta $0001
   lda (r14),y
   sta (r15),y
   ; set the color LUT for that position
   lda #$03
   sta $0001
   lda (r14),y
   sta (r15),y

   iny
   cpy #80
   bne _textlayer__scroll_up__copy_row
   ; else the row has been copied

   ; increment the r14/r15 addresses
   clc
   lda r14
   adc #80
   sta r14
   lda r14+1
   adc #0
   sta r14+1

   clc
   lda r15
   adc #80
   sta r15
   lda r15+1
   adc #0
   sta r15+1

   inx
   cpx #59
   bne _textlayer__scroll_up__next_row
   ; else the last row has been copied

   rts

_textlayer__newline:
   lda VINTAGE_TEXTLAYER_ROW
   cmp #59
   beq _textlayer__newline__scroll_row
   jmp _textlayer__newline__noscroll
   ;
_textlayer__newline__scroll_row:
   jsr _textlayer__scroll_up

   lda #0
   sta VINTAGE_TEXTLAYER_COL
   rts
   ;
_textlayer__newline__noscroll:
   ; not at bottom of screen; no scroll required
   clc
   lda VINTAGE_TEXTLAYER_LINE
   adc #80
   sta VINTAGE_TEXTLAYER_LINE
   lda VINTAGE_TEXTLAYER_LINE+1
   adc #0
   sta VINTAGE_TEXTLAYER_LINE+1
   lda #0
   sta VINTAGE_TEXTLAYER_COL

   clc
   lda VINTAGE_TEXTLAYER_ROW
   adc #1
   sta VINTAGE_TEXTLAYER_ROW
   rts
