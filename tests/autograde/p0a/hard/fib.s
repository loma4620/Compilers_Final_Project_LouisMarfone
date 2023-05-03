.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $16, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 while0:
 movl -4(%ebp), %esi
 pushl $10
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else1
 then1:
 pushl %ebx
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else2
 then2:
 pushl %esi
 call project_int
 movl %eax, %esi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %esi, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif2
 else2:
 pushl %ebx
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
 movl %ecx, -16(%ebp)
 jmp endif3
 else3:
 pushl %esi
 call project_int
 movl %eax, %esi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %esi, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 endif3:
 endif2:
 jmp endif1
 else1:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je endif4
 then4:
 pushl %ebx
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else5
 then5:
 pushl %esi
 call project_bool
 movl %eax, %esi
 addl $4, %esp
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %esi, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 jmp endif5
 else5:
 pushl %ebx
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
 movl %ecx, -16(%ebp)
 jmp endif6
 else6:
 pushl %esi
 call project_bool
 movl %eax, %esi
 addl $4, %esp
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %esi, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 endif6:
 endif5:
 jmp endif4
 endif4:
 endif1:
 movl -16(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je end0
 movl -12(%ebp), %eax
 pushl %eax
 call print_any
 addl $4, %esp
 movl -12(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else7
 then7:
 pushl %edi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else8
 then8:
 movl -12(%ebp), %eax
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
 movl %ecx, -8(%ebp)
 jmp endif8
 else8:
 pushl %edi
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
 movl %ecx, -8(%ebp)
 jmp endif9
 else9:
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
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
 movl %ecx, -8(%ebp)
 endif9:
 endif8:
 jmp endif7
 else7:
 movl -12(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else10
 then10:
 pushl %edi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else11
 then11:
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
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
 movl %ecx, -8(%ebp)
 jmp endif11
 else11:
 pushl %edi
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
 movl %ecx, -8(%ebp)
 jmp endif12
 else12:
 movl -12(%ebp), %eax
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
 movl %ecx, -8(%ebp)
 endif12:
 endif11:
 jmp endif10
 else10:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif13
 then13:
 pushl %edi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else14
 then14:
 movl -12(%ebp), %eax
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
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 jmp endif14
 else14:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 endif14:
 jmp endif13
 endif13:
 endif10:
 endif7:
 movl %edi, -12(%ebp)
 movl -8(%ebp), %edi
 pushl $1
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 movl -4(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else15
 then15:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else16
 then16:
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %esi
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
 jmp endif16
 else16:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else17
 then17:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif17
 else17:
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %esi
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
 endif17:
 endif16:
 jmp endif15
 else15:
 movl -4(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else18
 then18:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else19
 then19:
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %esi
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
 jmp endif19
 else19:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else20
 then20:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif20
 else20:
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %esi
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
 endif20:
 endif19:
 jmp endif18
 else18:
 movl -4(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif21
 then21:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else22
 then22:
 movl -4(%ebp), %eax
 pushl %eax
 call project_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %esi
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
 movl %ecx, -4(%ebp)
 jmp endif22
 else22:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 endif22:
 jmp endif21
 endif21:
 endif18:
 endif15:
 jmp while0
 end0:
 movl $0, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
