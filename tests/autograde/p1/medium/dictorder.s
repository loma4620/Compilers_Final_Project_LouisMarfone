.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $36, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 movl $1, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -8(%ebp)
 movl $2, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -24(%ebp)
 pushl $3
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 movl $1, %eax
 pushl %eax
 call inject_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -32(%ebp)
 movl $0, %eax
 pushl %eax
 call inject_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -16(%ebp)
 pushl $1
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 movl $2, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -28(%ebp)
 movl $0, %eax
 pushl %eax
 call inject_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -12(%ebp)
 movl $2, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -20(%ebp)
 movl $1, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -36(%ebp)
 call create_dict
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 movl %ebx, %eax
 movl -8(%ebp), %ecx
 movl -4(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl -28(%ebp), %eax
 movl -24(%ebp), %ecx
 movl -4(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl -12(%ebp), %eax
 movl %esi, %ecx
 movl -4(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl -20(%ebp), %eax
 movl -32(%ebp), %ecx
 movl -4(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl -36(%ebp), %eax
 movl -16(%ebp), %ecx
 movl -4(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl -4(%ebp), %ebx
 movl -4(%ebp), %eax
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
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
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
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 jmp endif2
 else2:
 movl -4(%ebp), %eax
 pushl %eax
 call project_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 endif2:
 endif1:
 jmp endif0
 else0:
 movl -4(%ebp), %eax
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
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %ebx
 call project_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
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
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 jmp endif5
 else5:
 movl -4(%ebp), %eax
 pushl %eax
 call project_bool
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl %ebx
 call project_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 endif5:
 endif4:
 jmp endif3
 else3:
 movl -4(%ebp), %eax
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
 movl -4(%ebp), %eax
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
 call equal
 movl %eax, %eax
 addl $8, %esp
 pushl %eax
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 jmp endif7
 else7:
 pushl %ebx
 call is_bool
 movl %eax, %edi
 addl $4, %esp
 cmpl $0, %edi
 je else8
 then8:
 pushl $0
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 jmp endif8
 else8:
 pushl $0
 call inject_bool
 movl %eax, %edi
 addl $4, %esp
 endif8:
 endif7:
 jmp endif6
 endif6:
 endif3:
 endif0:
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
