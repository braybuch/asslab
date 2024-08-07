; Add_Odd.asm
; Author(s):            Brayden Buchner
; Student Number(s):    041123080
; Date:                 2024-08-06
;
; Purpose:              This subroutine sums the oddly positioned digits
;
; Preconditions:        Register X contains the memory location of the number to work on
;                       Register B contains the number of digits
;
; Postcondition:        Register B contains the sum of the odd digits

Add_Odd
        ldaa        0,x    ; load register a with number in position 1, x
        adda        0,x         ; Multiply a by 2
        ldab        2,x    ; load register b with number in position 3, x
        addb        2,x         ; Multiply b by 2
        aba                ; Add register a to register b
        tfr     a,b
        
        rts                ; Sum of Odd Digit returned

        end