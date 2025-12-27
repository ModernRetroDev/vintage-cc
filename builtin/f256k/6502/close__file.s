;[BUILTIN-BLOCK-START]
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

   ; load stream number into A
   ldy #2
   lda (ZP_PTR_1),y
   sta KERNEL_ARGS_FILE_CLOSE_STREAM
   ;
   jsr KERNEL_FN_FILE_CLOSE

_close__file__wait_loop:
   jsr KERNEL_FN_NEXT_EVENT
   ; keep looping until we get an event
   bcs _close__file__wait_loop

   lda VINTAGE_NEXT_EVENT
   ;
   cmp #KERNEL_EVENT_FILE__CLOSED
   beq _close__file__out
   bra _close__file__wait_loop
   ;
_close__file__out:
   rts
