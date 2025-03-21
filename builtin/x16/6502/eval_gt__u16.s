;REQUIRES  eval_lteq__u16
;
;[BUILTIN-BLOCK-START]
_eval_gt__u16:
   ;-----------------------------------------------------;
   ; ZP_PTR_1 = POINTS TO VALUE ONE.                     ;
   ; ZP_PTR_2 = POINTS TO VALUE TWO.                     ;
   ;-----------------------------------------------------;
   jsr _eval_lteq__u16
   ; flip the value returned by `<=`
   cmp #1
   beq _eval_gt__u16__false
   lda #1
   bra _eval_gt__u16__out
_eval_gt__u16__false:
   lda #0
_eval_gt__u16__out:
   rts
