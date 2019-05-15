INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
;constants
arrayLength equ 10
randomWidth equ 51
randomOffset equ 50

;RandomizeArary proc constants
targetArg equ <dword ptr [esi]>
targetAddr equ <dword ptr [ebp + 8]>
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

	mov esi, offset ary1
	.while count > 0
		dec count
		
		mov eax, [esi]
		call WriteInt
		add esi, 4
	.endw

	;push ary1
	;push ary2
	;push arrayLength
	;call CountMatches

	invoke ExitProcess,0
main endp

CountMatches proc
	enter 0,0

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