;[BUILTIN-BLOCK-START]
_ref__arr8:
   ; get the memory address for a supplied array index
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO RETURN POINTER.                ;
   ; ZP_PTR_2 = POINTS TO ARRAY POINTER.                 ;
   ; r0       = CONTAINS THE U8 INDEX POSITION.          ;
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

   ; increment ZP_PTR_2 by 6 bytes
   clc
   lda ZP_PTR_2
   adc #6
   sta ZP_PTR_2
   lda ZP_PTR_2+1
   adc #0
   sta ZP_PTR_2+1

   ; now add the u8 index position; store to ZP_PTR_1
   ldy #0
   clc
   lda ZP_PTR_2
   adc r0
   sta (ZP_PTR_1),y
   iny
   lda ZP_PTR_2+1
   adc #0
   sta (ZP_PTR_1),y

   rts
