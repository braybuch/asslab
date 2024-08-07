

; Add_Odd.asm
; Author(s):            Brayden Buchner,        Aidan Keuning
; Student Number(s):    041123080,              041123875
; Date:                 2024-08-06
;
; Purpose:              This subroutine sums the oddly positioned digits after multiplying by 2 and cross adding double digits
;
; Preconditions:        Register X contains the memory location of the number to work on
;                       Register B contains the number of digits
;
; Postcondition:        Register B contains the sum of the odd digits
;                       Register A is destroyed
;                       Register X is destroyed
;                       Register Y is destroyed

oddSum         db      0
number_Digits  ds      2

Add_Odd
                ldaa    #0               ; Initialize a to zero
                staa    oddSum           ; Store zero into the sum of odd numbers
                stab    number_Digits+1  ; Store number of digits passed to subroutine
                ldy     #0               ; Init count to 0

Push_Odds       ; For i = 0, i less than number digits, i += 2

                ; Extract even digit and push
                ldaa    2,x+            ; Load current digit into a and increment x to next even digit
                psha                    ; Push digit to stack

                ; i =+ 2
                iny                     ; Increment count
                iny

                ; i < numDigits
                cpy     number_Digits   ; Test if this was the last digit
                blo     Push_Odds       ; Loop if less than numDigits

Pull_Odds       ; While i is greater or equal to 0
                pula                    ; Pull the even digit

                ;   Double a
                ldab    #2              ; Load multiplation factor of 2
                mul                     ; Multiply even digit by 2
                tfr     b,a             ; Move digit back to a
                clrb                    ; Clear the doubled bit

                ; If this number has two digits
                cmpa    #9
                bgt     Cross_Add         ; Cross add if this has two digits
                bra     Skip_Cross_Add  ; Skip if it's just one digit

Cross_Add
                ; Do cross multiplication
                ldab    #2              ; Load multiplation factor of 2
                mul                     ; Multiply by 2
                tfr     b,a             ; Move digit back to a
                suba    #10             ; Subtract 10
                inca                    ; Add 1

Skip_Cross_Add
                ; Add to previous sum
                ldab    oddSum         ; load previous sum
                aba                    ; Add previous sum to current digit
                staa    oddSum         ; Store new sum
                dey                    ; Decrement count
                dey
                cpy     #0             ; Test if this was the last digit
                bhi     Pull_Odds      ; Branch if there are more digits

                ; Return value
                clra
                ldab    oddSum

                rts                        ; Sum of Even Digits returned

                end


; ---------------------------------
;        END of Add_Odd -
;----------------------------------