		#include<p18f4550.inc>

loop_cnt1 	set 0x01
loop_cnt2 	set 0x02

			org 0x00
			goto start
			org 0x08
			retfie
			org 0x18
			retfie

start		clrf TRISD,A
loop		clrf PORTD,A
			call delay
			setf PORTD,A
			call delay
			bra loop

; ***********************************
; Subroutine to create 1 second delay
; ***********************************
		
dup_nop		macro	kk
			variable i
i=0 	
			while i < kk
			nop
i+=1
			endw
			endm	

delay		movlw d'80' ;1sec delay subroutine for
			movwf loop_cnt2,A ;20mhz
again1 		movlw d'250'
			movwf loop_cnt1,A
again2 		dup_nop d'247'
			decfsz loop_cnt1,F,A
			bra again2
			decfsz loop_cnt2,F,A
			bra again1
			nop
			return
			end
