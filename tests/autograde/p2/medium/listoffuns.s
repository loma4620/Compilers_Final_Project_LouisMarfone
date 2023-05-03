lambda_0:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 pushl %ebx
 movl 8(%ebp), %eax
 movl 12(%ebp), %edi
 movl 16(%ebp), %ebx
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else0
 then0:
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif0
 else0:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else1
 then1:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
 jmp endif1
 else1:
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 endif1:
 endif0:
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else2
 then2:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else3
 then3:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif3
 else3:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else4
 then4:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif4
 else4:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif4:
 endif3:
 jmp endif2
 else2:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else6
 then6:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif6
 else6:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else7
 then7:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif7
 else7:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif7:
 endif6:
 jmp endif5
 else5:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif8
 then8:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else9
 then9:
 pushl %edi
 call project_big
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call add
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %edi
 addl $4, %esp
 jmp endif9
 else9:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 endif9:
 jmp endif8
 endif8:
 endif5:
 endif2:
 movl %edi, %eax 
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret

lambda_1:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 pushl %ebx
 movl 8(%ebp), %eax
 movl 12(%ebp), %ebx
 movl 16(%ebp), %edi
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else10
 then10:
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else11
 then11:
 pushl %ebx
 call project_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif11
 else11:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else12
 then12:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif12
 else12:
 pushl %ebx
 call project_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif12:
 endif11:
 jmp endif10
 else10:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else13
 then13:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else14
 then14:
 pushl %ebx
 call project_bool
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif14
 else14:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else15
 then15:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif15
 else15:
 pushl %ebx
 call project_bool
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif15:
 endif14:
 jmp endif13
 else13:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif16
 then16:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else17
 then17:
 pushl %ebx
 call project_big
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %ebx
 call add
 movl %eax, %ecx
 addl $8, %esp
 pushl %ecx
 call inject_big
 movl %eax, %edi
 addl $4, %esp
 jmp endif17
 else17:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 endif17:
 jmp endif16
 endif16:
 endif13:
 endif10:
 movl %edi, %eax 
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret

lambda_2:
 pushl %ebp
 movl %esp, %ebp
 subl $20, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl 8(%ebp), %edi
 movl 12(%ebp), %eax
 movl %eax, -20(%ebp)
 movl 16(%ebp), %ebx
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %eax
 addl $8, %esp
 movl %eax, -16(%ebp)
 pushl $0
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else18
 then18:
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else19
 then19:
 pushl %ebx
 call project_int
 movl %eax, %esi
 addl $4, %esp
 pushl %edi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %esi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif19
 else19:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else20
 then20:
 pushl $0
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif20
 else20:
 pushl %ebx
 call project_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %ebx, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif20:
 endif19:
 jmp endif18
 else18:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif21
 then21:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else22
 then22:
 pushl %ebx
 call project_bool
 movl %eax, %esi
 addl $4, %esp
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %esi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif22
 else22:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else23
 then23:
 pushl $0
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif23
 else23:
 pushl %ebx
 call project_bool
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %ebx, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif23:
 endif22:
 jmp endif21
 endif21:
 endif18:
 pushl %esi
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else24
 then24:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif24
 else24:
 movl -16(%ebp), %eax
 pushl %eax
 call get_fun_ptr
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 movl -16(%ebp), %eax
 pushl %eax
 call get_free_vars
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %esi
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else25
 then25:
 pushl %edi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif25
 else25:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else26
 then26:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif26
 else26:
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif26:
 endif25:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else27
 then27:
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else28
 then28:
 pushl %ebx
 call project_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 jmp endif28
 else28:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else29
 then29:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 jmp endif29
 else29:
 pushl %ebx
 call project_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 endif29:
 endif28:
 jmp endif27
 else27:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else30
 then30:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else31
 then31:
 pushl %ebx
 call project_bool
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 jmp endif31
 else31:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else32
 then32:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 jmp endif32
 else32:
 pushl %ebx
 call project_bool
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 endif32:
 endif31:
 jmp endif30
 else30:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif33
 then33:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else34
 then34:
 pushl %ebx
 call project_big
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %ebx
 call add
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 jmp endif34
 else34:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 endif34:
 jmp endif33
 endif33:
 endif30:
 endif27:
 pushl -8(%ebp)
 pushl -20(%ebp)
 pushl %esi
 movl -12(%ebp), %eax
 call %eax
 movl %eax, %edi
 addl $12, %esp
 movl -20(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else35
 then35:
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else36
 then36:
 movl -20(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %edi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif36
 else36:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else37
 then37:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif37
 else37:
 movl -20(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %ebx, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 endif37:
 endif36:
 jmp endif35
 else35:
 movl -20(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else38
 then38:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else39
 then39:
 movl -20(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %edi
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif39
 else39:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else40
 then40:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif40
 else40:
 movl -20(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %edi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 endif40:
 endif39:
 jmp endif38
 else38:
 movl -20(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif41
 then41:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else42
 then42:
 movl -20(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %edi
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %ebx
 call add
 movl %eax, %ebx
 addl $8, %esp
 movl %ebx, %eax
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif42
 else42:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 endif42:
 jmp endif41
 endif41:
 endif38:
 endif35:
 endif24:
 movl -4(%ebp), %eax
 movl %eax, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret

.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $12, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call create_list
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call inject_big
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl $lambda_0
 call create_closure
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call create_list
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call inject_big
 movl %eax, %ebx
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 pushl %ebx
 pushl %eax
 call set_free_vars
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call create_list
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call inject_big
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl $lambda_1
 call create_closure
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %esi
 addl $4, %esp
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call create_list
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call inject_big
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %edi
 pushl %eax
 call set_free_vars
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %esi
 addl $4, %esp
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call create_list
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call inject_big
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl $lambda_2
 call create_closure
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ebx
 addl $4, %esp
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call create_list
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call inject_big
 movl %eax, %edi
 addl $4, %esp
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %ebx
 pushl %eax
 pushl %edi
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 pushl %ebx
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %edi
 pushl %eax
 call set_free_vars
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ebx
 addl $4, %esp
 pushl $3
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call create_list
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %esi, %eax
 movl -8(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $1
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 movl -8(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $2
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -4(%ebp), %eax
 movl -8(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -8(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %eax
 pushl %eax
 call get_fun_ptr
 movl %eax, %ebx
 addl $4, %esp
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -8(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %eax
 pushl %eax
 call get_free_vars
 movl %eax, %esi
 addl $4, %esp
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 pushl %esi
 call %ebx
 movl %eax, %eax
 addl $12, %esp
 pushl %eax
 call print_any
 addl $4, %esp
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -8(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %eax
 pushl %eax
 call get_fun_ptr
 movl %eax, %esi
 addl $4, %esp
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -8(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %eax
 pushl %eax
 call get_free_vars
 movl %eax, %edi
 addl $4, %esp
 pushl $1
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %ebx
 pushl %edi
 call %esi
 movl %eax, %eax
 addl $12, %esp
 pushl %eax
 call print_any
 addl $4, %esp
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -8(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %eax
 pushl %eax
 call get_fun_ptr
 movl %eax, %edi
 addl $4, %esp
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -8(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %eax
 pushl %eax
 call get_free_vars
 movl %eax, %ebx
 addl $4, %esp
 pushl $1
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %esi
 pushl %ebx
 call %edi
 movl %eax, %eax
 addl $12, %esp
 pushl %eax
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
