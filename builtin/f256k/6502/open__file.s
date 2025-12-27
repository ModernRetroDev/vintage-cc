;[BUILTIN-BLOCK-START]
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

   ;-----------------------------------------------------;
   ; Set the name of the file to be opened               ;
   ;-----------------------------------------------------;
   ; set the file_open filename
   clc
   lda ZP_PTR_2
   adc #06 ; skip over: str_type (1), length (2), allocated (2), and elemsize (1)
   sta KERNEL_ARGS_FILE_OPEN_FNAME
   lda ZP_PTR_2+1
   adc #0
   sta KERNEL_ARGS_FILE_OPEN_FNAME+1

   ; set the file_open filename length
   ldy #1
   lda (ZP_PTR_2),y
   sta KERNEL_ARGS_FILE_OPEN_FNAME_LEN
   
   ;-----------------------------------------------------;
   ; Set the drive and mode of the file to be opened     ;
   ;-----------------------------------------------------;
   ; set the file_open mode
   ldy #0
   lda (ZP_PTR_1),y
   sta KERNEL_ARGS_FILE_OPEN_MODE

   ; set the file_open drive #
   iny
   lda (ZP_PTR_1),y
   sta KERNEL_ARGS_FILE_OPEN_DRIVE

   ;-----------------------------------------------------;
   ; Open the file                                       ;
   ;-----------------------------------------------------;
   jsr KERNEL_FN_FILE_OPEN
   bcs _open__file__error
   ; else file was opened okay
   bra _open__file__okay
   ;
_open__file__error:
   lda #$01
   sta VINTAGE_HAS_ERROR
   rts
   ;
_open__file__okay:
   ; save stream
   ldy #2
   sta (ZP_PTR_1),y
   ;
_open__file__wait_loop:
   jsr KERNEL_FN_NEXT_EVENT
   ; keep looping until we get an event
   bcs _open__file__wait_loop

   lda VINTAGE_NEXT_EVENT
   ;
   cmp #KERNEL_EVENT_FILE__OPENED
   beq _open__file__out
   ;
   bra _open__file__wait_loop
   ;
_open__file__out:
   rts
