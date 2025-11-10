;[BUILTIN-BLOCK-START]
_plus_equals__u24_u24d:
   ;-----------------------------------------------------;
   ; Adds a u24 from r0,r0+1,r0+2 to a u24.              ;
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO u24 VALUE BEING ADDED TO.      ;
   ; r0   = LOW BYTE OF u24 VALUE TO BE ADDED            ;
   ; r0+1 = MID BYTE OF u24 VALUE TO BE ADDED            ;
   ; r0+2 = HIGH BYTE OF u24 VALUE TO BE ADDED           ;
   ;-----------------------------------------------------;
   ; add to low byte
   clc
   ldy #0
   lda r0
   adc (ZP_PTR_1),y
   sta (ZP_PTR_1),y
   ; carry over to mid byte
   iny
   lda r0+1
   adc (ZP_PTR_1),y
   sta (ZP_PTR_1),y
   ; carry over to high byte
   iny
   lda r0+2
   adc (ZP_PTR_1),y
   sta (ZP_PTR_1),y
   rts
