.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 pushl $1
 call inject_int
 movl %eax, %edi
 addl $4, %esp
 pushl $1
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
