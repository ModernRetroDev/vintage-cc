;[BUILTIN-BLOCK-START]
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

   ; Set the Vintage IO target to FILE
   lda #VINTAGE_IO_TARGET__FILE
   sta VINTAGE_IO_TARGET

   ; load stream number into A
   ldy #2
   lda (ZP_PTR_1),y
   sta VINTAGE_IO_STREAM
   sta KERNEL_ARGS_FILE_WRITE_STREAM

   ; set the buffer pointer
   lda #<VINTAGE_IO_NEXT_CHAR
   sta KERNEL_ARGS_FILE_WRITE_BUF
   lda #>VINTAGE_IO_NEXT_CHAR
   sta KERNEL_ARGS_FILE_WRITE_BUF+1

   ; set the buffer length
   lda #$01
   sta KERNEL_ARGS_FILE_WRITE_BUFLEN

   rts
