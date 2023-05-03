.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $12, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 call eval_input_pyobj
 movl %eax, -12(%ebp)
 movl $1, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 while0:
 movl -4(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else1
 then1:
 movl -12(%ebp), %eax
 pushl %eax
 call is_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else2
 then2:
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl %ebx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 jmp endif2
 else2:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else3
 then3:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 jmp endif3
 else3:
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl %ebx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 endif3:
 endif2:
 jmp endif1
 else1:
 movl -4(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif4
 then4:
 movl -12(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else5
 then5:
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 movl -12(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl %ebx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 jmp endif5
 else5:
 movl -12(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else6
 then6:
 movl $0, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 jmp endif6
 else6:
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 movl -12(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl %ebx, %eax
 setne %al 
 movzbl %al, %ecx
 movl %ecx, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 endif6:
 endif5:
 jmp endif4
 endif4:
 endif1:
 movl -8(%ebp), %eax
 movl $0, %ecx
 cmpl %ecx, %eax
 je end0
 pushl %edi
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else7
 then7:
 pushl $0
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 jmp endif7
 else7:
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 endif7:
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
 je else8
 then8:
 pushl %esi
 call is_int
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else9
 then9:
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
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
 jmp endif9
 else9:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else10
 then10:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif10
 else10:
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %esi
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
 endif10:
 endif9:
 jmp endif8
 else8:
 movl -4(%ebp), %eax
 pushl %eax
 call is_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je else11
 then11:
 pushl %esi
 call is_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else12
 then12:
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %ebx
 pushl %esi
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
 jmp endif12
 else12:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else13
 then13:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif13
 else13:
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
 endif13:
 endif12:
 jmp endif11
 else11:
 movl -4(%ebp), %eax
 pushl %eax
 call is_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %eax
 cmpl $0, %eax
 je endif14
 then14:
 pushl %esi
 call is_big
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else15
 then15:
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
 jmp endif15
 else15:
 movl $0, %eax
 pushl %eax
 call error_pyobj
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 endif15:
 jmp endif14
 endif14:
 endif11:
 endif8:
 jmp while0
 end0:
 pushl %edi
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %esi
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
