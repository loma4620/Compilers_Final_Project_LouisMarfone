.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 pushl %ebx
 pushl %esi
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl $2
 call inject_int
 movl %eax, %esi
 addl $4, %esp
 call create_dict
 pushl %eax
 call inject_big
 movl %eax, %ebx
 addl $4, %esp
 pushl %esi
 pushl %edi
 pushl %ebx
 call set_subscript
 movl %eax, %eax
 addl $12, %esp
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
