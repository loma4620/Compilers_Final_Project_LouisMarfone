lambda_0:
 pushl %ebp
 movl %esp, %ebp
 subl $16, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl 8(%ebp), %edi
 movl 12(%ebp), %eax
 movl %eax, -4(%ebp)
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
 movl -4(%ebp), %edi
 pushl $0
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else0
 then0:
 pushl %esi
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
 pushl %esi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif1
 else1:
 pushl %esi
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
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
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
 je endif3
 then3:
 pushl %esi
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
 pushl %esi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif4
 else4:
 pushl %esi
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
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 setne %al 
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
 movl -4(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
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
 movl -4(%ebp), %eax
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
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
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif11
 else11:
 movl -4(%ebp), %eax
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
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 endif11:
 endif10:
 jmp endif9
 else9:
 movl -4(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
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
 movl -4(%ebp), %eax
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
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
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
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif14
 else14:
 movl -4(%ebp), %eax
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
 movl %ecx, %eax
 movl %edi, %ecx
 addl %eax, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 endif14:
 endif13:
 jmp endif12
 else12:
 movl -4(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
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
 movl -4(%ebp), %eax
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
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif16
 else16:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 endif16:
 jmp endif15
 endif15:
 endif12:
 endif9:
 pushl -16(%ebp)
 pushl %ebx
 call %esi
 movl %eax, %eax
 addl $8, %esp
 jmp endif6
 else6:
 pushl $0
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 endif6:
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
 subl $12, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl 8(%ebp), %ebx
 movl 12(%ebp), %edi
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %ebx
 call get_subscript
 movl %eax, %esi
 addl $8, %esp
 movl %edi, %ebx
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -4(%ebp)
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else17
 then17:
 movl -4(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else18
 then18:
 pushl %ebx
 call project_int
 movl %eax, %ebx
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %ebx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 jmp endif18
 else18:
 movl -4(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else19
 then19:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 jmp endif19
 else19:
 pushl %ebx
 call project_int
 movl %eax, %edi
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 endif19:
 endif18:
 jmp endif17
 else17:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif20
 then20:
 movl -4(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else21
 then21:
 pushl %ebx
 call project_bool
 movl %eax, %ebx
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %ebx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 jmp endif21
 else21:
 movl -4(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else22
 then22:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 jmp endif22
 else22:
 pushl %ebx
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -12(%ebp)
 endif22:
 endif21:
 jmp endif20
 endif20:
 endif17:
 movl -12(%ebp), %eax
 pushl %eax
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else23
 then23:
 movl %esi, %eax
 pushl %eax
 call get_fun_ptr
 movl %eax, %eax
 addl $4, %esp
 movl %eax, -8(%ebp)
 pushl %esi
 call get_free_vars
 movl %eax, %ebx
 addl $4, %esp
 pushl $1
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else24
 then24:
 pushl %esi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif24
 else24:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else25
 then25:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif25
 else25:
 pushl %esi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif25:
 endif24:
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else26
 then26:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else27
 then27:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif27
 else27:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else28
 then28:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif28
 else28:
 pushl %edi
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif28:
 endif27:
 jmp endif26
 else26:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else29
 then29:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else30
 then30:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif30
 else30:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else31
 then31:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif31
 else31:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %edi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif31:
 endif30:
 jmp endif29
 else29:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif32
 then32:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else33
 then33:
 pushl %edi
 call project_big
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
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
 jmp endif33
 else33:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 endif33:
 jmp endif32
 endif32:
 endif29:
 endif26:
 pushl %edi
 pushl %ebx
 movl -8(%ebp), %eax
 call %eax
 movl %eax, %eax
 addl $8, %esp
 jmp endif23
 else23:
 pushl $1
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 endif23:
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
 pushl %esi
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
 pushl %ebx
 call get_fun_ptr
 movl %eax, %edi
 addl $4, %esp
 pushl %ebx
 call get_free_vars
 movl %eax, %ebx
 addl $4, %esp
 pushl $23
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %ebx
 call %edi
 movl %eax, %ebx
 addl $8, %esp
 pushl %ebx
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
