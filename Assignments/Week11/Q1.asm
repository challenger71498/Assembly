INCLUDE Irvine32.inc

; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
;string constants
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
	.repeat
		mov edx, offset STRING_WHAT_WANT
		call WriteString
		call crlf
		mov edx, offset STRING_ONE
		call WriteString
		call crlf
		mov edx, offset STRING_TWO
		call WriteString
		call crlf
		mov edx, offset STRING_THREE
		call WriteString
		call crlf
		call ReadChar
		call crlf

		.if al == '1'
			mov edx, offset STRING_HOW_MULTIPLY
			call WriteString
			call crlf
			call ReadInt
			.if (eax > 0) && (eax <= 5)
				dec eax
				mov count, eax
				mov edx, offset STRING_INSERT
				call WriteString
				call ReadInt
				mov var, eax
				.while count > 0
					dec count
					mov edx, offset STRING_INSERT
					call WriteString
					call ReadInt
					imul var
					mov var, eax
				.endw
				mov edx, offset STRING_RESULT
				call WriteString
				mov eax, var
				call WriteInt
				call crlf
			.endif
		.elseif al == '2'
		mov edx, offset STRING_HOW_DIVIDE
			call WriteString
			call crlf
			call ReadInt
			.if (eax > 0) && (eax <= 5)
				dec eax
				mov count, eax
				mov edx, offset STRING_INSERT
				call WriteString
				call ReadInt
				mov var, eax
				.while count > 0
					dec count
					mov edx, offset STRING_INSERT
					call WriteString
					call ReadInt
					mov edx, 0
					xchg eax, var
					idiv var
					mov var, eax
				.endw
				mov edx, offset STRING_RESULT
				call WriteString
				mov eax, var
				call WriteInt
				call crlf
			.endif
		.endif
		
		call crlf
	.until al == '3'



	invoke ExitProcess,0
main endp
end main