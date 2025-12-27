;REQUIRES  putchar
;
;[BUILTIN-BLOCK-START]
_print__char:
   ;-----------------------------------------------------;
   ; A = STARTS WITH CHARACTER TO BE PRINTED             ;
   ;-----------------------------------------------------;
   ; print out a single character
   jsr _putchar
   rts
