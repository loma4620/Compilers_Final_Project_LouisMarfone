.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 pushl $2
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call is_true
 movl %eax, %eax
 addl $4, %esp
 cmpl $0, %eax
 je else0
 then0:
 pushl $0
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 jmp endif0
 else0:
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 endif0:
 pushl %eax
 call print_any
 addl $4, %esp
 movl $0, %eax 
 movl %ebp, %esp
 popl %ebp
 ret
