;[BUILTIN-BLOCK-START]
_eval_logi_and__u8:
   ;-----------------------------------------------------;
   ; X = CONTAINS VALUE ONE (LHS).                       ;
   ; Y = CONTAINS VALUE TWO (RHS).                       ;
   ;-----------------------------------------------------;
   ; compare LHS value against zero
   txa
   cmp #0
   beq _eval_logi_and__u8__false
   ; compare RHS value against zero
   tya
   cmp #0
   beq _eval_logi_and__u8__false
   ; else: they are both non-zero
   lda #1
   rts
_eval_logi_and__u8__false:
   lda #0
   rts
