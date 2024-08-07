; < Add_Even.asm >
; Author(s):            Brayden Buchner
; Student Number(s):    041123080
; Date:                 2024-08-06
;
; Purpose:              This subroutine sums the evenly positioned digits
;
; Preconditions:        Register X contains the memory location of the number to work on
;                       Register B contains the number of digits
;
; Postcondition:        Register B contains the sum of the even digits

Add_Even
; register x is loaded with credit card number
        ldaa        1,x    ; load register a with number in position 2, x
        ldab        3,x    ; load register b with number in position 4, x
        aba                ; Add register a to register b
        tfr             a,b

        rts             ; Sum of Even Digits returned

        end




; ---------------------------------
;        END of Add_Even -
;----------------------------------