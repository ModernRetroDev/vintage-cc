;[BUILTIN-BLOCK-START]
_eval_lteq__u16:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO VALUE ONE.                     ;
   ; ZP_PTR_2 = POINTS TO VALUE TWO.                     ;
   ;-----------------------------------------------------;
   ; compare high byte first
   ldy #1
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lteq__u16__true   ; high-byte is less than; exit now
   beq _eval_lteq__u16__byte_2 ; high-byte is same.. check low-byte
   ; high byte greater-than; exit now
   lda #0
   bra _eval_lteq__u16__out

_eval_lteq__u16__byte_2:
   ; now compare the low bytes
   ldy #0
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lteq__u16__true ; low-byte is less than; exit now
   beq _eval_lteq__u16__true ; low-byte is equal-to; exit now
   ; low byte is greater-than; exit now
   lda #0
   bra _eval_lteq__u16__out
_eval_lteq__u16__true:
   lda #1
_eval_lteq__u16__out:
   rts
