;[BUILTIN-BLOCK-START]
_div_by_10__u8:
   ;-----------------------------------------------------;
   ; A = STARTS WITH NUMBER TO BE DIVIDED BY 10          ;
   ;-----------------------------------------------------;
   ; X = STORES WORKING NUMBER                           ;
   ; Y = RESULT REGISTER                                 ;
   ;-----------------------------------------------------;
   tax ; copy A to X
   lda #0 ; put 0 into A
   tay ; store 0 in Y

   ;-----------------------------------------------------;
   ; Check if Number is greater than 160                 ;
   ;-----------------------------------------------------;
   txa ; copy working number back into A
   cmp #160 ; compare A with 160
   bcc _div_by_10__u8__ck80; branch if < 160

   ; SUBTRACT 160 FROM WORKING NUMBER ;
   sec ; set carry flag
   sbc #160 ; subtract `160` from A
   tax ; copy A to X
   lda %00010000
   tay

_div_by_10__u8__ck80:
   ;-----------------------------------------------------;
   ; Check if Number is greater than 80                  ;
   ;-----------------------------------------------------;
   txa ; copy working number back into A
   cmp #80 ; compare A with 80
   bcc _div_by_10__u8__ck40; branch if < 80

   ; SUBTRACT 80 FROM WORKING NUMBER ;
   sec ; set carry flag
   sbc #80 ; subtract `80` from A
   tax ; copy A to X

   ; UPDATE RESULT REGISTER
   tya ; copy Y to A
   clc ; clear carry flag
   adc #%00001000
   tay

_div_by_10__u8__ck40:
   ;-----------------------------------------------------;
   ; Check if Number is greater than 40                  ;
   ;-----------------------------------------------------;
   txa ; copy working number back into A
   cmp #40 ; compare A with 40
   bcc _div_by_10__u8__ck20; branch if < 40

   ; SUBTRACT 40 FROM WORKING NUMBER ;
   sec ; set carry flag
   sbc #40 ; subtract `40` from A
   tax ; copy A to X

   ; UPDATE RESULT REGISTER
   tya ; copy Y to A
   clc ; clear carry flag
   adc #%00000100
   tay

_div_by_10__u8__ck20:
   ;-----------------------------------------------------;
   ; Check if Number is greater than 20                  ;
   ;-----------------------------------------------------;
   txa ; copy working number back into A
   cmp #20 ; compare A with 20
   bcc _div_by_10__u8__ck10; branch if < 20

   ; SUBTRACT 20 FROM WORKING NUMBER ;
   sec ; set carry flag
   sbc #20 ; subtract `20` from A
   tax ; copy A to X

   ; UPDATE RESULT REGISTER
   tya ; copy Y to A
   clc ; clear carry flag
   adc #%00000010
   tay

_div_by_10__u8__ck10:
   ;-----------------------------------------------------;
   ; Check if Number is greater than 10                  ;
   ;-----------------------------------------------------;
   txa ; copy working number back into A
   cmp #10 ; compare A with 10
   bcc _div_by_10__u8__done; branch if < 10

   ; SUBTRACT 10 FROM WORKING NUMBER ;
   ; sec ; set carry flag
   ; sbc #20 ; subtract `20` from A
   ; tax ; copy A to X

   ; UPDATE RESULT REGISTER
   tya ; copy Y to A
   clc ; clear carry flag
   adc #%00000001
   tay

_div_by_10__u8__done:
   ;-----------------------------------------------------;
   ; FINAL RESULT IS STORED WITHIN Y; MOVE IT TO A       ;
   ;-----------------------------------------------------;
   tya
   rts
