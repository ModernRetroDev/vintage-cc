;[BUILTIN-BLOCK-START]
_textlayer__home:
   lda #0
   sta VINTAGE_TEXTLAYER_COL
   sta VINTAGE_TEXTLAYER_ROW

   ; save $C000
   lda #$00
   sta VINTAGE_TEXTLAYER_LINE
   lda #$C0
   sta VINTAGE_TEXTLAYER_LINE+1
   rts
