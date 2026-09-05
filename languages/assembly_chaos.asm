; 汇编语言混乱计算器 - x86 NASM Linux - 功能完整但代码混乱
; 作者: 一个喜欢折磨自己的人
; 功能: 简单计算器 (加减乘除)

section .data
    msg1 db "=== 混乱计算器 ===", 10
    msg1_len equ $ - msg1
    msg2 db "输入第一个数: ", 0
    msg2_len equ $ - msg2
    msg3 db "输入运算符(+ - * /): ", 0
    msg3_len equ $ - msg3
    msg4 db "输入第二个数: ", 0
    msg4_len equ $ - msg4
    msg5 db "结果: ", 0
    msg5_len equ $ - msg5
    msg6 db 10, "按回车退出...", 10, 0
    msg6_len equ $ - msg6
    err_msg db "错误!", 10, 0
    err_len equ $ - err_msg
    newline db 10
    
    num1 dd 0
    num2 dd 0
    result dd 0
    op db 0
    temp db 0
    buffer times 32 db 0

section .bss
    input_buf resb 64

section .text
    global _start

_start:
    ; 打印欢迎信息
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msg1_len
    int 0x80

    ; 获取第一个数
    call print_msg2
    call read_number
    mov [num1], eax

    ; 获取运算符
    call print_msg3
    call read_char
    mov [op], al

    ; 获取第二个数
    call print_msg4
    call read_number
    mov [num2], eax

    ; 执行计算
    call calculate

    ; 显示结果
    call print_msg5
    mov eax, [result]
    call print_number
    
    ; 打印换行
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; 退出
    mov eax, 1
    xor ebx, ebx
    int 0x80

print_msg2:
    push eax
    push ebx
    push ecx
    push edx
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, msg2_len
    int 0x80
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

print_msg3:
    push eax
    push ebx
    push ecx
    push edx
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, msg3_len
    int 0x80
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

print_msg4:
    push eax
    push ebx
    push ecx
    push edx
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, msg4_len
    int 0x80
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

print_msg5:
    push eax
    push ebx
    push ecx
    push edx
    mov eax, 4
    mov ebx, 1
    mov ecx, msg5
    mov edx, msg5_len
    int 0x80
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

read_number:
    ; 读取数字输入
    push ebx
    push ecx
    push edx
    
    mov eax, 3
    mov ebx, 0
    mov ecx, input_buf
    mov edx, 32
    int 0x80
    
    ; 简单转换 (只处理正整数)
    xor eax, eax
    xor ecx, ecx
    mov esi, input_buf
    
.convert_loop:
    movzx edx, byte [esi]
    cmp edx, 10      ; 换行
    je .done
    cmp edx, 13      ; 回车
    je .done
    cmp edx, 0       ; 空字符
    je .done
    
    sub edx, '0'
    imul eax, 10
    add eax, edx
    inc esi
    jmp .convert_loop
    
.done:
    pop edx
    pop ecx
    pop ebx
    ret

read_char:
    push ebx
    push ecx
    push edx
    
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 0x80
    
    mov al, [temp]
    
    pop edx
    pop ecx
    pop ebx
    ret

calculate:
    push ebx
    push ecx
    push edx
    
    mov eax, [num1]
    mov ebx, [num2]
    mov cl, [op]
    
    cmp cl, '+'
    je .add_op
    cmp cl, '-'
    je .sub_op
    cmp cl, '*'
    je .mul_op
    cmp cl, '/'
    je .div_op
    
    ; 默认加法
    jmp .add_op
    
.add_op:
    add eax, ebx
    mov [result], eax
    jmp .done
    
.sub_op:
    sub eax, ebx
    mov [result], eax
    jmp .done
    
.mul_op:
    imul eax, ebx
    mov [result], eax
    jmp .done
    
.div_op:
    cmp ebx, 0
    je .div_error
    xor edx, edx
    idiv ebx
    mov [result], eax
    jmp .done
    
.div_error:
    mov dword [result], 0
    jmp .done
    
.done:
    pop edx
    pop ecx
    pop ebx
    ret

print_number:
    ; 打印数字 (简化版)
    push eax
    push ebx
    push ecx
    push edx
    
    mov ecx, buffer
    add ecx, 31
    mov byte [ecx], 0
    mov ebx, 10
    
.divide_loop:
    dec ecx
    xor edx, edx
    div ebx
    add dl, '0'
    mov [ecx], dl
    test eax, eax
    jnz .divide_loop
    
    ; 计算长度
    mov edx, buffer
    add edx, 31
    sub edx, ecx
    
    ; 打印
    mov eax, 4
    mov ebx, 1
    ; ecx 已经指向数字字符串
    int 0x80
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
