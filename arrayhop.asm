;;===============================
;;Name: ALLISON SOMMERS
;;===============================

.orig x3000

	LD R6, STACK			; load the stack pointer

	AND R0, R0, 0
	ADD R6, R6, -1			; push argument idx=0 on stack
	STR R0, R6, 0 

	LD R0, ARRAY2			; R0 = ARRAY1, change later to ARRAY2 and ARRAY3 for testing
	ADD R6, R6, -1 			; allocate spot on stack
	STR R0, R6, 0			; push argument ARRAY on stack

	JSR ARRAYHOP

	LDR R0, R6, 0			; load return value off top of stack
	ADD R6, R6, 3 			; restore stack to previous value

	ST R0, ANSWER			; store answer
	HALT

ARRAY1 	.fill x5000
ARRAY2	.fill x5010
ARRAY3  .fill x5020
ANSWER 	.blkw 1
STACK 	.fill xF000


ARRAYHOP

	ADD R6, R6, -3	; MOVE UP STACK 3 SPOTS
	STR R7, R6, 1	; STORE RETURN ADDRESS
	STR R5, R6, 0	; STORE OLD FP	
	ADD R5, R6, -1	; CREATE NEW FP

	ADD R6, R6, -1	; ALLOCATE 1 LOCALS

	LDR R0, R5, 4	; LOAD ARRAY ADDRESS, 1st ARG
	LDR R1, R5, 5 	; LOAD INDEX
	ADD R0, R1, R0 	; GET ARRAY MEM AT INDEX
	LDR R2, R0, 0	; GET ARRAY[INDEX]

	STR R2, R5, 0	; store N

	BRnp ELSE	; if N !=0 go to else

	STR R2, R5, 3	; RETURN VALUE SLOT
	BR RETURN

ELSE	

	ADD R6, R6, -1 	; ALLOCATE FOR ARGUMENT
	AND R3, R3, 0	; CLEAR R3 FOR N + INDEX
	ADD R3, R2, R1
	STR R3, R6, 0	; SAVE THE VALUE

	ADD R6, R6, -1 	; ALLOCATE FOR ARGUMENT
	LDR R0, R5, 4	; LOAD THE ARRAY
	STR R0, R6, 0	; SHOVE THE ARRAY FOR LATER

	JSR ARRAYHOP

	LDR R0, R6, 0	; RETURN OFF STACK
	ADD R0, R0, 1

	STR R0, R5, 3	; STORE RETURN VALUE

RETURN

	ADD R6, R5, 3	; R6 NOW POINTS TO RETURNVAL
	LDR R7, R5, 2 ; RESTORE R7
	LDR R5, R5, 1 ; RESTORE R5 OLD FP
	
	RET
.end

; 4 hops
.orig x5000
.fill 2
.fill 1
.fill 3
.fill 0
.fill -1
.fill -1
.end

; 5 hops
.orig x5010
.fill 1
.fill 1
.fill 1
.fill 3
.fill 0
.fill -12
.fill -2
.end

; 12 hops
.orig x5020
.fill 5
.fill 1
.fill 0
.fill -3
.fill 10
.fill -1
.fill 5
.fill 20
.fill 2
.fill 3
.fill 1
.fill -2
.fill 9
.fill 14
.fill 3
.fill 20
.fill -2
.fill -7
.fill 5
.fill 1
.fill -18
.fill -2
.end
