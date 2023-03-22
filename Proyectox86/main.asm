section .data
	filename db "5.txt",0
	newfile db 'decrypted1.txt',0
	numItera db 128
	char1 db 1 ,0
	space db '32',0
	array TIMES 635915 db 0

section .bss 
	text resb 640000
	text2 resb 640000
	printSpace resb 8
	
section .text
	global _start

%macro print 1
    mov eax, %1
    mov [printSpace], eax
    mov ebx, 0
%%printLoop:
    mov cl, [eax]
    cmp cl, 0
    je %%endPrintLoop
    inc ebx
    inc eax
    jmp %%printLoop
%%endPrintLoop:
    mov eax, 1
    mov edi, 0
    mov esi, [printSpace]
    mov edx, ebx
    syscall
%endmacro
%macro exit 0
	mov eax, 60
	mov edi,0
	syscall
%endmacro 

_start:
	mov eax, 2
	mov edi, filename
	mov esi, 0
	mov edx,0 
	syscall
	 
	mov edi, eax
	mov eax, 0
	
	mov esi, text 			;puntero (rsi) tiene el texto
	mov edx, 635915                 ; NO TOCAR ESI Y EDX
	syscall

	mov esi,text
	mov eax, 3
	syscall
	
	print text
	mov edi,0
	jmp _llenararray

_llenararray:
	mov edx, 1
	xor ebx,ebx
	mov bl,[esi+edi]
	sub bl,'0' 
	;mov [array], bl
	add bl,'0'
	mov [array+edi], bl
	add edi,1
	cmp edi, 635915
	je _createfile
	jmp _llenararray

_createfile:
	mov ecx, 0777o
	mov ebx, newfile
	mov eax, 8
	int 80h
	mov edx,edi
	mov ecx,array
	mov ebx, eax
	mov eax, 4
	int 80h
	exit
_exit:
	exit
	
