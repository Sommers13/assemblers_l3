;;===============================
;;Name: ALLISON SOMMERS
;;===============================

.orig x3000

	LD R6, STACK			; load the stack pointer

	LD R0, N				; R0 = N
	ADD R6, R6, -1			; push argument N on stack
	STR R0, R6, 0			

	JSR TWOTORIAL

	LDR R0, R6, 0			; load return value off top of stack
	ADD R6, R6, 2 			; restore stack to previous value

	ST R0, ANSWER			; store answer
	HALT

N 		.fill 10
ANSWER 	.blkw 1
STACK 	.fill xF000


TWOTORIAL

	ADD R6, R6, -3	; MOVE UP STACK 3 SPOTS
	STR R7, R6, 1	; STORE RETURN ADDRESS
	STR R5, R6, 0	; STORE OLD FP	
	ADD R5, R6, -1	; CREATE NEW FP

	ADD R6, R6, -2	; ALLOCATE 2 LOCALS

	LDR R0, R5, 4	; LOAD N, FIRST ARG
	AND R1, R1, 0	; CLEAR R1 AND LOAD N-2
	ADD R1, R0, -2

	STR R1, R5, 0	; STORE N-2
	STR R0, R5, -1	; STORE N

	LDR R2, R5, 4	; LOAD N
	BRp ELSE	; IF N >0 --> ELSE

	AND R2, R2, 0	; PREP FOR RETURN 
	STR R2, R5, 3
	BR RETURN

ELSE	

	ADD R6, R6, -1 	; ALLOCATE FOR ARGUMENT
	STR R1, R6, 0	; PUSHED N-2 ON STACK
	JSR TWOTORIAL

	LDR R0, R6, 0	; RETURN VAL OFF STACK
	LDR R1, R5, -1	; READ N-2 LOCAL
	ADD R0, R0, R1	; N + N-2

	STR R0, R5, 3	; STORE RETURN VALUE

RETURN

	ADD R6, R5, 3	; R6 NOW POINTS TO RETURNVAL
	LDR R7, R5, 2 	; RESTORE R7
	LDR R5, R5, 1 	; RESTORE R5 OLD FP
	
	RET
.end
