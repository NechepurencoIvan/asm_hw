; Disassembly of file: hello.o
; Wed Apr 17 03:15:15 2019
; Mode: 64 bits
; Syntax: YASM/NASM
; Instruction set: 80186, x64

default rel

global not_main: function
global main: function


SECTION .text   align=1 execute                         ; section number 1, code

not_main:; Function begin
        push    rbp                                     ; 0000 _ 55
        mov     rbp, rsp                                ; 0001 _ 48: 89. E5
        mov     dword [rbp-4H], 1294                    ; 0004 _ C7. 45, FC, 0000050E
        mov     ecx, dword [rbp-4H]                     ; 000B _ 8B. 4D, FC
        mov     edx, 1717986919                         ; 000E _ BA, 66666667
        mov     eax, ecx                                ; 0013 _ 89. C8
        imul    edx                                     ; 0015 _ F7. EA
        sar     edx, 2                                  ; 0017 _ C1. FA, 02
        mov     eax, ecx                                ; 001A _ 89. C8
        sar     eax, 31                                 ; 001C _ C1. F8, 1F
        sub     edx, eax                                ; 001F _ 29. C2
        mov     eax, edx                                ; 0021 _ 89. D0
        mov     dword [rbp-8H], eax                     ; 0023 _ 89. 45, F8
        mov     eax, 10                                 ; 0026 _ B8, 0000000A
        pop     rbp                                     ; 002B _ 5D
        ret                                             ; 002C _ C3
; not_main End of function

main:   ; Function begin
        push    rbp                                     ; 002D _ 55
        mov     rbp, rsp                                ; 002E _ 48: 89. E5
        mov     dword [rbp-4H], 1                       ; 0031 _ C7. 45, FC, 00000001
        mov     dword [rbp-8H], 2                       ; 0038 _ C7. 45, F8, 00000002
        mov     eax, dword [rbp-4H]                     ; 003F _ 8B. 45, FC
        imul    eax, dword [rbp-8H]                     ; 0042 _ 0F AF. 45, F8
        mov     dword [rbp-0CH], eax                    ; 0046 _ 89. 45, F4
        nop                                             ; 0049 _ 90
        pop     rbp                                     ; 004A _ 5D
        ret                                             ; 004B _ C3
; main End of function


SECTION .data   align=1 noexecute                       ; section number 2, data


SECTION .bss    align=1 noexecute                       ; section number 3, bss


