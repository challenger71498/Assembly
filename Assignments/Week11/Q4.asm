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
	call Randomize
	
	.repeat
	mov edx, offset STR_SETDIFF
	call WriteString
	call ReadInt
	mov diff, eax
	.until eax <= 10

	push offset ary1
	call RandomizeArray
	
	push offset ary2
	call RandomizeArray

	mov count, arrayLength
	mov esi, offset ary1		;DEBUG: for displaying an array1
	.while count > 0
		dec count
		
		mov eax, [esi]
		call WriteInt
		mov edx, offset STR_SPACE
		call WriteString
		add esi, 4
	.endw
	call crlf

	mov count, arrayLength
	mov esi, offset ary2		;DEBUG: for displaying an array2
	.while count > 0
		dec count
		
		mov eax, [esi]
		call WriteInt
		mov edx, offset STR_SPACe
		call WriteString
		add esi, 4
	.endw
	call crlf

	push offset ary1
	push offset ary2
	push arrayLength
	push diff
	call CountNearMatches

	call crlf
	call WriteInt
	call crlf

	invoke ExitProcess,0
main endp


CountNearMatches proc
	enter 4,0
	push esi
	push edi
	push ebx
	push edx

	mov eax, arrayLengthArg
	mov countArg, eax
	mov eax, 0
	mov esi, arrayFirst
	mov edi, arraySecond
	.while countArg > 0
		dec countArg
		mov ebx, [edi]
		add ebx, diffArg
		mov edx, [edi]
		sub edx, diffArg
		.if dword ptr [esi] >= edx && dword ptr [esi] <= ebx
			inc eax
		.endif
		add edi, 4
		add esi, 4
	.endw

	pop edx
	pop ebx
	pop edi
	pop esi
	leave
	ret 16
CountNearMatches endp


RandomizeArray proc
	enter 4,0
	pushad
	mov countArg, arrayLength
	mov esi, targetAddr
	.while countArg > 0
		dec countArg
		mov eax, randomWidth
		call RandomRange
		add eax, randomOffset
		mov targetArg, eax
		add esi, 4
	.endw
	popad
	leave
	ret 4
RandomizeArray endp

end main