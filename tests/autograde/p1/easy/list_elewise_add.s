.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $24, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 pushl $1
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 movl $2, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 pushl $2
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
 movl %ebx, %eax
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
 movl -16(%ebp), %eax
 movl -8(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $3
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 movl $4, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -24(%ebp)
 pushl $2
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
 movl %ecx, -4(%ebp)
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ebx, %eax
 movl -4(%ebp), %edx
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
 movl -24(%ebp), %eax
 movl -4(%ebp), %edx
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
 movl %edx, -12(%ebp)
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -4(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %ebx
 movl -12(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
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
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %esi
 pushl %ebx
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %esi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
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
 movl %eax, %esi
 addl $4, %esp
 jmp endif2
 else2:
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %esi
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %esi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif2:
 endif1:
 jmp endif0
 else0:
 movl -12(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
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
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %esi
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 movl %esi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
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
 movl %eax, %esi
 addl $4, %esp
 jmp endif5
 else5:
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %esi
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 movl %esi, %ecx
 addl %eax, %ecx
 pushl %ecx
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif5:
 endif4:
 jmp endif3
 else3:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
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
 movl -12(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %esi
 pushl %ebx
 call project_big
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 pushl %esi
 call add
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %esi
 addl $4, %esp
 jmp endif7
 else7:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 endif7:
 jmp endif6
 endif6:
 endif3:
 endif0:
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
 movl %edx, %ebx
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else8
 then8:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else9
 then9:
 pushl %esi
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
 movl %eax, %edi
 addl $4, %esp
 jmp endif9
 else9:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else10
 then10:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif10
 else10:
 pushl %esi
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
 endif10:
 endif9:
 jmp endif8
 else8:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else11
 then11:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else12
 then12:
 pushl %esi
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
 jmp endif12
 else12:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else13
 then13:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 jmp endif13
 else13:
 pushl %esi
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
 endif13:
 endif12:
 jmp endif11
 else11:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif14
 then14:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else15
 then15:
 pushl %esi
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
 jmp endif15
 else15:
 pushl $0
 call error_pyobj
 movl %eax, %edi
 addl $4, %esp
 endif15:
 jmp endif14
 endif14:
 endif11:
 endif8:
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 movl -4(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %ebx
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else16
 then16:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else17
 then17:
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif17
 else17:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else18
 then18:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif18
 else18:
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
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 endif18:
 endif17:
 jmp endif16
 else16:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else19
 then19:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else20
 then20:
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif20
 else20:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else21
 then21:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif21
 else21:
 pushl %edi
 call project_bool
 movl %eax, %edi
 addl $4, %esp
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
 endif21:
 endif20:
 jmp endif19
 else19:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif22
 then22:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else23
 then23:
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
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif23
 else23:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 endif23:
 jmp endif22
 endif22:
 endif19:
 endif16:
 movl -20(%ebp), %eax
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
