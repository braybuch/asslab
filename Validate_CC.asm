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
                tfr     a,b             ; Transfer a to b (Because it will fit and we divide with d)
                clra                    ; Clear leading bit

                ldx     #10             ; Load 10 into register x as divisor
                idiv                    ; divide register b by x

                cpd    #0               ; compare remainder with #0

                bne     Validation_False
                ldab    #1              ; Valid card
                bra     End_Validation

Validation_False
                ldab    #0              ; Invalid card
End_Validation

                rts

                end

; ---------------------------------
;        END of Validate.asm -
;----------------------------------


