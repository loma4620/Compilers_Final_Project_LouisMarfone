.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $4, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 call eval_input_pyobj
 movl %eax, %ecx
 pushl %ecx
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else0
 then0:
 movl $42, %eax
 pushl %eax
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, -4(%ebp)
 jmp endif0
 else0:
 pushl $1
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 pushl $2
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl $3
 call inject_int
 movl %eax, %edi
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
 movl %ecx, -4(%ebp)
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 movl %esi, %eax
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
 movl %ebx, %eax
 movl -4(%ebp), %edx
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
 movl %edi, %eax
 movl -4(%ebp), %edx
 pushl %eax
 pushl %ecx
 pushl %edx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
 movl %eax, %ecx
 endif0:
 movl -4(%ebp), %eax
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
