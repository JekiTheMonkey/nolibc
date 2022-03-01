global		_start

extern		main						; C main will be used

section		.text
_start:		mov		ecx, [esp]			; get argc
			mov		eax, esp			; move on
			add		eax, 4				;   argv
			push	eax					; push in 
			push	ecx					;   right order
			call	main				; call main function
			add		esp, 8				; clear stack
			mov		ebx, eax			; move main result in ebx
			mov		eax, 1				; sys_exit
			int		0x80				; finish
