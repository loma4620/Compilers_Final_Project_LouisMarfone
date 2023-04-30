.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 movl $0, %eax 
 movl %ebp, %esp
 popl %ebp
 ret
