; Add_Odd.asm
; Author: Aidan Keuning
; Student Number: 041123875
; Date: 04-08-2024
;
; Purpose: Performs the first step of CC validation, in which the odd numbered
;          digits of the CC are added after being multiplied by 2.
;
; Preconditions:        Register x loaded with address of 4-digit CC number
;                       Register a loaded with number of digits
;
; Notes:
;
; Postcondition:        Register y contains sum of calculation
;
; SUBROUTINE CONSTANTS
DIVISOR         equ     #10
MAX             equ     #9

Add_Odd
        
        ; Put first digit into register y
        ldy     0,x

        ; Check if number has two digits
        cpy     #9
        blo     ThirdDigit
        pshy
        bra     ThirdDigit
        
        ; Number has two digits
        tfr     x,d             ; Put x into d
        ldx     #DIVISOR        ; Put divisor into x
        idiv                    ; Divide digit by divisor
        tfr     x,a             ; Load remainder into a
        aba                     ; Add result and remainder
        psha                    ; Put a onto the stack
        
ThirdDigit
        
        ; Put third digit into register y
        ldy    3,x
        
        ; check if number has two digits
        cpy     #9
        blo     EndDigits
        pshy
        bra     EndDigits

        ; Number has two digits
        tfr     x,d             ; Put x into d
        ldx     #DIVISOR        ; Put divisor into x
        idiv                    ; Divide digit by divisor
        tfr     x,a             ; Load remainder into a
        aba                     ; Add result and remainder
        psha
        
EndDigits
 
        pula
        pulb
        aba
 

        rts                     ; Sum of Odd Digit returned

        end