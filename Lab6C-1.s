			.syntax		unified
			.cpu		cortex-m4
			.text
			.global		CopyCell
			.thumb_func
			.align
			// void CopyCell(uint32_t *dst, uint32_t *src);
CopyCell:	MOV R2, 0				// R2row = 0

NextRow1:	CMP R2, 60
			BGE EndRows1
			MOV R3, 0				// R3col = 0
			
NextCol1:	CMP R3, 240
			BGE EndCol1
			LDR R12, [R1, R3]		// R12 = R1src[R3col]
			STR R12, [R0, R3]		// R12 -> R0dst[R3col]
			ADD R3, R3, 4
			B NextCol1

EndCol1:	ADD R0, R0, 960
			ADD R1, R1, 960
			ADD R2, R2, 1
			B NextRow1				// move down to next row

EndRows1:	BX			LR

			.global		FillCell
			.thumb_func
			.align 
			// void FillCell(uint32_t *dst, uint32_t color);
FillCell:	MOV R2, 0				// Rwrow = 0

NextRow2:	CMP R2, 60
			BGE EndRows2
			MOV R3, 0				// R3col = 0

NextCol2:	CMP R3, 240
			BGE EndCol2
			STR R1, [R0, R3]			// R1 -> R0dst[R3col]
			ADD R3, R3, 4
			B NextCol2

EndCol2:	ADD R0, R0, 960
			ADD R2, R2, 1
			B NextRow2				// move down to next row

EndRows2:	BX			LR
			.end
