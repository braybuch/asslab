; Validate_CC.asm
; Author(s):            Brayden Buchner
; Student Number(s):    041123080
; Date:                 2024-08-06
;
; Purpose:              This subroutine adds register b to register a, then checks if
;                       the sum is divisiable by 10, and returns the boolean result through b
;
; Preconditions:        register a and b contain the values to check
;
; Postcondition:        register b contains boolean 1,0 representing valid or invalid
;                       register a is destroyed
;                       register x is destroyed
;

Validate_CC
                ; Add both digits together
                aba                     ; add register b to register a
                tfr     a,b             ; Transfer a to b (Because it will fit and we divide with d)
                clra                    ; Clear leading bit in register D

                ; Divide by 10
                ldx     #10             ; Load 10 into register x as divisor
                idiv                    ; divide register b by x

                ; Check if evenly divisable
                cpd     #0              ; compare remainder with #0
                bne     Not_Valid       ; Remainder isn't clear so card isn't valid
                ; Remainder is clear so card is validd
                ldab    #1              ; Valid card
                bra     End_Validation  ; End subroutine

Not_Valid       ; Card wasn't valid
                ldab    #0              ; Invalid card
                
End_Validation  ; All checks are finsihed

                rts

                end

; ---------------------------------
;        END of Validate.asm -
;----------------------------------

