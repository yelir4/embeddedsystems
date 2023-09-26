			.syntax	unified
			.cpu	cortex-m4
			.text
			.global	PutNibble
			.thumb_func
			.align
			// void PutNibble(void *nibbles, uint32_t index, uint32_t nibble) ;
PutNibble:	LSR R12, R1, 1				// divide by 2, 2 nibbles = 1 byte
			LDRB R3, [R0, R12]			// get byte from memory
			
			ANDS R1, R1, 1				// R1 odd or even, sets zero flag
			ITE EQ						// if(R1which == 0) , EQ reads the zero flag
			BFIEQ R3, R2, 0, 4			// set lower 4 bits of the byte
			BFINE R3, R2, 4, 4			// set upper 4 bits of byte
			STRB R3, [R0, R12]
			BX		LR
			
			.global	GetNibble
			.thumb_func
			.align
			// uint32_t GetNibble(void *nibbles, uint32_t index) ;
GetNibble:	LSR R2, R1, 1				// divide by 2, 2 nibbles = 1 byte
			LDRB R2, [R0, R2]			// get byte from memory
			
			ANDS R1, R1, 1				// R1 odd or even, sets zero flag
			ITE EQ						// if(R1which == 0), reads zero flag
			UBFXEQ R0, R2, 0, 4			// return lower 4 bits of byte
			UBFXNE R0, R2, 4, 4			// return upper 4 bits of byte
			BX		LR
			.end
