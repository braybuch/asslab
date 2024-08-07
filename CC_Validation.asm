; CC_Validation.asm
;
#include C:\68HCS12\registers.inc
;
; Author(s):
; Student Number(s):
; Date:
;
; Purpose:      Credit Card Number Validation

; Address Constants - Do NOT change
STORAGE1        equ     $1000                   ; Storage starts here for original cards
FINALRESULTS    equ     $1030                   ; Final number of valid and invalid cards
PROGRAMSTART    equ     $2000                   ; Executable code starts here

; Hardware Configuration - Complete the Constant values
DIGIT3_PP0      equ    %1110                        ; HEX Display MSB (left most digit)
DIGIT0_PP3      equ    %0111                        ; Display LSB (right most digit)


; Program Constants - Do not change these values
NUMBERSOFCARDS  equ     6                       ; Six Cards to process
NUMDIGITS       equ     4                       ; Each Card has 4 digits

; You may add other Constant here if needed



; DO NOT CHANGE THE DELAY_VALUE; OTHERWISE THE VALUES WILL INCORRECTLY BE DISPLAYED
; IN THE SIMULATOR
DELAY_VALUE     equ     64                      ; HEX Display Multiplexing Delay

                org STORAGE1                    ; Note: a Label cannot be placed
Cards                                           ; on same line as org statement
#include        Sec_302_CC_Numbers.txt          ; substitute the appropriate file name here.
EndCards


; Do not change this code.
; Place your results here as you loop through your solution
                org  FINALRESULTS
InvalidResult   ds      1                       ; Count of Invalid CARDs processed
ValidResult     ds      1                       ; Count of Valid CARDs processed
; end of do not change
TotalSize       ds      2

                org     ProgramStart
                lds     #ProgramStart           ; Stack used to protect values

; --- Your code starts here
; Loop through all cards and validate, then display results

                ; Initialize card pointer
                ldx     #Cards                   ; Load x with address of first card

                ; Initialize size variable
                ldd     #EndCards
                std     TotalSize
                
                ; Initialize result variables
                ldab    #0
                stab    InvalidResult           ; Initialize invalidResult with 0
                stab    ValidResult             ; Initialize validResult with 0

                ; Do while there are more cards to check
Loop
                ; Calculate for odd numbers
                ldab    #NUMDIGITS              ; Pass number of digits to Add_Odd sr
                pshx
                jsr     Add_Odd                 ; Calculate for odd numbers
                pulx
                pshb                            ; Push sum of odd numbers to stack

                ; Calculate for even numbers
                ldab    #NUMDIGITS
                pshx
                jsr     Add_Even                ; Calculate for even numbers
                pulx
                pshb                            ; Push sum of even numbers to stack

                ; Check if card is valid
                pula                            ; Pull sum of even numbers
                pulb                            ; Pull sum of add numbers
                pshx                            ; Protect x
                jsr     Validate_CC             ; Check credit card number
                pulx                            ; Protect x

                ; If credit card was valid
                cmpb    #1                      ; Test if Validate_CC output true
                beq     Inc_Valid               ; Branch if card is valid
                ; else card is not valid
                ldaa    InvalidResult           ; Load a with value of valid results
                inca                            ; Increment count of valid
                staa    InvalidResult           ; Store new result
                bra     End_If                  ; Exit else
Inc_Valid       ; if body
                ldaa    ValidResult             ; Load a with value of invalid results
                inca                            ; Increment count of invalid
                staa    ValidResult             ; Store new result
End_If

                ; Increment x by number of digits
                tfr     x,d                     ; Place x into register d
                addd    #NUMDIGITS              ; Increment d by number of digits
                tfr     d,x                     ; Put x back where it belongs
                
                ; Check if this is the last card
                cpx     #TotalSize             ; test if this is the last card
                blo     Loop                  ; Loop if it wasn't

; --- End of changed code

; Do not change and code below here
Finished        jsr     Config_HEX_Displays
Display         ldaa    ValidResult
                ldab    #DIGIT3_PP0             ; Select MSB
                jsr     Hex_Display             ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms                ; Delay for DELAY_VALUE milliseconds
                ldaa    InValidResult
                ldab    #DIGIT0_PP3             ; Select LSB
                jsr     Hex_Display             ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms                ; Eelay for DELAY_VALUE milliseconds
                bra     Display                 ; Endless loop


; Filenames without a "C:\68HCS12\Lib\" path MUST be placed in the SOURCE FOLDER
#include Add_Odd.asm                            ; you write this one
#include Add_Even.asm                           ; you write this one
#include Validate_CC.asm                        ; you write this one
#include Config_HEX_Displays.asm                ; provided to you - no changes permitted
#include Hex_Display.asm                        ; provided to you - no changes permitted
#include C:\68HCS12\Lib\Delay_ms.asm            ; Library File    - no changes permitted

                end

************************* No Code Past Here ****************************