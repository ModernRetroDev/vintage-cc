;[BUILTIN-BLOCK-START]
_lshift__u8_n:
   ;-----------------------------------------------------;
   ; Shifts a U8 value left a number of times.           ;
   ;-----------------------------------------------------;
   ; A = CONTAINS VALUE TO BE SHIFTED.                   ;
   ; X = CONTAINS NUMBER OF TIMES TO SHIFT VALUE.        ;
   ;-----------------------------------------------------;
   stx r0
   ldy #0

_lshift__u8_n__check:
   cpy r0
   bne _lshift__u8_n__again
   rts

_lshift__u8_n__again:
   asl
   iny
   bra _lshift__u8_n__check