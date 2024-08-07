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
; Postcondition:        Register B contains the sum of the even digit
;                       Register A is destroyed
;                       Register Y is destroyed

evenSum         db      0
currentNum      ds      1
num_Digits      ds      2

Add_Even
                ldaa    #0
                staa    evenSum
                stab   num_Digits+1     ; Store number of digits passed to subroutine
                ldy    #0               ; Init count to 0
                
                
Push_Loop       ; For i = 0, i less than number digits, i++

                ; Extract even digit and push
                inx                     ; Increment x to start from second digit
                ldaa    0,x             ; Load current digit into a
                psha                    ; Push digit to stack
                inx                     ; Increment x to skip odd number

                ; i++
                iny                     ; Increment count
                iny
                
                ; i < numDigits
                cpy     num_Digits      ; Test if this was the last digit
                blo     Push_Loop       ; Loop if less than numDigits

Pull_Loop       ; While i is greater or equal to 0
                      pula                        ; Pull the even digit
                      
                ; Add this digit to count
                ldab        evenSum         ; load previous sum
                aba                     ; Add previous sum to current digit
                staa    evenSum         ; Store current sum
                dey                     ; Decrement count
                dey
                cpy     #0              ; Test if this was the last digit
                bhi     Pull_Loop       ; Branch if there are more digits
                
                ; Return value
                clra
                ldab    evenSum

                rts                     ; Sum of Even Digits returned

                       end


; ---------------------------------
;        END of Add_Even -
;----------------------------------