.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call print_any
 addl $4, %esp
 movl $0, %eax 
 movl %ebp, %esp
 popl %ebp
 ret
