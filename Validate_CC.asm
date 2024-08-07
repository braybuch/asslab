; Validate_CC.asm
; Author(s): Brayden Buchner
; Student Number(s): 041123080
; Date: 2024-08-06
;
; Purpose:              This subroutine adds register b to register a, then checks if
;                       the sum is divisiable by 10
;
; Preconditions:        register a and b contains the values to add
;
; Notes:
;
; Postcondition:        register a contains boolean 1,0 representing valid or invalid
;                       register b,x is destroyed
;

Validate_CC
                aba                     ; add register b to register a
                tfr     b,a             ; Transfer a to b

                ldx     #10             ; Load 10 into register x as divisor
                idiv                    ; divide register b by x

                cmpb    #0              ; compare remainder with #0

                bne     VALIDATION_FALSE
                ldaa    #1              ; Valid card
VALIDATION_FALSE
                ldaa    #0              ; Invalid card

                rts

                        end

; ---------------------------------
;        END of Validate.asm -
;----------------------------------


