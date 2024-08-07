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

oddSum         db      0
currentOdd     ds      1
number_Digits  ds      2

Add_Odd
                ldaa    #0
                staa    oddSum
                stab   number_Digits+1  ; Store number of digits passed to subroutine
                ldy    #0               ; Init count to 0


Push_Odds       ; For i = 0, i less than number digits, i++

                ; Extract even digit and push
                ldaa    0,x             ; Load current digit into a
                psha                    ; Push digit to stack
                inx                     ; Increment x to start from next odd digit
                inx

                ; i++
                iny                     ; Increment count
                iny

                ; i < numDigits
                cpy     number_Digits   ; Test if this was the last digit
                blo     Push_Odds       ; Loop if less than numDigits

Pull_Odds              ; While i is greater or equal to 0
                      pula                    ; Pull the even digit
                      
                      ;   Double a
                staa    currentOdd
                adca    currentOdd
                daa

                       ; If this number has two digits
                       cmpa    #9
                       bgt     Cross_Add ; Cross add
                       bra     Skip_Cross_Add
                       
Cross_Add
                ; Do cross add
                tfr         a,b             ; Copy a to b
                clra                    ; Clear leading register a
                ldx     #10             ; Load 10 as divisor
                idiv                    ; Divide current value by 10
                ; b now contains the answer and x contains remainder

                ; Swap x to contain address of value
                stx         currentOdd
                ldx     currentOdd
                
                ; Remove leading bit from value
                ldaa    1,x
                
                ; Add remainder and answer together
                aba
                
                
Skip_Cross_Add
                      ; Add to previous sum
                ldab        oddSum     ; load previous sum
                aba                    ; Add previous sum to current digit
                staa    oddSum         ; Store current sum
                dey                    ; Decrement count
                dey
                cpy     #0             ; Test if this was the last digit
                bhi     Pull_Odds      ; Branch if there are more digits

                ; Return value
                clra
                ldab    oddSum

                rts                     ; Sum of Even Digits returned

                end


; ---------------------------------
;        END of Add_Even -
;----------------------------------