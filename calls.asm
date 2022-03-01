section		.bss
sys_errno	resd	1

global		sys_read
global		sys_write
global		sys_errno

section		.text
;;
;; Generic system call for 3 parameters
;; EAX contains the system call number
;; Return -1 in EAX if there was an error
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
generic_syscall_3:
			push	ebp
			mov		ebp, esp
			push	ebx					; save ebx
			mov		ebx, [ebp+8]		; push all the system
			mov		ecx, [ebp+12]		;   call arguments in
			mov		edx, [ebp+16]		;     appropriate registers
			int		0x80				; sys call
			mov		edx, eax			; check
			and		edx, 0xfffff000		;   for
			cmp		edx, 0xfffff000		;      errors
			jnz		.ok
			mov		[sys_errno], eax	; put it in sys_errno
			mov		eax, -1				; return -1 if there is an error
.ok:		pop		ebx					; restore ebx
			mov		esp, ebp
			pop		ebp
			ret

;;
;; Read system call wrapper
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sys_read:	mov		eax, 3
			jmp		generic_syscall_3

;;
;; Write system call wrapper
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sys_write:	mov		eax, 4
			jmp		generic_syscall_3
