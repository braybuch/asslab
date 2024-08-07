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
num_Digits      ds      1

Add_Even

                stab    num_Digits      ; Store number of digits passed to subroutine
                
                ; Initialize d with value in x
		clra
                clrb
                ldd     0,x
Push_Loop
		ldy    #0               ; For i = 0, i less than number digits, i++

		; push a digit
                ldx     #10             ; Load divisor
                idiv                    ; Divide D by divisor in X
                pshd                    ; Push digit/remainder to stack
                tfr     x,d             ; Transfer result back to d

                ; increment i
                iny                     ; Incrmenet count
                cpy     #num_Digits     ; Test if this was the last digit
                blo     Push_Loop       ; Loop if less than numDigits

Pull_Loop       ; While i is greater or equal to 0
        	pula			; pull a digit to delete
              	pula			; Pull another digit
                ; Add this digit to count
		ldab	evenSum         ; load previous sum
                aba                     ; Add previous sum to current digit
                staa    evenSum         ; Store current sum
                dey                     ; Decrement count
                cpy     #0              ; Test if this was the last digit
                bge     Pull_Loop       ; Branch if there are more digits
                
                ; Return value
                ldab    evenSum

        	rts             	; Sum of Even Digits returned

       		end




; ---------------------------------
;        END of Add_Even -
;----------------------------------