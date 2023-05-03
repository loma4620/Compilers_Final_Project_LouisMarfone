lambda_1:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 pushl %ebx
 movl 8(%ebp), %eax
 movl 12(%ebp), %edi
 pushl $1
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else0
 then0:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else1
 then1:
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
 jmp endif1
 else1:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else2
 then2:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif2
 else2:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif2:
 endif1:
 jmp endif0
 else0:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else3
 then3:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else4
 then4:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif4
 else4:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif5
 else5:
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
 endif5:
 endif4:
 jmp endif3
 else3:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif6
 then6:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else7
 then7:
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
 movl %eax, %ecx
 addl $8, %esp
 pushl %ecx
 call inject_big
 movl %eax, %edi
 addl $4, %esp
 jmp endif7
 else7:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 endif7:
 jmp endif6
 endif6:
 endif3:
 endif0:
 movl %edi, %eax 
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret

lambda_2:
 pushl %ebp
 movl %esp, %ebp
 subl $36, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl 8(%ebp), %edi
 movl 12(%ebp), %eax
 movl %eax, -20(%ebp)
 movl 16(%ebp), %eax
 movl %eax, -4(%ebp)
 movl 20(%ebp), %eax
 movl %eax, -32(%ebp)
 movl 24(%ebp), %eax
 movl %eax, -28(%ebp)
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
 movl %eax, -8(%ebp)
 movl -32(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else8
 then8:
 movl -28(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else9
 then9:
 movl -32(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 movl -28(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl %ebx, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif9
 else9:
 movl -28(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else10
 then10:
 pushl $0
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif10
 else10:
 movl -32(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -28(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 endif10:
 endif9:
 jmp endif8
 else8:
 movl -32(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif11
 then11:
 movl -28(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else12
 then12:
 movl -32(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 movl -28(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl %ebx, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif12
 else12:
 movl -28(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else13
 then13:
 pushl $0
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif13
 else13:
 movl -32(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -28(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 endif13:
 endif12:
 jmp endif11
 endif11:
 endif8:
 pushl %ebx
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else14
 then14:
 movl -20(%ebp), %eax
 pushl %eax
 call get_fun_ptr
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %esi
 movl -20(%ebp), %eax
 pushl %eax
 call get_free_vars
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 movl -32(%ebp), %eax
 movl -4(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 pushl %ebx
 call %esi
 movl %eax, %esi
 addl $8, %esp
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
 movl %eax, %ebx
 addl $4, %esp
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %esi
 pushl %eax
 pushl %ebx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl -8(%ebp), %eax
 pushl %eax
 call get_fun_ptr
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %esi
 movl -8(%ebp), %eax
 pushl %eax
 call get_free_vars
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 movl $1, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 movl -32(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else15
 then15:
 movl -12(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else16
 then16:
 movl -32(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
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
 movl %eax, %edi
 addl $4, %esp
 jmp endif16
 else16:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else17
 then17:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif17
 else17:
 movl -32(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif17:
 endif16:
 jmp endif15
 else15:
 movl -32(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else18
 then18:
 movl -12(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else19
 then19:
 movl -32(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif19
 else19:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else20
 then20:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif20
 else20:
 movl -32(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif20:
 endif19:
 jmp endif18
 else18:
 movl -32(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif21
 then21:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else22
 then22:
 movl -32(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
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
 movl %eax, %edi
 addl $4, %esp
 jmp endif22
 else22:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 endif22:
 jmp endif21
 endif21:
 endif18:
 endif15:
 pushl -28(%ebp)
 pushl -28(%ebp)
 pushl -28(%ebp)
 pushl -28(%ebp)
 pushl -28(%ebp)
 call %esi
 movl %eax, %ebx
 addl $12, %esp
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else23
 then23:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else24
 then24:
 pushl %ebx
 call project_int
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
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -24(%ebp)
 jmp endif24
 else24:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else25
 then25:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -24(%ebp)
 jmp endif25
 else25:
 pushl %ebx
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -24(%ebp)
 endif25:
 endif24:
 jmp endif23
 else23:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else26
 then26:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else27
 then27:
 pushl %ebx
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
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -24(%ebp)
 jmp endif27
 else27:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else28
 then28:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -24(%ebp)
 jmp endif28
 else28:
 pushl %ebx
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
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -24(%ebp)
 endif28:
 endif27:
 jmp endif26
 else26:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif29
 then29:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else30
 then30:
 pushl %ebx
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
 movl %eax, %edi
 addl $8, %esp
 movl %edi, %eax
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -24(%ebp)
 jmp endif30
 else30:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -24(%ebp)
 endif30:
 jmp endif29
 endif29:
 endif26:
 endif23:
 jmp endif14
 else14:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -36(%ebp)
 movl -36(%ebp), %eax
 pushl %eax
 call create_list
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -24(%ebp)
 endif14:
 movl -24(%ebp), %eax
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
 subl $20, %esp
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
 movl %eax, %ebx
 addl $4, %esp
 pushl %esi
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %ebx
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
 movl %eax, %edi
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
 movl %eax, %ebx
 addl $4, %esp
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %edi
 pushl %eax
 pushl %ebx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 pushl %edi
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %ebx
 pushl %eax
 call set_free_vars
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %edi
 addl $4, %esp
 movl %edi, %eax
 pushl %eax
 call get_fun_ptr
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 movl %edi, %eax
 pushl %eax
 call get_free_vars
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 pushl $1
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 movl $2, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 movl $3, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 movl $4, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 pushl $4
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
 movl %eax, %ecx
 addl $4, %esp
 pushl %ebx
 pushl %ecx
 pushl %edi
 call set_subscript
 movl %eax, %ecx
 addl $12, %esp
 pushl $1
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -20(%ebp), %eax
 movl %edi, %edx
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
 movl -16(%ebp), %eax
 movl %edi, %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $3
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl -4(%ebp), %eax
 movl %edi, %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $0
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl $4
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %eax
 pushl %eax
 pushl %eax
 pushl %eax
 movl -12(%ebp), %eax
 call %eax
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
