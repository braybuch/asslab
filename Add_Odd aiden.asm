; Add_Odd.asm
; Author: Aidan Keuning
; Student Number: 041123875
; Date: 04-08-2024
;
; Purpose: Performs the first step of CC validation, in which the odd numbered
;          digits of the CC are added after being multiplied by 2.
;
; Preconditions:        Register X loaded with address of a 4-digit CC number
;                       Digits of CC are in consecutive hex addresses
;
; Notes:
;
; Postcondition:
;
; SUBROUTINE CONSTANTS
DIVISOR         equ     #10
MAX             equ     #9


Add_Odd
        ldy     #x
Math
        ldaa    x               ; Load current digit
        adda    a               ; Multiply first digit by 2
        daa                     ; Adjust result to BCD
        cmpa    #MAX            ; Check if result is greater than 9
        bls     EndCrossAdd     ; Skip cross-add if <= 9
CrossAdd
        pshx                    ; Temporarily store pointer to current digit
        ldx     #DIVISOR        ; Load X with divisor of 10
        idiv                    ; Divide by 10 to get first digit in X and second in D
        adda    x               ; Add first and second digit of result
        daa                     ; Convert to BCD
        pulx                    ; Retrieve pointer to current digit
EndCrossAdd
        psha                    ; Store result on stack
        inx                     ; Increment loop counter
        inx                     ; Increment again
        cpx     y               ; Check if end of CC number has been reached
        blo     Math            ; Repeat process for third digit

        pula                    ; Pull result 1 to register A
        pulb                    ; Pull result 2 to register B
        aba                     ; Add digits
        daa                     ; Adjust sum to BCD
        psha                    ; Push sum to stack
        
        rts                     ; Sum of Odd Digit returned

        end