%include "macros.inc"
section .data
	filename db "5.txt",0

section .bss 
	text resb 640000

section .text
	global _start
_start:
	mov rax, SYS_OPEN
	mov rdi, filename
	mov rsi, O_RDONLY
	mov rdx,0 
	syscall

	push rax
	mov rdi, rax
	mov rax, SYS_READ
	mov rsi, text
	mov rdx, 635915
	syscall
	
	mov rax, SYS_CLOSE
	pop rdi
	syscall
	
	print text
	exit
