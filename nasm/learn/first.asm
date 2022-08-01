; nasm -f elf first.asm

%include "asm_io.inc"

; 初始化.data段
segment .data

prompt1 db "Enter a number: ", 0    ; 0是ASCII码, 在C语言中表示空字符'\0'
prompt2 db "Enter another number: ", 0
outmsg1 db "You enterd ", 0
outmsg2 db " and ", 0
outmsg3 db ", the sum of these is ", 0

; 初始化.bss段
segment .bss

input1 resd 1
input2 resd 1

; .text段放代码
segment .text
    global asm_main
asm_main:
    enter 0, 0          ;开始运行
    pusha

    mov eax, prompt1    ;输出提示
    call print_string

    call read_int       ; 读第一个整数到input1
    mov [input1], eax

    mov eax, prompt2    ; 输出提示
    call print_string

    call read_int       ; 读取第二个整数到input2
    mov [input2], eax

    mov eax, [input1]
    add eax, [input2]
    mov ebx, eax

    dump_regs 1             ; 输出寄存器值
    dump_mem 2, outmsg1, 1  ; 输出内存

; 输出结果
    mov eax, outmsg1        
    call print_string
    mov eax, [input1]
    call print_int          ; 输出input1

    mov eax, outmsg2
    call print_string
    mov eax, [input2]
    call print_int          ; 输出input2

    mov eax, outmsg3
    call print_string
    mov eax, ebx
    call print_int          ; 输出总和
    call print_nl           ; 换行

    popa
    mov eax, 0              ; 回到C中
    leave
    ret
