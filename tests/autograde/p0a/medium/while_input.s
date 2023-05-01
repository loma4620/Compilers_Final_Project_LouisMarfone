.global main
main:
 pushl %ebp
 movl %esp, %ebp
 subl $0, %esp
 while0:
 call eval_input_pyobj
 cmpl $0, %eax
 je end0
 pushl $1
 call inject_int
 movl %eax, %eax
 addl $4, %esp
 pushl %eax
 call print_any
 addl $4, %esp
 jmp while0
 end0:
 movl $0, %eax 
 movl %ebp, %esp
 popl %ebp
 ret
