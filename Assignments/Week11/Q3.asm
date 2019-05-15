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
randomWidth equ 3
randomOffset equ 0

;CountMatches proc constants
arrayFirst equ <dword ptr [ebp + 16]>
arraySecond equ <dword ptr [ebp + 12]>
arrayLengthArg equ <dword ptr [ebp + 8]>

;RandomizeArray proc constants
targetArg equ <dword ptr [esi]>
targetAddr equ <dword ptr [ebp + 8]>

;General proc constants
countArg equ <dword ptr [ebp - 4]>

;variables
ary1 dword arrayLength dup(?)
ary2 dword arrayLength dup(?)

count dword arrayLength


.code
main proc
	call Randomize
	
	push offset ary1
	call RandomizeArray
	
	push offset ary2
	call RandomizeArray

	mov count, arrayLength
	mov esi, offset ary1		;DEBUG: for displaying an array
	.while count > 0
		dec count
		
		mov eax, [esi]
		call WriteInt
		add esi, 4
	.endw
	call crlf

	mov count, arrayLength
	mov esi, offset ary2		;DEBUG: for displaying an array
	.while count > 0
		dec count
		
		mov eax, [esi]
		call WriteInt
		add esi, 4
	.endw
	call crlf

	push offset ary1
	push offset ary2
	push arrayLength
	call CountMatches

	call crlf
	call WriteInt
	call crlf

	invoke ExitProcess,0
main endp


CountMatches proc
	enter 4,0
	push esi
	push edi
	push ebx

	mov eax, arrayLengthArg
	mov countArg, eax
	mov eax, 0
	mov esi, arrayFirst
	mov edi, arraySecond
	.while countArg > 0
		dec countArg
		mov ebx, [edi]
		.if dword ptr [esi] == ebx
			inc eax
		.endif
		add edi, 4
		add esi, 4
	.endw

	pop ebx
	pop edi
	pop esi
	leave
	ret 12
CountMatches endp


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