
;Tim McCarty
; Celsius to Fahrenheit Converter
				INCLUDE stm32l1xx_constants.s		; Load Constant Definitions
				INCLUDE stm32l1xx_tim_constants.s   ; TIM Constants

				AREA    main, CODE, READONLY
				EXPORT	__main						; make __main visible to linker
				ENTRY
				
__main			PROC
	; Fahrenheit to Celsius converter
	;
				MOV R0, #0; Freezing point
				BL	CelsToFah
				;R0 should equal ~32, R0 holds 0x20=32 decimal
				MOV R0, #100
				BL	CelsToFah
				;R0 should equal ~212, R0 = 0xD4 = 212
				
				;Demo FahToCels
				MOV R0, #32 ;Freezing point
				BL	FahToCels
				;R0 should equal 0
				
				MOV R0, #212; Boiling Point
				BL	FahToCels
				;R0 should equal 100
				
				B Exit
				ENDP
					
; Modify R0 in place from Celsius to Fahrenheit 
CelsToFah
				;Fah = (Cels * 9 / 5) + 32
				MOV r11, #9
				MOV r12, #5
				MUL R0, R0, R11; Cels * 9
				SDIV R0, R0, R12; Cels / 5
				ADD R0, #32; Cells + 32
				BX	lr
; Modify R0 in place from Fahrenheit to Celsius
FahToCels
				; Cels = (Fah - 32) * 5/9
				MOV r11, #9
				MOV r12, #5
				SUB R0, R0, #32 ; Fah - 32
				MUL R0, R0, R12 ; * 5
				SDIV R0, R0, R11 ; / 9
				BX lr
Exit
				END
