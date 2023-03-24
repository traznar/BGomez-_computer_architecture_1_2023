section .data
	filename db "5.txt",0
	newfile db 'decrypted1.txt',0
	numItera db 128
	char1 dw 0
	char2 dw 0
	char3 dw 0
	contador dw 0
	operador1 dw 0
	operador2 dw 0		
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
    	mov ecx,0 
    	jmp _numberCreator

_numberCreator:
    mov esi, text 			;puntero (rsi) tiene el texto
    mov edx, 1
    mov bl,[esi+edi]
    ;sub bl,'0' 
    ;mov [array], bl
    ;add bl,'0'

    add edi,1
    add ecx,1
    
    cmp bl, 32
    je _condicionEspacio
  
    jmp _numberCreator

_condicionEspacio:
    cmp ecx,0
    je _reset
    cmp ecx,2
    je _numero1
    cmp ecx,3
    je _numero2
    cmp ecx,4
    je _numero3

_numero1:
    xor eax,eax
    mov edx,edi
    sub edx,ecx
    mov bl,[esi+edx]
    sub bl,'0'
    mov [char1], bl
    mov ecx,0
    ;print char1
    jmp _reset

_numero2:               ;crea segundo numero  
    mov edx,edi         ;ebx pasa a ser edi 
    sub edx,ecx         ;se resta ebx-ecx=2 para ubicarse antes de los espacios
    mov bl,[esi+edx]   ;nos colocamos en el caracter que nos interesa
    sub bl,'0'
    mov al,bl
    mov edx,10
    mul edx              ;multiplicamos este caracter por 10 para obtenerlo como se debe
    jmp _multi10
_multi10:
    sub ecx,1           ;le restamos 1 a ecx para pasar a la siguiente en edi ecx=1
    mov edx,edi         ;movemos edi a ebx 
    sub edx,ecx         ;le restamos ecx a ebx
    mov bh,[esi+edx]   ;sumamos lo que esta en eax + el dato de en [esi+ebx]
    sub bh,'0'
    add al,bh
    mov [char1],al
    ;print char2
    jmp _reset

_numero3:
    xor eax,eax
    xor ebx,ebx
    mov edx,edi
    sub edx,ecx
    mov bl,[esi+edx]
    sub bl,'0'
    mov al,bl
    mov edx,100
    mul edx
    mov [char1],al
    jmp _multi100

_multi100:
    xor eax,eax
    xor ebx,ebx
    sub ecx,1
    mov edx, edi    
    sub edx,ecx
    mov bh,[esi+edx]
    sub bh, '0'
    mov ah,bh
    mov edx,10
    mul edx
    add [char1],ah
    sub ecx,1
    mov edx, edi    
    sub edx,ecx
    xor ebx,ebx
    mov bl,[esi+edx]
    sub bl,'0'
    add [char1],bl
    xor ebx,ebx
    mov bl,[char1]
    jmp _reset

_reset:
    mov ecx,0
    xor ebx,ebx		;reinicia ebx=0

    mov bl,[contador]   ; asigna el contador a bl para incrementarlo
    add bl,1		; lo incrementa en 1 
    add [contador],bl
	
    cmp bl,1 		; si es igual a 1 significa que tenemos el primer dato
    je _preRSA1		

    mov [contador],bl

    cmp bl,2		; si es igual a 2 significa que tenemos el segundo dato
    je  _preRSA2

    jmp _numberCreator

_preRSA1:
	xor ebx, ebx
	mov bl, [char1]
	mov [operador1],bl
	mov bh, [operador1]
	xor ebx, ebx
	jmp _numberCreator
_preRSA2:
	xor ebx,ebx
	mov bh, [char1]
	mov [operador2],bh
	mov bl, [operador2]
	xor ebx, ebx
	mov bh,0
	mov [contador], bh
	mov bl, [contador]
	xor ebx, ebx
	jmp _RSA
_RSA:
		
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
