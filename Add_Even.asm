; Add_Even.asm
Add_Even
; register x is loaded with credit card number
        ldaa        1,x        ; load register a with number in position 2, x
        ldab        3,x        ; load register b with number in position 4, x
        aba                ; Add register a to register b

; return

        rts             ; Sum of Even Digits returned

        end
        
        