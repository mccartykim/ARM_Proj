

				INCLUDE stm32l1xx_constants.s		; Load Constant Definitions
				INCLUDE stm32l1xx_tim_constants.s   ; TIM Constants

				AREA    main, CODE, READONLY
				EXPORT	__main						; make __main visible to linker
				ENTRY
				
__main			PROC
	;  Find all primes below 1024 
				LDR R0, =Candidates
				MOV R1, #0 ; R1 = OFFSET
				MOV R12, #0xFF; True symbol
				MOV R10, #1024 ; MAX VALUE FOR OFFSET
				; Initiate all bytes at 0xFF
InitLoop ; Set all memory addresses in range to 0xFF, my "true" value
				CMP R1, R10
				BEQ CheckEach; Repeat until r1 == r10
				STRB R12, [R0, R1] ; Save to R1's address, increment R1's address afterwards
				ADD R1, #1; change offset to next byte 
				B		InitLoop
CheckEach
				MOV R1, #0 ; RESET OFFSET
				;Mark bytes 0 and 1 not prime
				MOV R11,  #0
				STRB R11, [R0, R1]
				ADD R1, #1
				STRB R11, [R0, R1]
				; set R1 to 2, the first prime
				MOV R1, #2
EachPrime
				MOV R4, R1 ; Put the prime value in R4 for debug/hacky output as there's no console
				LSL R2, R1, #1; Store offset starting at double the prime.
InnerPrimeLoop
				CMP R2, R10
				BGE NextPrime ; If this multiple is greater than the memory area, search for the next prime.
				STRB R11, [R0, R2] ; Store this multiple as false.
				ADD R2, R2, R1; set r2 to the next multiple of the prime in R1
				B InnerPrimeLoop; repeat
NextPrime; Essentially: while memory at offset R1 is false, R1++.
				ADD R1, #1
				LDRB R2, [R0, R1]
				CMP R2, R11 ; Compare to false value
				BEQ NextPrime ; If zero, try next number
				CMP R2, R10 ; If it's out of bounds, end
				BLT EachPrime ; Otherwise, go to the next number
				ENDP
				
				AREA da, DATA
Candidates		SPACE 1024; Allocate 1 kilobyte for the program.
				END
