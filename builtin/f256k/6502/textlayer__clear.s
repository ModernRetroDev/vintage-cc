;REQUIRES  textlayer__home
;REQUIRES  textlayer__newline
;
;[BUILTIN-BLOCK-START]
_textlayer__clear:
   ; save the register values
   sta VINTAGE_TEMP_A
   stx VINTAGE_TEMP_X
   sty VINTAGE_TEMP_Y

   jsr _textlayer__home

   ; configure banking to write textlayer
   lda $0001
   pha
   ;lda #$02
   ;sta $0001

   ;--------------------;
   ; Register Uses      ;
   ; Y = column counter ;
   ; X = row counter    ;
   ;--------------------;
   ldx #$00

_textlayer__clear__next_row:
   ;--------------------------;
   ; Iterate over the 60 rows ;
   ;--------------------------;
   ldy #$00

_textlayer__clear__fill_row:
   ;-----------------------------;
   ; Iterate over the 80 columns ;
   ;-----------------------------;
   ; blank out the character at that position
   lda #$02
   sta $0001
   lda #' '
   sta (VINTAGE_TEXTLAYER_LINE),y
   ; set the color LUT for that position
   lda #$03
   sta $0001
   ; 0 = black; 1 = ???; 2 = blue; 3 = pink; 4 = green; 5 = green
   lda #$30 ; FG = 1; BG = 0 (black)
   sta (VINTAGE_TEXTLAYER_LINE),y

   iny
   cpy #80
   bne _textlayer__clear__fill_row
   ; else the row has been filled

   jsr _textlayer__newline
   inx
   cpx #60
   bne _textlayer__clear__next_row
   ; else the last row has been cleared

   jsr _textlayer__home

   ; restore previous bank config
   pla
   sta $0001
   ; restore the register values
   lda VINTAGE_TEMP_A
   ldx VINTAGE_TEMP_X
   ldy VINTAGE_TEMP_Y
   rts
