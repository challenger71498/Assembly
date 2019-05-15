;	Student Name:	¿À¹Î¼® (Oh Min Seok)
;	Student ID:		12181632

NCLUDE Irvine32.inc

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
	call Randomize
	.while count > 0
		dec count

		mov eax, randomWidth					;randomizing
		call RandomRange
		add eax, randomOffset
		mov grade, eax

		push eax								;getting char
		call CalcGrade
		mov gradeChar, al

		mov eax, grade							;output
		call WriteInt
		mov edx, offset STR_SPACE
		call WriteString
		mov al, gradeChar
		call WriteChar
		call crlf
	.endw

	invoke ExitProcess,0
main endp

CalcGrade proc
	enter 0, 0
	.if gradeArg >= 90
		mov al, 'A'
	.elseif gradeArg >= 80 && gradeArg < 90
		mov al, 'B'
	.elseif gradeArg >= 70 && gradeArg < 80
		mov al, 'C'
	.elseif gradeArg >= 60 && gradeArg < 70
		mov al, 'D'
	.else
		mov al, 'F'
	.endif
	leave
	ret	4
CalcGrade endp

end main