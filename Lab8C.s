			.syntax		unified
			.cpu		cortex-m4
			.text
			// uint32_t Mul32X10(uint32_t R0_multiplicand) ;
			.global		Mul32X10
			.thumb_func
			.align
Mul32X10:	LSL R1, R0, 2				// r1 = r0 << 2 (4r0)
			ADD R1, R0, R1				// r1 += r0 (5r0)
			LSL R0, R1, 1				// r0 = r1 << 1 (10r0)
			BX LR						// 10r0 returns in r0

			// uint32_t Mul64X10(uint32_t R1.R0_multiplicand) ;
			.global		Mul64X10
			.thumb_func
			.align
Mul64X10:	LSL R2, R1, 2				// r2 = r1 << 2 (4r1)
			LSR R3, R0, 30				// r3 = r0 >> 30 (take sign bit, populate to right)
			ORR R2, R2, R3				// r2 = r2 | r3 (inserts into bits 0, 1 in R2 if needed)
			LSL R3, R0, 2				// r3 = (4r0)
			
			ADDS R3, R3, R0				// add, set carry bit if needed (R3 = 5r0)
			ADC R2, R2, R1				// add with carry (r2 = 5r1)
			
			LSLS R0, R3, 1				// r0 = r3 << 1 (r0 = 10r0, with carry bit if needed)
			ADC R1, R2, R2				// add (r1 = 10r1, with carry bit)
			BX			LR				// returns in R1.R0

			// uint32_t Div32X10(uint32_t R0_dividend) ;
			.global		Div32X10
			.thumb_func
			.align
Div32X10:	LDR R1, =3435973837			// magic number
			UMULL R2, R1, R1, R0		// R1 *= R0
			LSR R0, R1, 3				// r0 = r1 >> 3 (r0 /= 10)
			BX			LR				// returns in r0
			.end
