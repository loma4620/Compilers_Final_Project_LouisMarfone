.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl %edi
 pushl $0
 call inject_int
 movl %eax, %ecx
 addl $4, %esp
 pushl %ecx
 call create_list
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call inject_big
 movl %eax, %ecx
 addl $4, %esp
 movl %ecx, %edi
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 cmpl %edi, %eax
 sete %al 
 movzbl %al, %ecx
 pushl %ecx
 call inject_bool
 movl %eax, %ecx
 addl $4, %esp
 pushl %ecx
 call print_any
 addl $4, %esp
 movl $0, %eax 
 popl %edi
 movl %ebp, %esp
 popl %ebp
 ret
