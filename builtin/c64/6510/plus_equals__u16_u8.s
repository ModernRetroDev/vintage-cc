;[BUILTIN-BLOCK-START]
_plus_equals__u16_u8:
   ;-----------------------------------------------------;
   ; Adds a U8 from `ZP_PTR_2` to a U16.                 ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING ADDED TO.      ;
   ; ZP_PTR_2 = POINTS TO U8 VALUE BEING ADDED.          ;
   ;-----------------------------------------------------;
   ; add to low byte
   clc
   ldy #0
   lda (ZP_PTR_1),y
   adc (ZP_PTR_2),y
   sta (ZP_PTR_1),y
   ; carry over to high byte
   ldy #1
   lda (ZP_PTR_1),y
   adc #0
   sta (ZP_PTR_1),y
   rts

_plus_equals__u16_u8d:
   ;-----------------------------------------------------;
   ; Adds a U8 from register `A` to a U16.               ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO U16 VALUE BEING ADDED TO.      ;
   ; A = U8 VALUE TO BE ADDED                            ;
   ;-----------------------------------------------------;
   ; add to low byte
   clc
   ldy #0
   adc (ZP_PTR_1),y
   sta (ZP_PTR_1),y
   ; carry over to high byte
   ldy #1
   lda (ZP_PTR_1),y
   adc #0
   sta (ZP_PTR_1),y
   rts
