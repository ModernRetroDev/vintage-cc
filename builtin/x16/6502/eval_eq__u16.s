;[BUILTIN-BLOCK-START]
_eval_eq__u16:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO VALUE ONE.                     ;
   ; ZP_PTR_2 = POINTS TO VALUE TWO.                     ;
   ;-----------------------------------------------------;
   ; compare low byte first
   ldy #0
   lda (ZP_PTR_2),y
   cmp (ZP_PTR_1),y
   beq _eval_eq__u16__byte_2
   ; low byte not equal; exit now
   lda #0
   bra _eval_eq__u16__out

_eval_eq__u16__byte_2:
   ; now compare high byte
   ldy #1
   lda (ZP_PTR_2),y
   cmp (ZP_PTR_1),y
   beq _eval_eq__u16__true
   ; high byte not equal; exit now
   lda #0
   bra _eval_eq__u16__out
_eval_eq__u16__true:
   lda #1
_eval_eq__u16__out:
   rts
