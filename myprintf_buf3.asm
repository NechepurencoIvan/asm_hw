%macro write_string 2 
    mov   eax, 4
    mov   ebx, 1
    mov   ecx, %1
    mov   rdx, %2
    int   0x80
%endmacro


section .text
	global count_sum
	global print_num
	global my_printf

;
;Функция переводит число из rdx 0 - 15 в a - f
;


_num_to_char:
	cmp rdx, 10
	jl _small_num_to_char
	jmp _big_num_to_char


_small_num_to_char:
	add rdx, '0'
	ret

_big_num_to_char:
	sub rdx, 10
	add rdx, 'a'
	ret

;
; Функция для десятичного вывода числа
;

print_num:
	mov rax, rdi

	push r15
	push r14

	mov r15, 0
	mov r14, 0

_print_num_iter:
	mov rdx, 0
	mov rbx, rsi
	div rbx

	;add rdx, '0'
	call _num_to_char

	push rdx

	inc r15

	cmp rax, 0
	je _print_num_stack_out
	jmp _print_num_iter

_print_num_stack_out:
	cmp r15, 0
	je _print_num_quit
	dec r15
	pop rdx
	mov [res + r14], dl ;rdx
	inc r14

	jmp _print_num_stack_out

_print_num_quit:
	write_string res, r14

	pop r14
	pop r15

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
	res resb 30
