
;Tim McCarty
; Fibonacci sequence in ARM-ASM
				INCLUDE stm32l1xx_constants.s		; Load Constant Definitions
				INCLUDE stm32l1xx_tim_constants.s   ; TIM Constants

				AREA    main, CODE, READONLY
				EXPORT	__main						; make __main visible to linker
				ENTRY
				
__main			PROC
	;  Fibonacci sequence
				;Let r2 be current fib, r0, r1 be last two (f(n-1), f(n-2))
				;Let r11 be address, r12 offset
				LDR r11, =Fib
				MOV r12, #0
				
				MOV r10, #4096 ; Byte Length/Max offset
				
				MOV r0, #0
				MOV r1, #1
Loop			CMP r12, r10; Compare current offset to maximum offset.
				BGE Out; Branching out if greater than/equal
				ADD r2, r0, r1; F(n) = F(n-2) + F(n-1), but stored in registers
				STR r0, [r11, r12]; store result
				MOV r0, r1;Shift answers for next iteration
				MOV r1, r2
				ADD r12, #4; increment memory offset
				B Loop
Out			
				ENDP
				
				AREA da, DATA
Fib			SPACE 4096; Allocate 1024 words of space
				END
