.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 pushl %ebx
 pushl $2
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl $3
 call inject_int
 movl %eax, %ebx
 addl $4, %esp
 pushl %edi
 call print_any
 addl $4, %esp
 pushl %ebx
 call print_any
 addl $4, %esp
 movl %edi, %eax
 movl %ebx, %edi
 movl %eax, %ebx
 pushl %edi
 call print_any
 addl $4, %esp
 pushl %ebx
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %ebx
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
