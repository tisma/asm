section .text

lib_print_string:
	pusha

	mov eax, ecx
	mov edx, 0
.loop:
	cmp byte [eax], 0
	je .done
	inc edx
	inc eax
	jmp .loop

.done:
	mov eax, 4
	mov ebx, 1
	int 80h

	popa
	ret

section .text

lib_print_registers:
	pusha

	push ecx

	mov ecx, eax_string
	call lib_print_string
	call lib_int_to_string
	call lib_print_string

	mov ecx, ebx_string
	call lib_print_string
	mov eax, ebx
	call lib_int_to_string
	call lib_print_string

	mov ecx, ecx_string
	call lib_print_string
	pop eax
	call lib_int_to_string
	call lib_print_string

	mov ecx, edx_string
	call lib_print_string
	mov eax, edx
	call lib_int_to_string
	call lib_print_string

	mov ecx, esi_string
	call lib_print_string
	mov eax, esi
	call lib_int_to_string
	call lib_print_string

	mov ecx, edi_string
	call lib_print_string
	mov eax, edi
	call lib_int_to_string
	call lib_print_string

	mov ecx, newline_string
	call lib_print_string

	popa
	ret

section .data
	eax_string db "EAX: ", 0
	ebx_string db 10, "EBX: ", 0
	ecx_string db 10, "ECX: ", 0
	edx_string db 10, "EDX: ", 0
	esi_string db 10, "ESI: ", 0
	edi_string db 10, "EDI: ", 0
	newline_string db 10, 0

section .text

lib_int_to_string:
	pusha

	mov esi, int_to_string_store
	add esi, 9
	mov byte [esi], 0
	dec esi

	mov ebx, 10
.next_digit:
	mov edx, 0
	div ebx
	add dl, '0'
	dec esi
	mov [esi], dl
	cmp eax, 0
	jnz .next_digit
	mov [int_to_string_tmp], esi
	popa
	mov ecx, [int_to_string_tmp]
	ret

section .data:
	int_to_string_tmp dd 0
	int_to_string_store times 10 db 0

