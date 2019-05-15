;	Student Name:	¿À¹Î¼® (Oh Min Seok)
;	Student ID:		12181632

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword


.data
;constants
gradeArg equ <dword ptr [ebp + 8]>
randomWidth equ 51
randomOffset equ 50

;string variables
STR_SPACE byte " ", 0

;variables
count dword 10
grade dword 0
gradeChar byte 0


.code
main proc
	call Randomize																				  ;		Call Randomize proc, to randomize seed.
	.while count > 0																			  ;		Loop until count is zero.
		dec count																				  ;			Decrease count.
																								  ;		
		mov eax, randomWidth					;randomizing									  ;			Get a random number between offset ~ offset + width.
		call RandomRange																		  ;		
		add eax, randomOffset																	  ;		
		mov grade, eax																			  ;			Move eax to grade.	
																								  ;		
		push eax								;getting char									  ;			Push eax to CalcGrade proc.
		call CalcGrade																			  ;			Call CalcGrade proc. After calling, proc returns a single char to al.
		mov gradeChar, al																		  ;			Save this char to gradeChar.
																								  ;		
		mov eax, grade							;output											  ;			Print grade(number), and gradeChar.
		call WriteInt																			  ;		
		mov edx, offset STR_SPACE																  ;		
		call WriteString																		  ;		
		mov al, gradeChar																		  ;		
		call WriteChar																			  ;		
		call crlf																				  ;		
	.endw																						  ;		End of loop. It will loop 10 times.
																								  ;		
	invoke ExitProcess,0																		  ;		
main endp																						  ;		
																								  ;		
CalcGrade proc																					  ;		CalcGrade proc definition:
	enter 0, 0																					  ;			No local variables.
	.if gradeArg >= 90																			  ;				use if~elseif~else statement to determine which letter to be in al.
		mov al, 'A'																				  ;		
	.elseif gradeArg >= 80 && gradeArg < 90														  ;		
		mov al, 'B'																				  ;		
	.elseif gradeArg >= 70 && gradeArg < 80														  ;		
		mov al, 'C'																				  ;		
	.elseif gradeArg >= 60 && gradeArg < 70														  ;		
		mov al, 'D'																				  ;		
	.else																						  ;		
		mov al, 'F'																				  ;		
	.endif																						  ;		
	leave																						  ;			
	ret	4																						  ;			Since there is 1 argument, return with 4 bytes.
CalcGrade endp																					  ;		

end main