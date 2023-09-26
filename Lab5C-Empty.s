			.syntax     unified
			.cpu        cortex-m4
			.text
			//                         R0         R1            R2            R3
			// int32_t MxPlusB(int32_t x, int32_t mtop, int32_t mbtm, int32_t b) ;
			.global     MxPlusB
			.thumb_func
			.align
MxPlusB:	PUSH {R4, R5, R6, R7, R8, R9, R10, R11} // preserve these register values before overwriting them
			MUL R4, R1, R0
			MUL R5, R4, R2							// mtop * x * mbtm
			ASR R6, R5, 31
			MUL R7, R6, R2
			LSL R8, R7, 1							// shift left into register 8
			ADD R9, R8, R2
			LDR R10, =2								// i think
			SDIV R10, R9, R10						// divide for rounding
			MUL R11, R1, R0
			ADD R12, R11, R10						// mtop*x + rounding
			SDIV R0, R12, R2						// ^ / mbtm
			ADD R0, R0, R3							// add b
			POP {R4, R5, R6, R7, R8, R9, R10, R11} // restore the register values from memory
			BX          LR
			.end
