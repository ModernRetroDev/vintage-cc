;[BUILTIN-BLOCK-START]
_eval_lt__u24:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO VALUE ONE.                     ;
   ; ZP_PTR_2 = POINTS TO VALUE TWO.                     ;
   ;-----------------------------------------------------;
   ; compare high byte first
   ldy #2
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lt__u24__true   ; high-byte is less than; exit now
   beq _eval_lt__u24__byte_2 ; high-byte is same.. check low-byte
   ; high byte greater-than; exit now
   lda #0
   jmp _eval_lt__u24__out

_eval_lt__u24__byte_2:
   ; now compare mid byte
   ldy #1
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lt__u24__true   ; mid-byte is less than; exit now
   beq _eval_lt__u24__byte_1 ; mid-byte is same.. check low-byte
   ; mid byte greater-than; exit now
   lda #0
   jmp _eval_lt__u24__out

_eval_lt__u24__byte_1:
   ; now compare the low bytes
   ldy #0
   lda (ZP_PTR_1),y
   cmp (ZP_PTR_2),y
   bcc _eval_lt__u24__true
   ; low byte not less-than; exit now
   lda #0
   jmp _eval_lt__u24__out
_eval_lt__u24__true:
   lda #1
_eval_lt__u24__out:
   rts
