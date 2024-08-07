; Add_Odd.asm
; Author: Aidan Keuning and Brayden Buchner
; Student Number: 041123875 and 04112308
; Date: 04-08-2024
;
; Purpose: Performs the first step of CC validation, in which the odd numbered
;          digits of the CC are added after being multiplied by 2.
;
; Preconditions:        Register X loaded with address of a 4-digit CC number
;                       Register B is loaded with number of digits
;
; Notes:
;
; Postcondition:        Regiser B contains the results of the calculation
;                       Register A is destroyed
;
; SUBROUTINE CONSTANTS

Add_Odd
	ldaa   0,x      ; Load the value at address X into register A

        tfr	a,b
        rts                     ; Sum of Odd Digit returned

        end