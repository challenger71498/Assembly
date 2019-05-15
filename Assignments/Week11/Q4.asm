;	Student Name:	¿À¹Î¼® (Oh Min Seok)
;	Student ID:		12181632

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
;constants
arrayLength equ 10
randomWidth equ 7
randomOffset equ 10

;CountNearMatches proc constants
arrayFirst equ <dword ptr [ebp + 20]>
arraySecond equ <dword ptr [ebp + 16]>
arrayLengthArg equ <dword ptr [ebp + 12]>
diffArg equ <dword ptr [ebp + 8]>

;RandomizeArray proc constants
targetArg equ <dword ptr [esi]>
targetAddr equ <dword ptr [ebp + 8]>

;General proc constants
countArg equ <dword ptr [ebp - 4]>

;Strings
STR_SPACE byte " ", 0
STR_SETDIFF byte "Allowed difference of two elements (Must between 0 ~ 10): ", 0

;variables
ary1 dword arrayLength dup(?)
ary2 dword arrayLength dup(?)
diff dword 2

count dword arrayLength


.code
main proc
	call Randomize																					  ;	
																									  ;	
	.repeat																							  ;	
	mov edx, offset STR_SETDIFF																		  ;	
	call WriteString																				  ;	
	call ReadInt																					  ;	
	mov diff, eax																					  ;	
	.until eax <= 10																				  ;	1. Randomize.
																									  ;	
	push offset ary1																				  ;	Randomize ary1.
	call RandomizeArray																				  ;	Call RandomizeArray.
																									  ;	
	push offset ary2																				  ;	Randomize ary2.
	call RandomizeArray																				  ;	Call RandomizeArray.
																									  ;	
	mov count, arrayLength																			  ;	
	mov esi, offset ary1		;DEBUG: for displaying an array1									  ;	2. Printing 2 arrays.
	.while count > 0																				  ;	Move arrayLength to count.
		dec count																					  ;	Loop until count is zero.
																									  ;		Decrease count.
		mov eax, [esi]																				  ;	
		call WriteInt																				  ;		
		mov edx, offset STR_SPACE																	  ;		Print array elements.
		call WriteString																			  ;	
		add esi, 4																					  ;	End of loop.
	.endw																							  ;	
	call crlf																						  ;	
																									  ;	
	mov count, arrayLength																			  ;	Do the same job to ary2.
	mov esi, offset ary2		;DEBUG: for displaying an array2									  ;	
	.while count > 0																				  ;	
		dec count																					  ;	
																									  ;	
		mov eax, [esi]																				  ;	
		call WriteInt																				  ;	
		mov edx, offset STR_SPACe																	  ;	
		call WriteString																			  ;	
		add esi, 4																					  ;	
	.endw																							  ;	
	call crlf																						  ;	
																									  ;	
	push offset ary1																				  ;	3, Calling CountMatches.
	push offset ary2																				  ;	
	push arrayLength																				  ;	
	push diff																						  ;	Push three arguements: address of ary1 and ary2, and the length of them.
	call CountNearMatches																			  ;	Call CountMatches. This proc will return a value to eax.
																									  ;	
	call crlf																						  ;	4. Printing the result.
	call WriteInt																					  ;	Print eax.
	call crlf																						  ;	
																									  ;	
	invoke ExitProcess,0																			  ;	
main endp																							  ;	End of main.
																									  ;	
																									  ;	
CountNearMatches proc																				  ;	CountMatches proc definition.
	enter 4,0																						  ;	1. Preparing parameters and local variables.
	push esi																						  ;		There is 1 local variable: countArg (for while statement.)
	push edi																						  ;	
	push ebx																						  ;		Push esi, edi, ebx, edx, registers that are being used. No eax pushing because we need to keep it for return va.
	push edx																						  ;	
																									  ;	2. Calculation.
	mov eax, arrayLengthArg																			  ;		Move arrayLengthArg, parameter that we've pushed, to eax.
	mov countArg, eax																				  ;		And move it again to countArg.
	mov eax, 0																						  ;		Reset eax to zero.
	mov esi, arrayFirst																				  ;		
	mov edi, arraySecond																			  ;		Move each address of ary1 and ary2 to esi and edi.
	.while countArg > 0																				  ;		Loop until countArg is zero.
		dec countArg																				  ;			Decrease countArg.
		mov ebx, [edi]																				  ;			Move the value of edi to ebx, which is the element of ary2, because we cannot compare memory to memory
		add ebx, diffArg																			  ;			Add the offset to ebx.
		mov edx, [edi]																				  ;			Move the value of edi to edx.
		sub edx, diffArg																			  ;			Subtrace the offset to edx.
		.if dword ptr [esi] >= edx && dword ptr [esi] <= ebx										  ;			If difference of two elements are between -diff ~ diff 
			inc eax																					  ;				Increase eax.
		.endif																						  ;			End of if.
		add edi, 4																					  ;			
		add esi, 4																					  ;			Add 4 bytes to edi, esi.
	.endw																							  ;		End of loop. Loop will terminate after comparing every element of the array.
																									  ;	
	pop edx																							  ;		Pop ebx, edx, edi, and esi.
	pop ebx																							  ;	
	pop edi																							  ;	
	pop esi																							  ;	
	leave																							  ;		Leave.
	ret 16																							  ;		Return 12 bytes.
CountNearMatches endp																				  ;	End of procedure.
																									  ;	
																									  ;	
RandomizeArray proc																					  ;	RandomizeArray proc definition.
	enter 4,0																						  ;	1. Preparing parameters and local variables.
	pushad																							  ;		There is 1 local variable: countArg (for while statement.)
	mov countArg, arrayLength																		  ;		And push every registers because there is no return value.
	mov esi, targetAddr																				  ;	2. Randomize the array.
	.while countArg > 0																				  ;		Loop until countArg is zero.
		dec countArg																				  ;			Decrease countArg.
		mov eax, randomWidth																		  ;			Move randomWidth to eax.
		call RandomRange																			  ;			Call RandomRange.
		add eax, randomOffset																		  ;			Adjust offset to eax.
		mov targetArg, eax																			  ;			Move eax,generated random number, to targetArg, which is the element of target array.
		add esi, 4																					  ;			Add 4 bytes to esi.
	.endw																							  ;		End of loop.
	popad																							  ;	3. Completion.
	leave																							  ;		Pop all registers and leave.
	ret 4																							  ;		Return 4 bytes.
RandomizeArray endp																					  ;	End of procedure.
																	  ;	
end main