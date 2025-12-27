;REQUIRES  textlayer__clear
;REQUIRES  textlayer__home
;REQUIRES  textlayer__newline
;
;[BUILTIN-BLOCK-START]
_putchar:
   ; push a character to the screen or to an open file
   sta VINTAGE_TEMP_A
   sty VINTAGE_TEMP_Y

   lda VINTAGE_IO_TARGET

   cmp #VINTAGE_IO_TARGET__STDOUT
   beq _putchar__to_stdout
   cmp #VINTAGE_IO_TARGET__FILE
   beq _putchar__to_file
   rts
   ;
_putchar__to_stdout:
   lda VINTAGE_TEMP_A
   jsr _putchar_stdout
   rts
   ;
_putchar__to_file:
   lda VINTAGE_TEMP_A
   jsr _putchar_file
   rts


_putchar_stdout:
   ; push a character to the screen
   lda $0001
   pha
   lda #$02
   sta $0001

   ; check for a newline character
   lda VINTAGE_TEMP_A
   cmp #$0D
   beq _putchar_stdout__newline
   ;
   ; else: not a newline character
   lda VINTAGE_TEMP_A
   ldy VINTAGE_TEXTLAYER_COL
   sta (VINTAGE_TEXTLAYER_LINE),y
   iny
   cpy #80
   bne _putchar_stdout__save_col
   ;
   ; else wrap to next line
_putchar_stdout__newline:
   jsr _textlayer__newline
   pla
   sta $0001
   lda VINTAGE_TEMP_A
   ldy VINTAGE_TEMP_Y
   rts
   ;
_putchar_stdout__save_col:
   sty VINTAGE_TEXTLAYER_COL

   pla
   sta $0001
   lda VINTAGE_TEMP_A
   ldy VINTAGE_TEMP_Y
   rts


_putchar_file:
   ; push a character to an open file
   ;
   ; check for a newline character
   sta VINTAGE_IO_NEXT_CHAR
   lda #$01
   sta KERNEL_ARGS_FILE_WRITE_BUFLEN
   jsr KERNEL_FN_FILE_WRITE
   ;
_putchar_file__waitloop:
   jsr KERNEL_FN_NEXT_EVENT
   ; keep looping until we get an event
   bcs _putchar_file__waitloop

   lda VINTAGE_NEXT_EVENT
   ;
   cmp #KERNEL_EVENT_FILE__WROTE
   beq _putchar_file__finished
   bra _putchar_file__waitloop
   ;
_putchar_file__finished:
   lda VINTAGE_TEMP_A
   ldy VINTAGE_TEMP_Y
   rts
