;[BUILTIN-BLOCK-START]
_eval_neq__u24:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO VALUE ONE.                     ;
   ; ZP_PTR_2 = POINTS TO VALUE TWO.                     ;
   ;-----------------------------------------------------;
   ; compare low byte first
   ldy #0
   lda (ZP_PTR_2),y
   cmp (ZP_PTR_1),y
   beq _eval_neq__u24__byte_2
   ; low byte not equal; exit now
   lda #1
   jmp _eval_neq__u24__out

_eval_neq__u24__byte_2:
   ; now compare mid byte
   iny
   lda (ZP_PTR_2),y
   cmp (ZP_PTR_1),y
   beq _eval_neq__u24__byte_3
   ; mid byte not equal; exit now
   lda #1
   jmp _eval_neq__u24__out

_eval_neq__u24__byte_3:
   ; now compare high byte
   iny
   lda (ZP_PTR_2),y
   cmp (ZP_PTR_1),y
   beq _eval_neq__u24__true
   ; high byte not equal; exit now
   lda #1
   jmp _eval_neq__u24__out
_eval_neq__u24__true:
   lda #0
_eval_neq__u24__out:
   rts
