lambda_0:
 pushl %ebp
 movl %esp, %ebp
 subl $24, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl 8(%ebp), %edi
 movl 12(%ebp), %eax
 movl %eax, -24(%ebp)
 movl 16(%ebp), %esi
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
 movl %eax, -4(%ebp)
 movl %esi, -16(%ebp)
 pushl $0
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 movl -16(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else0
 then0:
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else1
 then1:
 movl -16(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %edi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %ebx, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif1
 else1:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else2
 then2:
 pushl $0
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif2
 else2:
 movl -16(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %ebx, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 endif2:
 endif1:
 jmp endif0
 else0:
 movl -16(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif3
 then3:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else4
 then4:
 movl -16(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %ebx, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif4
 else4:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
 pushl $0
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif5
 else5:
 movl -16(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %edi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %ebx, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 endif5:
 endif4:
 jmp endif3
 endif3:
 endif0:
 pushl %ebx
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else6
 then6:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif6
 else6:
 movl -4(%ebp), %eax
 pushl %eax
 call get_fun_ptr
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 movl -4(%ebp), %eax
 pushl %eax
 call get_free_vars
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else7
 then7:
 pushl %edi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 jmp endif7
 else7:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else8
 then8:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 jmp endif8
 else8:
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 endif8:
 endif7:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else9
 then9:
 movl -12(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else10
 then10:
 pushl %esi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif10
 else10:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else11
 then11:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif11
 else11:
 pushl %esi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif11:
 endif10:
 jmp endif9
 else9:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else12
 then12:
 movl -12(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else13
 then13:
 pushl %esi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif13
 else13:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else14
 then14:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif14
 else14:
 pushl %esi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif14:
 endif13:
 jmp endif12
 else12:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif15
 then15:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else16
 then16:
 pushl %esi
 call project_big
 movl %eax, %edi
 addl $4, %esp
 movl -12(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 pushl %eax
 pushl %edi
 call add
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %esi
 addl $4, %esp
 jmp endif16
 else16:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 endif16:
 jmp endif15
 endif15:
 endif12:
 endif9:
 pushl %esi
 pushl -24(%ebp)
 pushl %ebx
 movl -8(%ebp), %eax
 call %eax
 movl %eax, %ebx
 addl $12, %esp
 movl -24(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else17
 then17:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else18
 then18:
 movl -24(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif18
 else18:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else19
 then19:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif19
 else19:
 movl -24(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %ebx
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 endif19:
 endif18:
 jmp endif17
 else17:
 movl -24(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else20
 then20:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else21
 then21:
 movl -24(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %ebx
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif21
 else21:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else22
 then22:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif22
 else22:
 movl -24(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %ebx
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 endif22:
 endif21:
 jmp endif20
 else20:
 movl -24(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif23
 then23:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else24
 then24:
 movl -24(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %ebx
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call add
 movl %eax, %ecx
 addl $8, %esp
 movl %ecx, %eax
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif24
 else24:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 endif24:
 jmp endif23
 endif23:
 endif20:
 endif17:
 endif6:
 movl -20(%ebp), %eax
 movl %eax, %eax 
 popl %esi
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
 pushl %esi
 movl 8(%ebp), %edi
 movl 12(%ebp), %esi
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %edi
 call get_subscript
 movl %eax, %edi
 addl $8, %esp
 pushl %edi
 call get_fun_ptr
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call get_free_vars
 movl %eax, %eax
 addl $4, %esp
 pushl %esi
 pushl %esi
 pushl %eax
 call %ebx
 movl %eax, %eax
 addl $12, %esp
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
 subl $0, %esp
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
 pushl %esi
 call get_fun_ptr
 movl %eax, %ebx
 addl $4, %esp
 pushl %esi
 call get_free_vars
 movl %eax, %edi
 addl $4, %esp
 call eval_input_pyobj
 pushl %eax
 pushl %edi
 call %ebx
 movl %eax, %eax
 addl $8, %esp
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
