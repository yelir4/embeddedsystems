        		.syntax         unified
        		.cpu            cortex-m4
        		.text
				// int32_t Return32Bits(void) ;
        		.global         Return32Bits
        		.thumb_func
        		.align
Return32Bits:
				MOV R0, 10					// put value 10 in register R0
        		BX              LR

				// int64_t Return64Bits(void) ;
        		.global         Return64Bits
        		.thumb_func
        		.align
Return64Bits:
				MVN R0, 9
				MVN R1, 0					// puts value -10 in registers R0, R1 with R0 LSB
        		BX              LR

				// uint8_t Add8Bits(uint8_t x, uint8_t y) ;
	        	.global         Add8Bits
        		.thumb_func
        		.align
Add8Bits:		
				ADD R0, R0, R1
				UXTB R0, R0, ROR# 0			// extend to 32 bit so function returns correct number
        		BX              LR

				// uint32_t FactSum32(uint32_t x, uint32_t y) ;
		        .global         FactSum32
		        .thumb_func
		        .align
FactSum32:	
				PUSH {R4, LR}				// push 2 registers to avoid error
				ADD R0, R0, R1
				BL Factorial				// call factorial function, returns value in R0
				POP {R4, LR}
        		BX              LR

				// uint32_t XPlusGCD(uint32_t x, uint32_t y, uint32_t z) ;
        		.global         XPlusGCD
        		.thumb_func
        		.align
XPlusGCD:
				PUSH {R4, LR}
				MOV R4, R0					// preserve value of 'x' in R4
				MOV R0, R2
				BL gcd						// call gcd function, returns value in R0
				ADD R0, R0, R4
				POP {R4, LR}
        		BX              LR
        		.end
