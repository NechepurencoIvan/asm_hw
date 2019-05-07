%macro write_string 2 
    mov   eax, 4
    mov   ebx, 1
    mov   ecx, %1
    mov   edx, %2
    int   0x80
%endmacro


section .text
	global count_sum
	global print_num
	global my_printf

;
; Разминка с аргументами
;



count_sum:
; порядок аргументов: 
; rdi, rsi, rdx, rcx, r8d, r9d
	;write_string hello, helloLen
	add rdi, rsi
	add rdi, rdx
	add rdi, rcx
	add rdi, r8
	add rdi, r9
	mov rax, rdi
        ret                        ; Return control

;
; Функция для десятичного вывода числа
;

print_num:
	mov rax, rdi
	call _start
	ret

_start:             ;tell linker entry point
   
   write_string msg1, len1
   ;mov  ax, 267
   push 20
   jmp  _print_num_iter

_print_num_iter:	
   mov 	bl, 10
   div 	bl
   
   push ax

   mov  ah, 0
   cmp  ax, 0
   je   _print_num_out_stack
   jmp  _print_num_iter
;dds

_print_num_out_stack:
   pop ax
   cmp ax, 20
   je  _print_num_quit

   mov al, 0
  
   add	ah, '0'
   mov  [res], ah
   sub  ah, '0'
   
   ;mov cx, [digletters]
   ;mov 

   ;write_string cx,  1
   write_string res, 1	  
   jmp _print_num_out_stack

_print_num_quit:
   ;write_string msg2, len2 
   ;mov eax, 1
   ;pop ax
   ;int 0x80
   ret






































; строковые всякие функции

_print_substring: ;rdi - адрес начала чроки, r11 - число прочитанных символов
        mov eax, 4
        mov ebx, 1
        mov rcx, rdi
        mov rdx, r11
        int 80h
        
        ret

_get_strlen_with_persent:
; в rdi - адрес строки
; записать в r11 её окончание, 	
	mov r11, 0
	jmp _get_strlen_iter_persent

_get_strlen_iter_persent:
	cmp byte [rdi], 0
	je _get_strlen_end
	cmp byte [rdi], '%'
	je _get_strlen_end
	inc rdi
	inc r11
	jmp _get_strlen_iter_persent

_get_strlen:
; в rdi - адрес строки
; записать в r11 её окончание, 	
	mov r11, 0
	jmp _get_strlen_iter

_get_strlen_iter:
	cmp byte [rdi], 0
	je _get_strlen_end
	inc rdi
	inc r11
	jmp _get_strlen_iter


_get_strlen_end: 
	sub rdi, r11
	ret

; Вспомогательная функция: для вывода строки

_count_strlen:
	ret


; Основные функции для my_printf

my_printf:
; порядок аргументов: 
; rdi, rsi, rdx, rcx, r8d, r9d
	push r9
	push r8
	push rcx
	push rdx
	push rsi
	mov r12, 5 ; в r12 храним число неиспользованных аргументов

_my_printf_iter:

	call _get_strlen_with_persent
	push r11 ; использую r11 для скачков. Он - volatible, но почему-то не меняется?
	call _print_substring
	pop r11
	add rdi, r11
	cmp byte [rdi], 0

; здесь r11 уже не юзается 

	je _clear_stack_iter
	jmp _handle_tocken
	;jmp _my_printf_iter

_handle_tocken:
	inc rdi
	inc rdi
	cmp byte [rdi - 1], 'd'
	je _handle_persent
	

	cmp byte [rdi - 1], '%'
	je _handle_persent

	cmp byte [rdi - 1], 's'
	je _handle_str

	jmp _my_printf_iter

_handle_persent:
	write_string persent, 1
	jmp _my_printf_iter

_handle_str:

	mov r15, rdi

	pop rdi

	call _count_strlen
	call _get_strlen
	call _print_substring

	sub r12, 1

	mov rdi, r15

	jmp _my_printf_iter


_clear_stack_iter:
	cmp r12, 0
	je _quit
	sub r12, 1
	pop rax 
	jmp _clear_stack_iter

_quit:
	mov rax, 0
	ret



section .data
	hello:     db 'Oh no',10
	helloLen:  equ $-hello
	persent: db '%'
	digletters db "0123456789abcdef"
	msg1 db "The result is:", 0xA,0xD  
	len1 equ $- msg1
	msg2 db 0xA,0xD
	len2 equ $- msg2 

segment .bss
	res resb 1
