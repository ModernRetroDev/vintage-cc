;[BUILTIN-BLOCK-START]
_rshift__u8_n:
   ;-----------------------------------------------------;
   ; Shifts a U8 value right a number of times.          ;
   ;-----------------------------------------------------;
   ; A = CONTAINS VALUE TO BE SHIFTED.                   ;
   ; X = CONTAINS NUMBER OF TIMES TO SHIFT VALUE.        ;
   ;-----------------------------------------------------;
   clc
   stx r0
   ldy #0

_rshift__u8_n__check:
   cpy r0
   bne _rshift__u8_n__again
   rts

_rshift__u8_n__again:
   ror
   iny
   bra _rshift__u8_n__check