; A macro with two parameters
; Implements the write system call
   %macro write_string 2 
      mov   eax, 4
      mov   ebx, 1
      mov   ecx, %1
      mov   edx, %2
      int   0x80
   %endmacro



section	.text
   global _start    ;must be declared for using gcc
	
_start:             ;tell linker entry point
   
   write_string msg1, len1
   mov  ax, 267
   push 20
   jmp  _iter

_iter:	
   mov 	bl, 2
   div 	bl
   
   push ax

   mov  ah, 0
   cmp  ax, 0
   je   _out_stack
   jmp  _iter


_out_stack:
   pop ax
   cmp ax, 20
   je  _quit

   mov al, 0
  
   add	ah, '0'
   mov  [res], ah
   sub  ah, '0'
   
   ;mov cx, [digletters]
   ;mov 

   ;write_string cx,  1
   write_string res, 1	  
   jmp _out_stack

_quit:
   write_string msg2, len2 
   mov eax, 1
   int 0x80
	
section .data
digletters db "0123456789abcdef"
msg1 db "The result is:", 0xA,0xD  
len1 equ $- msg1
msg2 db 0xA,0xD
len2 equ $- msg2 
segment .bss
res resb 1
