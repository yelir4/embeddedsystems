					.syntax         unified
					.cpu            cortex-m4
					.text
					// float EccentricAnomaly(float e, float M)
					.global         EccentricAnomaly
					.thumb_func
					.align
EccentricAnomaly:	// S0 = e, S1 = M
					PUSH            {LR}
					VPUSH           {S16-S18}
					
					VMOV S16, S0					//temp16 = e
					VMOV S17, S1					//temp17 = M
					VMOV S0, S1						//temp0 = M
					BL cosDeg						//temp0 = cosDeg(temp0)
					VMOV S18, 1.0					//temp18 = 1.0
					VMLA.F32 S18, S0, S16			//temp18 = temp18 + temp0 * temp16
					VMOV S0, S17					//temp0 = temp17
					BL sinDeg						//temp0 = sinDeg(temp0)
					VMUL.F32 S18, S18, S0			//temp18 = temp18 * temp0
					VMUL.F32 S0, S16, S18			//temp0 = temp16 * temp18
					BL Rad2Deg						//temp0 = Rad2Deg(temp0)
					VMUL.F32 S0, S17, S0			//temp0 = temp17 * temp0
													//return temp0
					VPOP            {S16-S18}
					POP             {PC}

					// float Kepler(float m, float ecc)
					.global         Kepler
					.thumb_func
					.align
Kepler:				// S0 = m, S1 = ecc
					PUSH            {R3,LR}
					VPUSH           {S16-S19}
					
					VMOV S16, S1					//temp16 = ecc
					VSUB.F32 S1, S1, S1				//temp1 = 0.0
					BL Deg2Rad						//temp0 = Deg2Rad(m)
					VMOV S17, S0					//temp17 = temp0
					VMOV S18, S0					//temp18 = temp0
					VSUB.F32 S19, S19, S19			//temp19 = 0.0
					
					L1: VCMP.F32 S0, S1				//temp0 > temp1 ?
					VMRS APSR_nzcv,FPSCR			//core flags <-- cpu flags
					BLE L2							//if not, end loop
					VMOV S0, S18
					BL sinf							//temp0 = sinf(temp18)
					VMUL.F32 S1, S16, S0			//temp1 = temp18 * temp0
					VSUB.F32 S1, S18, S1			//temp1 = temp18 - temp1
					VSUB.F32 S19, S1, S17			//temp19 = temp1 - temp17
					VMOV S0, S18					//temp0 = temp18
					BL cosf							//temp0 = cosf(temp0)
					VMOV S1, 1.0					//temp1 = 1.0
					VMLS.F32 S1, S16, S0			//temp1 = temp1 - temp16 * temp0
					VDIV.F32 S0, S19, S1			//temp0 = temp19 / temp1
					VSUB.F32 S18, S18, S0			//temp18 = temp18 - temp0
					VMOV S0, S19
					BL fabsf						//temp0 = fabsf(temp19)
					VLDR S1, epsilon				//temp1 = 1E-6
					B L1							//return to top of loop
					
					L2: VMOV S0, S18				//return temp18

					VPOP            {S16-S19}
					POP             {R3,PC}

					.align
epsilon:			.float          1E-6
					.end
