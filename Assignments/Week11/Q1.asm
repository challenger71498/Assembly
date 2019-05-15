;	Student Name:	¿À¹Î¼® (Oh Min Seok)
;	Student ID:		12181632

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword


.data

;string variables
STRING_WHAT_WANT byte "What do you want to do?", 0
STRING_HOW_MULTIPLY byte "How many numbers do you want to multiply? <max = 5>", 0
STRING_HOW_DIVIDE byte "How many numbers do you want to divide? <max = 5>", 0
STRING_INSERT byte "Insert a number: ", 0
STRING_RESULT byte "The result is ", 0
STRING_ONE byte "    1- Multiply numbers", 0
STRING_TWO byte "    2- Divide numbers", 0
STRING_THREE byte "    3- Exit", 0

;variables
count dword 0
var dword 0


.code
main proc
	.repeat																					;	repeat until get 3
		mov edx, offset STRING_WHAT_WANT													;	1. Display Command Menus
		call WriteString																	;	
		call crlf																			;		
		mov edx, offset STRING_ONE															;	
		call WriteString																	;	
		call crlf																			;	
		mov edx, offset STRING_TWO															;	
		call WriteString																	;	
		call crlf																			;	
		mov edx, offset STRING_THREE														;	
		call WriteString																	;	
		call crlf																			;	
		call ReadChar																		;	
		call crlf																			;	
																							;	2. If statement whether al is '1', '2', or '3'
		.if al == '1'																		;		al == 1
			mov edx, offset STRING_HOW_MULTIPLY												;	
			call WriteString																;	
			call crlf																		;	
			call ReadInt																	;			Get the numbers to multiply.
			.if (eax > 0) && (eax <= 5)														;			If the number is between 1 to 5,
				dec eax																		;				Decrease eax, because I will get a number before whlie statement starts.
				mov count, eax																;				Move eax to count.
				mov edx, offset STRING_INSERT												;				
				call WriteString															;	
				call ReadInt																;				Get the first number.
				mov var, eax																;				Now move eax to var.
				.while count > 0															;				Loop until count is zero.
					dec count																;					Decrease count.
					mov edx, offset STRING_INSERT											;					
					call WriteString														;	
					call ReadInt															;					Get a number to eax.
					imul var																;					Multiply var to eax. Note that var is the one saving multiplied numbers accumulatively.
					mov var, eax															;					Now move eax, multiplied number, to var again.
				.endw																		;				End of loop
				mov edx, offset STRING_RESULT												;				
				call WriteString															;	
				mov eax, var																;				Move var to eax, to print the result of multiplication.
				call WriteInt																;				Print result.
				call crlf																	;				
			.endif																			;			End of if.
		.elseif al == '2'																	;		al == 2
		mov edx, offset STRING_HOW_DIVIDE													;	
			call WriteString																;	
			call crlf																		;	
			call ReadInt																	;			Get the numbers to divide.
			.if (eax > 0) && (eax <= 5)														;			If the number is between 1 to 5,
				dec eax																		;				Decrease eax, same reason as multiplication.
				mov count, eax																;				Move eax to count.
				mov edx, offset STRING_INSERT												;				
				call WriteString															;	
				call ReadInt																;				Get the first number, number to be divided.
				mov var, eax																;				Move eax to var.
				.while count > 0															;				Loop until count is zero.
					dec count																;	
					mov edx, offset STRING_INSERT											;	
					call WriteString														;	
					call ReadInt															;	
					mov edx, 0																;	
					xchg eax, var															;	
					idiv var																;	
					mov var, eax															;	
				.endw																		;	
				mov edx, offset STRING_RESULT												;	
				call WriteString															;	
				mov eax, var																;	
				call WriteInt																;	
				call crlf																	;	
			.endif																			;	
		.endif																				;	
																							;	
		call crlf																			;	
	.until al == '3'																		;	



	invoke ExitProcess,0
main endp
end main