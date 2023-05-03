.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $20, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 pushl $15
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 movl $25, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 pushl $35
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl $45
 call inject_int
 movl %eax, %edi
 addl $4, %esp
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
 movl -16(%ebp), %eax
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
 movl %ebx, %eax
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
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 movl -8(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 pushl $4
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 while0:
 movl %ebx, %edi
 pushl $0
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else1
 then1:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else2
 then2:
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif2
 else2:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else3
 then3:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif3
 else3:
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 endif3:
 endif2:
 jmp endif1
 else1:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif4
 then4:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif5
 else5:
 pushl %esi
 call is_big
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
 movl %ecx, -4(%ebp)
 jmp endif6
 else6:
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
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 endif6:
 endif5:
 jmp endif4
 endif4:
 endif1:
 movl -4(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je end0
 movl -12(%ebp), %eax
 movl -8(%ebp), %ecx
 pushl %eax
 pushl %ecx
 call get_subscript
 movl %eax, %edx
 addl $8, %esp
 movl %edx, %esi
 movl -20(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else7
 then7:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else8
 then8:
 movl -20(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
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
 jmp endif8
 else8:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else9
 then9:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif9
 else9:
 movl -20(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
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
 endif9:
 endif8:
 jmp endif7
 else7:
 movl -20(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else10
 then10:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else11
 then11:
 movl -20(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
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
 jmp endif11
 else11:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else12
 then12:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif12
 else12:
 movl -20(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
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
 endif12:
 endif11:
 jmp endif10
 else10:
 movl -20(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif13
 then13:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else14
 then14:
 movl -20(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
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
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 jmp endif14
 else14:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 endif14:
 jmp endif13
 endif13:
 endif10:
 endif7:
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else15
 then15:
 pushl %edi
 call project_int
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 jmp endif15
 else15:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else16
 then16:
 pushl $0
 call error_pyobj
 movl %eax, %esi
 addl $4, %esp
 jmp endif16
 else16:
 pushl %edi
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 negl %eax
 pushl %eax
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 endif16:
 endif15:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else17
 then17:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else18
 then18:
 pushl %ebx
 call project_int
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 jmp endif18
 else18:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else19
 then19:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
 jmp endif19
 else19:
 pushl %ebx
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
 movl %eax, %ebx
 addl $4, %esp
 endif19:
 endif18:
 jmp endif17
 else17:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else20
 then20:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else21
 then21:
 pushl %ebx
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
 movl %eax, %ebx
 addl $4, %esp
 jmp endif21
 else21:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else22
 then22:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
 jmp endif22
 else22:
 pushl %ebx
 call project_bool
 movl %eax, %edi
 addl $4, %esp
 pushl %esi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 endif22:
 endif21:
 jmp endif20
 else20:
 pushl %ebx
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif23
 then23:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else24
 then24:
 pushl %ebx
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
 movl %eax, %ebx
 addl $4, %esp
 jmp endif24
 else24:
 pushl $0
 call error_pyobj
 movl %eax, %ebx
 addl $4, %esp
 endif24:
 jmp endif23
 endif23:
 endif20:
 endif17:
 pushl $1
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 movl -12(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else25
 then25:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else26
 then26:
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 jmp endif26
 else26:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else27
 then27:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 jmp endif27
 else27:
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 endif27:
 endif26:
 jmp endif25
 else25:
 movl -12(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else28
 then28:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else29
 then29:
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
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
 movl %ecx, -12(%ebp)
 jmp endif29
 else29:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else30
 then30:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 jmp endif30
 else30:
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %esi
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %edi, %eax
 addl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 endif30:
 endif29:
 jmp endif28
 else28:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif31
 then31:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else32
 then32:
 movl -12(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
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
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 jmp endif32
 else32:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 endif32:
 jmp endif31
 endif31:
 endif28:
 endif25:
 jmp while0
 end0:
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
